--[[Module conversor unidadess]]
local module = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local data = require(script.DataUnidades)
local partModule = require(ReplicatedStorage.Module.PartModule)

--[[
    Tabla lo que se tiene que dar

    local Convertidor = {
	["Numero"] = 0,
	-- ["Tipo"] = {"(tipo1)", "(tipo2)"}}
]]

local function buscarVelocidades(unidadVelocidad: string): {}
	local unidades = {}

	local unidadNombre = ""
	for i = 1, #unidadVelocidad do
		local str = string.sub(unidadVelocidad, i, i)
		if str == "/" then
			unidades[1] = unidadNombre
			unidadNombre = ""
		else
			unidadNombre ..= str
		end
	end
	unidadNombre = string.gsub(unidadNombre, "²", "")

	unidades[2] = unidadNombre

	local verificacion = { false, false }
	for i = 1, #unidades do
		for _, v in data.Medicion do
			if v[unidades[i]] or (v.Especial and v.Especial[unidades[i]]) then
				verificacion[i] = true
			end
		end
	end

	if verificacion[1] == false or verificacion[2] == false then
		unidades = { "m", "seg" }
	end

	return unidades
end

function module:ConvertidorSeguimiento(parametroConv: {})
	local resultado = 0
	local seguimiento = {}

	local especialUnidades = {}
	local buscarTipo = ""

	local unidadInicio, unidadConvertir = table.unpack(parametroConv.Tipo) --

	if unidadInicio == unidadConvertir then
		return parametroConv.Numero, {}
	end

	for i, v in data.Medicion do
		local tbEspecial = if v.Especial then v.Especial else nil

		if
			(v[unidadInicio] and v[unidadConvertir])
			or (tbEspecial and (tbEspecial[unidadInicio] or tbEspecial[unidadConvertir]))
		then
			buscarTipo = i

			if tbEspecial then
				if tbEspecial[unidadInicio] then
					table.insert(especialUnidades, 1)
				end
				if tbEspecial[unidadConvertir] then
					table.insert(especialUnidades, 2)
				end
			end

			break
		end
	end
	if buscarTipo == "" then
		local aceleracion = false

		if string.find(unidadInicio, "²") then
			aceleracion = true
		end
		if unidadConvertir == nil then
			if string.find(unidadInicio, "²") then
				unidadConvertir = "m/seg²"
			else
				unidadConvertir = "m/seg"
			end
		end

		unidadInicio, unidadConvertir = buscarVelocidades(unidadInicio), buscarVelocidades(unidadConvertir)

		if aceleracion then
			table.insert(seguimiento, {
				'Como la unidad es una aceleración se tiene que despejar ambas unidades "'
					.. unidadInicio[1]
					.. "/"
					.. unidadInicio[2]
					.. '²" a "'
					.. unidadConvertir[1]
					.. "/"
					.. unidadConvertir[2]
					.. '²"',
				data.Colores.Normal,
			})
		else
			table.insert(seguimiento, {
				'Como la unidad es la velocidad se tiene que despejar ambas unidades "'
					.. unidadInicio[1]
					.. "/"
					.. unidadInicio[2]
					.. '" a "'
					.. unidadConvertir[1]
					.. "/"
					.. unidadConvertir[2]
					.. '"',

				data.Colores.Normal,
			})
		end

		table.insert(seguimiento, {
			'Vamos a convertir "' .. unidadInicio[1] .. '" a "' .. unidadConvertir[1] .. '"',
			data.Colores.Normal,
		})

		local un1, un1Seguimiento = self:ConvertidorSeguimiento({
			["Numero"] = parametroConv.Numero,
			["Tipo"] = { unidadInicio[1], unidadConvertir[1] },
		})

		for _, v in un1Seguimiento do
			table.insert(seguimiento, v)
		end

		table.insert(seguimiento, {
			'Vamos a convertir "' .. unidadInicio[2] .. '" a "' .. unidadConvertir[2] .. '"',
			data.Colores.Normal,
		})

		local un2, un2Seguimiento =
			self:ConvertidorSeguimiento({ ["Numero"] = 1, ["Tipo"] = { unidadInicio[2], unidadConvertir[2] } })

		for _, v in un2Seguimiento do
			table.insert(seguimiento, v)
		end

		table.insert(seguimiento, { "Respuesta de Longitud = " .. un1 .. unidadConvertir[1], data.Colores.Resultado })

		if aceleracion then
			table.insert(seguimiento, {
				"Como el tiempo es al cuadrado se tiene que potenciar ",
				data.Colores.Normal,
			})
			table.insert(seguimiento, { un2 .. unidadConvertir[2] .. "²", data.Colores.Operaciones })
			un2 ^= 2
			table.insert(
				seguimiento,
				{ "Respuesta de Tiempo Cuadrado = " .. un2 .. unidadConvertir[2] .. "²", data.Colores.Resultado }
			)
		else
			table.insert(seguimiento, { "Repuesta de Tiempo = " .. un2 .. unidadConvertir[2], data.Colores.Resultado })
		end

		resultado = un1 / un2

		table.insert(seguimiento, {
			"Ahora se divide longitud entre tiempo",
			data.Colores.Normal,
		})
		table.insert(seguimiento, {
			un1 .. unidadConvertir[1] .. "/" .. un2 .. unidadConvertir[2],
			data.Colores.Operaciones,
		})

		table.insert(
			seguimiento,
			{ "Respuesta = " .. resultado .. unidadConvertir[1] .. "/" .. unidadConvertir[2], data.Colores.Resultado }
		)
		return resultado, seguimiento
	end

	local tipoMedicion = data.Medicion[buscarTipo]

	if buscarTipo == "Temperatura" then
		if unidadInicio == "°C" then
			local str = ""

			if unidadConvertir == "°F" then
				resultado = (parametroConv.Numero * (5 / 9)) + 32

				str = "(" .. tostring(parametroConv.Numero) .. "°C" .. " * 5/9) + 32"
			elseif unidadConvertir == "°K" then
				resultado = parametroConv.Numero + 273.15

				str = partModule.Coma(parametroConv.Numero) .. "°C" .. " + 273.15"
			end
			table.insert(
				seguimiento,
				{ 'Se resuelve "°C" a "' .. unidadConvertir .. '", Usando:', data.Colores.Normal }
			)
			table.insert(seguimiento, { str, data.Colores.Operaciones })
		elseif unidadConvertir == "°C" then
			local str = ""

			if unidadInicio == "°F" then
				resultado = (parametroConv.Numero - 32) * (5 / 9)

				str = "(" .. partModule.Coma(parametroConv.Numero) .. unidadInicio .. " -32) + 5/9"
			elseif unidadInicio == "°K" then
				resultado = parametroConv.Numero - 273.15

				str = partModule.Coma(parametroConv.Numero) .. unidadInicio .. " - 273.15"
			end
			table.insert(
				seguimiento,
				{ 'Se cambia la unidad de "' .. unidadInicio .. '" a "°C", Usando:', data.Colores.Normal }
			)
			table.insert(seguimiento, { str, data.Colores.Operaciones })
		else
			table.insert(seguimiento, {
				'Para despejar "'
					.. unidadConvertir
					.. '" tenemos que cambiar la unidad de "'
					.. unidadInicio
					.. '" a °C',
				data.Colores.Normal,
			})

			local despejarUnidad, seg =
				self:ConvertidorSeguimiento({ ["Numero"] = parametroConv.Numero, ["Tipo"] = { unidadInicio, "°C" } })

			for _, v in seg do
				table.insert(seguimiento, v)
			end

			table.insert(
				seguimiento,
				{ 'Ahora con el numero despejado convertimos "°C" a "' .. unidadConvertir .. '"', data.Colores.Normal }
			)

			local con, seg =
				self:ConvertidorSeguimiento({ ["Numero"] = despejarUnidad, ["Tipo"] = { "°C", unidadConvertir } })
			resultado = con

			for i, v in seg do
				if i < #seg then
					table.insert(seguimiento, v)
				end
			end
		end
		table.insert(
			seguimiento,
			{ "Resultado = " .. partModule.Coma(resultado) .. unidadConvertir, data.Colores.Resultado }
		)
		return resultado, seguimiento
	end

	local numeroEspecial

	if table.find(especialUnidades, 1) or #especialUnidades == 2 then
		if typeof(tipoMedicion.Especial[unidadInicio]) == "table" then
			numeroEspecial = tipoMedicion.Especial[unidadInicio][1]
		else
			numeroEspecial = tipoMedicion.Especial[unidadInicio]
		end
	else
		if typeof(tipoMedicion.Especial[unidadConvertir]) == "table" then
			numeroEspecial = tipoMedicion.Especial[unidadConvertir][1]
		else
			numeroEspecial = tipoMedicion.Especial[unidadConvertir]
		end
	end

	--Cambio Unidades Normales
	if #especialUnidades == 0 then
		--Nada de especiales
		local indexParametro = {}

		if tipoMedicion[unidadInicio] < tipoMedicion[unidadConvertir] then
			-- si el numero de inicio es mayo a convertir (/)
			indexParametro[1] = tipoMedicion[unidadConvertir] - tipoMedicion[unidadInicio]
			indexParametro[2] = "/"

			table.insert(seguimiento, {
				'Como "'
					.. unidadInicio
					.. '" a "'
					.. unidadConvertir
					.. '" es menor en jerarquia por -'
					.. partModule.Coma(indexParametro[1])
					.. " se hace:",
				data.Colores.Normal,
			})
			--
		elseif tipoMedicion[unidadInicio] > tipoMedicion[unidadConvertir] then
			-- si el numero a convertir es mayo a inicio (*)
			indexParametro[1] = tipoMedicion[unidadInicio] - tipoMedicion[unidadConvertir]
			indexParametro[2] = "*"

			table.insert(seguimiento, {
				'Como "'
					.. unidadInicio
					.. '" a "'
					.. unidadConvertir
					.. '" es mayor en jerarquia por '
					.. partModule.Coma(indexParametro[1])
					.. " se hace:",
				data.Colores.Normal,
			})
		end

		local sum = "1"
		for _ = 1, indexParametro[1] do
			sum ..= "0"
		end

		table.insert(seguimiento, {
			partModule.Coma(parametroConv.Numero) .. unidadInicio .. indexParametro[2] .. sum,
			data.Colores.Operaciones,
		})

		if indexParametro[2] == "*" then
			resultado = parametroConv.Numero * tonumber(sum)
		else
			resultado = parametroConv.Numero / tonumber(sum)
		end

		table.insert(
			seguimiento,
			{ "Resultado = " .. partModule.Coma(resultado) .. unidadConvertir, data.Colores.Resultado }
		)
	elseif #especialUnidades == 1 then
		if table.find(especialUnidades, 1) then
			-- la unidadinicio tiene el especial

			table.insert(seguimiento, {
				'Como la unidad de inicio "'
					.. unidadInicio
					.. '" es una unidad que se tiene que convertir a una unidad media en este caso seria "'
					.. data.NeutralMedicion[buscarTipo]
					.. '" Usando la siguiente operacion:',
				data.Colores.Normal,
			})

			local numeroDespejado
			if typeof(tipoMedicion.Especial[unidadInicio]) == "table" then
				numeroDespejado = parametroConv.Numero * numeroEspecial

				table.insert(seguimiento, {
					partModule.Coma(parametroConv.Numero) .. unidadInicio .. " * " .. numeroEspecial,
					data.Colores.Operaciones,
				})
			else
				numeroDespejado = parametroConv.Numero / numeroEspecial

				table.insert(seguimiento, {
					partModule.Coma(parametroConv.Numero) .. unidadInicio .. " / " .. numeroEspecial,
					data.Colores.Operaciones,
				})
			end

			table.insert(seguimiento, {
				"Resultado = " .. partModule.Coma(numeroDespejado) .. parametroConv.Tipo[2],
				data.Colores.Resultado,
			})

			if data.NeutralMedicion[buscarTipo] ~= parametroConv.Tipo[2] then
				table.insert(seguimiento, {
					'Ahora con la unidad convertida lo convertimos de "'
						.. data.NeutralMedicion[buscarTipo]
						.. '" a "'
						.. parametroConv.Tipo[2]
						.. '"',
					data.Colores.Normal,
				})
			end

			local con, seg = self:ConvertidorSeguimiento({
				["Numero"] = numeroDespejado,

				["Tipo"] = { data.NeutralMedicion[buscarTipo], parametroConv.Tipo[2] },
			})

			resultado = con

			for _, v in seg do
				table.insert(seguimiento, v)
			end
		else
			-- la unidadConvertir tiene el especial

			table.insert(seguimiento, {
				'Como la unidad a convertir "'
					.. unidadConvertir
					.. '" es una unidad que se tiene que convertir a una unidad media en este caso seria "'
					.. data.NeutralMedicion[buscarTipo]
					.. '" Usando la siguiente operacion:',
				data.Colores.Normal,
			})

			local numeroDespejado
			if typeof(tipoMedicion.Especial[unidadConvertir]) == "table" then
				numeroDespejado = parametroConv.Numero / numeroEspecial

				table.insert(seguimiento, {
					partModule.Coma(parametroConv.Numero)
						.. data.NeutralMedicion[buscarTipo]
						.. " / "
						.. numeroEspecial,
					data.Colores.Operaciones,
				})
			else
				numeroDespejado = parametroConv.Numero * numeroEspecial

				table.insert(seguimiento, {
					partModule.Coma(parametroConv.Numero)
						.. data.NeutralMedicion[buscarTipo]
						.. " * "
						.. numeroEspecial,
					data.Colores.Operaciones,
				})
			end

			-- table.insert(seguimiento, {
			-- 	"Resultado = " .. partModule.Coma(numeroDespejado) .. data.NeutralMedicion[buscarTipo],
			-- 	data.Colores.Resultado,
			-- })

			local cont, seg = self:ConvertidorSeguimiento({
				["Numero"] = numeroDespejado,
				["Tipo"] = { parametroConv.Tipo[1], data.NeutralMedicion[buscarTipo] },
			})
			resultado = cont

			for _, v in seg do
				table.insert(seguimiento, v)
			end

			table.insert(
				seguimiento,
				{ "Resultado = " .. partModule.Coma(resultado) .. unidadConvertir, data.Colores.Resultado }
			)
		end
	else
		--se despejan ambos
		table.insert(seguimiento, {
			'Como ambas unidades "'
				.. unidadInicio
				.. '" y "'
				.. unidadConvertir
				.. '" es una unidad que se tiene que convertir a una unidad media en este caso seria "'
				.. unidadInicio
				.. '" a una unidad neutral "'
				.. data.NeutralMedicion[buscarTipo]
				.. '"',
			data.Colores.Normal,
		})

		local cont, seg = self:ConvertidorSeguimiento({
			["Numero"] = parametroConv.Numero,
			["Tipo"] = { unidadInicio, data.NeutralMedicion[buscarTipo] },
		})

		for _, v in seg do
			table.insert(seguimiento, v)
		end

		if data.NeutralMedicion[buscarTipo] ~= unidadConvertir then
			table.insert(seguimiento, {
				'Ahora con la unidad convertida lo convertimos de "'
					.. data.NeutralMedicion[buscarTipo]
					.. '" a "'
					.. unidadConvertir
					.. '"',
				data.Colores.Normal,
			})
		end

		cont, seg = self:ConvertidorSeguimiento({
			["Numero"] = cont,
			["Tipo"] = { data.NeutralMedicion[buscarTipo], unidadConvertir },
		})
		resultado = cont

		for _, v in seg do
			table.insert(seguimiento, v)
		end
	end
	return resultado, seguimiento
end

function module:Convertidor(parametroConv: {})
	local especialUnidades = {}
	local buscarTipo = ""

	local unidadInicio, unidadConvertir = table.unpack(parametroConv.Tipo) --

	if unidadInicio == unidadConvertir then
		return parametroConv.Numero
	end

	for i, v in data.Medicion do
		local tbEspecial = if v.Especial then v.Especial else nil
		if
			(v[unidadInicio] and v[unidadConvertir])
			or (tbEspecial and (tbEspecial[unidadInicio] or tbEspecial[unidadConvertir]))
		then
			buscarTipo = i

			if tbEspecial then
				if tbEspecial[unidadInicio] then
					table.insert(especialUnidades, 1)
				end
				if tbEspecial[unidadConvertir] then
					table.insert(especialUnidades, 2)
				end
			end

			break
		end
	end
	if buscarTipo == "" then
		--Velocidad
		local aceleracion = false

		if string.find(unidadInicio, "²") then
			aceleracion = true
		end
		if unidadConvertir == nil then
			if string.find(unidadInicio, "²") then
				unidadConvertir = "m/seg²"
			else
				unidadConvertir = "m/seg"
			end
		end

		unidadInicio, unidadConvertir = buscarVelocidades(unidadInicio), buscarVelocidades(unidadConvertir)

		local tiempoConversor = self:Convertidor({ ["Numero"] = 1, ["Tipo"] = { unidadInicio[2], unidadConvertir[2] } })

		if aceleracion then
			tiempoConversor = tiempoConversor ^ 2
		end
		return self:Convertidor({
			["Numero"] = parametroConv.Numero,
			["Tipo"] = { unidadInicio[1], unidadConvertir[1] },
		}) / tiempoConversor
	end

	local tipoMedicion = data.Medicion[buscarTipo]

	if buscarTipo == "Temperatura" then
		if unidadInicio == "°C" then
			if unidadConvertir == "°F" then
				return (parametroConv.Numero * (5 / 9)) + 32
			elseif unidadConvertir == "°K" then
				return parametroConv.Numero + 273.15
			end
		elseif unidadConvertir == "°C" then
			if unidadInicio == "°F" then
				return (parametroConv.Numero - 32) * (5 / 9)
			elseif unidadInicio == "°K" then
				return parametroConv.Numero - 273.15
			end
		else
			return self:Convertidor({
				["Numero"] = self:Convertidor({ ["Numero"] = parametroConv.Numero, ["Tipo"] = { unidadInicio, "°C" } }),
				["Tipo"] = { "°C", unidadConvertir },
			})
		end
	end

	local numeroEspecial

	if table.find(especialUnidades, 1) then
		if typeof(tipoMedicion.Especial[unidadInicio]) == "table" then
			numeroEspecial = tipoMedicion.Especial[unidadInicio][1]
		else
			numeroEspecial = tipoMedicion.Especial[unidadInicio]
		end
	elseif typeof(tipoMedicion.Especial[unidadConvertir]) == "table" then
		numeroEspecial = tipoMedicion.Especial[unidadConvertir][1]
	else
		numeroEspecial = tipoMedicion.Especial[unidadConvertir]
	end

	--Cambio Unidades Normales
	if #especialUnidades == 0 then
		--Nada de especiales
		local indexParametro = {}

		if tipoMedicion[unidadInicio] < tipoMedicion[unidadConvertir] then
			-- si el numero de inicio es mayo a convertir (/)
			indexParametro[1] = tipoMedicion[unidadConvertir] - tipoMedicion[unidadInicio]
			indexParametro[2] = "/"
			--
		elseif tipoMedicion[unidadInicio] > tipoMedicion[unidadConvertir] then
			-- si el numero a convertir es mayo a inicio (*)
			indexParametro[1] = tipoMedicion[unidadInicio] - tipoMedicion[unidadConvertir]
			indexParametro[2] = "*"
		end

		local sum = "1"
		for _ = 1, indexParametro[1] do
			sum ..= "0"
		end

		if indexParametro[2] == "*" then
			return parametroConv.Numero * tonumber(sum)
		else
			return parametroConv.Numero / tonumber(sum)
		end
	elseif #especialUnidades == 1 then
		if table.find(especialUnidades, 1) then
			-- la unidadPrincipal tiene el especial
			return self:Convertidor({
				["Numero"] = if typeof(tipoMedicion.Especial[unidadInicio]) == "table"
					then parametroConv.Numero * numeroEspecial
					else parametroConv.Numero / numeroEspecial,

				["Tipo"] = { data.NeutralMedicion[buscarTipo], parametroConv.Tipo[2] },
			})
		else
			-- la unidadConvertir tiene el especial
			return self:Convertidor({
				["Numero"] = if typeof(tipoMedicion.Especial[unidadConvertir]) == "table"
					then parametroConv.Numero / numeroEspecial
					else parametroConv.Numero * numeroEspecial,

				["Tipo"] = { parametroConv.Tipo[1], data.NeutralMedicion[buscarTipo] },
			})
		end
	else
		--se despejan ambos
		return self:Convertidor({
			["Numero"] = if typeof(tipoMedicion.Especial[unidadInicio]) == "table"
				then parametroConv.Numero * numeroEspecial
				else parametroConv.Numero / numeroEspecial,

			["Tipo"] = { data.NeutralMedicion[buscarTipo], unidadConvertir },
		})
	end
end

function module.buscarTipo(unidad: string): string
	for i, v in data.Medicion do
		local tbEspecial = if v.Especial then v.Especial else nil

		if v[unidad] or (tbEspecial and tbEspecial[unidad]) then
			return data.NeutralMedicion[i]
		end
	end
	return nil
end

function module:UnidadConNumero(tno: number, unidad: string): string
	local strTurno = ""

	if not data.Turno[tno] then
		tno = 1
	end
	strTurno = data.Turno[tno][unidad]
	if strTurno == nil then
		return self:UnidadConNumero(1, unidad)
	else
		return strTurno, tno
	end
end

return module
