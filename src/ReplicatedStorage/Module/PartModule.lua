local ReplicatedStorage = game:GetService("ReplicatedStorage")
local module = {}
local moduleTween = require(script.Parent.TweenMaster)

function module.Coma(amount)
	local formatted = tostring(amount)
	if tonumber(amount) and tonumber(amount) < 0 then
		return amount
	end
	local k
	while true do
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", "%1,%2")
		if k == 0 then
			break
		end
	end
	return formatted
end

function module.automaticSize(sf: ScrollingFrame)
	local gc = #sf:GetChildren() - 1
	sf.CanvasSize = UDim2.fromScale(0, 0.25 * gc)
	sf.UIGridLayout.CellSize = UDim2.fromScale(0.9, 0.8 / gc)
end

function module.EntrarTs(objetos, bool: boolean)
	local posNormal = {}
	for i, v in objetos do
		if v:IsA("GuiBase") and not v:FindFirstChild("Bloqueo") then
			posNormal[v.Name] = v.Position
		else
			objetos[i] = nil
		end
	end

	local tweenMov = {
		[true] = { Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0.4, nil },
		[false] = { Enum.EasingStyle.Back, Enum.EasingDirection.In, 0.2, nil },
	}

	for i, v in objetos do
		task.delay(0, function()
			v.Visible = true

			if bool then
				v.Position = posNormal[v.Name] - UDim2.fromScale(0, 0.25)
				tweenMov[bool][4] = { Position = posNormal[v.Name] }
			else
				tweenMov[bool][4] = { Position = posNormal[v.Name] + UDim2.fromScale(0, 0.25) }
			end
			moduleTween:WaitTween(v, tweenMov[bool])

			if not bool then
				v.Visible = false
				v.Position = posNormal[v.Name]
			end
		end)
	end
end

function module.Error(eror, texto)
	eror.Text = texto
	eror.TextTransparency = 0
	moduleTween:FastTween(eror, { Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 5, { TextTransparency = 1 } })
end

function module.vr(v1, v2)
	local x = v2.X - v1.X
	local y = v2.Y - v1.Y
	local z = v2.Z - v1.Z
	return math.sqrt((x ^ 2) + (y ^ 2) + (z ^ 2))
end

function module.giro(v1, eje, velocidad, pos)
	local x = v1.Position.X - eje.Position.X
	local y = v1.Position.Z - eje.Position.Z
	local vr = math.sqrt((x ^ 2) + (y ^ 2))
	local rd = math.deg(math.atan2(y, x))
	local radianAngle = math.rad(rd + (pos * velocidad))

	return { math.cos(radianAngle) * vr + eje.Position.X, math.sin(radianAngle) * vr + eje.Position.Z }
end
return module
