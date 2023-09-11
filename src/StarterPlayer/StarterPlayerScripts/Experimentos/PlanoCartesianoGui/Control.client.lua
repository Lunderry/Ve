local ReplicatedStorage = game:GetService("ReplicatedStorage")
local plrs = game:GetService("Players")

repeat
	task.wait()
until plrs.LocalPlayer

local plr = plrs.LocalPlayer
local plrGui = plr.PlayerGui
local pais = plr:WaitForChild("Datos").Pais

local guiPlanoCartesiano = plrGui:WaitForChild("Experimentos").PlanoCartesianoGui

local moduleTween = require(ReplicatedStorage.Module.TweenMaster)
local modulePart = require(ReplicatedStorage.Module.PartModule)
local textoData = require(ReplicatedStorage.Module.Data.TextoIdiomas)
local sd = require(script.Parent.ModuleScript)

local EntreVector = 1

local pos = {
	["arriba"] = Vector3.new(0, EntreVector, 0),
	["izquierda"] = Vector3.new(-EntreVector, 0, 0),
	["derecha"] = Vector3.new(EntreVector, 0, 0),
	["abajo"] = Vector3.new(0, -EntreVector, 0),
	["izqAba"] = Vector3.new(-EntreVector, -EntreVector, 0),
	["izqArr"] = Vector3.new(-EntreVector, EntreVector, 0),
	["derAba"] = Vector3.new(EntreVector, -EntreVector, 0),
	["derArr"] = Vector3.new(EntreVector, EntreVector, 0),
}

local nivel2 = ReplicatedStorage.Value.Fisica.Nivel2

local centro = nivel2.CentroVector
local size = nivel2.Size
local mover = nivel2.Mover

local espera = false

local posVerticeX, posVerticeY = 0, 0

local function mov(suma)
	if espera == true then
		return
	end
	espera = true

	local w = (mover.Value.Position + suma) - centro.Value
	posVerticeX = w.X
	posVerticeY = w.Y

	if
		posVerticeX < size.Value.X
		and posVerticeX > -size.Value.X
		and posVerticeY < size.Value.Y
		and posVerticeY > -size.Value.Y
	then
		mover.Value.Position += suma
		sd.sacarData()
	end
	espera = false
end

--botones Gui
local eror = guiPlanoCartesiano.TextError

local down = false
local rep = guiPlanoCartesiano.Controles.Rep
for _, v in pairs(guiPlanoCartesiano.Controles.Frame:GetChildren()) do
	if v:IsA("GuiButton") then
		v.MouseEnter:Connect(function()
			if down == false then
				return
			end
			if mover.Value == nil then
				return
			end
			moduleTween:FastTween(
				v,
				{ Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 0.1, { Size = UDim2.fromScale(0.3, 0.3) } }
			)
			rep.Value = pos[v.Name]
			mov(pos[v.Name])
		end)
		v.MouseButton1Down:Connect(function()
			down = true
			if mover.Value == nil then
				modulePart.Error(eror, textoData[pais.Value]["Errores"][3])
				return
			end
			for _, q in pairs(script.Parent:GetChildren()) do
				if q.Name == "TextButton" then
					q.Visible = true
				end
			end
			moduleTween:FastTween(
				v,
				{ Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 0.1, { Size = UDim2.fromScale(0.3, 0.3) } }
			)
			rep.Value = pos[v.Name]
			mov(pos[v.Name])
		end)
		v.MouseButton1Up:Connect(function()
			for _, q in pairs(guiPlanoCartesiano.Controles:GetChildren()) do
				if q.Name == "TextButton" then
					q.Visible = false
				end
			end
			rep.Value = Vector3.zero
			moduleTween:FastTween(
				v,
				{ Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 0.1, { Size = UDim2.fromScale(0.249, 0.249) } }
			)
			down = false
		end)
		v.MouseLeave:Connect(function()
			moduleTween:FastTween(
				v,
				{ Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 0.1, { Size = UDim2.fromScale(0.249, 0.249) } }
			)
			rep.Value = Vector3.zero
		end)
	end
end

for _, v in pairs(guiPlanoCartesiano.Controles:GetChildren()) do
	if v:IsA("GuiButton") then
		v.MouseEnter:Connect(function()
			down = false
			for _, q in pairs(guiPlanoCartesiano.Controles:GetChildren()) do
				if q.Name == "TextButton" then
					q.Visible = false
				end
			end
		end)
	end
end

local tiempo = 0
local cont = 3

rep:GetPropertyChangedSignal("Value"):Connect(function()
	if rep.Value == Vector3.zero then
		return
	end
	while rep.Value ~= Vector3.zero do
		if tiempo >= cont then
			mov(rep.Value)
			cont -= 0.1
			if cont < 1 then
				cont = 1
			end
		end
		tiempo += 0.1
		task.wait()
	end
	cont = 3
	tiempo = 0
end)
