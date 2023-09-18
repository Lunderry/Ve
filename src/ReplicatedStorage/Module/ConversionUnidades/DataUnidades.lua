--[[
	Para sacar numero especial es de ejem:
	min - seg
	hr - seg
	yd - m

	Cuando se pone en una tabla es multiplo
]]
local data = {
	["Medicion"] = {
		["Longitud"] = {
			["mm"] = 1,
			["cm"] = 2,
			["dm"] = 3,
			["m"] = 4,
			["dam"] = 5,
			["hm"] = 6,
			["km"] = 7,

			["Especial"] = {
				["yd"] = 1.0936,
				["ft"] = 3.281,
				["in"] = 39.370,
				["mi"] = { 1609.34 },
			},
		},
		["Masa"] = {
			["mg"] = 1,
			["cg"] = 2,
			["dg"] = 3,
			["g"] = 4,
			["dag"] = 5,
			["hg"] = 6,
			["kg"] = 7,

			["Especial"] = {}
		},
		["Tiempo"] = {
			["seg"] = 1,

			["Especial"] = {
				["min"] = { 60 },
				["hr"] = { 3600 },
			},
		},
		["TiempoCuadrado"] = {
			["seg²"] = 1,

			["Especial"] = {
				["min²"] = { 3600 },
				["hr²"] = { 12960000 },
			},
		},
		["Temperatura"] = {
			["°C"] = 1,
			["°F"] = 2,
			["°K"] = 3,
		},
		["Calorias"] = {
			["cal"] = 1,

			["Especial"] = {
				["J"] = 4.1868,
				["Kj"] = { 238.85 },
				--
				["kcal"] = { 1000 },
			},
			--[[
				cal - kj se tiene que hacer j y despues se hace kj
			]]
		},
		["Area"] = {
			["mm²"] = 1,
			["cm²"] = 3,
			["dm²"] = 5,
			["m²"] = 7,
			["dam²"] = 9,
			["hm²"] = 11,
			["km²"] = 13,

			["Especial"] = {
				["yd²"] = 1.1960,
				["ft²"] = 10.764,
				["in²"] = 1550.0,
				["mi²"] = { 0.00000038610 },
			},
		},
		["Volumen"] = {
			["mm³"] = 1,
			["cm³"] = 4,
			["dm³"] = 7,
			["m³"] = 10,
			["dam³"] = 13,
			["hm³"] = 16,
			["km³"] = 19,

			["Especial"] = {
				["yd³"] = 1.3080,
				["ft³"] = 35.315,
				["in³"] = 61024,
				["mi³"] = { 4.168e+9 },
			},
		},
	},
	["NeutralMedicion"] = {
		["Temperatura"] = "°C",
		["Tiempo"] = "seg",
		["TiempoCuadrado"] = "seg²",
		["Masa"] = "g",
		["Longitud"] = "m",
		["Area"] = "m²",
		["Volumen"] = "m³",
		["Calorias"] = "cal",
	},
	["Nombre"] = {
		["mm"] = "Milimetros",
		["cm"] = "Centimetros",
		["dm"] = "Decimetro",
		["m"] = "Metro",
		["dam"] = "Decametros",
		["hm"] = "Hectometro",
		["km"] = "Kilometro",

		["yd"] = "Yardas",
		["ft"] = "Pies",
		["in"] = "Pulgada",
		["mi"] = "Milla",

		["mm²"] = "Milimetros Cuadrado",
		["cm²"] = "Centimetros Cuadrado",
		["dm²"] = "Decimetro Cuadrado",
		["m²"] = "Metro Cuadrado",
		["dam²"] = "Decametros Cuadrado",
		["hm²"] = "Hectometro Cuadrado",
		["km²"] = "Kilometro Cuadrado",

		["yd²"] = "Yardas Cuadrado",
		["ft²"] = "Pies Cuadrado",
		["in²"] = "Pulgada Cuadrado",
		["mi²"] = "Milla Cuadrado",

		["mm³"] = "Milimetros Cubico",
		["cm³"] = "Centimetros Cubico",
		["dm³"] = "Decimetro Cubico",
		["m³"] = "Metro Cubico",
		["dam³"] = "Decametros Cubico",
		["hm³"] = "Hectometro Cubico",
		["km³"] = "Kilometro Cubico",

		["yd³"] = "Yardas Cubico",
		["ft³"] = "Pies Cubico",
		["in³"] = "Pulgada Cubico",
		["mi³"] = "Milla Cubico",

		["mg"] = "Miligramo",
		["cg"] = "Centigramos",
		["dg"] = "Decigramos",
		["g"] = "Gramos",
		["dag"] = "Decagramos",
		["hg"] = "Hectogramos",
		["kg"] = "Kilogramos",

		["seg"] = "Segundos",
		["min"] = "Minutos",
		["hr"] = "Horas",

		["seg²"] = "Segundos al cuadrado",
		["min²"] = "Minutos al cuadrado",
		["hr²"] = "Horas al cuadrado",

		["°C"] = "Centígrados",
		["°F"] = "Fahrenheit",
		["°K"] = "Kelvin",

		["Julios"] = "J",
		["Kilojulios"] = "Kj",
		["Calorías"] = "cal",
		["Kilocalorías"] = "kcal",

		--al revez
		["Milimetros"] = "mm",
		["Centimetros"] = "cm",
		["Decimetro"] = "dm",
		["Metro"] = "m",
		["Decametros"] = "dam",
		["Hectometro"] = "hm",
		["Kilometro"] = "km",

		["Yardas"] = "yd",
		["Pies"] = "ft",
		["Pulgada"] = "in",
		["Milla"] = "mi",

		["Milimetros Cuadrado"] = "mm²",
		["Centimetros Cuadrado"] = "cm²",
		["Decimetro Cuadrado"] = "dm²",
		["Metro Cuadrado"] = "m²",
		["Decametros Cuadrado"] = "dam²",
		["Hectometro Cuadrado"] = "hm²",
		["Kilometro Cuadrado"] = "km²",

		["Yardas Cuadrado"] = "yd²",
		["Pies Cuadrado"] = "ft²",
		["Pulgada Cuadrado"] = "in²",
		["Milla Cuadrado"] = "mi²",

		["Milimetros Cubico"] = "mm³",
		["Centimetros Cubico"] = "cm³",
		["Decimetro Cubico"] = "dm³",
		["Metro Cubico"] = "m³",
		["Decametros Cubico"] = "dam³",
		["Hectometro Cubico"] = "hm³",
		["Kilometro Cubico"] = "km³",

		["Yardas Cubico"] = "yd³",
		["Pies Cubico"] = "ft³",
		["Pulgada Cubico"] = "in³",
		["Milla Cubico"] = "mi³",

		["Miligramo"] = "mg",
		["Centigramos"] = "cg",
		["Decigramos"] = "dg",
		["Gramos"] = "g",
		["Decagramos"] = "dag",
		["Hectogramos"] = "hg",
		["Kilogramos"] = "kg",

		["Segundos"] = "seg",
		["Minutos"] = "min",
		["Horas"] = "hr",

		["Segundos al cuadrado"] = "seg²",
		["Minutos al cuadrado"] = "min²",
		["Horas al cuadrado"] = "hr²",

		["Centígrados"] = "°C",
		["Fahrenheit"] = "°F",
		["Kelvin"] = "°K",

		["J"] = "Julios",
		["Kj"] = "Kilojulios",
		["cal"] = "Calorías",
		["kcal"] = "Kilocalorías",
	},

	["Turno"] = {
		[1] = { ["Longitud"] = "mm", ["Tiempo"] = "seg" },
		[2] = { ["Longitud"] = "cm", ["Tiempo"] = "min" },
		[3] = { ["Longitud"] = "dm", ["Tiempo"] = "hr" },
		[4] = { ["Longitud"] = "m" },
		[5] = { ["Longitud"] = "dam" },
		[6] = { ["Longitud"] = "hm" },
		[7] = { ["Longitud"] = "km" },
		[8] = { ["Longitud"] = "yd" },
		[9] = { ["Longitud"] = "ft" },
		[10] = { ["Longitud"] = "in" },
		[11] = { ["Longitud"] = "mi" },
	},
	["Colores"] = {
		["Normal"] = Color3.fromRGB(0, 0, 0),
		["Operaciones"] = Color3.fromRGB(200, 212, 75),
		["Resultado"] = Color3.fromRGB(213, 27, 27),
	},
}

return data
