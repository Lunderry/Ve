script.Enabled = false

local dss = game:GetService("DataStoreService")

local KeyCodigos = dss:GetDataStore("Codigos")

local letras = {
	{'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'},
{'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'},
}

local function crearCodigos(Largo)
	local str = ""
	for _ = 1, Largo do
		local r = math.random(1, 20000)
		if r >= 10000  then
			local letrasR = math.random(1, 20000)
			if letrasR >= 10000 then
				str = str..letras[1][math.random(1, #letras[1])]
			else
				str = str..letras[2][math.random(1, #letras[2])]
			end
		else
			str = str..tostring(math.random(1, 9))
		end
	end
	return str
end


local CodigosTb = {}

for i = 1, 50 do
	CodigosTb[i] = {crearCodigos(10), "Congreso Nacional de Fisica", false}
end

KeyCodigos:UpdateAsync("Codigos", function(value)
	for _, v in pairs(CodigosTb) do
		table.insert(value, v)
	end
	return value
end)
