local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectionService = game:GetService("CollectionService")

local moduleTween = require(ReplicatedStorage.Module.TweenMaster)
local modulePart = require(ReplicatedStorage.Module.PartModule)

repeat
	task.wait(0.1)
until Players.LocalPlayer

local plr: Player = Players.LocalPlayer
local plrGui: PlayerGui = plr:WaitForChild("PlayerGui")

local seleccionScreenGui: ScreenGui = plrGui:WaitForChild("SeleccionExperimentos")
local experimentoGui: ScreenGui = plrGui:WaitForChild("Experimentos")

local temaValue: StringValue = ReplicatedStorage.Value.ControlesVetty.Tema

local cam: Camera = workspace.CurrentCamera
cam.CameraType = Enum.CameraType.Scriptable
cam.CFrame = workspace.Part.CFrame

local tweenMov = { Enum.EasingStyle.Circular, Enum.EasingDirection.InOut, 0.5, nil, 0, false }
for _, v in seleccionScreenGui.Frame.Frame.Selector:GetChildren() do
	if v:IsA("TextButton") then
		v.MouseButton1Click:Connect(function()
			--entrar
			modulePart.EntrarTs({ seleccionScreenGui.Frame, seleccionScreenGui.TextLabel }, false)
			--poner camara de movimiento o no
			if workspace:FindFirstChild(v.Name) then
				local folder = workspace[v.Name]
				if folder:FindFirstChild("Cam") then
					tweenMov[4] = { CFrame = folder.Cam.CFrame }
					moduleTween:WaitTween(cam, tweenMov)
				else
					tweenMov[4] = { CFrame = folder.Folder.Mov.CFrame + folder.Folder.Mov.CFrame.RightVector * 5 }
					moduleTween:WaitTween(cam, tweenMov)
					cam.CameraType = Enum.CameraType.Custom
					cam.CameraSubject = folder.Folder.Mov
				end
			end
			modulePart.EntrarTs(experimentoGui[v.Name .. "Gui"]:GetChildren(), true)
		end)
	end
end

for _, v: TextButton in pairs(CollectionService:GetTagged("BotonSalir")) do
	v.MouseButton1Click:Connect(function()
		--salir
		cam.CameraType = Enum.CameraType.Scriptable
		modulePart.EntrarTs(v.Parent.Parent:GetChildren(), false)

		tweenMov[4] = { CFrame = workspace.Part.CFrame }
		moduleTween:WaitTween(cam, tweenMov)

		modulePart.EntrarTs({ seleccionScreenGui.Frame, seleccionScreenGui.TextLabel }, true)
	end)
end
