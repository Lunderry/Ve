local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local moduleUnidades = require(ReplicatedStorage.Module.ConversionUnidades)
local CrearExperimento = require(ReplicatedStorage.Module.Experimentos.CrearExperimento)
local GuiExperimento = require(ReplicatedStorage.Module.Experimentos.GuiExperimento)
local Data = require(script.Parent)

for _, v in Data do
	task.defer(function()
		CrearExperimento.CrearValue(v)
		CrearExperimento.ConversionValue(v)
		CrearExperimento.CambioTiempo(v)
		CrearExperimento.Funcionamiento(v)
		CrearExperimento.AcomodarBloques(v)
		CrearExperimento.LimitanteTexto(v)

		GuiExperimento.Gui(v.Nombre)
	end)
end

local plr = Players.LocalPlayer
local plrGui = plr:WaitForChild("PlayerGui")

local experimentoGui: ScreenGui = plrGui:WaitForChild("Experimentos")

for _, v in experimentoGui:GetChildren() do
	if v:FindFirstChild("Datos") and v.Name ~= "PlanoCartesianoGui" then
		for _, frame in v.Datos.Frame.ScrollingFrame:GetChildren() do
			if frame:IsA("Frame") then
				local unidad = frame.Unidad
				if unidad:IsA("TextBox") then
					unidad.FocusLost:Connect(function()
						if frame.Value.Value == "Aceleracion" then
							frame.Unidad.Text = unidad.Text .. "²"
						else
							frame.Unidad.Text = unidad.Text
						end
						frame.Numero.Text = moduleUnidades:Convertidor({
							["Numero"] = frame.ValorNeutral.Value,
							["Tipo"] = { frame.Convertir.Value, unidad.Text },
						}) .. unidad.Text
					end)
				else
					local turnoUnidad = 0
					unidad.MouseButton1Click:Connect(function()
						turnoUnidad += 1
						unidad.Text, turnoUnidad = moduleUnidades:UnidadConNumero(turnoUnidad, frame.Value.Value)
						frame.Numero.Text = moduleUnidades:Convertidor({
							["Numero"] = frame.ValorNeutral.Value,
							["Tipo"] = { frame.Convertir.Value, unidad.Text },
						}) .. unidad.Text
					end)
				end
			end
		end
	end
end
