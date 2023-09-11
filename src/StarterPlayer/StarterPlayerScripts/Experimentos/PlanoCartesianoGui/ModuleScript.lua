local module = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local plrs = game:GetService("Players")

local TextoIdiomas = require(ReplicatedStorage.Module.Data.TextoIdiomas)
local modulePart = require(ReplicatedStorage.Module.PartModule)

local plr = plrs.LocalPlayer
local plrGui = plr.PlayerGui

local pais = plr:WaitForChild("Datos").Pais

local valuePlanoCartesiano = ReplicatedStorage.Value.Fisica.Nivel2
local centroVector = valuePlanoCartesiano.CentroVector
local ObjetosValue = valuePlanoCartesiano.Objetos

local guiPlanoCartesiano = plrGui.Experimentos.PlanoCartesianoGui

local dataFrame = guiPlanoCartesiano.Datos.Frame.ScrollingFrame

function module.sacarData()
	local posEje = ObjetosValue.Vertice.Value.Position - ObjetosValue.eje0.Value.Position
	local posPuntoMedio = ObjetosValue.Vertice.Value.Position - centroVector.Value

	local angle
	if posEje.Y >= 0 then
		angle = math.abs(math.deg(math.atan2(posEje.Y, posEje.X)))
	else
		angle = math.abs(math.deg(math.atan2(posEje.Y, -posEje.X))) + 180
	end
	dataFrame.DistanciaPuntoMedio.Text = modulePart.vr(ObjetosValue.Vertice.Value.Position, centroVector.Value)
	dataFrame.VerticePosicionPuntoMedio.Text = posPuntoMedio.X .. "," .. posPuntoMedio.Y
	dataFrame.VerticePosicionEje.Text = posEje.X .. "," .. posEje.Y
	dataFrame.Grados.Text = angle .. "°"
	dataFrame.Distancia.Text = modulePart.vr(ObjetosValue.Vertice.Value.Position, ObjetosValue.eje0.Value.Position)

	if TextoIdiomas[pais.Value].Angulo[angle] then
		dataFrame.TipoAngulo.Text = TextoIdiomas[pais.Value].Angulo[angle]
	else
		if angle > 0 and angle < 90 then
			dataFrame.TipoAngulo.Text = TextoIdiomas[pais.Value].Angulo[1]
		elseif angle > 90 and angle < 180 then
			dataFrame.TipoAngulo.Text = TextoIdiomas[pais.Value].Angulo[2]
		else
			dataFrame.TipoAngulo.Text = TextoIdiomas[pais.Value].Angulo[3]
		end
	end
end

return module
