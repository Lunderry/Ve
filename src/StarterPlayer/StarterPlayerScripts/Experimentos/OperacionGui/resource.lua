local module = {
	colores = {
		'<font color = "rgb(222, 100, 40)" >', --amarillo
		'<font color = "rgb(181, 27, 224)" >', -- rosa
		'<font color = "rgb(33, 73, 205)" >', -- azul

		["[]"] = '<font color = "rgb( 62, 56, 104 )" >', -- morado
		["{}"] = '<font color = "rgb(238, 250, 7)" >', -- amarillo
	},
}

function module.quitarPalabras(texto: string, lado: number)
	if #texto == 1 and lado == 0 then
		texto = ""
	elseif lado > 1 then
		texto = string.sub(texto, 1, lado - 2) .. string.sub(texto, lado, #texto)
	end
	return texto
end
function module.insertarPalabra(texto: string, poner: string, lado: number)
	return string.sub(texto, 1, lado - 1) .. poner .. string.sub(texto, lado, #texto)
end

local function cambioColor(color: string, pos: number, text: string)
	return string.sub(text, 1, pos - 1)
		.. color
		.. string.sub(text, pos, pos)
		.. "</font>"
		.. string.sub(text, pos + 1, #text)
end

function module:TextColor(texto: string): string
	local posColor = 1
	local i = 1

	while i <= #texto do
		local str = string.sub(texto, i, i)

		if str == "{" then
			local cont = i
			for q = i, #texto do
				if string.sub(texto, q, q) == "}" then
					break
				else
					cont += 1
				end
			end
			texto = string.sub(texto, 1, i - 1)
				.. self.colores["{}"]
				.. string.sub(texto, i, cont)
				.. "</font>"
				.. string.sub(texto, cont + 1, #texto)
			i += #self.colores["[]"] + #"</font>" + (cont - i) - 2
		elseif str == "[" or str == "]" then
			texto = cambioColor(self.colores["[]"], i, texto)
			i += #self.colores["[]"] + #"</font>"
		elseif str == "(" then
			texto = cambioColor(self.colores[posColor], i, texto)
			i += #self.colores[posColor] + #"</font>"
			posColor = if posColor == 3 then 1 else posColor + 1
		elseif str == ")" then
			posColor = if posColor == 1 then 3 else posColor - 1
			texto = cambioColor(self.colores[posColor], i, texto)
			i += #self.colores[posColor] + #"</font>"
		end
		i += 1
	end
	return texto
end

return module
