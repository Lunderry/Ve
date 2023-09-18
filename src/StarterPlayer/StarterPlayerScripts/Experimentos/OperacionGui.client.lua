local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local modulePart = require(ReplicatedStorage.Module.PartModule)
local moduleOperacion = require(ReplicatedStorage.Module.Operaciones)

repeat
	task.wait(0.1)
until Players.LocalPlayer and Players.LocalPlayer.PlayerGui

local plr = Players.LocalPlayer
local plrGui = plr.PlayerGui

local folderResource: Folder = ReplicatedStorage.Resource

local calculadoraGui = plrGui:WaitForChild("Experimentos").CalculadoraGui

local textOperacion: TextLabel = calculadoraGui.Operacion.Op.Operacion
local escribirBox: TextBox = calculadoraGui.Operacion.Op.Crear

local crearVariable: Frame = calculadoraGui.CrearVariable

local optrigonometria: ScrollingFrame = calculadoraGui.Clave

escribirBox:GetPropertyChangedSignal("Text"):Connect(function()
	textOperacion.Text = moduleOperacion.TextColor(escribirBox.Text)
end)

for _, v: TextButton in optrigonometria:GetChildren() do
	if v:IsA("TextButton") then
		v.MouseButton1Click:Connect(function()
			local str

			if table.find({ "cos", "sin", "tan" }, v.Name) then
				str = "[" .. v.Name .. "()]"
			else
				str = v.Name
			end

			escribirBox.Text = moduleOperacion.insertarPalabra(escribirBox.Text, str, escribirBox.CursorPosition)
			textOperacion.Text = moduleOperacion.TextColor(escribirBox.Text)
		end)
	end
end

local tipoCalculo = "rad"

for _, v: TextButton in calculadoraGui.CambioCalculadora:GetChildren() do
	if v:IsA("TextButton") then
		v.MouseButton1Click:Connect(function()
			calculadoraGui.CambioCalculadora.deg.BackgroundColor3 = Color3.fromRGB(175, 186, 248)
			calculadoraGui.CambioCalculadora.rad.BackgroundColor3 = Color3.fromRGB(175, 186, 248)

			v.BackgroundColor3 = Color3.fromRGB(101, 113, 179)
			tipoCalculo = v.Name
		end)
	end
end
--[[
	ordenar esto
]]
local tablaOperacion = {}

local variablePlantilla: Frame = folderResource.VariablePlantilla

crearVariable.TextButton.MouseButton1Click:Connect(function()
	local valores = crearVariable.ScrollingFrame
	if tablaOperacion[valores.Index.Text] then
		return
	end
	local frame = variablePlantilla:Clone()
	frame.Name = valores.Index.Text
	frame.Frame.Index.Text = valores.Index.Text
	frame.Frame.Value.Text = tonumber(valores.Value.Text)

	tablaOperacion[frame.Name] = valores.Value.Text

	local Connection: { RBXScriptConnection } = {}

	Connection[#Connection + 1] = frame.Frame.Quitar.MouseButton1Click:Connect(function()
		for _, v in Connection do
			v:Disconnect()
		end
		tablaOperacion[frame.Name] = nil
		frame:Destroy()
	end)

	local indexPrincipal, valuePrincipal = valores.Index.Text, tonumber(valores.Value.Text)

	Connection[#Connection + 1] = frame.Frame.Index.FocusLost:Connect(function()
		tablaOperacion[indexPrincipal] = nil
		tablaOperacion[frame.Frame.Index.Text] = valuePrincipal
		indexPrincipal = frame.Frame.Index.Text
	end)

	Connection[#Connection + 1] = frame.Frame.Value.FocusLost:Connect(function()
		if not tonumber(frame.Frame.Value.Text) then
			frame.Frame.Value.Text = "0"
		end
		tablaOperacion[indexPrincipal] = tonumber(frame.Frame.Value.Text)
		valuePrincipal = tonumber(frame.Frame.Value.Text)
	end)
	frame.Parent = calculadoraGui.DatosVariable.ScrollingFrame
end)

calculadoraGui.Calcular.MouseButton1Click:Connect(function()
	local a = moduleOperacion.crearTabla(escribirBox.Text, tablaOperacion)
	local b = moduleOperacion:crearOperacion(a)

	calculadoraGui.Resultado.Op.Texto.Text =
		modulePart.Coma(moduleOperacion:resolverOperacion(b, tablaOperacion, tipoCalculo))
end)
