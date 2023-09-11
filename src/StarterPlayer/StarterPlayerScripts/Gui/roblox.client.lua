local StarterGui = game:GetService("StarterGui")
local ContextActionService = game:GetService("ContextActionService")

StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)

ContextActionService:UnbindAction("BaseCameraKeyboardZoom")

for _ = 1, 2 do
	while true do
		local info = ContextActionService:GetBoundActionInfo("RbxCameraKeypress")
		if info and info.inputTypes then
			ContextActionService:UnbindAction("RbxCameraKeypress")
			break
		else
			task.wait()
		end
	end
end
