local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local modulePart = require(ReplicatedStorage.Module.PartModule)
local moduleTween = require(ReplicatedStorage.Module.TweenMaster)
local moduleConvertir = require(ReplicatedStorage.Module.ConversionUnidades)

local dataUnidades = require(ReplicatedStorage.Module.ConversionUnidades.DataUnidades)

repeat
	task.wait(0.1)
until Players.LocalPlayer

local plr = Players.LocalPlayer
local plrGui = plr.PlayerGui

local mouse = plr:GetMouse()

local conversionFolder = plrGui:WaitForChild("Experimentos").ConversionNumerosGui
local selectorScrolling = conversionFolder.Selector.ScrollingFrame
local jerarquiaScrolling = conversionFolder.Jerarrquia.ScrollingFrame

local conversorFrame = conversionFolder.Conversor

local parametroUnidades = {
	["Numero"] = nil,
	["Tipo"] = { nil, nil },
}
local referenciaParametro = {
	["UnidadInicio"] = 1,
	["UnidadConversor"] = 2,
}

local cacheTextButton = {}

local movibleTextButton
local nombreButton = ""

local mouseBool = Instance.new("BoolValue")
mouseBool.Name = "mouseBool"

local function crearTextButton(nombre: string, orden: number)
	if selectorScrolling:FindFirstChild(nombre) then
		return
	end
	local TextButton = Instance.new("TextButton")
	TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
	-- TextButton.Font = Font.fromId(12187362578)
	TextButton.Size = UDim2.fromScale(0.9, 0.2)
	TextButton.LayoutOrder = orden
	TextButton.Name = nombre
	TextButton.Text = nombre
	TextButton.Parent = selectorScrolling

	local UITextSizeConstraint = Instance.new("UITextSizeConstraint")
	UITextSizeConstraint.MaxTextSize = 30

	UITextSizeConstraint.Parent = TextButton

	cacheTextButton[#cacheTextButton + 1] = TextButton.InputBegan:Connect(function(inp, gpe)
		if gpe then
			return
		end

		if inp.UserInputType == Enum.UserInputType.MouseButton1 then
			nombreButton = TextButton.Name
			mouseBool.Value = true
		end
	end)
	cacheTextButton[#cacheTextButton + 1] = TextButton.InputEnded:Connect(function(inp, gpe)
		if gpe then
			return
		end
		if inp.UserInputType == Enum.UserInputType.MouseButton1 then
			mouseBool.Value = false
		end
	end)
end

local function convetirDatos()
	if parametroUnidades.Numero ~= nil and parametroUnidades.Tipo[1] ~= nil and parametroUnidades.Tipo[2] ~= nil then
		local text, seguimiento = moduleConvertir:ConvertidorSeguimiento(parametroUnidades)

		conversorFrame.Resultado.Text = modulePart.Coma(text) .. parametroUnidades.Tipo[2]

		for _, v in conversionFolder.Explicacion.ScrollingFrame:GetChildren() do
			if v:IsA("Frame") then
				v:Destroy()
			end
		end

		local cont = 0

		for i = 1, #seguimiento do
			cont += 1
			local seg = seguimiento[i]

			local explicacionFrame = ReplicatedStorage.Resource.ExplicacionPlantilla:Clone()
			explicacionFrame.Escritura.TextLabel.Text = seg[1]
			explicacionFrame.Escritura.TextLabel.TextColor3 = seg[2]
			explicacionFrame.Numero.Text = i
			explicacionFrame.Parent = conversionFolder.Explicacion.ScrollingFrame

			if seg[2] == dataUnidades.Colores.Resultado or seg[2] == dataUnidades.Colores.Operaciones then
				explicacionFrame.Size = UDim2.fromScale(1, 0.25)
			end
		end
	elseif parametroUnidades.Tipo[2] ~= nil then
		conversorFrame.Resultado.Text = "0" .. parametroUnidades.Tipo[2]
	else
		conversorFrame.Resultado.Text = "0"
	end
end

local function crearJerarquia(nombre: string, valor: string, bool: boolean)
	local framePlantilla = ReplicatedStorage.Resource.JerarquiaPlantilla:Clone()
	framePlantilla.Frame.Nombre.Text = nombre
	framePlantilla.Frame.Valor.Text = "= " .. valor
	framePlantilla.LayoutOrder = if bool then 40 else math.floor(valor)
	framePlantilla.Parent = jerarquiaScrolling
end

for _, v in conversionFolder.CambioTipo.ScrollingFrame:GetChildren() do
	if v:IsA("TextButton") then
		v.MouseButton1Click:Connect(function()
			parametroUnidades.Tipo = { nil, nil }
			for _, TextButton: TextButton in { conversorFrame.UnidadInicio, conversorFrame.UnidadConversor } do
				TextButton.Text = ""
			end
			conversorFrame.Resultado.Text = "0"

			for _, Frame: Frame in jerarquiaScrolling:GetChildren() do
				if Frame:IsA("Frame") then
					Frame:Destroy()
				end
			end

			if #cacheTextButton > 0 then
				for _, boton in selectorScrolling:GetChildren() do
					if boton:IsA("TextButton") then
						boton:Destroy()
					end
				end
				for _, cache: RBXScriptConnection in cacheTextButton do
					cache:Disconnect()
				end
			end
			local cont = 0

			local framePlantilla = ReplicatedStorage.Resource.JerarquiaPlantilla:Clone()
			framePlantilla.Frame.Nombre.Text = "Posicion de jerarquia de unidades"
			framePlantilla.Frame.Valor:Destroy()
			framePlantilla.Frame.Nombre.AnchorPoint = Vector2.new(0.5, 0.5)
			framePlantilla.Frame.Nombre.Position = UDim2.fromScale(0.5, 0.5)
			framePlantilla.Frame.BackgroundColor3 = Color3.fromRGB(225, 230, 200)
			framePlantilla.LayoutOrder = 1
			framePlantilla.Parent = jerarquiaScrolling

			for nombre, valor in dataUnidades.Medicion[v.Name] do
				if typeof(valor) == "table" then
					local framePlantilla = ReplicatedStorage.Resource.JerarquiaPlantilla:Clone()
					framePlantilla.Frame.Valor:Destroy()
					framePlantilla.Frame.Nombre.Text = "Unidades no estándar"
					framePlantilla.Frame.Nombre.AnchorPoint = Vector2.new(0.5, 0.5)
					framePlantilla.Frame.Nombre.Position = UDim2.fromScale(0.5, 0.5)
					framePlantilla.Frame.BackgroundColor3 = Color3.fromRGB(225, 230, 200)
					framePlantilla.LayoutOrder = 39
					framePlantilla.Parent = jerarquiaScrolling

					for especialNombre, q in valor do
						crearJerarquia(especialNombre, if typeof(q) == "table" then q[1] else q, true)
						crearTextButton(
							dataUnidades.Nombre[especialNombre],
							if typeof(q) == "table" then math.abs(q[1]) + 40 else math.abs(q) + 40
						)
					end
				else
					crearJerarquia(nombre, valor, false)
					crearTextButton(dataUnidades.Nombre[nombre], valor)
				end
				cont += 1
			end
		end)
	end
end

local paramConnection = {}
local adentro = ""

mouseBool:GetPropertyChangedSignal("Value"):Connect(function()
	if mouseBool.Value == true then
		movibleTextButton = Instance.new("TextLabel")
		movibleTextButton.Text = nombreButton
		movibleTextButton.TextScaled = true
		movibleTextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		movibleTextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
		movibleTextButton.AnchorPoint = Vector2.new(0.5, 0.5)
		movibleTextButton.Position = UDim2.fromOffset(mouse.X, mouse.Y)
		movibleTextButton.Size = UDim2.fromScale(0.08, 0.08)

		local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")

		local UICorner = Instance.new("UICorner")
		UICorner.CornerRadius = UDim.new(0, 0)

		local UIStroke = Instance.new("UIStroke")
		UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		UIStroke.Thickness = 1

		UIStroke.Parent = movibleTextButton
		UICorner.Parent = movibleTextButton
		UIAspectRatioConstraint.Parent = movibleTextButton
		movibleTextButton.Parent = conversionFolder

		for _, v: TextButton in { conversorFrame.UnidadInicio, conversorFrame.UnidadConversor } do
			paramConnection[#paramConnection + 1] = v.MouseEnter:Connect(function()
				adentro = v.Name
				moduleTween:FastTween(
					UICorner,
					{ Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0.1, { CornerRadius = UDim.new(0.3, 0) } }
				)
			end)
			paramConnection[#paramConnection + 1] = v.MouseLeave:Connect(function()
				adentro = ""
				moduleTween:FastTween(
					UICorner,
					{ Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0.1, { CornerRadius = UDim.new(0, 0) } }
				)
			end)
		end

		paramConnection[#paramConnection + 1] = RunService.Heartbeat:Connect(function()
			movibleTextButton.Position = UDim2.fromOffset(mouse.X, mouse.Y)
		end)
	else
		if adentro ~= "" then
			if #nombreButton > 3 then
				nombreButton = dataUnidades.Nombre[nombreButton]
			end
			parametroUnidades.Tipo[referenciaParametro[adentro]] = nombreButton
			conversorFrame[adentro].Text = nombreButton
			convetirDatos()
		end

		adentro = ""
		nombreButton = ""
		movibleTextButton:Destroy()
		for _, v: RBXScriptConnection in paramConnection do
			v:Disconnect()
		end
	end
end)

--Poner el valor a nil en los frame

for _, v: TextButton in { conversorFrame.UnidadInicio, conversorFrame.UnidadConversor } do
	v.MouseButton1Click:Connect(function()
		if parametroUnidades.Tipo[referenciaParametro[v.Name]] ~= nil and adentro == "" then
			parametroUnidades.Tipo[referenciaParametro[v.Name]] = nil
			v.Text = ""
		end
		convetirDatos()
	end)
end

local conversorTextBox = conversorFrame.TextBox

conversorTextBox:GetPropertyChangedSignal("Text"):Connect(function()
	if not tonumber(conversorTextBox.Text) or not string.sub(conversorTextBox.Text, 1, 1) == "-" then
		conversorTextBox.TextColor3 = Color3.fromRGB(255, 0, 0)
		parametroUnidades.Numero = nil
		return
	end
	parametroUnidades.Numero = tonumber(conversorTextBox.Text)
	conversorTextBox.TextColor3 = Color3.fromRGB(0, 0, 0)
	convetirDatos()
end)

--[[
poner los movimientos cambien de datos.
]]
