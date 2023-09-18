local module = {}
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local moduleTween = require(ReplicatedStorage.Module.TweenMaster)
local moduleOperacion = require(ReplicatedStorage.Module.Operaciones)

local textoData = require(ReplicatedStorage.Module.Data.TextoIdiomas)
local imagenesData = require(ReplicatedStorage.Module.Data.DataImagenes)
local preguntasData = require(ReplicatedStorage.Module.Data.DataPreguntas)

repeat
	task.wait(0.1)
until Players.LocalPlayer

local plr = Players.LocalPlayer
local plrGui = plr:WaitForChild("PlayerGui")
local mouse: Mouse = plr:GetMouse()

local resource: Folder = ReplicatedStorage.Resource

local folderSonido: Folder = resource.Sonidos
local folderControles: Folder = ReplicatedStorage.Value.ControlesVetty

local adentroValue: BoolValue = ReplicatedStorage.Value.Adentro

local clickValue: BoolValue = folderControles.Click
local bloqueoValue: BoolValue = folderControles.Bloqueo
local estadoValue: StringValue = folderControles.Estado
local poseValue: StringValue = folderControles.Pose

local screenVettyGui: ScreenGui = plrGui:WaitForChild("VettyScreenGui")

local interfaz: Frame = screenVettyGui.Interfaz
local contenido: Frame = interfaz.Contenido

local scrollingConversacion: ScrollingFrame = contenido.ScrollingFrame
local infoLabel: TextLabel = contenido.TextLabel

local debounceCTexto = false
--
function module.lecturaTexto(tb: {})
	local connectionMouse = mouse.Button1Down:Connect(function()
		clickValue.Value = true
	end)

	if debounceCTexto then
		return
	end
	debounceCTexto = true

	for i = 1, #tb do
		bloqueoValue.Value = false
		clickValue.Value = false
		estadoValue.Value = "Lectura"
		poseValue.Value = tb[i][2]

		moduleTween:FastTween(interfaz.Vetty, {
			Enum.EasingStyle.Back,
			Enum.EasingDirection.InOut,
			0.05,
			{
				Rotation = 10,
				Position = interfaz.Vetty.Position + UDim2.fromScale(0.05, 0.05),
			},
			0,
			true,
		})

		interfaz.Vetty.Image = imagenesData[poseValue.Value]["Abierto"]

		local tskOperacion, tskTexto

		if tb[i][3] then
			infoLabel.Position = UDim2.fromScale(0.5, 0.19)
			infoLabel.Size = UDim2.fromScale(0.962, 0.302)

			tskOperacion = task.defer(function()
				contenido.Operacion.Text = tb[i][3]
				for s = 1, #tb[i][3] do
					contenido.Operacion.Visible = true
					contenido.Operacion.TextLabel.Text = moduleOperacion.TextColor(string.sub(tb[i][3], 1, s))
					task.wait(0.02)
				end
			end)
		else
			infoLabel.Position = UDim2.fromScale(0.5, 0.5)
			infoLabel.Size = UDim2.fromScale(0.962, 0.923)
		end

		tskTexto = task.defer(function()
			for s = 1, #tb[i][1] do
				infoLabel.Text = string.sub(tb[i][1], 1, s)

				local sonido = folderSonido.Hablar:Clone()
				sonido.PitchShiftSoundEffect.Octave = Random.new():NextNumber(1.5, 2)
				sonido.Volume = Random.new():NextNumber(0.1, 0.3)
				sonido.PlaybackSpeed = Random.new():NextNumber(2, 3)
				sonido.Parent = resource.Basura
				sonido:Play()

				for _ = 1, 2 do
					RunService.Heartbeat:Wait()
				end
			end
		end)
		interfaz.Avance.Visible = true
		interfaz.Avance.Text = "Click para terminar"

		repeat
			task.wait(0.1)
		until clickValue.Value or infoLabel.Text == tb[i][1]

		infoLabel.Text = tb[i][1]
		resource.Basura:ClearAllChildren()

		clickValue.Value = false
		bloqueoValue.Value = true

		interfaz.Avance.Text = "Click para avanzar"

		if tskTexto then
			task.cancel(tskTexto)
			if tb[i][3] then
				contenido.Operacion.TextLabel.Text = moduleOperacion.TextColor(tb[i][3])
			end
		end
		if tskOperacion then
			task.cancel(tskOperacion)
		end

		repeat
			clickValue:GetPropertyChangedSignal("Value"):Wait()
		until clickValue.Value

		contenido.Operacion.Visible = false
		clickValue.Value = false

		infoLabel.Text = ""

		interfaz.Avance.Visible = false
	end
	connectionMouse:Disconnect()

	debounceCTexto = false

	bloqueoValue.Value = true
	poseValue.Value = "Normal"
	estadoValue.Value = "Eleccion"

	interfaz.Titulo.Text = ""
	interfaz.Titulo.Visible = false
	interfaz.Vetty.Image = imagenesData[poseValue.Value]["Abierto"]

	moduleTween:FastTween(
		interfaz.Titulo,
		{ Enum.EasingStyle.Back, Enum.EasingDirection.In, 0.1, { Size = UDim2.fromScale(0, 0.15) } }
	)
end

function module:crearSeleccion(tb: {}, completo: {}, seguimientoTurno: {})
	for _, v in scrollingConversacion:GetChildren() do
		if not v:IsA("UIGridLayout") then
			v:Destroy()
		end
	end

	local botonSalir = resource.TextButton:Clone()
	botonSalir.Name = "Salir"
	botonSalir.Text = "Salir"
	botonSalir.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	botonSalir.TextColor3 = Color3.fromRGB(255, 255, 255)
	botonSalir.Parent = scrollingConversacion

	local salirMBC = botonSalir.MouseButton1Click:Connect(function()
		if #seguimientoTurno == 0 then
			self:Salir(true)
			return
		end
		local tbAnterior = completo

		for i = 1, #seguimientoTurno - 1 do
			tbAnterior = tbAnterior[seguimientoTurno[i]]
		end
		table.remove(seguimientoTurno, #seguimientoTurno)
		if #seguimientoTurno == 0 then
			interfaz.SelectorScrolling.Visible = true
		end
		self:crearSeleccion(tbAnterior, completo, seguimientoTurno)
	end)

	local salirDest

	salirDest = botonSalir.Destroying:Connect(function()
		task.delay(0.01, function()
			salirDest:Disconnect()
			salirMBC:Disconnect()
		end)
	end)

	local layout = 1
	for nombre, _ in tb do
		local txb = resource.TextButton:Clone()
		txb.Name = nombre
		txb.Text = nombre
		txb.LayoutOrder = layout
		txb.Parent = scrollingConversacion
		layout += 1

		local botonMBC = txb.MouseButton1Click:Connect(function()
			interfaz.SelectorScrolling.Visible = false

			if tb[nombre][1] then
				for i = 1, #seguimientoTurno do
					if i == 1 then
						interfaz.Titulo.Text = seguimientoTurno[i]
					else
						interfaz.Titulo.Text = interfaz.Titulo.Text .. " - " .. seguimientoTurno[i]
					end
				end
				interfaz.Titulo.Text = interfaz.Titulo.Text .. " - " .. nombre

				interfaz.Titulo.Visible = true

				moduleTween:FastTween(interfaz.Titulo, {
					Enum.EasingStyle.Circular,
					Enum.EasingDirection.Out,
					0.1,
					{ Size = UDim2.fromScale(0.4, 0.15) },
				})

				module.lecturaTexto(tb[nombre])
			else
				table.insert(seguimientoTurno, nombre)
				self:crearSeleccion(tb[nombre], completo, seguimientoTurno)
			end
		end)
		local botonDest

		botonDest = txb.Destroying:Connect(function()
			task.delay(0.01, function()
				botonDest:Disconnect()
				botonMBC:Disconnect()
			end)
		end)
	end
	-- if not cacheMouseButton1Click[nivel] then
	-- 	cacheMouseButton1Click[nivel] = {}
	-- end
	-- for _, v in cache do
	-- 	table.insert(cacheMouseButton1Click[nivel], v)
	-- end
end

local tbVisible = {}
--boton de salir
function module:Salir(despedida: boolean)
	interfaz.Fondo.BackgroundTransparency = 1

	moduleTween:FastTween(interfaz.Fondo, {
		Enum.EasingStyle.Back,
		Enum.EasingDirection.Out,
		0.3,
		{ Position = UDim2.fromScale(0.326, 0.594), Rotation = 0 },
	})

	if despedida then
		self.lecturaTexto(preguntasData["Despedida"])
	end
	moduleTween:FastTween(
		interfaz,
		{ Enum.EasingStyle.Back, Enum.EasingDirection.In, 0.3, { Position = UDim2.fromScale(2, 0.5), Rotation = 10 } }
	)

	for _, v in pairs(tbVisible) do
		v.Visible = true
	end
	table.clear(tbVisible)

	estadoValue.Value = "Lectura"

	adentroValue.Value = false
end
--boton de entrar

function module:Entrar(entrar: boolean)
	if adentroValue.Value then
		return
	end
	for _, v in pairs(plrGui.Experimentos:GetDescendants()) do
		if v:IsA("GuiBase") and v.Visible then
			v.Visible = false
			table.insert(tbVisible, v)
		end
	end

	adentroValue.Value = true
	interfaz.Fondo.BackgroundTransparency = 0

	moduleTween:WaitTween(interfaz, {
		Enum.EasingStyle.Back,
		Enum.EasingDirection.Out,
		0.1,
		{ Position = UDim2.fromScale(0.55, 0.5), Rotation = 0 },
	})
	moduleTween:FastTween(interfaz.Fondo, {
		Enum.EasingStyle.Bounce,
		Enum.EasingDirection.Out,
		1,
		{ Position = UDim2.fromScale(0.353, 0.653), Rotation = 5 },
	})

	if entrar then
		self.lecturaTexto(preguntasData["Base"])
	end
end

function module:Pack(tb)
	self:Entrar(false)
	self.lecturaTexto(tb)
	self:Salir(false)
end

return module
