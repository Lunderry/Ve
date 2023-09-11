local ReplicatedStorage = game:GetService("ReplicatedStorage")

local cargarPlano = ReplicatedStorage.re["Cliente-Server"].CargarPlano
local planoCartesiano = workspace.PlanoCartesiano
local p = planoCartesiano.Crear

cargarPlano.OnServerEvent:Connect(function(plr, numero)
	local NumeroX, NumeroY = numero[1], numero[2]
	local piezas = {}
	local centro
	local mitadX = math.ceil(NumeroX / 2) - 1
	local mitadY = math.ceil(NumeroY / 2) - 1

	for _, v in ipairs(planoCartesiano.Collider.Model:GetChildren()) do
		local posX, posY = v.Position.X - p.Position.X, v.Position.Y - p.Position.Y
		if posX < NumeroX and posY < NumeroY then
			if mitadY == posY and mitadX == posX then
				centro = v
			else
				table.insert(piezas, v)
			end
		end
	end

	cargarPlano:FireClient(plr, piezas, centro)
end)
