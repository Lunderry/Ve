local module = {}
local TweenService = game:GetService("TweenService")

local tbNeutral = {
	Enum.EasingStyle.Linear,
	Enum.EasingDirection.InOut,
	1,
	{ CFrame = CFrame.new() },
	0,
	false,
	["IsA"] = {},
	["Name"] = {},
	["FindFirstChild"] = {},
	["FindFirstChildOfClass"] = {},
}

local function movModel(model)
	local cf = Instance.new("CFrameValue")

	cf.Value = model:GetPivot()
	cf.Parent = model
	local gpc = cf:GetPropertyChangedSignal("Value"):Connect(function()
		model:PivotTo(cf.Value)
	end)

	return cf, gpc
end

function module.InfoTable(tweenInfo: TweenInfo, mov)
	return {
		tweenInfo.EasingStyle.Value,
		tweenInfo.EasingDirection.Value,
		tweenInfo.Time,
		mov,
		tweenInfo.RepeatCount,
		tweenInfo.Reverses,
	}
end

function module.TweenClientGenerator(obj, specs: table)
	if obj == nil then
		return
	end

	for i, v in pairs(tbNeutral) do
		if not specs[i] then
			specs[i] = v
		end
	end

	if type(obj) == "table" then
		for i, v in pairs(obj) do
			if
				(not table.find(specs["IsA"], v.ClassName) or #specs["IsA"] == 0)
				and (not table.find(specs["Name"], v.Name) or #specs["Name"] == 0)
				and (not table.find(specs["FindFirstChild"], v:GetChildren()) or #specs["FindFirstChild"] == 0)
				and (
					not table.find(specs["FindFirstChildOfClass"], v:GetChildren().ClassName)
					or #specs["FindFirstChildOfClass"] == 0
				)
			then
				table.remove(obj, i)
			end
		end
	end
	return { obj, specs }
end

function module.TweenGenerator(obj, specs: table)
	if obj == nil then
		return
	end

	for i, v in pairs(tbNeutral) do
		if not specs[i] then
			specs[i] = v
		end
	end
	local info = TweenInfo.new(specs[3], specs[1], specs[2], specs[5], specs[6])

	local tsCreate

	if type(obj) == "table" then
		tsCreate = {}
		for _, v in pairs(obj) do
			if
				(table.find(specs["IsA"], v.ClassName) or #specs["IsA"] == 0)
				and (table.find(specs["Name"], v.Name) or #specs["Name"] == 0)
				and (table.find(specs["FindFirstChild"], v:GetChildren()) or #specs["FindFirstChild"] == 0)
				and (
					table.find(specs["FindFirstChildOfClass"], v:GetChildren().ClassName)
					or #specs["FindFirstChildOfClass"] == 0
				)
			then
				if v:IsA("Model") then
					if v:FindFirstChildOfClass("CFrameValue") then
						v:FindFirstChildOfClass("CFrameValue"):Destroy()
					end
					local cf, gpc = movModel(v)
					local cfValue
					for _, q in pairs(specs[4]) do
						cfValue = q
						table.insert(tsCreate, { TweenService:Create(cf, info, { Value = cfValue }), cf, gpc })
						if typeof(cfValue) ~= "CFrame" then
							error("It has to be CFrame")
						end
					end
				else
					table.insert(tsCreate, TweenService:Create(v, info, specs[4]))
				end
			end
		end
	elseif obj:IsA("Model") then
		local cf, gpc = movModel(obj)
		local cfValue
		for _, v in pairs(specs[4]) do
			cfValue = v
			if typeof(cfValue) ~= "CFrame" then
				error("It has to be CFrame")
			end
		end
		tsCreate = {}
		table.insert(tsCreate, { TweenService:Create(cf, info, { Value = cfValue }), cf, gpc })
	else
		tsCreate = TweenService:Create(obj, info, specs[4])
	end
	return tsCreate
end

function module:FastTween(obj, specs: table)
	self:Play(self.TweenGenerator(obj, specs))
end

function module:WaitTween(obj, specs: table)
	self:Wait(self.TweenGenerator(obj, specs))
end
function module:Pause(tween)
	if type(tween) == "table" then
		for _, v in pairs(tween) do
			task.delay(0, function()
				if type(v) == "table" then
					v[1]:Pause()
				else
					v:Pause()
				end
			end)
		end
	else
		tween:Pause()
	end
end

function module:Cancel(tween)
	if type(tween) == "table" then
		for _, v in pairs(tween) do
			task.delay(0, function()
				if type(v) == "table" then
					v[1]:Cancel()
				else
					v:Cancel()
				end
			end)
		end
	else
		tween:Pause()
	end
end

function module:Play(tween)
	if type(tween) == "table" then
		for _, v in pairs(tween) do
			task.delay(0, function()
				if type(v) == "table" then
					v[1]:Play()
					v[1].Completed:Connect(function()
						v[2]:Destroy()
						v[3]:Disconnect()
					end)
				else
					v:Play()
				end
			end)
		end
	else
		tween:Play()
	end
end

function module:Wait(tween)
	if type(tween) == "table" then
		local cont = 0
		for _, v in pairs(tween) do
			task.delay(0, function()
				if type(v) == "table" then
					v[1]:Play()
					v[1].Completed:Wait()
					cont += 1
					v[2]:Destroy()
					v[3]:Disconnect()
				else
					v:Play()
					v.Completed:Wait()
					cont += 1
				end
			end)
		end
		repeat
			task.wait()
		until cont >= #tween
	else
		tween:Play()
		tween.Completed:Wait()
	end
end

function module:WaitTable(tween)
	for _, v in pairs(tween) do
		if type(v) == "table" then
			v[1]:Play()
			v[1].Completed:Wait()
			v[2]:Destroy()
			v[3]:Disconnect()
		else
			v:Play()
			v.Completed:Wait()
		end
	end
end

return module
