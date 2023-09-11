local module = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local conversionNumeros = require(ReplicatedStorage.Module.Data.ConversionUnidades)
local resource = require(script.Resource)
local moduleData = require(script.Data)

local plr = Players.LocalPlayer
local plrGui = plr.PlayerGui

function module.CrearValue(data)
	local InstanciasCreacion = {
		"Pausar",
		"Iniciar",
	}

	local folder = Instance.new("Folder")
	folder.Name = data.Nombre
	folder.Parent = ReplicatedStorage.ExpFolder

	local prop = Instance.new("Folder")
	prop.Name = "Props"
	prop.Parent = folder

	local estados = Instance.new("Folder")
	estados.Name = "Estados"
	estados.Parent = folder

	for _, v in data.Propiedades do
		local NumberValue = Instance.new("NumberValue")
		NumberValue.Name = v
		NumberValue.Parent = prop
	end

	for _, v in InstanciasCreacion do
		local BoolValue = Instance.new("BoolValue")
		BoolValue.Name = v
		BoolValue.Parent = estados
	end

	--Eleccion Value
	local stringValue = Instance.new("StringValue")
	stringValue.Name = "Eleccion"
	stringValue.Parent = estados
end

local function Mover(prop, data, folderJuego)
	local Resultado = data.Funcion(table.unpack(resource.buscarObjetos(data, "PonerFuncion", prop, "Normal")))

	for i, v in Resultado do
		if prop:FindFirstChild(i) then
			prop[i].Value = v
		end
	end
	local Sumar = data.Sumar(Resultado)
	if Sumar == nil then
		return
	end
	folderJuego.Mov.Position = Sumar
end

function module.ConversionValue(data)
	local folderValue = ReplicatedStorage.ExpFolder:WaitForChild(data.Nombre)
	local prop = folderValue:WaitForChild("Props")
	--[[Variables]]
	local experimentoGui = plrGui:WaitForChild("Experimentos")[data.Nombre .. "Gui"]

	local configuracion = experimentoGui:FindFirstChild("Configuracion").ScrollingFrame
	local folderJuego = workspace[data.Nombre].Folder
	local eleccionValue = folderValue.Estados.Eleccion

	--Cambio dependiendo del texto
	local tbConversion = {}

	--crear la tabla
	for _, v in data.Conversion do
		local cambiarNombre = if v == "Altura" then "Longitud" else v

		tbConversion[cambiarNombre] = {
			["Numero"] = 0,
			["Longitud1"] = if v == "Altura" then data.Conversion["Longitud"] else data.Conversion[v],
			["Longitud2"] = if v == "Altura" then data.Conversion["Longitud"] else data.Conversion[v],
		}
	end

	local cambioTexto = false

	for i, v in data.ListaBlanca do
		if typeof(v) == "table" then
			if i == "Basta" then
				for _, q in v do
					local textSecu = configuracion[q]
					textSecu:GetPropertyChangedSignal("Text"):Connect(function()
						if cambioTexto == true then
							return
						end
						if not tonumber(textSecu.Text) then
							eleccionValue.Value = ""
							return
						end
						cambioTexto = true
						eleccionValue.Value = textSecu.Name

						for _, r in prop:GetChildren() do
							if table.find(data.ListaBlanca.Basta, r.Name) then
								if r.Name ~= textSecu.Name then
									configuracion[r.Name].Text = ""
								end
							end
						end
						if table.find(data.Conversion, textSecu.Name) then
							local CambiarNombre = if textSecu.Name == "Altura" then "Longitud" else textSecu.Name

							tbConversion[CambiarNombre].Numero = tonumber(textSecu.Text)
							prop[textSecu.Name].Value =
								conversionNumeros.Conversion(tbConversion[CambiarNombre], CambiarNombre)
						else
							prop[textSecu.Name].Value = tonumber(textSecu.Text)
						end
						Mover(prop, data, folderJuego)
						cambioTexto = false
					end)
				end
			else
				for _, q in v do
					local textTerciario = configuracion[q]
					textTerciario:GetPropertyChangedSignal("Text"):Connect(function()
						if not tonumber(textTerciario.Text) then
							eleccionValue.Value = ""
							return
						end
						eleccionValue.Value = textTerciario.Name
						if table.find(data.Conversion, textTerciario.Name) then
							local CambiarNombre = if textTerciario.Name == "Altura"
								then "Longitud"
								else textTerciario.Name

							tbConversion[CambiarNombre].Numero = tonumber(textTerciario.Text)
							prop[textTerciario.Name].Value =
								conversionNumeros.Conversion(tbConversion[CambiarNombre], CambiarNombre)
						else
							prop[textTerciario.Name].Value = tonumber(textTerciario.Text)
						end
						Mover(prop, data, folderJuego)
					end)
				end
			end
		else
			local textPrin = configuracion[v]
			textPrin:GetPropertyChangedSignal("Text"):Connect(function()
				if not tonumber(textPrin.Text) then
					return
				end
				if table.find(data.Conversion, textPrin.Name) then
					tbConversion[textPrin.Name].Numero = tonumber(textPrin.Text)
					prop[textPrin.Name].Value = conversionNumeros.Conversion(tbConversion[textPrin.Name], textPrin.Name)
				else
					prop[textPrin.Name].Value = tonumber(textPrin.Text)
				end
				Mover(prop, data, folderJuego)
			end)
		end
	end
	--------------------------
	local CanvasGroup = experimentoGui.CanvasGroup

	for _, v in pairs(CanvasGroup:GetDescendants()) do
		if v:IsA("TextButton") then
			local nombreTipo = if v.Parent.Parent.Name == "Longitud" then "Altura" else v.Parent.Parent.Name
			if v.Name == data.Conversion[nombreTipo] then
				v.BackgroundColor3 = Color3.fromRGB(4, 170, 43)
			end
			v.MouseButton1Click:Connect(function()
				local Tipo = tbConversion[nombreTipo]

				CanvasGroup[nombreTipo].ScrollingFrame[Tipo.Longitud1].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				if Tipo.Longitud1 == v.Name then
					Tipo.Longitud1 = data.Conversion[nombreTipo]
				else
					Tipo.Longitud1 = v.Name
				end

				prop[nombreTipo].Value = conversionNumeros.Conversion(tbConversion[nombreTipo], nombreTipo)
				CanvasGroup[nombreTipo].ScrollingFrame[Tipo.Longitud1].BackgroundColor3 = Color3.fromRGB(4, 170, 43)
			end)
		end
	end
end

function module.CambioTiempo(data)
	--[[Variables]]
	local experimentoGui = plrGui:WaitForChild("Experimentos")[data.Nombre .. "Gui"]
	local textVelocidad = experimentoGui.TextBox.Value

	textVelocidad:GetPropertyChangedSignal("Value"):Connect(function()
		experimentoGui.TextBox.Text = tostring(textVelocidad.Value) .. "x"
	end)

	local clickAvanzar = false

	experimentoGui.Avanzar.MouseButton1Down:Connect(function()
		local max = 0.2

		textVelocidad.Value += 0.5
		clickAvanzar = true

		local cont = 0
		while clickAvanzar do
			cont += RunService.Heartbeat:Wait()
			if cont >= max then
				if max <= 0.05 then
					max = 0.05
				else
					max -= 0.05
				end
				cont = 0
				textVelocidad.Value += 0.5
			end
		end
	end)
	experimentoGui.Avanzar.MouseButton1Up:Connect(function()
		clickAvanzar = false
	end)
	experimentoGui.Avanzar.MouseLeave:Connect(function()
		clickAvanzar = false
	end)

	local clickRetroceso = false

	experimentoGui.Retroceso.MouseButton1Down:Connect(function()
		local max = 0.2
		clickRetroceso = true

		textVelocidad.Value -= 0.5

		local cont = 0
		while clickRetroceso do
			cont += RunService.Heartbeat:Wait()
			if cont >= max then
				if max <= 0.05 then
					max = 0.05
				else
					max -= 0.05
				end
				cont = 0
				textVelocidad.Value -= 0.5
			end
		end
	end)

	experimentoGui.Retroceso.MouseButton1Up:Connect(function()
		clickRetroceso = false
	end)
	experimentoGui.Retroceso.MouseLeave:Connect(function()
		clickRetroceso = false
	end)

	resource.NumeroTextBox(experimentoGui.TextBox)

	experimentoGui.TextBox.FocusLost:Connect(function()
		if tonumber(experimentoGui.TextBox.Text) then
			textVelocidad.Value = tonumber(experimentoGui.TextBox.Text)
		end
	end)
end

function module.Funcionamiento(data)
	--Creando sus values
	local prop = ReplicatedStorage.ExpFolder:WaitForChild(data.Nombre):WaitForChild("Props")
	local estados = ReplicatedStorage.ExpFolder:WaitForChild(data.Nombre):WaitForChild("Estados")
	--[[Variables]]
	local experimentoGui = plrGui:WaitForChild("Experimentos")[data.Nombre .. "Gui"]

	local configuracion = experimentoGui:FindFirstChild("Configuracion").ScrollingFrame

	local folderJuego = workspace[data.Nombre].Folder

	local datosGui = experimentoGui.Datos.Frame.ScrollingFrame
	local textVelocidad = experimentoGui.TextBox.Value

	--Se crea la tabla de conversion

	--

	local Pausar = estados.Pausar
	local Iniciar = estados.Iniciar
	--[[
		Pausar hace que se detenga o siga el mecanismo.
		Empezar es empezar el recorrido o reiniciarlo
	]]
	--Cambiar Estados
	Pausar.Value = not Pausar.Value
	
	experimentoGui.Pausar.MouseButton1Click:Connect(function()
		Pausar.Value = not Pausar.Value
	end)

	experimentoGui.Iniciar.MouseButton1Click:Connect(function()
		Iniciar.Value = not Iniciar.Value
	end)

	--Editar Color
	for _, v in pairs({ Iniciar, Pausar }) do
		v:GetPropertyChangedSignal("Value"):Connect(function()
			--hace que cambie los colores de su respectivo lado
			for r, q in pairs(moduleData[v.Name][v.Value]) do
				experimentoGui[v.Name][r] = q
			end
		end)
	end

	--Poner en una talba todos los textbox para desactivarlos y activarlos
	local tbTextBox = {}

	for _, v in pairs(configuracion:GetChildren()) do
		if v:IsA("TextBox") then
			table.insert(tbTextBox, v)
		end
	end

	--Ejecutar
	Iniciar:GetPropertyChangedSignal("Value"):Connect(function()
		if Iniciar.Value == false then
			return
		end
		local inicioValue = {}

		for _, v in prop:GetChildren() do
			inicioValue[v.Name] = v.Value
		end
		--ve si cumple con los requisitos
		local pasa = true

		local cont = 0
		for _, v in pairs(configuracion:GetChildren()) do
			if table.find(data.ListaBlanca, v.Name) then
				if not tonumber(v.Text) then
					pasa = false
					break
				end
			elseif table.find(data.ListaBlanca.Basta, v.Name) then
				if tonumber(v.Text) then
					cont += 1
				end
			end
		end

		if pasa == false or cont >= 2 then
			warn("Tienes un error")
			return
		end
		--Conversion
		local suma =
			data.Sumar(data.Funcion(table.unpack(resource.buscarObjetos(data, "PonerFuncion", prop, "Normal"))))

		if suma ~= nil then
			folderJuego.Mov.Position = suma
		end

		local alturaIncio = folderJuego.Mov.Position

		local Calculos = data.Calculos(table.unpack(resource.buscarObjetos(data, "PonerCalculo", prop, "X")))

		for i, v in Calculos do
			datosGui[i].Text = v
		end

		prop.Tiempo.Value = 0
		local HeartbeatConnection
		local ConnectDiscconect = {}
		--Connection
		--Quita el poder escribir

		for _, v in tbTextBox do
			v.TextEditable = false
		end
		--[[
			Revisa que tenga pausa para que puedas cambiar el tiempo a la hora que tu desees
		]]
		local turno = ""
		for _, v in datosGui:GetChildren() do
			if v:IsA("TextBox") then
				local gpc, focusConnect, focusLostConnect
				gpc = v:GetPropertyChangedSignal("Text"):Connect(function()
					if Pausar.Value == false or turno ~= v.Name then
						return
					end

					if tonumber(v.Text) then
						prop[v.Name].Value = tonumber(v.Text)

						local Resultado = data.Funcion(
							table.unpack(resource.buscarObjetos(data, "PonerFuncion", prop, "Cambio" .. v.Name))
						)

						for i, q in Resultado do
							if i ~= v.Name then
								if prop:FindFirstChild(i) then
									prop[i].Value = q
								end
								if datosGui:FindFirstChild(i) then
									datosGui[i].Text = q
								end
							end
						end

						folderJuego.Mov.Position = data.Sumar(Resultado, alturaIncio)
					end
				end)
				focusConnect = v.Focused:Connect(function()
					turno = v.Name
				end)
				focusLostConnect = v.Focused:Connect(function()
					turno = ""
				end)
				table.insert(ConnectDiscconect, gpc)
				table.insert(ConnectDiscconect, focusConnect)
				table.insert(ConnectDiscconect, focusLostConnect)
			end
		end

		--[[
			Aqui ocurre la magia de movimiento dependiendo lo que mandaron con su
			funcion y suma, con calculos extra
		]]

		HeartbeatConnection = RunService.Heartbeat:Connect(function(dt)
			if Pausar.Value == true then
				return
			end

			if textVelocidad.Value < 0 then
				if prop.Tiempo.Value > 0 then
					prop.Tiempo.Value -= dt * math.abs(textVelocidad.Value)
				else
					prop.Tiempo.Value = 0
				end
			elseif prop.Tiempo.Value < Calculos.TiempoMaximo then
				prop.Tiempo.Value += dt * textVelocidad.Value
			else
				prop.Tiempo.Value = Calculos.TiempoMaximo
			end
			local Resultado = data.Funcion(table.unpack(resource.buscarObjetos(data, "PonerFuncion", prop, "Contador")))

			for i, v in Resultado do
				if i ~= "Tiempo" then
					if prop:FindFirstChild(i) then
						prop[i].Value = v
					end
					if datosGui:FindFirstChild(i) then
						datosGui[i].Text = v
					end
				end
			end
			datosGui.Tiempo.Text = prop.Tiempo.Value

			folderJuego.Mov.Position = data.Sumar(Resultado, alturaIncio)
		end)

		repeat
			Iniciar:GetPropertyChangedSignal("Value"):Wait()
		until Iniciar.Value == false

		HeartbeatConnection:Disconnect()
		for _, v in ConnectDiscconect do
			v:Disconnect()
		end
		table.clear(ConnectDiscconect)

		prop.Tiempo.Value = 0
		local resultado = data.Funcion(table.unpack(resource.buscarObjetos(data, "PonerFuncion", prop, "Contador")))
		for i, v in resultado do
			if prop:FindFirstChild(i) then
				prop[i].Value = v
			end
			if datosGui:FindFirstChild(i) then
				datosGui[i].Text = v
			end
		end
		folderJuego.Mov.Position = data.Sumar(resultado, alturaIncio)

		for i, v in inicioValue do
			if prop:FindFirstChild(i) then
				prop[i].Value = v
			end
		end

		for _, v in tbTextBox do
			v.TextEditable = true
		end
	end)
end

function module.AcomodarBloques(data)
	local expFolder = ReplicatedStorage["ExpFolder"]
	local folderNombre = expFolder:WaitForChild(data.Nombre)

	local tbEscanear = {}
	for _, v in data.ListaBlanca do
		if type(v) == "table" then
			for _, q in v do
				table.insert(tbEscanear, q)
			end
		else
			table.insert(tbEscanear, v)
		end
	end

	local GetPropertyChangedSignalDisconnect = {}

	folderNombre.Estados.Iniciar:GetPropertyChangedSignal("Value"):Connect(function()
		if folderNombre.Estados.Iniciar.Value == true then
			for _, v in GetPropertyChangedSignalDisconnect do
				v:Disconnect()
			end
			return
		end
		resource:activarFuncion(tbEscanear, folderNombre, data, GetPropertyChangedSignalDisconnect)
	end)
	resource:activarFuncion(tbEscanear, folderNombre, data, GetPropertyChangedSignalDisconnect)
end

function module.LimitanteTexto(data)
	local experimento = plrGui:WaitForChild("Experimentos")
	local folderNivel = experimento[data.Nombre .. "Gui"]

	for i, v in data.Limitante do
		task.delay(0, function()
			local textBox = folderNivel.Configuracion.ScrollingFrame[i]

			textBox:GetPropertyChangedSignal("Text"):Connect(function()
				if tonumber(textBox.Text) then
					local nm = tonumber(textBox.Text)
					if nm < v[1] then
						textBox.Text = 0
						textBox.Text = ""
					elseif v[2] ~= nil and v[2] < nm then
						textBox.Text = tostring(v[2])
					end
				end
			end)
		end)
	end
end
return module
