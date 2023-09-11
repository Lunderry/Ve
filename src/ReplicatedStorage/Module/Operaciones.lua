local ReplicatedStorage = game:GetService("ReplicatedStorage")

local conversionNumeros = require(ReplicatedStorage.Module.ConversionUnidades)

local module = {}
local matematicas = {}

matematicas.bloqVariable = { " ", ")", "]", "[", "(", "=", "/", "*", "+", "-", "%", "^", "√", "²", "³" }
matematicas.signosMatema = { "/", "*", "+", "-", "%", "^", "√", "²", "³" }
matematicas.signosTrigon = { "cos", "sin", "tan" }

function matematicas.Trigonometria(numero: number, tipo: string, modo: string): number
	if modo == "rad" then
		numero = math.rad(numero)
	else
		numero = math.deg(numero)
	end
	if tipo == "cos" then
		return math.cos(numero)
	elseif tipo == "sin" then
		return math.sin(numero)
	elseif tipo == "tan" then
		return math.tan(numero)
	end
end

function matematicas.Basicas(n: {}, tipo: string)
	if tipo == "/" then
		return n[1] / n[2]
	elseif tipo == "*" then
		return n[1] * n[2]
	elseif tipo == "%" then
		return n[1] % n[2]
	elseif tipo == "+" then
		return n[1] + n[2]
	elseif tipo == "-" then
		return n[1] - n[2]
	elseif tipo == "^" then
		return n[1] ^ n[2]
	end
end

local function stringUnidad(numero: string, variables: {})
	if type(numero) ~= "string" then
		return { false }
	end

	local nm = ""
	local unidad = ""
	local turno = 0

	for i = 1, #numero do
		local str = string.sub(numero, i, i)

		if str == "|" then
			turno += 1
		elseif turno == 1 then
			unidad ..= str
		elseif turno == 0 then
			nm ..= str
		end
	end
	if unidad == "" then
		return { false }
	else
		nm = if variables[nm] then variables[nm] else nm
		return { true, nm, unidad }
	end
end
local function buscarNumero(v, variables)
	if not table.find({ "string", "number" }, type(v)) or table.find(matematicas.bloqVariable, v) then
		return
	end
	local n = nil

	local menos = false

	if type(v) == "string" and #v > 1 and string.sub(v, 1, 1) == "-" then
		menos = true
		v = string.sub(v, 2, #v)
	end

	local su = stringUnidad(v, variables)
	if su[1] == true then
		n = conversionNumeros:Convertidor({
			["Numero"] = su[2],
			["Tipo"] = { su[3], conversionNumeros.buscarTipo(su[3]) },
		})
	elseif tonumber(v) then
		n = tonumber(v)
	elseif variables[v] then
		n = variables[v]
	end

	if menos then
		n = -n
	end

	return n
end
local function entregarData(operacion: {}): {}
	local r = { ["Negativo"] = nil, ["Unidad"] = nil }
	if type(operacion[1]) == "string" and string.sub(operacion[1], 1, 1) == "|" then
		r.Unidad = operacion[1]
		table.remove(operacion, 1)
	elseif type(operacion[2]) == "string" and string.sub(operacion[2], 1, 1) == "|" then
		r.Unidad = operacion[2]
		table.remove(operacion, 2)
	end

	if type(operacion[1]) == "string" and operacion[1] == "@Negativo" then
		r.Negativo = true
		table.remove(operacion, 1)
	elseif type(operacion[2]) == "string" and operacion[2] == "@Negativo" then
		r.Negativo = true
		table.remove(operacion, 2)
	end

	return r
end
local function resolverData(r, variables, data)
	if data.Unidad ~= nil then
		r = buscarNumero(tostring(r) .. data.Unidad, variables)
	end
	if data.Negativo then
		r = -r
	end
	return r
end
local function limpiarNuevaTabla(final: {}, tb: {})
	for i = 1, #tb do
		table.insert(final, tb[i])
	end

	return final
end
local function agregarPalabras(texto: {}, pos)
	local str = ""
	local palabras = 0
	for i = pos, #texto do
		local s = string.sub(texto, i, i)
		if not table.find(matematicas.bloqVariable, s) then
			str ..= s
			palabras += 1
		else
			break
		end
	end
	return str, palabras
end

function module.crearTabla(texto: string, variables: {}): {}
	local tb = {}

	local bloq = 0
	for i = 1, #texto do
		if bloq == 0 then
			local str = string.sub(texto, i, i)
			if str ~= " " then
				local s, c = agregarPalabras(texto, i)
				if variables[s] then
					bloq = c
					table.insert(tb, s)
				else
					table.insert(tb, str)
				end
				local sub = string.sub(texto, i + 1, i + 1)
				if str == "-" and (sub == " " or sub == "") then
					table.insert(tb, "")
				end
			end
		else
			bloq -= 1
		end
	end
	return tb
end

function module:crearOperacion(operacion: {}, pos: number): {}
	local finalTabla = {}
	local newTabla = {}

	local resta = false
	local cont = 0
	local bloq = 0

	local numero = ""
	local inicio, final = 0, 0

	local nIndex = if pos then pos else 1

	for i = nIndex, #operacion do
		cont += 1
		if bloq == 0 then
			local v = operacion[i]

			if not tonumber(v) and v ~= "." and #numero > 0 then
				table.insert(newTabla, tonumber(numero))
				inicio, final = 0, 0
				numero = ""
			end

			if v == "{" then
				local num = ""
				for q = i + 1, #operacion do
					bloq += 1
					if operacion[q] ~= "}" then
						num ..= operacion[q]
					else
						if #newTabla > 0 then
							finalTabla = limpiarNuevaTabla(finalTabla, newTabla)
							table.clear(newTabla)
							finalTabla[#finalTabla] = tostring(finalTabla[#finalTabla]) .. "|" .. num .. "|"
						elseif type(finalTabla[#finalTabla]) == "table" then
							table.insert(finalTabla[#finalTabla], 1, "|" .. num .. "| ")
						else
							newTabla[#newTabla] = newTabla[#newTabla] .. "|" .. num .. "| "
						end
						break
					end
				end
			elseif v == "[" then
				local tipo = ""
				for q = i + 1, #operacion do
					bloq += 1
					local w = operacion[q]
					if w == "(" then
						local t, c = self:crearOperacion(operacion, q + 1)

						if resta then
							table.insert(t, 1, "@Negativo")
							resta = false
						end
						bloq += c + 1
						local tb = { tipo, t }
						table.insert(finalTabla, tb)
						break
					else
						tipo ..= w
					end
				end
			elseif v == "(" then
				if #newTabla > 0 then
					finalTabla = limpiarNuevaTabla(finalTabla, newTabla)
					table.clear(newTabla)
				end
				local t, c = self:crearOperacion(operacion, i + 1)
				bloq += c
				if resta then
					table.insert(t, 1, "@Negativo")
					resta = false
				end
				table.insert(finalTabla, t)
			elseif v == ")" then
				break
			elseif tonumber(v) or v == "." then
				if inicio == 0 then
					inicio = i
				end
				final += 1
				numero ..= v
			elseif v == "-" and operacion[i + 1] ~= "" then
				if tonumber(operacion[i + 1]) or operacion[i + 1] == "." then
					numero ..= "-"
				else
					resta = true
				end
			elseif resta then
				table.insert(newTabla, "-" .. v)
				resta = false
			elseif #newTabla == 0 or table.find(matematicas.bloqVariable, v) then
				table.insert(newTabla, v)
			elseif not table.find(matematicas.bloqVariable, string.sub(newTabla[#newTabla], 1, 1)) then
				newTabla[#newTabla] ..= v
			end
		else
			bloq -= 1
		end
	end
	if numero ~= "" then
		table.insert(newTabla, tonumber(numero))
	end
	if #newTabla > 0 then
		finalTabla = limpiarNuevaTabla(finalTabla, newTabla)
	end
	return finalTabla, cont
end

local refe = {
	["√"] = { "Potencia", 2 },
	["²"] = { "Potencia", 2 },
	["³"] = { "Potencia", 2 },
	["^"] = { "Potencia", 2 },
	["/"] = { "Dividir", 3 },
	["*"] = { "Multiplicar", 4 },
	["+"] = { "Sumar", 5 },
	["-"] = { "Sumar", 5 },
}
local Indentificacion = {
	["Potencia"] = { "√", "²", "³" },
	["Sumar"] = { "+", "-" },
}

--[[
	HACER QUE LA POTENCIA SIRVA
	HACER UN BOTON PARA PONER SIGNOS DE POTENCIA
]]

function module:resolverOperacion(operacion: {}, variables: {}, tTipo): number
	local i = 1

	local jerarquia = { [6] = "Libre" }
	for _, v in operacion do
		if refe[v] then
			local ind = refe[v]
			jerarquia[ind[2]] = ind[1]
		elseif type(v) == "table" then
			jerarquia[1] = "Parentesis"
		end
	end

	for t = 1, 6 do
		local turno = jerarquia[t]
		if turno == nil then
			continue
		end
		i = 1
		while i <= #operacion do
			local v
			if type(operacion[i]) == "string" and #operacion[i] > 1 and string.sub(operacion[i], 1, 1) == "-" then
				v = string.sub(operacion[i], 2, #operacion[i])
			else
				v = operacion[i]
			end

			if turno == "Parentesis" and type(v) == "table" then
				local d = entregarData(v)
				local trigo

				if table.find(matematicas.signosTrigon, v[1]) then
					trigo = v[1]
					table.remove(v, 1)
				end
				local r = self:resolverOperacion(v, variables, tTipo)

				r = resolverData(r, variables, d)

				if trigo then
					r = matematicas.Trigonometria(r, trigo, tTipo)
				end

				operacion[i] = r

				if not table.find(matematicas.bloqVariable, operacion[i - 1]) and i > 1 then
					jerarquia[4] = "Multiplicar"
					table.insert(operacion, i, "*")
					i += 1
				end

				if not table.find(matematicas.bloqVariable, operacion[i + 1]) and i < #operacion then
					jerarquia[4] = "Multiplicar"
					table.insert(operacion, i + 1, "*")
				end
			elseif turno == "Potencia" and table.find(Indentificacion.Potencia, v) then
				if v == "²" then
					operacion[i - 1] = buscarNumero(operacion[i - 1], variables) ^ 2
					table.remove(operacion, i)
				elseif v == "³" then
					operacion[i - 1] = buscarNumero(operacion[i - 1], variables) ^ 3
					table.remove(operacion, i)
				else
					operacion[i] = math.sqrt(buscarNumero(operacion[i + 1], variables))
					table.remove(operacion, i + 1)
				end
			elseif
				(turno == "Potencia" and v == "^")
				or (turno == "Multiplicar" and v == "*")
				or (turno == "Dividir" and v == "/")
				or (turno == "Sumar" and table.find(Indentificacion.Sumar, v))
			then
				operacion[i] = matematicas.Basicas(
					{ buscarNumero(operacion[i - 1], variables), buscarNumero(operacion[i + 1], variables) },
					operacion[i]
				)
				table.remove(operacion, i + 1)
				table.remove(operacion, i - 1)

				i -= 1
			elseif turno == "Libre" then
				operacion[1] = buscarNumero(operacion[i], variables)
			end
			i += 1
		end
	end
	return operacion[1], operacion
end

return module
