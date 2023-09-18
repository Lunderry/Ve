local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")

local moduleTween = require(ReplicatedStorage.Module.TweenMaster)

local preguntasData = require(ReplicatedStorage.Module.Data.DataPreguntas)
local imagenesData = require(ReplicatedStorage.Module.Data.DataImagenes)
local vettyFuncion = require(ReplicatedStorage.Module.VettyFuncion)

repeat
	task.wait(0.1)
until Players.LocalPlayer

local plr = Players.LocalPlayer
local plrGui = plr:WaitForChild("PlayerGui")

local resource: Folder = ReplicatedStorage.Resource

local folderSonido: Folder = resource.Sonidos
local folderControles: Folder = ReplicatedStorage.Value.ControlesVetty

local adentroValue: BoolValue = ReplicatedStorage.Value.Adentro

local temaValue: StringValue = folderControles.Tema
local bloqueoValue: BoolValue = folderControles.Bloqueo
local estadoValue: StringValue = folderControles.Estado
local poseValue: StringValue = folderControles.Pose

local screenVettyGui: ScreenGui = plrGui:WaitForChild("VettyScreenGui")

local vettyAjustes: Folder = screenVettyGui.VettyAjustes

local interfaz: Frame = screenVettyGui.Interfaz
local contenido: Frame = interfaz.Contenido

--cargando imagenes
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

interfaz.Position = UDim2.fromScale(2, 0.5)
interfaz.Rotation = 10

--cargue
task.defer(function()
	for e = 1, #Poses do
		for p = 1, 3 do
			if imagenesData[Poses[e]][estado[p]] then
				local cargaClon = vettyAjustes.carga:Clone()
				cargaClon.Visible = true
				cargaClon.Name = Poses[e] .. " " .. estado[p]
				cargaClon.Image = imagenesData[Poses[e]][estado[p]]
				cargaClon.Parent = vettyAjustes.Parent.Imagenes
				repeat
					task.wait(0.1)
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

local rd = Random.new():NextInteger(10, 20)

--saber si esta adentro o no para el blur
adentroValue:GetPropertyChangedSignal("Value"):Connect(function()
	if not adentroValue.Value then
		moduleTween:FastTween(Lighting.Blur, { Enum.EasingStyle.Circular, Enum.EasingDirection.Out, 0.2, { Size = 0 } })
		return
	end
	moduleTween:FastTween(Lighting.Blur, { Enum.EasingStyle.Circular, Enum.EasingDirection.Out, 0.5, { Size = 24 } })

	while adentroValue.Value do
		ojos += 1
		if ojos >= rd then
			ojos = 1
			if imagenesData[poseValue.Value]["Ojos"] then
				interfaz.Vetty.Image = imagenesData[poseValue.Value]["Ojos"]
				repeat
					rd = Random.new():NextInteger(10, 20)
				until rd % 2 == 0
			end
		end
		task.wait(0.04)
		if not bloqueoValue.Value then
			for i = 1, 2 do
				task.wait(0.04)
				if i % 2 == 0 then
					interfaz.Vetty.Image = imagenesData[poseValue.Value][estado[1]]
				else
					interfaz.Vetty.Image = imagenesData[poseValue.Value][estado[2]]
				end
			end
		else
			interfaz.Vetty.Image = imagenesData[poseValue.Value]["Cerrado"]
		end
	end
end)

temaValue:GetPropertyChangedSignal("Value"):Connect(function()
	vettyFuncion:crearSeleccion(preguntasData[temaValue.Value], preguntasData[temaValue.Value], {})
end)

estadoValue:GetPropertyChangedSignal("Value"):Connect(function()
	moduleTween:WaitTween(contenido, {
		Enum.EasingStyle.Circular,
		Enum.EasingDirection.Out,
		0.1,
		{ Size = UDim2.fromScale(contenido.Position.Y.Scale, 0) },
	})

	folderSonido.Deslizar:Play()

	for _, v in pairs(contenido:GetChildren()) do
		if v:IsA("GuiObject") then
			v.Visible = false
		end
	end
	if estadoValue.Value == "Eleccion" then
		contenido.ScrollingFrame.Visible = true
	elseif estadoValue.Value == "Lectura" then
		if contenido:FindFirstChildOfClass("TextLabel") then
			contenido.TextLabel.Visible = true
		end
	end
	moduleTween:FastTween(
		contenido,
		{ Enum.EasingStyle.Circular, Enum.EasingDirection.Out, 0.1, { Size = UDim2.fromScale(0.666, 0.745) } }
	)
end)
