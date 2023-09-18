local posOriginal = {}

for _, v in workspace:GetChildren() do
	if v:IsA("Folder") and v:FindFirstChild("Folder") and v.Folder:FindFirstChild("Mov") then
		posOriginal[v.Nivel.Value] = v.Folder.Mov.Position
	end
end

--[[mejorar sistema para mejorar la manera de meter datos, ejem:
velocidad inicial para eel tiempoMaximo de un objeto
]]
local Data = {
	["MovimientoRectilinio"] = {
		["Nombre"] = "MovimientoRectilinio",

		["Funcion"] = function(a, vi, t, EleccionBasta: string)
			local d, v

			--a = (v - vi) / t
			--t = (v - vi) / a
			-- 	a = (v - vi) / t

			if table.find({ "Contador", "CambioTiempo" }, EleccionBasta) then
				if a == 0 then
					d = vi * t
					v = d / t
				else
					d = (vi * t) + ((0.5 * a) * (t ^ 2))
					v = vi + (a * t)
				end
			end

			return {
				["Velocidad"] = v,
				["Distancia"] = d,
			}
		end,
		["Calculos"] = function(a, vi)
			-- buen calculos
			return {
				["TiempoMaximo"] = if (a < 0 and vi > 0) or (a > 0 and vi < 0) then -vi / a else tonumber("inf"),
			}
		end,
		["Sumar"] = function(Resultado)
			if Resultado.Distancia == nil then
				return posOriginal[3]
			end
			return posOriginal[3] + Vector3.new(0, 0, Resultado.Distancia)
		end,
		["PonerCalculo"] = { "Aceleracion", "VelocidadInicial" },
		["PonerFuncion"] = { "Aceleracion", "VelocidadInicial", "Tiempo" },
		["Propiedades"] = { "Aceleracion", "VelocidadInicial", "Velocidad", "Tiempo" },
		["Conversion"] = { "Aceleracion", { "VelocidadInicial", "Velocidad" }, "Tiempo " },
		--Si son "especiales se pone dentro de una tabla y se cuenta el segundo valor
		["ListaBlanca"] = {
			["Basta"] = {},
			["Opccional"] = {
				"Aceleracion",
				"VelocidadInicial",
			},
		},
		["Limitante"] = {},
	},
	["CaidaLibre"] = {
		["Nombre"] = "CaidaLibre",

		-- usar eleccion basta y analizar por dentro sobre la altura
		--agregar altura por velocidad final
		["Funcion"] = function(g, h, t, EleccionBasta: string)
			local vf = 0

			if table.find({ "Contador", "CambioTiempo", "Tiempo" }, EleccionBasta) then
				vf = (g * t)
				h = ((g * (t ^ 2)) / 2)
				-- t = math.sqrt((2 * h) / g)
			end
			return {
				["Tiempo"] = t,
				["Altura"] = h,
				["VelocidadFinal"] = -math.abs(vf),
			}
		end,
		["Calculos"] = function(g, h)
			local tiempoFinal = math.sqrt((2 * h) / g)

			return {
				["AlturaRecorrido"] = g * ((tiempoFinal ^ 2) / 2),
				["TiempoMaximo"] = tiempoFinal,
			}
		end,
		["Sumar"] = function(Resultado: {}, AlturaInicio)
			local h

			if AlturaInicio ~= nil then
				h = AlturaInicio.Y - Resultado["Altura"]
			else
				h = Resultado["Altura"] + posOriginal[4].Y
			end
			return Vector3.new(posOriginal[4].X, h, posOriginal[4].Z)
		end,
		["PonerCalculo"] = { "Gravedad", "Altura" },
		["PonerFuncion"] = { "Gravedad", "Altura", "Tiempo" },
		["Propiedades"] = { "Gravedad", "Altura", "Tiempo", "VelocidadFinal" },
		["Conversion"] = {
			{ "Gravedad", "Aceleracion" },
			{ "Altura", "Longitud" },
			"Tiempo",
			{ "VelocidadInicial", "Velocidad" },
		},

		["ListaBlanca"] = {
			"Gravedad",
			["Basta"] = {
				"Tiempo",
				"Altura",
			},
			["Opccional"] = {},
		},

		["Limitante"] = {
			["Tiempo"] = { 0, nil },
			["Altura"] = { 0, nil },
			["Gravedad"] = { 0, nil },
		},
	},
	["TiroVertical"] = {
		["Nombre"] = "TiroVertical",

		["Funcion"] = function(g, t, vi, v, EleccionBasta: string)
			local h

			if table.find({ "Contador", "CambioTiempo" }, EleccionBasta) then
				h = (vi * t) - (0.5 * g) * (t ^ 2)
				v = vi - (g * t)
			elseif EleccionBasta == "Tiempo" then
				vi = g * (t / 2)
			elseif EleccionBasta == "CambioVelocidad" then
				h = ((v ^ 2) - (vi ^ 2)) / (2 * -g)
				t = (vi - v) / g
			else
				h = 0
			end

			return {
				["VelocidadInicial"] = vi,
				["Velocidad"] = v,
				["Altura"] = h,
				["Tiempo"] = t,
			}
		end,
		["Calculos"] = function(g, vi)
			return {
				["TiempoSubida"] = vi / g,
				["TiempoMaximo"] = (vi / g) * 2,
				["AlturaMaxima"] = (vi ^ 2) / (2 * g),
				["VelocidadUltima"] = vi - (g * ((vi / g) * 2)),
			}
		end,
		["Sumar"] = function(Resultado)
			if Resultado["Altura"] == nil then
				return
			end

			if Resultado["Altura"] < 0 then
				return posOriginal[5]
			elseif Resultado["Altura"] > 10000 then
				return Vector3.new(posOriginal[5].X, 10000, posOriginal[5].Z)
			else
				return posOriginal[5] + Vector3.new(0, Resultado["Altura"], 0)
			end
		end,
		["PonerCalculo"] = { "Gravedad", "VelocidadInicial" },
		["PonerFuncion"] = { "Gravedad", "Tiempo", "VelocidadInicial", "Velocidad" },
		["Propiedades"] = { "Gravedad", "Altura", "Tiempo", "VelocidadInicial", "Velocidad" },
		["Conversion"] = {
			{ "Gravedad", "Aceleracion" },
			{ "Altura", "Longitud" },
			"Tiempo",
			{ "VelocidadInicial", "Velocidad" },
			"Velocidad",
		},

		["ListaBlanca"] = {
			"Gravedad",

			["Basta"] = {
				"VelocidadInicial",
				"Tiempo",
			},
			["Opccional"] = {},
		},
		["Limitante"] = {
			["Tiempo"] = { 0, nil },
			["VelocidadInicial"] = { 0, nil },
			["Gravedad"] = { 0, nil },
		},
	},
	["TiroParabolico"] = {
		["Nombre"] = "TiroParabolico",

		["Funcion"] = function(g, t, vi, gra, dis, EleccionBasta: string)
			local pos = Vector3.new(posOriginal[6].X, 0, 0)
			local graRad = math.rad(gra)
			local vx = vi * math.cos(graRad)
			local vy = vi * math.sin(graRad)

			local x = vx * t
			local y = (vy * t) - (0.5 * g * t ^ 2)

			if table.find({ "Contador", "CambioTiempo" }, EleccionBasta) then
				pos = Vector3.new(posOriginal[6].X, y, -x)
			elseif EleccionBasta == "Tiempo" then
				vi = math.sqrt((-0.5 * g * t) ^ 2 / math.sin(graRad) ^ 2)
			elseif EleccionBasta == "Distancia" then
				vi = math.sqrt(dis * g / math.sin(2 * graRad))
			end

			return {
				["VelocidadInicial"] = vi,
				["VelocidadX"] = vx,
				["VelocidadY"] = vy - (g * t),
				["PosicionX"] = x,
				["PosicionY"] = y,
				["Tiempo"] = t,
				["Posicion"] = pos,
			}
		end,
		["Calculos"] = function(g, gra, vi)
			local angulo = math.rad(gra)
			local vx = vi * math.cos(angulo)
			local vy = vi * math.sin(angulo)

			local tb = {
				["TiempoSubida"] = math.abs(vy / g),
				["AlturaMaxima"] = math.pow(vy, 2) / (2 * g),
				["TiempoMaximo"] = math.abs((2 * vy) / g),
				["AlcanceHorizontal"] = (vx * (vy / g * 2)),
			}
			return tb
		end,
		["Sumar"] = function(Resultado)
			return Resultado["Posicion"] + Vector3.new(0, posOriginal[6].Y, posOriginal[6].Z)
		end,
		["PonerCalculo"] = { "Gravedad", "Grados", "VelocidadInicial" },
		["PonerFuncion"] = { "Gravedad", "Tiempo", "VelocidadInicial", "Grados", "Distancia" },
		["Propiedades"] = { "Gravedad", "Grados", "Posicion", "Tiempo", "VelocidadInicial", "Distancia" },
		["Conversion"] = {
			{ "Gravedad", "Aceleracion" },
			"Tiempo",
			{ "VelocidadInicial", "Velocidad" },
			{ "Distancia", "Longitud" },
		},
		["ListaBlanca"] = {
			"Gravedad",
			"Grados",

			["Basta"] = {
				"VelocidadInicial",
				"Tiempo",
				"Distancia",
			},
			["Opccional"] = {},
		},
		["Limitante"] = {
			["Tiempo"] = { 0, nil },
			["VelocidadInicial"] = { 0, nil },
			["Grados"] = { 0, 180 },
			["Distancia"] = { 0, nil },
			["Gravedad"] = { 0, nil },
		},
	},
}

return Data

--[[ Documentacion de que es cada cosa
	["TiroParabolico"] = {
		["Nombre"] = "TiroParabolico",

		["Funcion"] = function(g, t, vi, gra, dis, EleccionBasta: string)
			local pos = Vector3.new(406.856, 0, 0)
			local graRad = math.rad(gra)
			local vx = vi * math.cos(graRad)
			local vy = vi * math.sin(graRad)

			local x = vx * t
			local y = (vy * t) - (0.5 * g * t ^ 2)

			if EleccionBasta == "Contador" or EleccionBasta == "CambioTiempo" then
				pos = Vector3.new(406.856, y, x)
			elseif EleccionBasta == "Tiempo" then
				vi = math.sqrt((-0.5 * g * t) ^ 2 / math.sin(graRad) ^ 2)
			elseif EleccionBasta == "Distancia" then
				vi = math.sqrt(dis * g / math.sin(2 * graRad))
			end

			return {
				["VelocidadInicial"] = vi,
				["Velocidad"] = tostring(vx - t) .. "X" .. " " .. tostring(vy - (g * t)) .. "Y",
				["Tiempo"] = t,
				["Posicion"] = pos,
				["PosicionXY"] = tostring(x) .. "X " .. tostring(y) .. "Y",
			}
		end,
		["Calculos"] = function(g, gra, vi)
			local angulo = math.rad(gra)
			local vx = vi * math.cos(angulo)
			local vy = vi * math.sin(angulo)

			local tb = {
				["VelocidadXY"] = vi,
				["TiempoSubida"] = math.abs(vy / g),
				["AlturaMaxima"] = math.pow(vy, 2) / (2 * g),
				["TiempoMaximo"] = math.abs((2 * vy) / g),
				["AlcanceHorizontal"] = -(vx * (vy / g * 2)),
			}
			return tb
		end,
		["Sumar"] = function(Resultado)
			return Resultado["Posicion"] + Vector3.new(0, 30.052, -178.057)
		end,
		["PonerCalculo"] = { "Gravedad", "Grados", "VelocidadInicial" },
		--el orden de poner calculo
		["PonerFuncion"] = { "Gravedad", "Tiempo", "VelocidadInicial", "Grados", "Distancia" },
		--El orden de poner
		["Propiedades"] = { "Gravedad", "Grados", "Posicion", "Tiempo", "VelocidadInicial", "Distancia" },
		--Crea su value
		["Conversion"] = {},
		--Value que pueden tener conversiones
		["ListaBlanca"] = {
			"Gravedad",
			"Grados",

			["Basta"] = {
				"VelocidadInicial",
				"Tiempo",
				"Distancia",
			},
		},
		["Limitante"] = {
			["Tiempo"] = { 0, nil },
			["VelocidadInicial"] = { 0, nil },
			["Grados"] = { 0, 89.99 },
			["Distancia"] = { 0, nil },
			["Gravedad"] = { 0, nil },
		},
		--Numeros que si o si tienen que tener un valor
		--Basta es que uno de los dos tiene que pasar
		--Lado en el que va a ir
	},
]]
