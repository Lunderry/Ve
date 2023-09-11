--[[Movimiento]]

local module = {}
--[[Service]]
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--[[Module]]
local moduleTween = require(ReplicatedStorage.Module.TweenMaster)
local modulePart = require(ReplicatedStorage.Module.PartModule)
local data = require(script.Data)

repeat
	task.wait(0.1)
until Players.LocalPlayer

local plr = Players.LocalPlayer
local plrGui = plr:WaitForChild("PlayerGui")

local adentroJuego = ReplicatedStorage.Value.AdentroJuego
local transicion = ReplicatedStorage.Value.Transicion

function module.ConversionGui(nombre: string)
	local Experimento = plrGui:WaitForChild("Experimentos")[nombre .. "Gui"]

	local turno = {}
	for _, v in Experimento.CanvasGroup:GetChildren() do
		turno[v.Name] = false

		local ImageButton = v.Frame:FindFirstChildOfClass("ImageButton")

		ImageButton.MouseButton1Click:Connect(function()
			turno[v.Name] = not turno[v.Name]

			moduleTween:FastTween(v, {
				Enum.EasingStyle.Circular,
				Enum.EasingDirection.Out,
				0.3,
				{ Position = UDim2.fromScale(data.PropTurno[turno[v.Name]][1], v.Position.Y.Scale) },
			})
			moduleTween:FastTween(ImageButton, {
				Enum.EasingStyle.Back,
				Enum.EasingDirection.Out,
				0.3,
				{ Rotation = data.PropTurno[turno[v.Name]][2] },
			})
		end)
	end
end

function module.Gui(nombre: string)
	local Experimentos = plrGui:WaitForChild("Experimentos")[nombre .. "Gui"]
	local DatosGui = Experimentos.Datos

	local turnoDatosGui = true

	DatosGui.TextButton.MouseButton1Click:Connect(function()
		DatosGui.TextButton.Text = data.PropTurno[turnoDatosGui][4]
		moduleTween:FastTween(DatosGui, {
			Enum.EasingStyle.Back,
			Enum.EasingDirection.Out,
			0.2,
			{ Position = UDim2.fromScale(data.PropTurno[turnoDatosGui][3], DatosGui.Position.Y.Scale) },
		})

		turnoDatosGui = not turnoDatosGui
	end)

	Experimentos.TextBox.Value:GetPropertyChangedSignal("Value"):Connect(function()
		Experimentos.TextBox.Text = tostring(Experimentos.TextBox.Value.Value) .. "x"
	end)
	Experimentos.TextBox.FocusLost:Connect(function()
		if tonumber(Experimentos.TextBox.Text) then
			Experimentos.TextBox.Value.Value = Experimentos.TextBox.Text
		end
		Experimentos.TextBox.Text = tostring(Experimentos.TextBox.Value.Value) .. "x"
	end)

	local tb = {}
	for _, v in Experimentos:GetChildren() do
		if v:IsA("GuiBase") then
			table.insert(tb, v)
		end
	end
	DatosGui.X.MouseButton1Click:Connect(function()
		adentroJuego.Value = false
		modulePart.EntrarTs(tb, false)
		transicion.Value = false
	end)
end
return module
