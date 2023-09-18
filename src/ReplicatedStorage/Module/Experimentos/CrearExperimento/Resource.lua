local Resource = {}

--[[Service]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local expFolder = ReplicatedStorage.ExpFolder

function Resource.buscarObjetos(tb, orden, lugar, Estado: string)
	local obj = {}
	for _, v in tb[orden] do
		if typeof(v) ~= "table" then
			if lugar:FindFirstChild(v) then
				table.insert(obj, lugar[v].Value)
			else
				error("No se encuentra el objeto")
			end
		end
	end
	if Estado == "Normal" then
		table.insert(obj, expFolder[tb.Nombre].Estados.Eleccion.Value)
	elseif Estado == "CambioNormal" then
		table.insert(obj, "Cambio" .. expFolder[tb.Nombre].Estados.Eleccion.Value)
	elseif Estado ~= "X" then
		table.insert(obj, Estado)
	end
	return obj
end

function Resource.ValueUnpack(lista, folder, tiempo, EleccionBasta)
	local tb = {}
	for _, v in lista do
		if v == "Tiempo" and tiempo ~= nil then
			table.insert(tb, tiempo)
		else
			table.insert(tb, folder[v].Value)
		end
	end
	if EleccionBasta ~= nil then
		table.insert(tb, EleccionBasta)
	end
	return tb
end

function Resource:activarFuncion(tbEscanear, folderNombre, Propiedades, GetPropertyChangedSignalDisconnect)
	local folderProps = folderNombre.Props
	local folderJuego = workspace[Propiedades.Nombre]

	for _, v in tbEscanear do
		local guardarConnect = folderProps[v]:GetPropertyChangedSignal("Value"):Connect(function()
			local caluculo = Propiedades.Calculos(table.unpack(self.ValueUnpack(Propiedades.PonerCalculo, folderProps)))
			local divisor = caluculo.TiempoMaximo / 20

			for i = 1, 20 do
				task.delay(0, function()
					local func = Propiedades.Funcion(
						table.unpack(self.ValueUnpack(Propiedades.PonerFuncion, folderProps, divisor * i, "Contador"))
					)
					folderJuego.Seguimiento[i].Position = Propiedades.Sumar(func)

					task.wait()
					if i < 20 then
						folderJuego.Seguimiento[i].CFrame =
							CFrame.lookAt(folderJuego.Seguimiento[i].Position, folderJuego.Seguimiento[i + 1].Position)
					end
				end)
			end
		end)
		table.insert(GetPropertyChangedSignalDisconnect, guardarConnect)
	end
end

function Resource.findCompleto(tb: {}, buscar)
	for _, v in tb do
		if v == buscar or (type(v) == "table" and v[1] == buscar) then
			return true
		end
	end
	return false
end

local aprobado = {
	"-",
	".",
}
function Resource.NumeroTextBox(TextBox: TextBox)
	TextBox.FocusLost:Connect(function()
		local str = string.sub(TextBox.Text, 1, 1)
		if tonumber(str) or table.find(aprobado, str) then
			return
		end
		TextBox.Text = ""
	end)
end
return Resource
