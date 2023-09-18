local module = {}

local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")

local moduleUnidades = require(ReplicatedStorage.Module.ConversionUnidades)
local dataUnidades = require(ReplicatedStorage.Module.ConversionUnidades.DataUnidades)
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
	local folderValue: Folder = ReplicatedStorage.ExpFolder:WaitForChild(data.Nombre)
	local prop: Folder = folderValue:WaitForChild("Props")
	--[[Variables]]
	local experimentoGui: ScreenGui = plrGui:WaitForChild("Experimentos")[data.Nombre .. "Gui"]

	local configuracion: ScrollingFrame = experimentoGui:FindFirstChild("Configuracion").ScrollingFrame
	local folderJuego: Folder = workspace[data.Nombre].Folder
	local eleccionValue = folderValue.Estados.Eleccion --Cambio dependiendo del texto

	local tbConversion = {}
	local unidadReferencia = {}
	--crear la tabla
	for _, v in data.Conversion do
		local valor, tipo
		if type(v) == "table" then
			valor = v[1]
			unidadReferencia[valor] = v[2]
			if v[2] == "Aceleracion" then
				tipo = "m/seg²"
			elseif v[2] == "Velocidad" then
				tipo = "m/seg"
			else
				tipo = dataUnidades.NeutralMedicion[v[2]]
			end
		elseif v == "Aceleracion" then
			valor = v
			tipo = "m/seg²"
		elseif v == "Velocidad" then
			valor = v
			tipo = "m/seg"
		else
			valor = v
			tipo = dataUnidades.NeutralMedicion[v]
		end
		if not unidadReferencia[valor] then
			unidadReferencia[valor] = v
		end
		tbConversion[valor] = {
			["Numero"] = 0,
			["Tipo"] = { tipo, tipo },
		}
	end

	local function forUnidad(tb: {}, index: string)
		for i, v in tb do
			if type(v) == "table" then
				forUnidad(v, i)
				continue
			end
			local textBox

			if configuracion[v].ClassName == "Frame" then
				textBox = configuracion[v].Numero
				local botonUnidad = configuracion[v].Unidad
				if botonUnidad:IsA("TextButton") then
					--botonUnidad = textbutton
					local strUnidad, turnoUnidad = "", 1

					botonUnidad.MouseButton1Click:Connect(function()
						eleccionValue.Value = textBox.Parent.Name
						turnoUnidad += 1
						strUnidad, turnoUnidad = moduleUnidades:UnidadConNumero(turnoUnidad, unidadReferencia[v])

						botonUnidad.Text = strUnidad
						tbConversion[v].Tipo[1] = strUnidad

						prop[v].Value = moduleUnidades:Convertidor(tbConversion[v])

						Mover(prop, data, folderJuego)
					end)
				else
					--botonUnidad = textbox
					botonUnidad.FocusLost:Connect(function()
						eleccionValue.Value = textBox.Parent.Name
						tbConversion[v].Tipo[1] = botonUnidad.Text

						prop[v].Value = moduleUnidades:Convertidor(tbConversion[v])
						Mover(prop, data, folderJuego)
					end)

					if unidadReferencia[v] == "Aceleracion" then
						botonUnidad.FocusLost:Connect(function()
							botonUnidad.Text = botonUnidad.Text .. "²"
						end)
					end
				end
			else
				textBox = configuracion[v]
			end

			textBox.FocusLost:Connect(function()
				if not tonumber(textBox.Text) then
					textBox.Text = ""
					eleccionValue.Value = ""
					return
				end
				if textBox:FindFirstAncestorOfClass("Frame") then
					eleccionValue.Value = textBox.Parent.Name
				else
					eleccionValue.Value = textBox.Name
				end
				if index == "Basta" then
					for _, q in prop:GetChildren() do
						if table.find(data.ListaBlanca.Basta, q.Name) and q.Name ~= v then
							local confiGui = configuracion[q.Name]
							if confiGui.ClassName == "Frame" then
								confiGui.Numero.Text = ""
							else
								confiGui.Text = ""
							end
						end
					end
				end

				if resource.findCompleto(data.Conversion, v) then
					tbConversion[v].Numero = tonumber(textBox.Text)
					prop[v].Value = moduleUnidades:Convertidor(tbConversion[v])
				else
					prop[v].Value = tonumber(textBox.Text)
				end

				Mover(prop, data, folderJuego)
			end)
		end
	end

	forUnidad(data.ListaBlanca, "")
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
			v = if v.ClassName == "Frame" then v.Unidad else v
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
			datosGui[i].Numero.Text = moduleUnidades:Convertidor({
				["Numero"] = v,
				["Tipo"] = { datosGui[i].Convertir.Value, datosGui[i].Unidad.Text },
			}) .. datosGui[i].Unidad.Text
		end
		for _, v in prop:GetChildren() do
			datosGui[v.Name].ValorNeutral.Value = v.Value
			datosGui[v.Name].Numero.Text = moduleUnidades:Convertidor({
				["Numero"] = v.Value,
				["Tipo"] = { datosGui[v.Name].Convertir.Value, datosGui[v.Name].Unidad.Text },
			}) .. datosGui[v.Name].Unidad.Text
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

		for _, v in datosGui:GetChildren() do
			if v:IsA("Frame") and v.Numero.TextEditable == true then
				ConnectDiscconect[#ConnectDiscconect + 1] = v.Numero.FocusLost:Connect(function()
					local textNumero = string.gsub(v.Numero.Text, "%l", "")
					if not Pausar.Value and textNumero then
						return
					end
					prop[v.Name].Value = moduleUnidades:Convertidor({
						["Numero"] = tonumber(textNumero),
						["Tipo"] = { v.Convertir.Value, v.Unidad.Text },
					})

					local r = data.Funcion(
						table.unpack(resource.buscarObjetos(data, "PonerFuncion", prop, "Cambio" .. v.Name))
					)

					for i, q in r do
						if i ~= v.Name then
							if prop:FindFirstChild(i) then
								prop[i].Value = q
							end
							if datosGui:FindFirstChild(i) then
								datosGui[i].ValorNeutral.Value = q
								datosGui[i].Numero.Text = moduleUnidades:Convertidor({
									["Numero"] = q,
									["Tipo"] = { datosGui[i].Convertir.Value, datosGui[i].Unidad.Text },
								}) .. datosGui[i].Unidad.Text
							end
						end
					end
					folderJuego.Mov.Position = data.Sumar(r, alturaIncio)
				end)
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
						datosGui[i].ValorNeutral.Value = v
						datosGui[i].Numero.Text = moduleUnidades:Convertidor({
							["Numero"] = v,
							["Tipo"] = { datosGui[i].Convertir.Value, datosGui[i].Unidad.Text },
						}) .. " " .. datosGui[i].Unidad.Text
					end
				end
			end
			datosGui.Tiempo.Numero.Text = moduleUnidades:Convertidor({
				["Numero"] = prop.Tiempo.Value,
				["Tipo"] = { datosGui.Tiempo.Convertir.Value, datosGui.Tiempo.Unidad.Text },
			}) .. " " .. datosGui.Tiempo.Unidad.Text

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
				datosGui[i].ValorNeutral.Value = 0
				datosGui[i].Numero.Text = "0"
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

			if textBox.ClassName == "Frame" then
				textBox = textBox.Numero
			end
			textBox.FocusLost:Connect(function()
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
