local module = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local plrs = game:GetService("Players")

repeat
	task.wait()
until plrs.LocalPlayer
local plr = plrs.LocalPlayer

local moduleTween = require(ReplicatedStorage.Module.TweenMaster)
local modulePart = require(ReplicatedStorage.Module.PartModule)
local TextoData = require(ReplicatedStorage.Module.Data.TextoIdiomas)
local ImagenesData = require(ReplicatedStorage.Module.Data.DataImagenes)
local data = require(ReplicatedStorage.Module.Data.DataPreguntas)

local Instancias = ReplicatedStorage.Resource

local folderSonido = Instancias.sonidos
local folderControles = ReplicatedStorage.Value.ControlesVetty

local adentroAjustes = ReplicatedStorage.Value.AdentroAjustes
local adentro = ReplicatedStorage.Value.Adentro

local clickValue = folderControles.Click
local bloqueoValue = folderControles.Bloqueo
local temaValue = folderControles.Tema
local estadoValue = folderControles.Estado
local posicion = folderControles.Posicion

local VettyGui = plr.PlayerGui:WaitForChild("VettyScreenGui")

local frame = VettyGui.Frame
local Vetty = VettyGui.Frame.Vetty

local subtema = ""
local salirDelay = false
local terminar = false

local pais = plr:WaitForChild("Datos"):FindFirstChild("Pais")

--texto

--1 frame, 2 betty
function module.crearTexto(tabla)
	if terminar == true then
		return
	end
	terminar = true
	estadoValue.Value = "Lectura"
	bloqueoValue.Value = false

	for i = 1, #tabla do
		clickValue.Value = false
		local str = tabla[i][1]
		posicion.Value = tabla[i][2]
		local textLabel = Instancias.TextLabel:Clone()
		textLabel.Parent = frame.Frame

		moduleTween:FastTween(Vetty, {
			Enum.EasingStyle.Back,
			Enum.EasingDirection.Out,
			0.05,
			{
				Rotation = 10,
				Position = UDim2.fromScale(Vetty.Position.X.Scale + 0.05, Vetty.Position.Y.Scale - 0.1),
			},
			0,
			true,
		})

		moduleTween:FastTween(Vetty, {
			Enum.EasingStyle.Back,
			Enum.EasingDirection.Out,
			0.05,
			{
				Rotation = 10,
				Position = UDim2.fromScale(Vetty.Position.X.Scale + 0.05, Vetty.Position.Y.Scale + 0.05),
			},
			0,
			true,
		})

		Vetty.Image = ImagenesData[posicion.Value]["Abierto"]
		for q = 1, #str do
			if clickValue.Value == true then
				clickValue.Value = false
				break
			end

			if tabla[i][3] then
				textLabel.Position = UDim2.fromScale(0.764, 0.5)
				textLabel.Size = UDim2.fromScale(0.445, 0.923)
				frame.Frame.ImageLabel.Image = "rbxassetid://" .. tostring(tabla[i][3])
				frame.Frame.ImageLabel.Visible = true
			else
				textLabel.Position = UDim2.fromScale(0.5, 0.5)
				textLabel.Size = UDim2.fromScale(0.962, 0.923)
				frame.Frame.ImageLabel.Visible = false
			end

			task.wait(0.04)
			textLabel.Text = string.sub(str, 1, q)
			----
			--repararlo
			if _G.DataConfi.Sonido > 0 then
				local sonido = folderSonido.Hablar:Clone()
				sonido.PitchShiftSoundEffect.Octave = Random.new():NextNumber(1.5, 2)
				sonido.Volume = Random.new():NextNumber(0.1, folderSonido.Hablar.Volume)
				sonido.PlaybackSpeed = Random.new():NextNumber(2, 3)
				sonido.Parent = Instancias.basura
				sonido:Play()
			end
		end
		for _, v in pairs(Instancias.basura:GetChildren()) do
			v:Destroy()
		end
		frame.Avance.Visible = true
		textLabel.Text = str
		bloqueoValue.Value = true
		repeat
			task.wait()
		until clickValue.Value == true
		textLabel:Destroy()
		clickValue.Value = false
		bloqueoValue.Value = false
		frame.Avance.Visible = false
	end
	posicion.Value = "Normal"
	Vetty.Image = ImagenesData[posicion.Value]["Abierto"]
	bloqueoValue.Value = true
	estadoValue.Value = "Eleccion"
	terminar = false

	frame.Titulo.Text = ""
	moduleTween:WaitTween(
		frame.Titulo,
		{ Enum.EasingStyle.Back, Enum.EasingDirection.In, 0.1, { Size = UDim2.fromScale(0, 0.15) } }
	)
	frame.Titulo.Visible = false
end

--textButton crear Nombre
local function crearSeleccion(v: TextButton)
	v.MouseEnter:Connect(function()
		folderSonido.MouseEnter:Play()
	end)

	v.MouseButton1Click:Connect(function()
		if salirDelay == true then
			return
		end
		folderSonido.SonidoClick:Play()
		local sf = frame.Frame.ScrollingFrame:Clone()
		sf.Parent = frame.Frame
		for _, txb in pairs(sf:GetChildren()) do
			if txb:IsA("TextButton") then
				txb:Destroy()
			end
		end
		frame.Frame.ScrollingFrame.Visible = false
		--creo otra subtabla

		local button = Instancias.TextButton:Clone()
		button.Name = "Regresar"
		button.Text = TextoData[pais.Value]["Regresar"]
		button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		button.TextColor3 = Color3.fromRGB(255, 255, 255)
		button.Parent = sf

		button.MouseButton1Click:Connect(function()
			frame.Titulo.Visible = false
			folderSonido.SonidoClick:Play()
			sf:Destroy()
			frame.Frame.ScrollingFrame.Visible = true
		end)
		button.MouseEnter:Connect(function()
			folderSonido.MouseEnter:Play()
		end)

		sf.Visible = true
		subtema = v.Name
		local layout = 1
		sf.CanvasSize = UDim2.fromScale(0, 0)
		print(data[pais.Value], pais.Value, temaValue.Value)
		for name, _ in pairs(data[pais.Value][temaValue.Value][v.Name]) do
			local txb = Instancias.TextButton:Clone()
			txb.Name = name
			txb.Text = name
			txb.Parent = sf
			txb.LayoutOrder = layout
			layout += 1
			txb.MouseButton1Click:Connect(function()
				frame.Titulo.Text = subtema

				frame.Titulo.Visible = true
				frame.Titulo.Text = v.Name .. " - " .. txb.Name
				moduleTween:FastTween(
					frame.Titulo,
					{ Enum.EasingStyle.Circular, Enum.EasingDirection.Out, 0.1, { Size = UDim2.fromScale(0.4, 0.15) } }
				)
				folderSonido.SonidoClick:Play()

				sf:Destroy()
				module.crearTexto(data[pais.Value][temaValue.Value][v.Name][txb.Name])
				frame.Frame.ScrollingFrame.Visible = true
			end)
			txb.MouseEnter:Connect(function()
				folderSonido.MouseEnter:Play()
			end)
		end
		modulePart.automaticSize(sf)
	end)
end

function module.crearTxb()
	frame.Frame.ScrollingFrame.UIGridLayout.CellSize = UDim2.fromScale(0.9, 1)
	frame.Frame.ScrollingFrame.Salir.Text = TextoData[pais.Value]["Salir"]
	for _, v in pairs(frame.Frame.ScrollingFrame:GetChildren()) do
		if v:IsA("TextButton") and v.Name ~= "Salir" then
			v:Destroy()
		end
	end
	frame.Frame.ScrollingFrame.CanvasSize = UDim2.fromScale(0, 0)
	frame.Frame.ScrollingFrame.UIGridLayout.CellSize = UDim2.fromScale(0.9, 1 / 1.5)
	local layout = 1
	for i, _ in pairs(data[pais.Value][temaValue.Value]) do
		local txb = Instancias.TextButton:Clone()
		txb.Name = i
		txb.Text = i
		txb.Parent = frame.Frame.ScrollingFrame
		txb.LayoutOrder = layout
		layout += 1
		crearSeleccion(txb)
	end
	modulePart.automaticSize(frame.Frame.ScrollingFrame)
end

local tbVisible = {}
--boton de salir
function module:Salir(despedida: boolean)
	salirDelay = true

	moduleTween:FastTween(frame.Fondo, {
		Enum.EasingStyle.Back,
		Enum.EasingDirection.Out,
		0.3,
		{ Position = UDim2.fromScale(0.326, 0.594), Rotation = 0 },
	})

	frame.Fondo.BackgroundTransparency = 1

	if despedida == true then
		self.crearTexto(data[pais.Value]["Despedida"])
	end
	estadoValue.Value = "Lectura"
	moduleTween:FastTween(
		frame,
		{ Enum.EasingStyle.Back, Enum.EasingDirection.In, 0.3, { Position = UDim2.fromScale(2, 0.5), Rotation = 10 } }
	)
	adentro.Value = false
	salirDelay = false
	for _, v in pairs(tbVisible) do
		v.Visible = true
	end
	table.clear(tbVisible)
end
--boton de entrar

function module:Entrar(entrar: boolean)
	if adentro.Value == true or adentroAjustes.Value == true then
		return
	end
	for _, v in pairs(plr.PlayerGui.Experimentos:GetDescendants()) do
		if v:IsA("GuiBase") and v.Visible == true then
			v.Visible = false
			table.insert(tbVisible, v)
		end
	end
	adentro.Value = true
	folderSonido.SonidoClick:Play()
	frame.Fondo.BackgroundTransparency = 0

	moduleTween:WaitTween(frame, {
		Enum.EasingStyle.Back,
		Enum.EasingDirection.Out,
		0.1,
		{ Position = UDim2.fromScale(0.5, 0.5), Rotation = 0 },
	})
	moduleTween:FastTween(frame.Fondo, {
		Enum.EasingStyle.Bounce,
		Enum.EasingDirection.Out,
		1,
		{ Position = UDim2.fromScale(0.353, 0.653), Rotation = 5 },
	})

	if entrar == true then
		self.crearTexto(data[pais.Value]["Base"])
	end
end

function module:Pack(tb)
	self:Entrar(false)
	self.crearTexto(tb)
	self:Salir(false)
end

return module
