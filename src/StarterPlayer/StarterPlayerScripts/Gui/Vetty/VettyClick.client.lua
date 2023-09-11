local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local moduleTween = require(ReplicatedStorage.Module.TweenMaster)
local vettyFuncion = require(ReplicatedStorage.Module.VettyFuncion)

repeat
    task.wait()
until Players.LocalPlayer

local plr = Players.LocalPlayer
local plrGui = plr.PlayerGui

local vettyScreenGui = plrGui.VettyScreenGui
local baseGui = vettyScreenGui.Frame

local botonEntrar = vettyScreenGui.Entrar
local sombraBoton = vettyScreenGui.Mov

botonEntrar.MouseButton1Click:Connect(function()
	vettyFuncion:Entrar(true)
end)

botonEntrar.MouseEnter:Connect(function()
	botonEntrar.Rotation = -5
	sombraBoton.Rotation = -8
	moduleTween:FastTween(botonEntrar, {Enum.EasingStyle.Circular, Enum.EasingDirection.InOut, .3, {Size = UDim2.fromScale(.109, .195)}})
	moduleTween:FastTween(sombraBoton, {Enum.EasingStyle.Circular, Enum.EasingDirection.InOut, .15, {Position = UDim2.fromScale(.064, .934)}})
end)

botonEntrar.MouseLeave:Connect(function()
	moduleTween:FastTween(sombraBoton, {Enum.EasingStyle.Circular, Enum.EasingDirection.InOut, .05, {Position = UDim2.fromScale(.058, .918), Rotation = 0}})
	moduleTween:FastTween(botonEntrar, {Enum.EasingStyle.Circular, Enum.EasingDirection.InOut, .05,  {Rotation = 0, Size = UDim2.fromScale(.097, .192)}})
end)

baseGui.Frame.ScrollingFrame.Salir.MouseButton1Click:Connect(function()
	vettyFuncion:Salir(true)
end)