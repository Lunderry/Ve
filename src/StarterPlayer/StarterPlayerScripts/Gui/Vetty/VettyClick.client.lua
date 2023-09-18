local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local moduleTween = require(ReplicatedStorage.Module.TweenMaster)
local vettyFuncion = require(ReplicatedStorage.Module.VettyFuncion)

repeat
	task.wait(0.1)
until Players.LocalPlayer

local plr = Players.LocalPlayer
local plrGui = plr:WaitForChild("PlayerGui")

local screenVettyGui: ScreenGui = plrGui:WaitForChild("VettyScreenGui")
local interfaz: Frame = screenVettyGui.Interfaz

local botonEntrar: TextButton = screenVettyGui.Entrar
local sombraBoton: TextButton = screenVettyGui.Mov

local temaValue: StringValue = ReplicatedStorage.Value.ControlesVetty.Tema

for _, v in interfaz.SelectorScrolling.ScrollingFrame:GetChildren() do
	if v:IsA("TextButton") then
		v.MouseButton1Click:Connect(function()
			temaValue.Value = v.Name
		end)
	end
end

botonEntrar.MouseButton1Click:Connect(function()
	vettyFuncion:Entrar(true)
end)

botonEntrar.MouseEnter:Connect(function()
	botonEntrar.Rotation = -5
	sombraBoton.Rotation = -8
	moduleTween:FastTween(
		botonEntrar,
		{ Enum.EasingStyle.Circular, Enum.EasingDirection.InOut, 0.3, { Size = UDim2.fromScale(0.109, 0.195) } }
	)
	moduleTween:FastTween(
		sombraBoton,
		{ Enum.EasingStyle.Circular, Enum.EasingDirection.InOut, 0.15, { Position = UDim2.fromScale(0.064, 0.934) } }
	)
end)

botonEntrar.MouseLeave:Connect(function()
	moduleTween:FastTween(sombraBoton, {
		Enum.EasingStyle.Circular,
		Enum.EasingDirection.InOut,
		0.05,
		{ Position = UDim2.fromScale(0.058, 0.918), Rotation = 0 },
	})
	moduleTween:FastTween(botonEntrar, {
		Enum.EasingStyle.Circular,
		Enum.EasingDirection.InOut,
		0.05,
		{ Rotation = 0, Size = UDim2.fromScale(0.097, 0.192) },
	})
end)

interfaz.Contenido.ScrollingFrame.Salir.MouseButton1Click:Connect(function()
	vettyFuncion:Salir(true)
end)
