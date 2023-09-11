local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

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

		GuiExperimento.ConversionGui(v.Nombre)
		GuiExperimento.Gui(v.Nombre)
	end)
end
