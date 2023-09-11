local ReplicatedStorage = game:GetService("ReplicatedStorage")
local plrs = game:GetService("Players")

repeat
	task.wait()
until plrs.LocalPlayer

local moduleTween = require(ReplicatedStorage.Module.TweenMaster)
local datos = require(ReplicatedStorage.Module.Data.DataPreguntas)
local vettyFuncion = require(ReplicatedStorage.Module.VettyFuncion)

local plr = plrs.LocalPlayer
local plrGui = plr.PlayerGui

local paisValue = plr.Datos.Pais
local pais = paisValue.Value

local configuracion = ReplicatedStorage.re["Cliente-Server"].Configuracion

local cargandoGui = plrGui.Cargando

local termino = false

paisValue:GetPropertyChangedSignal("Value"):Connect(function()
	pais = paisValue.Value
end)
task.spawn(function()
	local image = cargandoGui.Fondo
	while not termino do
		image.Position = UDim2.fromScale(1.334, 2)
		moduleTween:WaitTween(
			image,
			{ Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 10, { Position = UDim2.fromScale(0, 2) } }
		)
		task.wait()
	end
end)
local logo = cargandoGui.Logo
task.spawn(function()
	while not termino do
		moduleTween:WaitTween(logo, { Enum.EasingStyle.Back, Enum.EasingDirection.Out, 1, { Rotation = 360 } })
		logo.Rotation = 0
		task.wait(0.5)
	end
end)

local idioma = cargandoGui.Idioma
local carga = ReplicatedStorage.Carga

plr.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = 0

local ContadorCarga = 0

for _, v in pairs(carga:GetChildren()) do
	v:GetPropertyChangedSignal("Value"):Connect(function()
		ContadorCarga += 1
		if ContadorCarga >= 1 then
			moduleTween:WaitTween(
				logo,
				{ Enum.EasingStyle.Back, Enum.EasingDirection.In, 0.4, { Size = UDim2.fromScale(0, 0) } }
			)

			logo.Visible = false
			if _G.DataConfi.PrimeraVez == false then
				plrGui.VettyScreenGui.DisplayOrder = 3
				for _, image in pairs(plrGui.VettyScreenGui:GetChildren()) do
					if image:IsA("ImageButton") then
						image.Visible = false
					end
				end
				-- vettyFuncion:Pack({
				-- 	[1] = { "Idioma / Lenguaje", "Dato" },
				-- })
				-- idioma.Selector.Visible = true
				-- moduleTween:WaitTween(
				-- 	idioma.Selector,
				-- 	{ Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0.5, { Size = UDim2.fromScale(0.5, 0.5) } }
				-- )
				-- local esperar = false
				-- for _, txb in pairs(idioma.Selector.ScrollingFrame:GetChildren()) do
				-- 	if txb:IsA("TextButton") then
				-- 		txb.MouseButton1Click:Connect(function()
				-- 			esperar = true
				-- 			configuracion:FireServer("Pais", txb.Name)
				-- 		end)
				-- 	end
				-- end
				-- repeat
				-- 	task.wait()
				-- until esperar == true
				moduleTween:WaitTween(
					idioma.Selector,
					{ Enum.EasingStyle.Back, Enum.EasingDirection.In, 0, { Size = UDim2.fromScale(0.552, 0) } }
				)
				idioma.Selector.Visible = false
				vettyFuncion:Entrar(false)
				vettyFuncion.crearTexto(datos[pais]["Tutorial"]["Tutorial1"])
				for _, image in pairs(plrGui.VettyScreenGui:GetChildren()) do
					if image:IsA("ImageButton") then
						image.Visible = true
					end
				end

				vettyFuncion.crearTexto(datos[pais]["Tutorial"]["Tutorial2"])
				vettyFuncion:Salir(true)
				configuracion:FireServer("PrimeraVez", true)
			end
			moduleTween:FastTween(
				cargandoGui.Fondo,
				{ Enum.EasingStyle.Circular, Enum.EasingDirection.Out, 0.5, { ImageTransparency = 1 } }
			)
			plr.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = 16
		end
	end)
end
