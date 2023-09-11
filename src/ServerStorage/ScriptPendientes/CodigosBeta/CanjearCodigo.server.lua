script.Enabled = false

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local dss = game:GetService("DataStoreService")

local KeyCodigos = dss:GetDataStore("Codigos")

local globalCodigos = require(ReplicatedStorage.module.Data.CodigosGlobal)

local reCodigo = Instance.new("RemoteEvent")
reCodigo.Name = "reCodigo"
reCodigo.Parent = ReplicatedStorage

local codigosData 

repeat 
	local succes = pcall(function()
	 codigosData = KeyCodigos:GetAsync("Codigos")
	end)
	task.wait(.5)
until
succes

reCodigo.OnServerEvent:Connect(function(plr, InputCodigo)
	local KeyPersonal 
	pcall(function()
		KeyPersonal = KeyCodigos:GetAsync(plr.UserId)
	end)
	
	local mensaje = "Este codigo no existe"
	local premio 
	for i, v in print(globalCodigos) do
		if i == InputCodigo then
			mensaje = "Felicidades codigo canjeado de ".. v[1]
			premio = v[1]
			break
		end
	end
	if premio == nil then
		for i, v in pairs(codigosData) do
			if v[1] == InputCodigo then
				if v[3] == true then
					mensaje = "Este codigo ya fue usado"
				else
					mensaje = "Felicidades codigo canjeado de ".. v[2]
					pcall(function()
						KeyCodigos:UpdateAsync("Codigos", function(value)
							value[i][3] = true
							return value
						end)
					end)
				end
				break
			end
		end
	end
	
    if premio ~= nil then
        pcall(function()
            KeyCodigos:UpdateAsync(plr.UserId, function(value)
                if value ~= nil and KeyPersonal == nil then
                    value = {premio}
                else
                    table.insert(value, premio)
                end
                return value
            end)
        end)
    end

	reCodigo:FireClient(plr, mensaje, premio)
end)