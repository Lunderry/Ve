--[[init conversion
]]
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

local plr: Player = Players.LocalPlayer
local plrGui: PlayerGui = plr.PlayerGui

local mouse: Mouse = plr:GetMouse()

local conversionGui: ScreenGui = plrGui:WaitForChild("Experimentos").ConversionUnidadesGui
local selectorScrolling: ScrollingFrame = conversionGui.Selector.ScrollingFrame
local jerarquiaScrolling: ScrollingFrame = conversionGui.Jerarrquia.ScrollingFrame

local conversorFrame: Frame = conversionGui.Conversor

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

local function crearTextButton(nombre: string, orden: number, par)
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
	TextButton.Parent = if par then par else selectorScrolling

	local UITextSizeConstraint = Instance.new("UITextSizeConstraint")
	UITextSizeConstraint.MaxTextSize = 30

	UITextSizeConstraint.Parent = TextButton

	cacheTextButton[#cacheTextButton + 1] = TextButton.InputBegan:Connect(function(inp, gpe)
		if gpe then
			return
		end

		if inp.UserInputType == Enum.UserInputType.MouseButton1 then
			nombreButton = dataUnidades.Nombre[TextButton.Name]
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

		for _, v in conversionGui.Explicacion.ScrollingFrame:GetChildren() do
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
			explicacionFrame.Parent = conversionGui.Explicacion.ScrollingFrame

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

local function crearJerarquia(nombre: string, color: Color3, valor: string, bool: boolean, layout: number)
	local framePlantilla = ReplicatedStorage.Resource.JerarquiaPlantilla:Clone()
	if #nombre > 8 then
		framePlantilla.Frame.Nombre.Text = nombre
	else
		framePlantilla.Frame.Nombre.Text = nombre .. " = " .. valor
	end
	framePlantilla.Frame.BackgroundColor3 = color
	if layout then
		framePlantilla.LayoutOrder = layout
	else
		framePlantilla.LayoutOrder = if bool then 40 else math.floor(valor)
	end
	framePlantilla.Parent = jerarquiaScrolling
end

for _, v in conversionGui.CambioTipo.ScrollingFrame:GetChildren() do
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
				for _, boton in conversionGui.SelectorVelocidad:GetDescendants() do
					if boton:IsA("TextButton") then
						boton:Destroy()
					end
				end
				for _, cache: RBXScriptConnection in cacheTextButton do
					cache:Disconnect()
				end
			end

			if table.find({ "Velocidad", "Aceleracion" }, v.Name) then
				conversionGui.SelectorVelocidad.Visible = true
				selectorScrolling.Visible = false

				local cont = 0

				for i = 1, 2 do
					local turno = if i == 1
						then "Longitud"
						elseif v.Name == "Aceleracion" then "TiempoCuadrado"
						else "Tiempo"

					local pos = if i == 1 then "Longitud" else "Tiempo"

					if i == 2 then
						cont = 100000
					end
					crearJerarquia(
						"Posicion de la jerarquia de unidades " .. turno,
						Color3.fromRGB(255, 243, 156),
						cont,
						false
					)

					for nombre, valor in dataUnidades.Medicion[turno] do
						if type(valor) == "table" then
							continue
						end

						crearJerarquia(nombre, Color3.fromRGB(255, 255, 255), valor, false, valor + cont)
						crearTextButton(dataUnidades.Nombre[nombre], valor, conversionGui.SelectorVelocidad[pos])
					end
					crearJerarquia("Unidades no estándar", Color3.fromRGB(255, 243, 156), 39 + cont, false)

					for especialNombre, q in dataUnidades.Medicion[turno].Especial do
						crearJerarquia(
							especialNombre,
							Color3.fromRGB(255, 255, 255),
							if type(q) == "table" then q[1] else q,
							true,
							(if type(q) == "table" then q[1] else q) + 40 + cont
						)
						crearTextButton(
							dataUnidades.Nombre[especialNombre],
							(if type(q) == "table" then math.abs(q[1]) else math.abs(q)) + 40,
							conversionGui.SelectorVelocidad[pos]
						)
						cont += 1
					end
				end
			else
				conversionGui.SelectorVelocidad.Visible = false
				selectorScrolling.Visible = true

				crearJerarquia("Posicion de la jerarquia de unidades", Color3.fromRGB(255, 243, 156), 1, false)
				for nombre, valor in dataUnidades.Medicion[v.Name] do
					if typeof(valor) == "table" then
						crearJerarquia("Unidades no estándar", Color3.fromRGB(255, 243, 156), 39, false)

						for especialNombre, q in valor do
							crearJerarquia(
								especialNombre,
								Color3.fromRGB(255, 255, 255),
								if typeof(q) == "table" then q[1] else q,
								true
							)
							crearTextButton(
								dataUnidades.Nombre[especialNombre],
								if typeof(q) == "table" then math.abs(q[1]) + 40 else math.abs(q) + 40
							)
						end
					else
						crearJerarquia(nombre, Color3.fromRGB(255, 255, 255), valor, false)
						crearTextButton(dataUnidades.Nombre[nombre], valor)
					end
				end
			end
		end)
	end
end

local paramConnection = {}
local adentroNombre = ""

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

		movibleTextButton.Parent = conversionGui

		for _, v: TextButton in { conversorFrame.UnidadInicio, conversorFrame.UnidadConversor } do
			paramConnection[#paramConnection + 1] = v.MouseEnter:Connect(function()
				adentroNombre = v.Name
				moduleTween:FastTween(
					UICorner,
					{ Enum.EasingStyle.Quart, Enum.EasingDirection.Out, 0.1, { CornerRadius = UDim.new(0.3, 0) } }
				)
			end)
			paramConnection[#paramConnection + 1] = v.MouseLeave:Connect(function()
				adentroNombre = ""
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
		if adentroNombre ~= "" then
			local textOr = conversorFrame[adentroNombre]

			if
				(dataUnidades.Medicion.Longitud[textOr.Text] or dataUnidades.Medicion.Longitud.Especial[textOr.Text])
				and (
					dataUnidades.Medicion.Tiempo[nombreButton]
					or dataUnidades.Medicion.TiempoCuadrado[nombreButton]
					or dataUnidades.Medicion.Tiempo.Especial[nombreButton]
					or dataUnidades.Medicion.TiempoCuadrado.Especial[nombreButton]
				)
			then
				nombreButton = textOr.Text .. "/" .. nombreButton
			elseif
				(
					dataUnidades.Medicion.Tiempo[textOr.Text]
					or dataUnidades.Medicion.TiempoCuadrado[textOr.Text]
					or dataUnidades.Medicion.Tiempo.Especial[textOr.Text]
					or dataUnidades.Medicion.TiempoCuadrado.Especial[textOr.Text]
				)
				and (
					dataUnidades.Medicion.Longitud[nombreButton]
					or dataUnidades.Medicion.Longitud.Especial[nombreButton]
				)
			then
				nombreButton = nombreButton .. "/" .. textOr.Text
			else
				nombreButton = nombreButton
			end
			parametroUnidades.Tipo[referenciaParametro[adentroNombre]] = nombreButton
			textOr.Text = nombreButton

			convetirDatos()
		end

		adentroNombre = ""
		nombreButton = ""
		movibleTextButton:Destroy()
		for _, v: RBXScriptConnection in paramConnection do
			v:Disconnect()
		end
	end
end)

for _, v: TextButton in { conversorFrame.UnidadInicio, conversorFrame.UnidadConversor } do
	v.MouseButton1Click:Connect(function()
		if parametroUnidades.Tipo[referenciaParametro[v.Name]] ~= nil and adentroNombre == "" then
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
