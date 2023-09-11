local module = {
	["Iniciar"] = {
		[false] = {
			["ImageRectOffset"] = Vector2.new(312, 4),
			["ImageRectSize"] = Vector2.new(24, 24),
			["ImageColor3"] = Color3.fromRGB(39, 255, 28),
			["BackgroundColor3"] = Color3.fromRGB(4, 170, 43),
		},
		[true] = {
			["ImageRectOffset"] = Vector2.new(244, 684),
			["ImageRectSize"] = Vector2.new(36, 36),
			["ImageColor3"] = Color3.fromRGB(246, 255, 190),
			["BackgroundColor3"] = Color3.fromRGB(223, 205, 9),
		},
	},
	["Pausar"] = {
		[true] = {
			["ImageRectOffset"] = Vector2.new(100, 150),
			["ImageRectSize"] = Vector2.new(50, 50),
			["ImageColor3"] = Color3.fromRGB(255, 128, 0),
			["BackgroundColor3"] = Color3.fromRGB(170, 0, 0),
		},
		[false] = {
			["ImageRectOffset"] = Vector2.new(100, 550),
			["ImageRectSize"] = Vector2.new(50, 50),
			["ImageColor3"] = Color3.fromRGB(246, 255, 190),
			["BackgroundColor3"] = Color3.fromRGB(223, 205, 9),
		},
	},
	["Conversion"] = {
		["Tiempo"] = "seg",
		["Masa"] = "g",
		["Longitud"] = "m",
		["Cuadrado"] = "m",
		["Cubico"] = "m",
	},
}

return module

