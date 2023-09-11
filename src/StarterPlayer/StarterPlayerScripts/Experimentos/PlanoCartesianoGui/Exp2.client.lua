local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local plrs = game:GetService("Players")
local uis = game:GetService("UserInputService")

repeat
	task.wait()
until plrs.LocalPlayer

local plr = plrs.LocalPlayer
local plrGui = plr.PlayerGui
local mouse = plr:GetMouse()

local pais = plr:WaitForChild("Datos").Pais

local guiPlanoCartesiano = plrGui:WaitForChild("Experimentos").PlanoCartesianoGui
-- module
local TextoData = require(ReplicatedStorage.Module.Data.TextoIdiomas)
local modulePart = require(ReplicatedStorage.Module.PartModule)
local fisicaFun = require(script.Parent.FiscaFunciones)
local sd = require(script.Parent.ModuleScript)

--variable
local cam = workspace.CurrentCamera

local folderResource = guiPlanoCartesiano.Resource
local folderValue = folderResource.Value
local folderSonido = folderResource.Sonidos

local configuracionesGui = guiPlanoCartesiano.Configuraciones

local pos = {
	["x"] = 0,
	["y"] = 0,
}

--Crear Plano cartesiano

for _, v in pairs(configuracionesGui.Selector.ScrollingFrame:GetChildren()) do
	if v:IsA("Frame") then
		local textB = v:FindFirstChildOfClass("TextBox")
		textB:GetPropertyChangedSignal("Text"):Connect(function()
			if tonumber(textB.Text) then
				pos[textB.Name] = tonumber(textB.Text)
			else
				textB.Text = "0"
			end
		end)
	end
end
----
local PlanoEspera = false

guiPlanoCartesiano.Listo.MouseButton1Click:Connect(function()
	if PlanoEspera == true then
		folderSonido.Error:Play()
		return
	end
	for i, v in pairs(pos) do
		if i == "x" or i == "y" then
			if v == 0 then
				modulePart.Error(guiPlanoCartesiano.TextError, TextoData[pais.Value]["Errores"][1])
				folderSonido.Error:Play()
				return
			end
			if v % 2 == 0 then
				modulePart.Error(guiPlanoCartesiano.TextError, TextoData[pais.Value]["Errores"][2])
				folderSonido.Error:Play()
				return
			end
		end
	end
	PlanoEspera = true
	folderValue.Entrar.Value = false

	fisicaFun.CreacionPlano(pos)

	for _, v in pairs(configuracionesGui:GetDescendants()) do
		if v:IsA("TextLabel") and v.Name ~= "TextLabel" then
			v.Text = ""
		end
	end
	PlanoEspera = false
end)

----------------
local value = ReplicatedStorage.Value

local folderNivel2 = value.Fisica.Nivel2
local vettyfolder = value.ControlesVetty

local centroVector = folderNivel2.CentroVector
local objetoMover = folderNivel2.Mover
local objetos = folderNivel2.Objetos

local listaBlanca = {
	"eje0",
	"Vertice",
	"Collider",
}

mouse.Button1Down:Connect(function()
	if
		centroVector.Value ~= Vector3.zero
		and mouse.Target ~= nil
		and mouse.Target.Name ~= nil
		and objetos:FindFirstChild(mouse.Target.Name)
	then
		objetoMover.Value = mouse.Target
		mouse.Target:FindFirstChildOfClass("SelectionBox").Visible = true
	elseif
		objetoMover.Value ~= nil
		and centroVector.Value ~= Vector3.zero
		and mouse.Target ~= nil
		and mouse.Target.Name ~= nil
		and table.find(listaBlanca, mouse.Target.Name)
		and mouse.Target.Transparency == 0
	then
		objetoMover.Value.Position = mouse.Target.CFrame.Position
		sd.sacarData()
	end
	folderValue.Click.Value = true
end)

mouse.Button1Up:Connect(function()
	folderValue.Click.Value = false
end)

objetoMover:GetPropertyChangedSignal("Value"):Connect(function()
	for _, v in pairs(objetos:GetChildren()) do
		if v ~= objetoMover.Value then
			v.Value:FindFirstChildOfClass("SelectionBox").Visible = false
		end
	end
end)

local datosScrollingFrame = guiPlanoCartesiano.Datos.Frame.ScrollingFrame

local mouseData = guiPlanoCartesiano.MouseData
local camViewport = cam.ViewportSize

vettyfolder.Tema:GetPropertyChangedSignal("Value"):Connect(function()
	if vettyfolder.Tema.Value ~= "PlanoCartesiano" or (uis.TouchEnabled and not uis.MouseEnabled) then
		return
	end

	local moveConnection

	moveConnection = mouse.Move:Connect(function()
		if value.AdentroJuego.Value == false then
			moveConnection:Disconnect()
		end

		mouse.Icon = ""
		if folderValue.Click.Value == true then
			if
				objetoMover.Value ~= nil
				and centroVector.Value ~= Vector3.zero
				and mouse.Target ~= nil
				and table.find(listaBlanca, mouse.Target.Name)
				and mouse.Target.Transparency == 0
			then
				objetoMover.Value.Position = mouse.Target.CFrame.Position
				sd.sacarData()

				if objetoMover.Value.Name == "eje0" then
					local posData = objetos.eje0.Value.Position - centroVector.Value
					datosScrollingFrame.EjePosicion.Text = posData.X .. "," .. posData.Y
				end
			end
		end
		if
			centroVector.Value == Vector3.new(0, 0, 0)
			or mouse.Target == nil
			or mouse.Target.Name == nil
			or not table.find(listaBlanca, mouse.Target.Name)
			or mouse.Target.Transparency == 1
		then
			mouseData.Visible = false
			return
		end

		mouse.Icon = "rbxassetid://11249195843"
		mouseData.Visible = true

		mouseData.Position = UDim2.fromScale(mouse.X / camViewport.X, mouse.Y / camViewport.Y)
		if folderValue.Vista.Value == "Centro" then
			mouseData.vector.Text = mouse.Target.CFrame.Position.X - centroVector.Value.X
				.. ","
				.. mouse.Target.CFrame.Position.Y - centroVector.Value.Y
		else
			mouseData.vector.Text = mouse.Target.CFrame.Position.X - objetos.eje0.Value.Position.X
				.. ","
				.. mouse.Target.CFrame.Position.Y - objetos.eje0.Value.Position.Y
		end
	end)
end)

local folderPlanoCartesiano = workspace.PlanoCartesiano

objetoMover:GetPropertyChangedSignal("Value"):Connect(function()
	if objetoMover.Value.Name ~= "eje0" then
		return
	end
	local ObjetoMoverGPCSConnection = objetoMover.Value:GetPropertyChangedSignal("Position"):Connect(function()
		for i = 1, 4 do
			local worldCF = folderPlanoCartesiano.Base:FindFirstChild(i).Attachment.WorldCFrame
			if i > 2 then
				folderPlanoCartesiano.Base:FindFirstChild(i).Attachment.WorldCFrame =
					CFrame.new(objetoMover.Value.Position.X, worldCF.Position.Y, worldCF.Position.Z)
			else
				folderPlanoCartesiano.Base:FindFirstChild(i).Attachment.WorldCFrame =
					CFrame.new(worldCF.Position.X, objetoMover.Value.Position.Y, worldCF.Position.Z)
			end
		end
	end)
	objetoMover:GetPropertyChangedSignal("Value"):Wait()
	ObjetoMoverGPCSConnection:Disconnect()
end)

local anclarButton = datosScrollingFrame.Anclar.Button

local anclarTurno = false

anclarButton.MouseButton1Click:Connect(function()
	if centroVector.Value == nil then
		return
	end
	if anclarTurno == false then
		cam.CameraType = Enum.CameraType.Scriptable
		anclarButton.BackgroundColor3 = Color3.fromRGB(255, 113, 30)
		anclarButton.ImageColor3 = Color3.fromRGB(255, 0, 0)
		cam.CFrame = folderPlanoCartesiano.Cam.CFrame
	else
		cam.CameraType = Enum.CameraType.Custom
		anclarButton.BackgroundColor3 = Color3.fromRGB(4, 170, 43)
		anclarButton.ImageColor3 = Color3.fromRGB(39, 255, 28)
	end
	anclarTurno = not anclarTurno
end)

datosScrollingFrame.VistaDatos.TextButton.MouseButton1Click:Connect(function()
	if folderValue.Vista.Value == "Centro" then
		folderValue.Vista.Value = "Eje0"
	else
		folderValue.Vista.Value = "Centro"
	end
	datosScrollingFrame.VistaDatos.TextButton.Text = folderValue.Vista.Value
end)

local girandoEspera = false

datosScrollingFrame.Giro:FindFirstChildOfClass("ImageButton").MouseButton1Click:Connect(function()
	if girandoEspera == true then
		return
	end
	girandoEspera = true

	local g = tonumber(datosScrollingFrame.Giro.TextBox.Text)
	local str = "+"

	if g < 0 then
		str = "-"
		g = -g
	end
	local x = objetos.Vertice.Value.Position.X - objetos.eje0.Value.Position.X
	local y = objetos.Vertice.Value.Position.Y - objetos.eje0.Value.Position.Y
	local rd = math.deg(math.atan2(y, x))
	local vr = modulePart.vr(objetos.eje0.Value.Position, objetos.Vertice.Value.Position)

	local model = Instance.new("Model")
	model.Parent = workspace

	for i = 1, g do
		local radianAngle
		if str == "-" then
			radianAngle = math.rad(rd - i)
		else
			radianAngle = math.rad(rd + i)
		end

		local c = math.cos(radianAngle) * vr + objetos.eje0.Value.Position.X
		local s = math.sin(radianAngle) * vr + objetos.eje0.Value.Position.Y

		local part = Instance.new("Part")
		part.Shape = "Ball"
		part.Position = Vector3.new(c, s, objetos.Vertice.Value.Position.Z)
		part.Color = Color3.fromRGB(38, 255, 0)
		part.Anchored = true
		part.CanTouch = false
		part.CanCollide = false
		part.CanQuery = false
		part.CastShadow = false
		part.Size = Vector3.new(1, 1, 0.2)
		part.Parent = model
		RunService.Heartbeat:Wait()
	end
	task.wait(5)
	model:Destroy()
	girandoEspera = false
end)
