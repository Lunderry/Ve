local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local plrs = game:GetService("Players")

repeat
	task.wait(.1)
until plrs.LocalPlayer

local plr = plrs.LocalPlayer
local plrGui = plr.PlayerGui
local mouse = plr:GetMouse()

local moduleTween = require(ReplicatedStorage.Module.TweenMaster)
local ImagenesData = require(ReplicatedStorage.Module.Data.DataImagenes)
local vettyFuncion = require(ReplicatedStorage.Module.VettyFuncion)

local Poses = {
	[1] = "Normal",
	[2] = "Listo",
	[3] = "Dato",
	[4] = "Pensando",
	[5] = "Escribiendo",
	[6] = "Saludando",
	[7] = "Lentes",
	[8] = "Incomoda",
	[9] = "Risa",
	[10] = "Mareada",
}
local estado = {
	[1] = "Abierto",
	[2] = "Cerrado",
	[3] = "Ojos",
}

local vettyScreenGui = plrGui.VettyScreenGui
local vettyAjustes = vettyScreenGui.VettyAjustes

local frame = vettyScreenGui.Frame
local vettyImage = frame.Vetty

local folderSonido = vettyAjustes.sonidos
local folderControles = ReplicatedStorage.Value.ControlesVetty

local adentro = ReplicatedStorage.Value.Adentro

local tema = folderControles.Tema
local click = folderControles.Click
local bloqueo = folderControles.Bloqueo
local estadoValue = folderControles.Estado
local posicion = folderControles.Posicion

local pais = plr:WaitForChild("Datos"):FindFirstChild("Pais")

--cargando imagenes
frame.Position = UDim2.fromScale(2, 0.5)
frame.Rotation = 10

--cargue
task.spawn(function()
	for e = 1, #Poses do
		for p = 1, 3 do
			if ImagenesData[Poses[e]][estado[p]] then
				local cargaClon = vettyAjustes.carga:Clone()
				cargaClon.Visible = true
				cargaClon.Name = Poses[e] .. " " .. estado[p]
				cargaClon.Image = ImagenesData[Poses[e]][estado[p]]
				cargaClon.Parent = vettyAjustes.Parent.Imagenes
				repeat
					task.wait()
				until cargaClon.IsLoaded == true
				cargaClon.Visible = false
			end
		end
	end
	print("Vetty esta cargada")
	ReplicatedStorage.Carga.CargaVetty.Value = true
end)

--parpadie
local ojos = 1
local rd = math.random(10, 20)
repeat
	rd = Random.new():NextInteger(10, 20)
until rd % 2 == 0

--saber si esta adentro o no para el blur
adentro:GetPropertyChangedSignal("Value"):Connect(function()
	if adentro.Value == true then
		moduleTween:FastTween(
			Lighting.Blur,
			{ Enum.EasingStyle.Circular, Enum.EasingDirection.Out, 0.5, { Size = 24 } }
		)

		while adentro.Value do
			ojos += 1
			if ojos >= rd then
				ojos = 1
				repeat
					rd = Random.new():NextInteger(10, 20)
				until rd % 2 == 0
				if ImagenesData[posicion.Value]["Ojos"] then
					vettyImage.Image = ImagenesData[posicion.Value]["Ojos"]
				end
			end
			task.wait(0.04)
			if bloqueo.Value == false then
				for i = 1, 2 do
					task.wait(0.04)
					if i % 2 == 0 then
						vettyImage.Image = ImagenesData[posicion.Value][estado[1]]
					else
						vettyImage.Image = ImagenesData[posicion.Value][estado[2]]
					end
				end
			else
				vettyImage.Image = ImagenesData[posicion.Value]["Cerrado"]
			end
		end
	else
		moduleTween:FastTween(
			Lighting.Blur,
			{ Enum.EasingStyle.Circular, Enum.EasingDirection.Out, 0.2, { Size = 0 } }
		)
	end
end)

--click para avanzar
mouse.Button1Up:Connect(function()
	if click.Value == true then
		return
	end
	click.Value = true
end)

--
vettyFuncion.crearTxb()
pais:GetPropertyChangedSignal("Value"):Connect(function()
	vettyFuncion.crearTxb()
end)
tema:GetPropertyChangedSignal("Value"):Connect(function()
	vettyFuncion.crearTxb()
end)

estadoValue:GetPropertyChangedSignal("Value"):Connect(function()
	moduleTween:WaitTween(frame.Frame, {
		Enum.EasingStyle.Circular,
		Enum.EasingDirection.Out,
		0.1,
		{ Size = UDim2.fromScale(frame.Frame.Position.Y.Scale, 0) },
	})

	folderSonido.Deslizar:Play()
	for _, v in pairs(frame.Frame:GetChildren()) do
		if v:IsA("GuiObject") then
			v.Visible = false
		end
	end
	if estadoValue.Value == "Eleccion" then
		frame.Frame.ScrollingFrame.Visible = true
	elseif estadoValue.Value == "Lectura" then
		if frame.Frame:FindFirstChildOfClass("TextLabel") then
			frame.Frame.TextLabel.Visible = true
		end
	end
	moduleTween:FastTween(
		frame.Frame,
		{ Enum.EasingStyle.Circular, Enum.EasingDirection.Out, 0.1, { Size = UDim2.fromScale(0.666, 0.745) } }
	)
end)
