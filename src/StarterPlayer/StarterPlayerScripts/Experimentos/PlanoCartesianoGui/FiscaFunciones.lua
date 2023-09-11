local module = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local plrs = game:GetService("Players")

local moduleTween = require(ReplicatedStorage.Module.TweenMaster)
local modulePart = require(ReplicatedStorage.Module.PartModule)

repeat
	task.wait()
until plrs.LocalPlayer

local cam = workspace.CurrentCamera

local plr = plrs.LocalPlayer
local plrGui = plr.PlayerGui
local datos = plrGui:WaitForChild("Experimentos").PlanoCartesianoGui

local planoCartesiano = workspace.PlanoCartesiano
local PuntoInicio = planoCartesiano.Crear
local niveles = ReplicatedStorage.Value.Fisica
local nivel2 = niveles.Nivel2

local cargarPlano = ReplicatedStorage.re["Cliente-Server"].CargarPlano

function module.CreacionPlano(pos)
	cam.CameraType = Enum.CameraType.Scriptable
	local NumeroX = pos["x"]
	local NumeroY = pos["y"]

	local mitadX = math.ceil(NumeroX / 2) - 1
	local mitadY = math.ceil(NumeroY / 2) - 1

	planoCartesiano.Base:ClearAllChildren()
	planoCartesiano.Objetos:ClearAllChildren()

	local acercarse

	if mitadX > mitadY then
		acercarse = mitadX * 1.5 + mitadY
	elseif mitadX < mitadY then
		acercarse = mitadX + mitadY * 1.5
	else
		acercarse = (mitadX + mitadY)
	end

	cargarPlano:FireServer({ NumeroX, NumeroY })
	local piezas, centro = cargarPlano.OnClientEvent:Wait()

	for _, v in pairs(planoCartesiano.Collider.Model:GetChildren()) do
		v.Transparency = 1
	end

	for i, v in pairs(piezas) do
		v.Color = Color3.fromRGB(163, 162, 165)
		v.Transparency = 0
		if i % 10 == 0 then
			RunService.Heartbeat:Wait()
		end
	end

	centro.Color = Color3.fromRGB(0, 0, 0)
	centro.Transparency = 0

	moduleTween:WaitTween(
		cam,
		{
			Enum.EasingStyle.Circular,
			Enum.EasingDirection.Out,
			0.5,
			{ CFrame = centro.CFrame - centro.CFrame.LookVector * acercarse },
		}
	)
	planoCartesiano.Cam.CFrame = centro.CFrame - centro.CFrame.LookVector * acercarse
	cam.CameraSubject = centro
	cam.CameraType = Enum.CameraType.Custom

	local sum = {
		[1] = {
			Vector3.new(NumeroX + PuntoInicio.Position.X + 0.5, centro.Position.Y, PuntoInicio.Position.Z),
			Vector3.new(1, NumeroY + 3, 1),
			"Vertice",
			Color3.fromRGB(0, 255, 0),
			Vector3.new(1, 1, 0.9),
		},
		[2] = {
			Vector3.new(PuntoInicio.Position.X - 1.5, centro.Position.Y, PuntoInicio.Position.Z),
			Vector3.new(1, NumeroY + 3, 1),
			"eje0",
			Color3.fromRGB(58, 134, 255),
			Vector3.new(0.8, 0.8, 1),
		},
		[3] = {
			Vector3.new(centro.Position.X, NumeroY + PuntoInicio.Position.Y + 0.5, PuntoInicio.Position.Z),
			Vector3.new(NumeroX + 3, 1, 1),
		},
		[4] = {
			Vector3.new(centro.Position.X, PuntoInicio.Position.Y - 1.5, PuntoInicio.Position.Z),
			Vector3.new(NumeroX + 3, 1, 1),
		},
	}
	for i = 1, 4 do
		local base = Instance.new("Part")
		base.Anchored = true
		base.Name = i
		base.Size = sum[i][2]
		base.Position = sum[i][1]
		base.Material = Enum.Material.Plastic
		base.CastShadow = false
		base.CanCollide = false
		base.CanQuery = false
		base.CanTouch = false
		base.Parent = planoCartesiano.Base

		local atthacment = Instance.new("Attachment")
		atthacment.CFrame = CFrame.new(0, 0, 0.25)
		atthacment.Parent = base
	end

	nivel2.Size.Value = Vector3.new(NumeroX / 2, NumeroY / 2, 0)
	nivel2.CentroVector.Value = centro.Position

	for i = 1, 2 do
		local vertice = Instance.new("Part")
		vertice.Position = centro.Position
		vertice.Size = sum[i][5]
		vertice.Color = sum[i][4]
		vertice.Name = sum[i][3]
		vertice.Anchored = true
		vertice.CanCollide = false
		vertice.CastShadow = false
		vertice.CanTouch = false
		vertice.Parent = planoCartesiano.Objetos
		nivel2.Objetos[sum[i][3]].Value = vertice

		local sb = Instance.new("SelectionBox")
		sb.Color3 = Color3.fromRGB(0, 0, 0)
		sb.Visible = false
		sb.Adornee = vertice
		sb.LineThickness = 0.05
		sb.Parent = vertice

		if vertice.Name == "eje0" then
			local attachment = Instance.new("Attachment")
			attachment.CFrame = CFrame.new(0, 0, 0.25)
			attachment.Parent = vertice

			for q = 1, 4 do
				local beam = Instance.new("Beam")
				beam.FaceCamera = true
				beam.Attachment0 = attachment
				beam.Attachment1 = planoCartesiano.Base:FindFirstChild(q).Attachment
				beam.Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
					ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 4)),
				})
				beam.Parent = attachment
			end
		end
	end

	task.wait(0.5)
	modulePart.EntrarTs({ datos.Controles.Frame }, true)
end

return module
