local ReplicatedStorage = game:GetService("ReplicatedStorage")
local plrs = game:GetService("Players")

local modulePart = require(ReplicatedStorage.Module.PartModule)
local moduleTween = require(ReplicatedStorage.Module.TweenMaster)
local TextoData = require(ReplicatedStorage.Module.Data.TextoIdiomas)

repeat
	task.wait()
until plrs.LocalPlayer

local plr = plrs.LocalPlayer
local plrGui = plr.PlayerGui
local pais = plr:WaitForChild("Datos").Pais

local guiPlanoCartesiano = plrGui:WaitForChild("Experimentos").PlanoCartesianoGui

local folderResource = guiPlanoCartesiano.Resource
local folderValue = folderResource.Value
local folderSonido = folderResource.Sonidos

local configuracionesGui = guiPlanoCartesiano.Configuraciones
local datosGui = guiPlanoCartesiano.Datos

modulePart.automaticSize(configuracionesGui.Selector.ScrollingFrame)

--------------------[Ocultar / Mostrar configuracion y datos]
local sz = {
	[false] = UDim2.fromScale(1, 4.88),
	[true] = UDim2.fromScale(1, 0.292),
}

folderValue.Entrar:GetPropertyChangedSignal("Value"):Connect(function()
	moduleTween:FastTween(
		configuracionesGui.Selector,
		{ Enum.EasingStyle.Circular, Enum.EasingDirection.Out, 0.3, { Size = sz[folderValue.Entrar.Value] } }
	)
	moduleTween:FastTween(configuracionesGui.Entrar, {
		Enum.EasingStyle.Back,
		Enum.EasingDirection.Out,
		0.1,
		{ Rotation = configuracionesGui.Entrar.Rotation + 180 },
	})
	configuracionesGui.Selector.ScrollingFrame.Visible = not folderValue.Entrar.Value
end)

configuracionesGui.Entrar.MouseButton1Click:Connect(function()
	folderSonido.SonidoClick:Play()
	folderValue.Entrar.Value = not folderValue.Entrar.Value
end)

--ver/ quitar datos gui
local turnoDatosGui = false
datosGui.TextButton.MouseButton1Click:Connect(function()
	local posX
	if turnoDatosGui == false then
		datosGui.TextButton.Text = "<"
		posX = 0.9
	else
		datosGui.TextButton.Text = ">"
		posX = 0.625
	end
	moduleTween:FastTween(datosGui, {
		Enum.EasingStyle.Circular,
		Enum.EasingDirection.In,
		0.5,
		{ Position = UDim2.fromScale(posX, datosGui.Position.Y.Scale) },
	})

	turnoDatosGui = not turnoDatosGui
end)

---
for _, v in pairs(configuracionesGui.Selector.ScrollingFrame:GetChildren()) do
	if v:IsA("Frame") then
		local tb = v:FindFirstChildOfClass("TextBox")
		tb.MouseEnter:Connect(function()
			guiPlanoCartesiano.TextData.Visible = true
			guiPlanoCartesiano.TextData.TextLabel.Text = TextoData[pais.Value]["PlanoCartesiano"][v.Name]
		end)
		tb.MouseLeave:Connect(function()
			guiPlanoCartesiano.TextData.Visible = false
		end)
	end
end

-- sonido al poner el mouse arriba del gui
for _, v in pairs(guiPlanoCartesiano:GetDescendants()) do
	if v:IsA("GuiButton") then
		v.MouseEnter:Connect(function()
			folderSonido.MouseEnter:Play()
		end)
	end
end

---
local salir = {}

for _, v in pairs(guiPlanoCartesiano:GetChildren()) do
	if v:IsA("GuiBase") then
		table.insert(salir, v)
	end
end

datosGui.X.MouseButton1Click:Connect(function()
	modulePart.EntrarTs(salir, false)
	datosGui.Position = UDim2.fromScale(0.9, datosGui.Position.Y.Scale)
	datosGui.TextButton.Text = "<"

	configuracionesGui.Entrar.Rotation = 0
	configuracionesGui.Selector.Size = UDim2.fromScale(1, 0.211)

	for _, v in pairs(configuracionesGui.Selector.ScrollingFrame:GetChildren()) do
		if v:IsA("TextBox") then
			v.Text = ""
		end
	end

	ReplicatedStorage.Value.AdentroJuego.Value = false
end)
