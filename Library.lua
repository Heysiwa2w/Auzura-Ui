local function geniter(f, s, c)
	if type(f) ~= "function" then
		local mt = getmetatable(f)

		if type(mt) == "table" and mt.__iter then
			f, s, c = mt.__iter(f)
		elseif type(f) == "table" then
			f, s, c = next, f, nil
		end
	end

	return function()
		local r = table.pack(f(s, c))

		if r[1] == nil then
			return false
		end

		c = r[1]

		return true, table.unpack(r, 1, r.n)
	end
end

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")

if CoreGui:FindFirstChild("AuzuRax") then
	CoreGui:FindFirstChild("AuzuRax"):Destroy()
end

GetIcon = function(arg)
	if type(arg) == "string" then
		if not arg:find("rbxassetid://") then
			return "rbxassetid://" .. arg
		end
	end

	if type(arg) == "number" then
		return "rbxassetid://" .. arg
	end

	return arg
end
tw = function(options)
	return TweenService:Create(options.v, TweenInfo.new(options.t, Enum.EasingStyle[options.s], Enum.EasingDirection[options.d]), options.g)
end
ResizeFrame = function(parent)
	local flag = false
	local Size
	local number = 0
	local connection
	local flagB = false
	local items = {}
	local value
	local MouseEnabled = UserInputService.MouseEnabled
	local Position
	local flagC = false
	local Frame = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local UIStroke = Instance.new("UIStroke")
	local ImageLabel = Instance.new("ImageLabel")
	local ProgressRingFrame = Instance.new("Frame")
	local ProgressInnerFrame = Instance.new("Frame")
	local ProgressRingFrameCorner = Instance.new("UICorner")
	local ProgressInnerFrameCorner = Instance.new("UICorner")
	local UIGradient = Instance.new("UIGradient")

	Frame.Name = "ResizeHandle"
	Frame.Parent = parent
	Frame.AnchorPoint = Vector2.new(1, 1)
	Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
	Frame.BackgroundTransparency = 0.3
	Frame.Position = UDim2.new(1, -5, 1, -5)
	Frame.Size = UDim2.new(0, 25, 0, 25)
	Frame.ZIndex = 1000
	UICorner.CornerRadius = UDim.new(1, 0)
	UICorner.Parent = Frame
	UIStroke.Parent = Frame
	UIStroke.Color = Color3.fromRGB(100, 100, 130)
	UIStroke.Thickness = 2
	UIStroke.Transparency = 0.7
	ImageLabel.Parent = Frame
	ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
	ImageLabel.BackgroundTransparency = 1
	ImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
	ImageLabel.Size = UDim2.new(0, 14, 0, 14)
	ImageLabel.Image = "rbxassetid://7734053495"
	ImageLabel.ImageColor3 = Color3.fromRGB(150, 150, 180)
	ProgressRingFrame.Name = "ProgressRing"
	ProgressRingFrame.Parent = Frame
	ProgressRingFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	ProgressRingFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ProgressRingFrame.BackgroundTransparency = 1
	ProgressRingFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
	ProgressRingFrame.Size = UDim2.new(0, 25, 0, 25)
	ProgressRingFrame.ZIndex = 9
	ProgressRingFrameCorner.CornerRadius = UDim.new(1, 0)
	ProgressRingFrameCorner.Parent = ProgressRingFrame
	UIGradient.Parent = ProgressRingFrame
	UIGradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
		ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 170, 255)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)),
	})
	ProgressInnerFrame.Name = "ProgressInner"
	ProgressInnerFrame.Parent = ProgressRingFrame
	ProgressInnerFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	ProgressInnerFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
	ProgressInnerFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
	ProgressInnerFrame.Size = UDim2.new(0, 19, 0, 19)
	ProgressInnerFrame.ZIndex = 10
	ProgressInnerFrameCorner.CornerRadius = UDim.new(1, 0)
	ProgressInnerFrameCorner.Parent = ProgressInnerFrame

	local function helper()
		local number = 0

		for _ in pairs(items) do
			number += 1
		end

		return number
	end
	local function helperB(self, arg)
		return (self - arg).Magnitude
	end
	local function helperC()
		flag = false
		flagB = false
		number = 0
		items = {}
		value = nil
		Position = nil
		flagC = false

		if connection then
			connection:Disconnect()
			connection = nil
		end

		tw({
			v = UIStroke,
			t = 0.3,
			s = "Back",
			d = "Out",
			g = {
				Transparency = 0.7,
				Color = Color3.fromRGB(100, 100, 130),
			},
		}):Play()
		tw({
			v = Frame,
			t = 0.3,
			s = "Back",
			d = "Out",
			g = {
				Size = UDim2.new(0, 25, 0, 25),
				BackgroundTransparency = 0.3,
			},
		}):Play()
		tw({
			v = ImageLabel,
			t = 0.3,
			s = "Back",
			d = "Out",
			g = {
				Size = UDim2.new(0, 14, 0, 14),
				ImageColor3 = Color3.fromRGB(150, 150, 180),
			},
		}):Play()
		tw({
			v = ProgressRingFrame,
			t = 0.3,
			s = "Back",
			d = "Out",
			g = {
				BackgroundTransparency = 1,
				Size = UDim2.new(0, 25, 0, 25),
			},
		}):Play()
		tw({
			v = ProgressInnerFrame,
			t = 0.3,
			s = "Back",
			d = "Out",
			g = {
				Size = UDim2.new(0, 19, 0, 19),
			},
		}):Play()
	end

	if MouseEnabled then
		Frame.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				flag = true
				flagB = true
				Size = parent.Size
				Position = input.Position
				flagC = true
				tw({
					v = UIStroke,
					t = 0.3,
					s = "Back",
					d = "Out",
					g = {
						Transparency = 0.2,
						Color = Color3.fromRGB(0, 255, 127),
					},
				}):Play()
				tw({
					v = Frame,
					t = 0.3,
					s = "Back",
					d = "Out",
					g = {
						Size = UDim2.new(0, 35, 0, 35),
						BackgroundTransparency = 0.1,
					},
				}):Play()
				tw({
					v = ImageLabel,
					t = 0.3,
					s = "Back",
					d = "Out",
					g = {
						Size = UDim2.new(0, 20, 0, 20),
						ImageColor3 = Color3.fromRGB(0, 255, 127),
					},
				}):Play()
			end
		end)
		UserInputService.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 and flag then
				helperC()
			end
		end)
		UserInputService.InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement and flag and flagB and Position then
				local amount = input.Position - Position
				local clamped = math.clamp(Size.X.Offset + amount.X, 400, 800)
				local clampedB = math.clamp(Size.Y.Offset + amount.Y, 280, 600)

				parent.Size = UDim2.new(0, clamped, 0, clampedB)
			end
		end)
	else
		UserInputService.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.Touch then
				items[input] = input.Position

				if helper() == 2 and not (flagB or connection) then
					number = 0

					local itemsB = {}

					for k in pairs(items) do
						table.insert(itemsB, k.Position)
					end

					if #itemsB == 2 then
						value = helperB(itemsB[1], itemsB[2])
					end

					connection = RunService.Heartbeat:Connect(function(dt)
						if helper() ~= 2 then
							helperC()

							return
						end

						number += dt

						local clamped = math.clamp(number / 2, 0, 1)
						local amount = 25 + clamped * 15
						local amountB = 19 + clamped * 9

						ProgressRingFrame.Size = UDim2.new(0, amount, 0, amount)
						ProgressInnerFrame.Size = UDim2.new(0, amountB, 0, amountB)
						ProgressRingFrame.BackgroundTransparency = 1 - clamped

						if clamped < 1 then
							UIGradient.Rotation = clamped * 360
						end

						if number >= 2 and not flagB then
							flagB = true
							flag = true
							Size = parent.Size
							flagC = true
							tw({
								v = UIStroke,
								t = 0.3,
								s = "Back",
								d = "Out",
								g = {
									Transparency = 0.2,
									Color = Color3.fromRGB(0, 255, 127),
								},
							}):Play()
							tw({
								v = Frame,
								t = 0.3,
								s = "Back",
								d = "Out",
								g = {
									Size = UDim2.new(0, 35, 0, 35),
									BackgroundTransparency = 0.1,
								},
							}):Play()
							tw({
								v = ImageLabel,
								t = 0.3,
								s = "Back",
								d = "Out",
								g = {
									Size = UDim2.new(0, 20, 0, 20),
									ImageColor3 = Color3.fromRGB(0, 255, 127),
								},
							}):Play()
							task.wait(0.5)
							tw({
								v = Frame,
								t = 0.4,
								s = "Back",
								d = "Out",
								g = {
									Size = UDim2.new(0, 28, 0, 28),
								},
							}):Play()
							tw({
								v = ImageLabel,
								t = 0.4,
								s = "Back",
								d = "Out",
								g = {
									Size = UDim2.new(0, 16, 0, 16),
								},
							}):Play()
						end
					end)
				end
			end
		end)
		UserInputService.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.Touch then
				items[input] = nil

				if helper() < 2 then
					if flagB then
						flag = false
						flagC = false
					else
						helperC()
					end
				end
			end
		end)
		UserInputService.InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.Touch and flag and flagB then
				local itemsB = {}

				for k in pairs(items) do
					table.insert(itemsB, k.Position)
				end

				if #itemsB == 2 and value then
					local amount = helperB(itemsB[1], itemsB[2]) / value
					local clamped = math.clamp(Size.X.Offset * amount, 400, 800)
					local clampedB = math.clamp(Size.Y.Offset * amount, 280, 600)

					parent.Size = UDim2.new(0, clamped, 0, clampedB)
				end
			end
		end)
	end

	return {
		IsDraggingDisabled = function()
			return flagC
		end,
	}
end
lak = function(options)
	local flag
	local value
	local Position
	local position
	local valueB

	local function helper(self)
		if valueB then
			if valueB.IsDraggingDisabled() then
				return
			end
		end

		local amount = self.Position - Position
		local udim =
			UDim2.new(position.X.Scale, position.X.Offset + amount.X, position.Y.Scale, position.Y.Offset + amount.Y)

		TweenService:Create(options, TweenInfo.new(0.3), {
			Position = udim,
		}):Play()
	end

	options.InputBegan:Connect(function(input)
		if valueB then
			if valueB.IsDraggingDisabled() then
				return
			end
		end

		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			flag = true
			Position = input.Position
			position = options.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					flag = false
				end
			end)

			return
		elseif input.UserInputType == Enum.UserInputType.Touch then
			flag = true
			Position = input.Position
			position = options.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					flag = false
				end
			end)
		end
	end)
	options.InputChanged:Connect(function(input)
		if
			input.UserInputType == Enum.UserInputType.MouseMovement
			or input.UserInputType == Enum.UserInputType.Touch
		then
			value = input
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if input == value then
			if flag then
				helper(input)
			end
		end
	end)

	return {
		SetResizeController = function(self)
			valueB = self
		end,
	}
end
click = function(parent)
	local TextButton = Instance.new("TextButton")

	TextButton.Name = "Click"
	TextButton.Parent = parent
	TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextButton.BackgroundTransparency = 1
	TextButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextButton.BorderSizePixel = 0
	TextButton.Size = UDim2.new(1, 0, 1, 0)
	TextButton.Font = Enum.Font.SourceSans
	TextButton.Text = ""
	TextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
	TextButton.TextSize = 14
	TextButton.ZIndex = 5

	return TextButton
end
EffectClick = function(options, parent)
	local mouse = Players.LocalPlayer:GetMouse()
	local x = mouse.X - options.AbsolutePosition.X
	local y = mouse.Y - options.AbsolutePosition.Y

	if x < 0 or y < 0 or options.AbsoluteSize.X < x or options.AbsoluteSize.Y < y then
		return
	end

	local Frame = Instance.new("Frame")

	Frame.Parent = parent
	Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Frame.BackgroundTransparency = 0.5
	Frame.BorderSizePixel = 0
	Frame.AnchorPoint = Vector2.new(0.5, 0.5)
	Frame.Position = UDim2.new(0, x, 0, y)
	Frame.Size = UDim2.new(0, 0, 0, 0)
	Frame.ZIndex = 10

	local UICorner = Instance.new("UICorner")

	UICorner.CornerRadius = UDim.new(1, 0)
	UICorner.Parent = Frame

	local tween = TweenService:Create(Frame, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		Size = UDim2.new(0, options.AbsoluteSize.X * 1.5, 0, options.AbsoluteSize.X * 1.5),
		BackgroundTransparency = 1,
	})

	tween.Completed:Connect(function()
		Frame:Destroy()
	end)
	tween:Play()
end
EffectClick2 = function(options, parent)
	local mouse = Players.LocalPlayer:GetMouse()
	local x = mouse.X - options.AbsolutePosition.X
	local y = mouse.Y - options.AbsolutePosition.Y

	if x < 0 or y < 0 or options.AbsoluteSize.X < x or options.AbsoluteSize.Y < y then
		return
	end

	local Frame = Instance.new("Frame")

	Frame.Parent = parent
	Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Frame.BackgroundTransparency = 0.5
	Frame.BorderSizePixel = 0
	Frame.AnchorPoint = Vector2.new(0.5, 0.5)
	Frame.Position = UDim2.new(0, x, 0, y)
	Frame.Size = UDim2.new(0, 0, 0, 0)
	Frame.ZIndex = 10

	local UIGradient = Instance.new("UIGradient")

	UIGradient.Parent = Frame
	UIGradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
		ColorSequenceKeypoint.new(0.482699, Color3.fromRGB(0, 170, 255)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)),
	})
	UIGradient.Rotation = 48

	local UICorner = Instance.new("UICorner")

	UICorner.CornerRadius = UDim.new(1, 0)
	UICorner.Parent = Frame

	local tween = TweenService:Create(Frame, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		Size = UDim2.new(0, options.AbsoluteSize.X * 1.5, 0, options.AbsoluteSize.X * 1.5),
		BackgroundTransparency = 1,
	})

	tween.Completed:Connect(function()
		Frame:Destroy()
	end)
	tween:Play()
end

local function ScaleElements(window, columns, cols, items)
	local X = window.AbsoluteSize.X
	if columns == 1 then
		local c = cols[1]
		if c then c.Size = UDim2.new(0, math.min(X * 0.95, 600), 1, 0) end
	else
		local l, r = cols[1], cols[2]
		if l and r then
			if X < 450 then
				l.Size = UDim2.new(0, X * 0.9, 0.48, 0)
				r.Size = UDim2.new(0, X * 0.9, 0.48, 0)
				r.Position = UDim2.new(0, 0, 0.52, 0)
			else
				local w = X * 0.9 / 2 - 5
				l.Size = UDim2.new(0, w, 1, 0)
				r.Size = UDim2.new(0, w, 1, 0)
				r.Position = UDim2.new(0, 0, 0, 0)
			end
		end
	end
	local scale = math.clamp(X / 520, 0.7, 1.3)
	for _, item in pairs(items or {}) do
		local frame = item and item.Frame
		if frame then
			for _, d in ipairs(frame:GetDescendants()) do
				if d:IsA("ImageLabel") and d.Name ~= "Banner" and d.Size.X.Scale == 0 and d.Size.Y.Scale == 0 and d.Size.X.Offset <= 80 then
					local base = d:GetAttribute("BaseSize")
					if not base then base = d.Size.X.Offset; d:SetAttribute("BaseSize", base) end
					d.Size = UDim2.new(0, math.floor(base * scale), 0, math.floor(base * scale))
				elseif d:IsA("UITextSizeConstraint") then
					local mx = d:GetAttribute("BaseMaxSize")
					if not mx then mx = d.MaxTextSize; d:SetAttribute("BaseMaxSize", mx) end
					local mn = d:GetAttribute("BaseMinSize")
					if not mn then mn = d.MinTextSize; d:SetAttribute("BaseMinSize", mn) end
					d.MaxTextSize = math.max(1, math.floor(mx * scale))
					d.MinTextSize = math.max(1, math.floor(mn * scale))
				end
			end
		end
	end
end

local ScreenGui = Instance.new("ScreenGui")

ScreenGui.Name = "AuzuRax"
ScreenGui.Parent = not RunService:IsStudio() and CoreGui or Players.LocalPlayer.PlayerGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global

local Library = {
	Notification = {},
}
local Frame = Instance.new("Frame")

Frame.Name = "NotificationContainer"
Frame.Parent = ScreenGui
Frame.AnchorPoint = Vector2.new(1, 1)
Frame.BackgroundTransparency = 1
Frame.Position = UDim2.new(1, -20, 1, -20)
Frame.Size = UDim2.new(0, 280, 0, 600)
Frame.ZIndex = 1000

local UIListLayout = Instance.new("UIListLayout")

UIListLayout.Parent = Frame
UIListLayout.Padding = UDim.new(0, 8)
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
Library.Notification = function(self, options)
	local Title = options.Title or "Notification"
	local TitleB = options.Title1 or ""
	local Desc = options.Desc or "Description"
	local SubContent = options.SubContent or nil
	local Time = options.Time or 5
	local Button = options.Button or {}
	local Icon = options.Icon or nil
	local count = #Button > 0
	local flag = SubContent ~= nil and SubContent ~= ""
	local value = 55

	if flag then
		value += 14
	end

	if count then
		value += 38
	end

	local valueB = value
	local NotificationFrame = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local UIStroke = Instance.new("UIStroke")
	local ImageLabel = Instance.new("ImageLabel")
	local BackgroundFrame = Instance.new("Frame")
	local BackgroundFrameCorner = Instance.new("UICorner")
	local UIGradient = Instance.new("UIGradient")
	local ProgressBarFrame = Instance.new("Frame")
	local ProgressFillFrame = Instance.new("Frame")
	local ProgressFillFrameCorner = Instance.new("UICorner")
	local ProgressFillFrameGradient = Instance.new("UIGradient")
	local ContentFrame = Instance.new("Frame")
	local TextContainerFrame = Instance.new("Frame")
	local TextLabel = Instance.new("TextLabel")
	local DescLabelTextLabel = Instance.new("TextLabel")

	NotificationFrame.Name = "Notification"
	NotificationFrame.Parent = Frame
	NotificationFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
	NotificationFrame.BackgroundTransparency = 0.1
	NotificationFrame.BorderSizePixel = 0
	NotificationFrame.Size = UDim2.new(0, 0, 0, valueB)
	NotificationFrame.ClipsDescendants = true
	NotificationFrame.ZIndex = 1001
	UICorner.Parent = NotificationFrame
	UICorner.CornerRadius = UDim.new(0, 12)
	UIStroke.Parent = NotificationFrame
	UIStroke.Color = Color3.fromRGB(100, 100, 130)
	UIStroke.Thickness = 2
	UIStroke.Transparency = 0.6
	ImageLabel.Name = "DropShadow"
	ImageLabel.Parent = NotificationFrame
	ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
	ImageLabel.BackgroundTransparency = 1
	ImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
	ImageLabel.Size = UDim2.new(1, 40, 1, 40)
	ImageLabel.ZIndex = 1000
	ImageLabel.Image = "rbxassetid://8992230677"
	ImageLabel.ImageColor3 = Color3.fromRGB(0, 0, 0)
	ImageLabel.ImageTransparency = 0.3
	ImageLabel.ScaleType = Enum.ScaleType.Slice
	ImageLabel.SliceCenter = Rect.new(99, 99, 99, 99)
	BackgroundFrame.Name = "Background"
	BackgroundFrame.Parent = NotificationFrame
	BackgroundFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	BackgroundFrame.BackgroundTransparency = 0.95
	BackgroundFrame.BorderSizePixel = 0
	BackgroundFrame.Size = UDim2.new(1, 0, 1, 0)
	BackgroundFrame.ZIndex = 1001
	BackgroundFrameCorner.Parent = BackgroundFrame
	BackgroundFrameCorner.CornerRadius = UDim.new(0, 12)
	UIGradient.Parent = BackgroundFrame
	UIGradient.Rotation = 45
	UIGradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
		ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 170, 255)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)),
	})
	ProgressBarFrame.Name = "ProgressBar"
	ProgressBarFrame.Parent = NotificationFrame
	ProgressBarFrame.AnchorPoint = Vector2.new(0.5, 1)
	ProgressBarFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
	ProgressBarFrame.BackgroundTransparency = 0.5
	ProgressBarFrame.Position = UDim2.new(0.5, 0, 1, -3)
	ProgressBarFrame.Size = UDim2.new(0.94, 0, 0, 2.5)
	ProgressBarFrame.ZIndex = 1003

	local ProgressBarFrameCorner = Instance.new("UICorner")

	ProgressBarFrameCorner.Parent = ProgressBarFrame
	ProgressBarFrameCorner.CornerRadius = UDim.new(1, 0)
	ProgressFillFrame.Name = "ProgressFill"
	ProgressFillFrame.Parent = ProgressBarFrame
	ProgressFillFrame.AnchorPoint = Vector2.new(0, 0.5)
	ProgressFillFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ProgressFillFrame.Position = UDim2.new(0, 0, 0.5, 0)
	ProgressFillFrame.Size = UDim2.new(1, 0, 1, 0)
	ProgressFillFrame.ZIndex = 1004
	ProgressFillFrameCorner.Parent = ProgressFillFrame
	ProgressFillFrameCorner.CornerRadius = UDim.new(1, 0)
	ProgressFillFrameGradient.Parent = ProgressFillFrame
	ProgressFillFrameGradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
		ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 170, 255)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)),
	})
	ContentFrame.Name = "ContentFrame"
	ContentFrame.Parent = NotificationFrame
	ContentFrame.BackgroundTransparency = 1
	ContentFrame.Position = UDim2.new(0, 10, 0, 8)
	ContentFrame.Size = UDim2.new(1, -20, 1, count and -46 or -14)
	ContentFrame.ZIndex = 1002

	local flagB, handler, delay_, value

	if Icon then
		local IconFrame = Instance.new("Frame")
		local IconFrameCorner = Instance.new("UICorner")
		local IconFrameImage = Instance.new("ImageLabel")
		local IconFrameGradient = Instance.new("UIGradient")

		IconFrame.Name = "IconFrame"
		IconFrame.Parent = ContentFrame
		IconFrame.AnchorPoint = Vector2.new(0, 0)
		IconFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		IconFrame.BackgroundTransparency = 0.9
		IconFrame.Position = UDim2.new(0, 0, 0, 0)
		IconFrame.Size = UDim2.new(0, 36, 0, 36)
		IconFrame.ZIndex = 1003
		IconFrameCorner.Parent = IconFrame
		IconFrameCorner.CornerRadius = UDim.new(0, 8)
		IconFrameGradient.Parent = IconFrame
		IconFrameGradient.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 170, 255)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)),
		})
		IconFrameImage.Parent = IconFrame
		IconFrameImage.AnchorPoint = Vector2.new(0.5, 0.5)
		IconFrameImage.BackgroundTransparency = 1
		IconFrameImage.Position = UDim2.new(0.5, 0, 0.5, 0)
		IconFrameImage.Size = UDim2.new(0, 20, 0, 20)
		IconFrameImage.Image = GetIcon(Icon)
		IconFrameImage.ScaleType = Enum.ScaleType.Fit
		IconFrameImage.ZIndex = 1004
		TextContainerFrame.Position = UDim2.new(0, 42, 0, 0)
		TextContainerFrame.Size = UDim2.new(1, -42, 1, 0)
		TextContainerFrame.Name = "TextContainer"
		TextContainerFrame.Parent = ContentFrame
		TextContainerFrame.BackgroundTransparency = 1
		TextContainerFrame.ZIndex = 1003

		local TextContainerFrameListLayout = Instance.new("UIListLayout")

		TextContainerFrameListLayout.Parent = TextContainerFrame
		TextContainerFrameListLayout.Padding = UDim.new(0, 2)
		TextContainerFrameListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		TextContainerFrameListLayout.VerticalAlignment = Enum.VerticalAlignment.Top

		local text = Title

		if TitleB ~= "" then
			text = Title .. '<font size="10">' .. TitleB .. "</font>"
		end

		TextLabel.Name = "TitleLabel"
		TextLabel.Parent = TextContainerFrame
		TextLabel.BackgroundTransparency = 1
		TextLabel.Size = UDim2.new(1, 0, 0, 16)
		TextLabel.Font = Enum.Font.GothamBold
		TextLabel.RichText = true
		TextLabel.Text = text
		TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		TextLabel.TextSize = 13
		TextLabel.TextXAlignment = Enum.TextXAlignment.Left
		TextLabel.TextYAlignment = Enum.TextYAlignment.Top
		TextLabel.TextScaled = false
		TextLabel.TextWrapped = true
		TextLabel.ZIndex = 1004
		TextLabel.LayoutOrder = 1
		DescLabelTextLabel.Name = "DescLabel"
		DescLabelTextLabel.Parent = TextContainerFrame
		DescLabelTextLabel.BackgroundTransparency = 1
		DescLabelTextLabel.Size = UDim2.new(1, 0, 0, 14)
		DescLabelTextLabel.Font = Enum.Font.Gotham
		DescLabelTextLabel.Text = Desc
		DescLabelTextLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
		DescLabelTextLabel.TextSize = 11
		DescLabelTextLabel.TextTransparency = 0.3
		DescLabelTextLabel.TextXAlignment = Enum.TextXAlignment.Left
		DescLabelTextLabel.TextYAlignment = Enum.TextYAlignment.Top
		DescLabelTextLabel.TextWrapped = true
		DescLabelTextLabel.ZIndex = 1004
		DescLabelTextLabel.LayoutOrder = 2

		local UITextSizeConstraint = Instance.new("UITextSizeConstraint")

		UITextSizeConstraint.Parent = DescLabelTextLabel
		UITextSizeConstraint.MaxTextSize = 11
		UITextSizeConstraint.MinTextSize = 8

		if flag then
			local SubContentLabelTextLabel = Instance.new("TextLabel")

			SubContentLabelTextLabel.Name = "SubContentLabel"
			SubContentLabelTextLabel.Parent = TextContainerFrame
			SubContentLabelTextLabel.BackgroundTransparency = 1
			SubContentLabelTextLabel.Size = UDim2.new(1, 0, 0, 13)
			SubContentLabelTextLabel.Font = Enum.Font.GothamBold
			SubContentLabelTextLabel.Text = SubContent
			SubContentLabelTextLabel.TextColor3 = Color3.fromRGB(150, 200, 255)
			SubContentLabelTextLabel.TextSize = 10
			SubContentLabelTextLabel.TextTransparency = 0.2
			SubContentLabelTextLabel.TextXAlignment = Enum.TextXAlignment.Left
			SubContentLabelTextLabel.TextYAlignment = Enum.TextYAlignment.Top
			SubContentLabelTextLabel.TextWrapped = true
			SubContentLabelTextLabel.ZIndex = 1004
			SubContentLabelTextLabel.LayoutOrder = 3

			local SubContentLabelTextLabelTextConstraint = Instance.new("UITextSizeConstraint")

			SubContentLabelTextLabelTextConstraint.Parent = SubContentLabelTextLabel
			SubContentLabelTextLabelTextConstraint.MaxTextSize = 10
			SubContentLabelTextLabelTextConstraint.MinTextSize = 7
		end

		flagB = false
		handler = function()
			if flagB then
				return
			end

			flagB = true
			tw({
				v = NotificationFrame,
				t = 0.3,
				s = "Back",
				d = "In",
				g = {
					Size = UDim2.new(0, 0, 0, valueB),
				},
			}):Play()
			tw({
				v = UIStroke,
				t = 0.2,
				s = "Quad",
				d = "Out",
				g = {
					Transparency = 1,
				},
			}):Play()
			task.wait(0.3)
			NotificationFrame:Destroy()
		end

		if count then
			local ButtonContainerFrame = Instance.new("Frame")
			local ButtonContainerFrameListLayout = Instance.new("UIListLayout")

			ButtonContainerFrame.Name = "ButtonContainer"
			ButtonContainerFrame.Parent = NotificationFrame
			ButtonContainerFrame.BackgroundTransparency = 1
			ButtonContainerFrame.AnchorPoint = Vector2.new(0.5, 1)
			ButtonContainerFrame.Position = UDim2.new(0.5, 0, 1, -8)
			ButtonContainerFrame.Size = UDim2.new(0.92, 0, 0, 32)
			ButtonContainerFrame.ZIndex = 1003
			ButtonContainerFrameListLayout.Parent = ButtonContainerFrame
			ButtonContainerFrameListLayout.FillDirection = Enum.FillDirection.Horizontal
			ButtonContainerFrameListLayout.Padding = UDim.new(0, 6)
			ButtonContainerFrameListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			ButtonContainerFrameListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
			ButtonContainerFrameListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

			local amount = 1 / #Button - 6 * (#Button - 1) / #Button / 280

			for i, v in ipairs(Button) do
				local TextButton = Instance.new("TextButton")
				local TextButtonCorner = Instance.new("UICorner")
				local TextButtonGradient = Instance.new("UIGradient")

				TextButton.Name = "Button" .. i
				TextButton.Parent = ButtonContainerFrame
				TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TextButton.BackgroundTransparency = 0.9
				TextButton.BorderSizePixel = 0
				TextButton.Size = UDim2.new(amount, 0, 1, 0)
				TextButton.Font = Enum.Font.GothamBold
				TextButton.Text = v.Text or "Button"
				TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
				TextButton.TextSize = 12
				TextButton.TextScaled = true
				TextButton.TextWrapped = true
				TextButton.AutoButtonColor = false
				TextButton.ZIndex = 1005

				local TextButtonTextConstraint = Instance.new("UITextSizeConstraint")

				TextButtonTextConstraint.Parent = TextButton
				TextButtonTextConstraint.MaxTextSize = 12
				TextButtonTextConstraint.MinTextSize = 8
				TextButtonCorner.Parent = TextButton
				TextButtonCorner.CornerRadius = UDim.new(0, 7)
				TextButtonGradient.Parent = TextButton
				TextButtonGradient.Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
					ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 170, 255)),
					ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)),
				})
				TextButton.MouseEnter:Connect(function()
					tw({
						v = TextButton,
						t = 0.2,
						s = "Quad",
						d = "Out",
						g = {
							BackgroundTransparency = 0.85,
						},
					}):Play()
				end)
				TextButton.MouseLeave:Connect(function()
					tw({
						v = TextButton,
						t = 0.2,
						s = "Quad",
						d = "Out",
						g = {
							BackgroundTransparency = 0.9,
						},
					}):Play()
				end)
				TextButton.MouseButton1Click:Connect(function()
					EffectClick2(TextButton, TextButton)

					if v.Callback then
						pcall(v.Callback)
					end

					task.wait(0.15)
					handler()
				end)
			end
		end

		tw({
			v = NotificationFrame,
			t = 0.4,
			s = "Back",
			d = "Out",
			g = {
				Size = UDim2.new(0, 280, 0, valueB),
			},
		}):Play()
		tw({
			v = UIStroke,
			t = 0.3,
			s = "Quad",
			d = "Out",
			g = {
				Transparency = 0.4,
			},
		}):Play()
		tw({
			v = ProgressFillFrame,
			t = Time,
			s = "Linear",
			d = "Out",
			g = {
				Size = UDim2.new(0, 0, 1, 0),
			},
		}):Play()
		delay_ = task.delay
		value = Time
	else
		TextContainerFrame.Position = UDim2.new(0, 0, 0, 0)
		TextContainerFrame.Size = UDim2.new(1, 0, 1, 0)
		TextContainerFrame.Name = "TextContainer"
		TextContainerFrame.Parent = ContentFrame
		TextContainerFrame.BackgroundTransparency = 1
		TextContainerFrame.ZIndex = 1003

		local TextContainerFrameListLayout = Instance.new("UIListLayout")

		TextContainerFrameListLayout.Parent = TextContainerFrame
		TextContainerFrameListLayout.Padding = UDim.new(0, 2)
		TextContainerFrameListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		TextContainerFrameListLayout.VerticalAlignment = Enum.VerticalAlignment.Top

		local text = Title

		if TitleB ~= "" then
			text = Title .. '<font size="10">' .. TitleB .. "</font>"
		end

		TextLabel.Name = "TitleLabel"
		TextLabel.Parent = TextContainerFrame
		TextLabel.BackgroundTransparency = 1
		TextLabel.Size = UDim2.new(1, 0, 0, 16)
		TextLabel.Font = Enum.Font.GothamBold
		TextLabel.RichText = true
		TextLabel.Text = text
		TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		TextLabel.TextSize = 13
		TextLabel.TextXAlignment = Enum.TextXAlignment.Left
		TextLabel.TextYAlignment = Enum.TextYAlignment.Top
		TextLabel.TextScaled = false
		TextLabel.TextWrapped = true
		TextLabel.ZIndex = 1004
		TextLabel.LayoutOrder = 1
		DescLabelTextLabel.Name = "DescLabel"
		DescLabelTextLabel.Parent = TextContainerFrame
		DescLabelTextLabel.BackgroundTransparency = 1
		DescLabelTextLabel.Size = UDim2.new(1, 0, 0, 14)
		DescLabelTextLabel.Font = Enum.Font.Gotham
		DescLabelTextLabel.Text = Desc
		DescLabelTextLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
		DescLabelTextLabel.TextSize = 11
		DescLabelTextLabel.TextTransparency = 0.3
		DescLabelTextLabel.TextXAlignment = Enum.TextXAlignment.Left
		DescLabelTextLabel.TextYAlignment = Enum.TextYAlignment.Top
		DescLabelTextLabel.TextWrapped = true
		DescLabelTextLabel.ZIndex = 1004
		DescLabelTextLabel.LayoutOrder = 2

		local UITextSizeConstraint = Instance.new("UITextSizeConstraint")

		UITextSizeConstraint.Parent = DescLabelTextLabel
		UITextSizeConstraint.MaxTextSize = 11
		UITextSizeConstraint.MinTextSize = 8

		if flag then
			local SubContentLabelTextLabel = Instance.new("TextLabel")

			SubContentLabelTextLabel.Name = "SubContentLabel"
			SubContentLabelTextLabel.Parent = TextContainerFrame
			SubContentLabelTextLabel.BackgroundTransparency = 1
			SubContentLabelTextLabel.Size = UDim2.new(1, 0, 0, 13)
			SubContentLabelTextLabel.Font = Enum.Font.GothamBold
			SubContentLabelTextLabel.Text = SubContent
			SubContentLabelTextLabel.TextColor3 = Color3.fromRGB(150, 200, 255)
			SubContentLabelTextLabel.TextSize = 10
			SubContentLabelTextLabel.TextTransparency = 0.2
			SubContentLabelTextLabel.TextXAlignment = Enum.TextXAlignment.Left
			SubContentLabelTextLabel.TextYAlignment = Enum.TextYAlignment.Top
			SubContentLabelTextLabel.TextWrapped = true
			SubContentLabelTextLabel.ZIndex = 1004
			SubContentLabelTextLabel.LayoutOrder = 3

			local SubContentLabelTextLabelTextConstraint = Instance.new("UITextSizeConstraint")

			SubContentLabelTextLabelTextConstraint.Parent = SubContentLabelTextLabel
			SubContentLabelTextLabelTextConstraint.MaxTextSize = 10
			SubContentLabelTextLabelTextConstraint.MinTextSize = 7
		end

		flagB = false
		handler = function()
			if flagB then
				return
			end

			flagB = true
			tw({
				v = NotificationFrame,
				t = 0.3,
				s = "Back",
				d = "In",
				g = {
					Size = UDim2.new(0, 0, 0, valueB),
				},
			}):Play()
			tw({
				v = UIStroke,
				t = 0.2,
				s = "Quad",
				d = "Out",
				g = {
					Transparency = 1,
				},
			}):Play()
			task.wait(0.3)
			NotificationFrame:Destroy()
		end

		if count then
			local ButtonContainerFrame = Instance.new("Frame")
			local ButtonContainerFrameListLayout = Instance.new("UIListLayout")

			ButtonContainerFrame.Name = "ButtonContainer"
			ButtonContainerFrame.Parent = NotificationFrame
			ButtonContainerFrame.BackgroundTransparency = 1
			ButtonContainerFrame.AnchorPoint = Vector2.new(0.5, 1)
			ButtonContainerFrame.Position = UDim2.new(0.5, 0, 1, -8)
			ButtonContainerFrame.Size = UDim2.new(0.92, 0, 0, 32)
			ButtonContainerFrame.ZIndex = 1003
			ButtonContainerFrameListLayout.Parent = ButtonContainerFrame
			ButtonContainerFrameListLayout.FillDirection = Enum.FillDirection.Horizontal
			ButtonContainerFrameListLayout.Padding = UDim.new(0, 6)
			ButtonContainerFrameListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			ButtonContainerFrameListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
			ButtonContainerFrameListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

			local amount = 1 / #Button - 6 * (#Button - 1) / #Button / 280

			for i, v in ipairs(Button) do
				local TextButton = Instance.new("TextButton")
				local TextButtonCorner = Instance.new("UICorner")
				local TextButtonGradient = Instance.new("UIGradient")

				TextButton.Name = "Button" .. i
				TextButton.Parent = ButtonContainerFrame
				TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TextButton.BackgroundTransparency = 0.9
				TextButton.BorderSizePixel = 0
				TextButton.Size = UDim2.new(amount, 0, 1, 0)
				TextButton.Font = Enum.Font.GothamBold
				TextButton.Text = v.Text or "Button"
				TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
				TextButton.TextSize = 12
				TextButton.TextScaled = true
				TextButton.TextWrapped = true
				TextButton.AutoButtonColor = false
				TextButton.ZIndex = 1005

				local TextButtonTextConstraint = Instance.new("UITextSizeConstraint")

				TextButtonTextConstraint.Parent = TextButton
				TextButtonTextConstraint.MaxTextSize = 12
				TextButtonTextConstraint.MinTextSize = 8
				TextButtonCorner.Parent = TextButton
				TextButtonCorner.CornerRadius = UDim.new(0, 7)
				TextButtonGradient.Parent = TextButton
				TextButtonGradient.Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
					ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 170, 255)),
					ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)),
				})
				TextButton.MouseEnter:Connect(function()
					tw({
						v = TextButton,
						t = 0.2,
						s = "Quad",
						d = "Out",
						g = {
							BackgroundTransparency = 0.85,
						},
					}):Play()
				end)
				TextButton.MouseLeave:Connect(function()
					tw({
						v = TextButton,
						t = 0.2,
						s = "Quad",
						d = "Out",
						g = {
							BackgroundTransparency = 0.9,
						},
					}):Play()
				end)
				TextButton.MouseButton1Click:Connect(function()
					EffectClick2(TextButton, TextButton)

					if v.Callback then
						pcall(v.Callback)
					end

					task.wait(0.15)
					handler()
				end)
			end
		end

		tw({
			v = NotificationFrame,
			t = 0.4,
			s = "Back",
			d = "Out",
			g = {
				Size = UDim2.new(0, 280, 0, valueB),
			},
		}):Play()
		tw({
			v = UIStroke,
			t = 0.3,
			s = "Quad",
			d = "Out",
			g = {
				Transparency = 0.4,
			},
		}):Play()
		tw({
			v = ProgressFillFrame,
			t = Time,
			s = "Linear",
			d = "Out",
			g = {
				Size = UDim2.new(0, 0, 1, 0),
			},
		}):Play()
		delay_ = task.delay
		value = Time
	end

	delay_(value, function()
		if not flagB then
			handler()
		end
	end)

	return {
		Close = handler,
	}
end
Library.Window = function(self, options)
	local Title = options.Title or "Title"
	local Desc = options.Desc or "Desc"
	local IconTile = options.IconTile or nil
	local SizeUi = options.SizeUi or "520,340"
	local loadCustomTheme = _G.loadCustomTheme ~= "" and _G.loadCustomTheme or nil
	local items = {}

	for match in string.gmatch(SizeUi, "[^,]+") do
		table.insert(items, tonumber(match))
	end

	local value = items[1] or 520
	local valueB = items[2] or 340
	local BackgroundFrame = Instance.new("Frame")
	local ImageLabel = Instance.new("ImageLabel")
	local UICorner = Instance.new("UICorner")
	local UIStroke = Instance.new("UIStroke")
	local HeaderFrameB = Instance.new("Frame")
	local TextLabel = Instance.new("TextLabel")
	local HeaderFrameBListLayout = Instance.new("UIListLayout")
	local UIPadding = Instance.new("UIPadding")
	local LineFrameB = Instance.new("Frame")
	local UIGradient = Instance.new("UIGradient")
	local DescTextLabel = Instance.new("TextLabel")
	local EffectImageLabel = Instance.new("ImageLabel")

	BackgroundFrame.Name = "Background"
	BackgroundFrame.Parent = ScreenGui
	BackgroundFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	BackgroundFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
	BackgroundFrame.BackgroundTransparency = 0.1
	BackgroundFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	BackgroundFrame.BorderSizePixel = 0
	BackgroundFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
	BackgroundFrame.Size = UDim2.new(0, 0, 0, 0)

	local valueC = lak(BackgroundFrame)
	local valueD = ResizeFrame(BackgroundFrame)

	valueC.SetResizeController(valueD)
	tw({
		v = BackgroundFrame,
		t = 1,
		s = "Bounce",
		d = "Out",
		g = {
			Size = UDim2.new(0, value, 0, valueB),
		},
	}):Play()
	UIStroke.Parent = BackgroundFrame
	UIStroke.Color = Color3.fromRGB(80, 80, 100)
	UIStroke.Thickness = 2.5
	UIStroke.Transparency = 0.6
	ImageLabel.Name = "DropShadow"
	ImageLabel.Parent = BackgroundFrame
	ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
	ImageLabel.BackgroundColor3 = Color3.fromRGB(28, 28, 30)
	ImageLabel.BackgroundTransparency = 1
	ImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ImageLabel.BorderSizePixel = 0
	ImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
	ImageLabel.Size = UDim2.new(1, 160, 1, 160)
	ImageLabel.ZIndex = 0
	ImageLabel.Image = "rbxassetid://8992230677"
	ImageLabel.ImageColor3 = Color3.fromRGB(0, 0, 0)
	ImageLabel.ImageTransparency = 0.15
	ImageLabel.ScaleType = Enum.ScaleType.Slice
	ImageLabel.SliceCenter = Rect.new(99, 99, 99, 99)
	EffectImageLabel.Name = "Effect"
	EffectImageLabel.Parent = BackgroundFrame
	EffectImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
	EffectImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	EffectImageLabel.BackgroundTransparency = 1
	EffectImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	EffectImageLabel.BorderSizePixel = 0
	EffectImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
	EffectImageLabel.Size = UDim2.new(1, 0, 1, 0)
	EffectImageLabel.Image = "rbxassetid://132687652275989"
	EffectImageLabel.ImageColor3 = Color3.fromRGB(0, 255, 127)
	EffectImageLabel.ImageTransparency = 0.05
	EffectImageLabel.ScaleType = Enum.ScaleType.Crop
	EffectImageLabel.ZIndex = 1

	if loadCustomTheme then
		local value = request({
			Url = loadCustomTheme,
			Method = "GET",
		})

		if value.StatusCode == 200 then
			local match = loadCustomTheme:match("%.([^%.%?&#/]+)") or loadCustomTheme:match("%.([^%.]+)$")

			if
				not match
				or not ({
					png = true,
					jpg = true,
					jpeg = true,
					gif = true,
					bmp = true,
					webp = true,
					svg = true,
					tiff = true,
					ico = true,
					tga = true,
					dds = true,
					hdr = true,
				})[match:lower()]
			then
				local contentType = value.Headers
					and (value.Headers["content-type"] or value.Headers["Content-Type"] or "")
				local items = {
					["image/png"] = "png",
					["image/jpeg"] = "jpg",
					["image/jpg"] = "jpg",
					["image/gif"] = "gif",
					["image/webp"] = "webp",
					["image/bmp"] = "bmp",
					["image/x-icon"] = "ico",
					["image/svg+xml"] = "svg",
					["image/tiff"] = "tiff",
				}

				match = items[contentType] or items[contentType:match("^([^;]+)")] or "png"
			end

			local text = "Theme." .. match:lower()

			writefile(text, value.Body)

			local getcustomasset_ = getcustomasset
				or getsynasset
				or function(arg)
					return "rbxasset://" .. arg
				end
			local ThemeImageImageLabel = Instance.new("ImageLabel")

			ThemeImageImageLabel.Name = "ThemeImage"
			ThemeImageImageLabel.Size = UDim2.new(1, 0, 1, 0)
			ThemeImageImageLabel.Position = UDim2.new(0, 0, 0, 0)
			ThemeImageImageLabel.BackgroundTransparency = 1
			ThemeImageImageLabel.ScaleType = Enum.ScaleType.Stretch
			ThemeImageImageLabel.Image = getcustomasset_(text)
			ThemeImageImageLabel.ImageTransparency = 0.3
			ThemeImageImageLabel.ZIndex = 1
			ThemeImageImageLabel.Parent = BackgroundFrame

			local ThemeImageImageLabelCorner = Instance.new("UICorner")

			ThemeImageImageLabelCorner.CornerRadius = UDim.new(0, 12)
			ThemeImageImageLabelCorner.Parent = ThemeImageImageLabel
			BackgroundFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
				ThemeImageImageLabel.Size = UDim2.new(1, 0, 1, 0)
			end)
		else
			warn("StatusCode " .. tostring(value.StatusCode))
		end
	end

	UICorner.Parent = BackgroundFrame
	UICorner.CornerRadius = UDim.new(0, 20)
	HeaderFrameB.Name = "Header"
	HeaderFrameB.Parent = BackgroundFrame
	HeaderFrameB.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	HeaderFrameB.BackgroundTransparency = 1
	HeaderFrameB.BorderColor3 = Color3.fromRGB(0, 0, 0)
	HeaderFrameB.BorderSizePixel = 0
	HeaderFrameB.Size = UDim2.new(1, 0, 0, 65)

	if IconTile then
		local IconTileFrame = Instance.new("Frame")
		local IconTileImageImageLabel = Instance.new("ImageLabel")
		local TitleWithIconTextLabel = Instance.new("TextLabel")

		IconTileFrame.Name = "IconTileFrame"
		IconTileFrame.Parent = HeaderFrameB
		IconTileFrame.BackgroundTransparency = 1
		IconTileFrame.Size = UDim2.new(0, 450, 0, 22)
		IconTileImageImageLabel.Name = "IconTileImage"
		IconTileImageImageLabel.Parent = IconTileFrame
		IconTileImageImageLabel.AnchorPoint = Vector2.new(0, 0.5)
		IconTileImageImageLabel.BackgroundTransparency = 1
		IconTileImageImageLabel.Position = UDim2.new(0, 0, 0.5, 0)
		IconTileImageImageLabel.Size = UDim2.new(0, 30, 900, 5)
		IconTileImageImageLabel.ScaleType = Enum.ScaleType.Fit
		IconTileImageImageLabel.ImageTransparency = 1

		if type(IconTile) ~= "string" then
			IconTileImageImageLabel.Image = GetIcon(IconTile)
			task.spawn(function()
				task.wait(0.1)
				tw({
					v = IconTileImageImageLabel,
					t = 0.5,
					s = "Quad",
					d = "Out",
					g = {
						ImageTransparency = 0,
					},
				}):Play()
			end)
		elseif IconTile:find("http") then
			task.spawn(function()
				local ok, result = pcall(function()
					return request({
						Url = IconTile,
						Method = "GET",
					})
				end)

				if ok and result and result.StatusCode == 200 then
					local match = IconTile:match("%.([^%.%?&#/]+)") or "png"
					local text = "IconTile_" .. tick() .. "." .. match

					writefile(text, result.Body)
					IconTileImageImageLabel.Image = (getcustomasset or getsynasset or function(arg)
						return "rbxasset://" .. arg
					end)(text)
				else
					IconTileImageImageLabel.Image = GetIcon(IconTile)
				end

				task.wait(0.1)
				tw({
					v = IconTileImageImageLabel,
					t = 0.5,
					s = "Quad",
					d = "Out",
					g = {
						ImageTransparency = 0,
					},
				}):Play()
			end)
		elseif IconTile:find("https") then
			task.spawn(function()
				local ok, result = pcall(function()
					return request({
						Url = IconTile,
						Method = "GET",
					})
				end)

				if ok and result and result.StatusCode == 200 then
					local match = IconTile:match("%.([^%.%?&#/]+)") or "png"
					local text = "IconTile_" .. tick() .. "." .. match

					writefile(text, result.Body)
					IconTileImageImageLabel.Image = (getcustomasset or getsynasset or function(arg)
						return "rbxasset://" .. arg
					end)(text)
				else
					IconTileImageImageLabel.Image = GetIcon(IconTile)
				end

				task.wait(0.1)
				tw({
					v = IconTileImageImageLabel,
					t = 0.5,
					s = "Quad",
					d = "Out",
					g = {
						ImageTransparency = 0,
					},
				}):Play()
			end)
		else
			IconTileImageImageLabel.Image = GetIcon(IconTile)
			task.spawn(function()
				task.wait(0.1)
				tw({
					v = IconTileImageImageLabel,
					t = 0.5,
					s = "Quad",
					d = "Out",
					g = {
						ImageTransparency = 0,
					},
				}):Play()
			end)
		end

		TitleWithIconTextLabel.Name = "TitleWithIcon"
		TitleWithIconTextLabel.Parent = IconTileFrame
		TitleWithIconTextLabel.BackgroundTransparency = 1
		TitleWithIconTextLabel.Position = UDim2.new(0, 28, 0, 0)
		TitleWithIconTextLabel.Size = UDim2.new(1, -28, 1, 0)
		TitleWithIconTextLabel.Font = Enum.Font.GothamBold
		TitleWithIconTextLabel.Text = Title
		TitleWithIconTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		TitleWithIconTextLabel.TextSize = 26
		TitleWithIconTextLabel.TextWrapped = true
		TitleWithIconTextLabel.TextXAlignment = Enum.TextXAlignment.Left
		TextLabel = TitleWithIconTextLabel
	else
		TextLabel.Name = "Title"
		TextLabel.Parent = HeaderFrameB
		TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TextLabel.BackgroundTransparency = 1
		TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TextLabel.BorderSizePixel = 0
		TextLabel.Position = UDim2.new(0, 0, 0.116666667, 0)
		TextLabel.Size = UDim2.new(0, 450, 0, 22)
		TextLabel.Font = Enum.Font.GothamBold
		TextLabel.Text = Title
		TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		TextLabel.TextSize = 26
		TextLabel.TextWrapped = true
		TextLabel.TextXAlignment = Enum.TextXAlignment.Left
	end

	HeaderFrameBListLayout.Parent = HeaderFrameB
	HeaderFrameBListLayout.Padding = UDim.new(0, 7)
	HeaderFrameBListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	HeaderFrameBListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	UIPadding.Parent = HeaderFrameB
	UIPadding.PaddingLeft = UDim.new(0, 20)
	UIPadding.PaddingTop = UDim.new(0, 5)
	LineFrameB.Name = "Line"
	LineFrameB.Parent = HeaderFrameB
	LineFrameB.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	LineFrameB.BorderColor3 = Color3.fromRGB(0, 0, 0)
	LineFrameB.BorderSizePixel = 0
	LineFrameB.Size = UDim2.new(0, 80, 0, 3.5)
	UIGradient.Parent = LineFrameB
	UIGradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
		ColorSequenceKeypoint.new(0.482699, Color3.fromRGB(0, 170, 255)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)),
	})
	DescTextLabel.Name = "Desc"
	DescTextLabel.Parent = HeaderFrameB
	DescTextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	DescTextLabel.BackgroundTransparency = 1
	DescTextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	DescTextLabel.BorderSizePixel = 0
	DescTextLabel.Position = UDim2.new(0.0179999992, 0, 0, 0)
	DescTextLabel.Size = UDim2.new(0, 220, 0, 6)
	DescTextLabel.Font = Enum.Font.GothamBold
	DescTextLabel.Text = Desc
	DescTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	DescTextLabel.TextSize = 15
	DescTextLabel.TextTransparency = 0.35
	DescTextLabel.TextXAlignment = Enum.TextXAlignment.Left

	local TextButton = Instance.new("TextButton")
	local TextButtonCorner = Instance.new("UICorner")
	local TextButtonStroke = Instance.new("UIStroke")
	local CloseTextTextLabel = Instance.new("TextLabel")

	TextButton.Name = "CloseUI"
	TextButton.Parent = ScreenGui
	TextButton.AnchorPoint = Vector2.new(0, 1)
	TextButton.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
	TextButton.BorderSizePixel = 0
	TextButton.Position = UDim2.new(0.06, 0, 0.21, 0)
	TextButton.Size = UDim2.new(0, 55, 0, 55)
	TextButton.BackgroundTransparency = 0.15
	TextButton.Text = ""
	TextButton.AutoButtonColor = false
	lak(TextButton)
	TextButtonCorner.Parent = TextButton
	TextButtonCorner.CornerRadius = UDim.new(0, 14)
	TextButtonStroke.Parent = TextButton
	TextButtonStroke.Color = Color3.fromRGB(100, 100, 130)
	TextButtonStroke.Thickness = 2.5
	TextButtonStroke.Transparency = 0.6
	CloseTextTextLabel.Name = "CloseText"
	CloseTextTextLabel.Parent = TextButton
	CloseTextTextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
	CloseTextTextLabel.BackgroundTransparency = 1
	CloseTextTextLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
	CloseTextTextLabel.Size = UDim2.new(1, 0, 1, 0)
	CloseTextTextLabel.Font = Enum.Font.GothamBlack
	CloseTextTextLabel.Text = "Close"
	CloseTextTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	CloseTextTextLabel.TextSize = 16
	CloseTextTextLabel.TextTransparency = 0
	CloseTextTextLabel.ZIndex = 3

	local function helper(self)
		pcall(function()
			tw({
				v = CloseTextTextLabel,
				t = 0.15,
				s = "Quad",
				d = "Out",
				g = {
					TextTransparency = 1,
				},
			}):Play()
		end)
		task.wait(0.15)
		CloseTextTextLabel.Text = self
		pcall(function()
			tw({
				v = CloseTextTextLabel,
				t = 0.15,
				s = "Quad",
				d = "Out",
				g = {
					TextTransparency = 0,
				},
			}):Play()
		end)
	end
	local function helperB()
		local Visible = BackgroundFrame.Visible

		helper(Visible and "Open" or "Close")
		BackgroundFrame.Visible = not Visible
	end

	TextButton.MouseButton1Click:Connect(function()
		helperB()
	end)
	UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if not gameProcessed then
			if input.KeyCode == Enum.KeyCode.F2 then
				helperB()
			end
		end
	end)

	local ScrollingFrame = Instance.new("ScrollingFrame")
	local UIGridLayout = Instance.new("UIGridLayout")

	ScrollingFrame.Name = "Tab"
	ScrollingFrame.Parent = BackgroundFrame
	ScrollingFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	ScrollingFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ScrollingFrame.BackgroundTransparency = 1
	ScrollingFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ScrollingFrame.BorderSizePixel = 0
	ScrollingFrame.Position = UDim2.new(0.5, 0, 0.58, 0)
	ScrollingFrame.Size = UDim2.new(0.96, 0, 0.73, 0)
	ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 130)
	ScrollingFrame.ScrollBarThickness = 4
	ScrollingFrame.ScrollBarImageTransparency = 0.5
	UIGridLayout.Parent = ScrollingFrame
	UIGridLayout.CellPadding = UDim2.new(0, 12, 0, 12)
	UIGridLayout.CellSize = UDim2.new(0.23, 0, 0, 110)
	UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
	BackgroundFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
		if BackgroundFrame.AbsoluteSize.X <= 450 then
			UIGridLayout.CellSize = UDim2.new(0.31, 0, 0, 110)
		else
			UIGridLayout.CellSize = UDim2.new(0.23, 0, 0, 110)
		end
	end)
	UIGridLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, UIGridLayout.AbsoluteContentSize.Y + 15)
	end)

	local ReturnFrame = Instance.new("Frame")
	local ReturnFrameCorner = Instance.new("UICorner")
	local ReturnFrameGradient = Instance.new("UIGradient")
	local ReturnFrameStroke = Instance.new("UIStroke")
	local ReturnFrameImage = Instance.new("ImageLabel")
	local ReturnFrameLabel = Instance.new("TextLabel")

	ReturnFrame.Name = "Return"
	ReturnFrame.Parent = BackgroundFrame
	ReturnFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ReturnFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ReturnFrame.BorderSizePixel = 0
	ReturnFrame.Position = UDim2.new(0.77, 0, 0.055, 0)
	ReturnFrame.Size = UDim2.new(0, 100, 0, 30)
	ReturnFrame.ClipsDescendants = true
	ReturnFrame.Visible = false
	ReturnFrameCorner.Parent = ReturnFrame
	ReturnFrameCorner.CornerRadius = UDim.new(0, 10)
	ReturnFrameGradient.Parent = ReturnFrame
	ReturnFrameGradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 89, 89)),
		ColorSequenceKeypoint.new(0.482699, Color3.fromRGB(255, 0, 0)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 0, 0)),
	})
	ReturnFrameStroke.Parent = ReturnFrame
	ReturnFrameStroke.Color = Color3.fromRGB(255, 85, 127)
	ReturnFrameStroke.Thickness = 2.5
	ReturnFrameImage.Parent = ReturnFrame
	ReturnFrameImage.AnchorPoint = Vector2.new(0.5, 0.5)
	ReturnFrameImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ReturnFrameImage.BackgroundTransparency = 1
	ReturnFrameImage.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ReturnFrameImage.BorderSizePixel = 0
	ReturnFrameImage.Position = UDim2.new(0.5, 0, 0.5, 0)
	ReturnFrameImage.Size = UDim2.new(1, 50, 1, 0)
	ReturnFrameImage.Image = "rbxassetid://87782680483863"
	ReturnFrameImage.ImageTransparency = 0.75
	ReturnFrameImage.ScaleType = Enum.ScaleType.Crop
	ReturnFrameLabel.Parent = ReturnFrame
	ReturnFrameLabel.AnchorPoint = Vector2.new(0.5, 0.5)
	ReturnFrameLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ReturnFrameLabel.BackgroundTransparency = 1
	ReturnFrameLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ReturnFrameLabel.BorderSizePixel = 0
	ReturnFrameLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
	ReturnFrameLabel.Size = UDim2.new(1, 0, 1, 0)
	ReturnFrameLabel.Font = Enum.Font.GothamBold
	ReturnFrameLabel.Text = "Back"
	ReturnFrameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	ReturnFrameLabel.TextSize = 14
	click(ReturnFrame).MouseButton1Click:Connect(function()
		HeaderFrameB.Position = UDim2.new(0, -38, 0, 0)
		tw({
			v = HeaderFrameB,
			t = 0.35,
			s = "Back",
			d = "Out",
			g = {
				Position = UDim2.new(0, 0, 0, 0),
			},
		}):Play()
		tw({
			v = TextLabel,
			t = 0.5,
			s = "Back",
			d = "Out",
			g = {
				TextTransparency = 1,
			},
		}):Play()
		tw({
			v = DescTextLabel,
			t = 0.5,
			s = "Back",
			d = "Out",
			g = {
				TextTransparency = 1,
			},
		}):Play()
		tw({
			v = LineFrameB,
			t = 0.5,
			s = "Back",
			d = "Out",
			g = {
				BackgroundTransparency = 1,
			},
		}):Play()
		DescTextLabel.Text = Desc
		TextLabel.Text = Title
		delay(0.22, function()
			tw({
				v = TextLabel,
				t = 0.5,
				s = "Back",
				d = "Out",
				g = {
					TextTransparency = 0,
				},
			}):Play()
			tw({
				v = DescTextLabel,
				t = 0.5,
				s = "Back",
				d = "Out",
				g = {
					TextTransparency = 0.35,
				},
			}):Play()
			tw({
				v = LineFrameB,
				t = 0.5,
				s = "Back",
				d = "Out",
				g = {
					BackgroundTransparency = 0,
				},
			}):Play()
		end)

		for _, child in pairs(BackgroundFrame:GetChildren()) do
			if child.Name == "Pages" then
				child.Visible = false
			end
		end

		ScrollingFrame.Visible = true
		tw({
			v = ScrollingFrame,
			t = 0.35,
			s = "Back",
			d = "Out",
			g = {
				Size = UDim2.new(0.96, 0, 0.73, 0),
			},
		}):Play()
		tw({
			v = ReturnFrame,
			t = 0.35,
			s = "Back",
			d = "Out",
			g = {
				Position = UDim2.new(0.95, 0, 0.055, 0),
			},
		}):Play()
		tw({
			v = ReturnFrame,
			t = 0.35,
			s = "Back",
			d = "Out",
			g = {
				BackgroundTransparency = 1,
			},
		}):Play()
		ReturnFrameStroke.Enabled = false
		tw({
			v = ReturnFrameImage,
			t = 0.35,
			s = "Back",
			d = "Out",
			g = {
				ImageTransparency = 1,
			},
		}):Play()
		tw({
			v = ReturnFrameLabel,
			t = 0.35,
			s = "Back",
			d = "Out",
			g = {
				TextTransparency = 1,
			},
		}):Play()
		task.wait(0.12)
		ReturnFrame.Visible = false
	end)
	Library.Tabs = {}
	Library.Tabs.Add = function(self, options)
		local title = options.Title
		local DescB = options.Desc or nil
		local Banner = options.Banner
		local Icon = options.Icon or nil
		local Columns = options.Columns or 1
		local TabCardFrame = Instance.new("Frame")
		local TabCardFrameCorner = Instance.new("UICorner")
		local TabCardFrameStroke = Instance.new("UIStroke")
		local BannerImageLabel = Instance.new("ImageLabel")
		local BannerImageLabelCorner = Instance.new("UICorner")
		local OverlayFrameB = Instance.new("Frame")
		local OverlayFrameBCorner = Instance.new("UICorner")
		local OverlayFrameBGradient = Instance.new("UIGradient")
		local TitleTextLabelB = Instance.new("TextLabel")
		local IconImageLabelB = Instance.new("ImageLabel")
		local HubNameTextLabel = Instance.new("TextLabel")
		local BadgeFrame = Instance.new("Frame")
		local BadgeFrameCorner = Instance.new("UICorner")
		local BadgeLabelTextLabel = Instance.new("TextLabel")
		local BadgeFrameGradient = Instance.new("UIGradient")
		local tabCardFrameClick = click(TabCardFrame)
		local number = 0

		TabCardFrame.Name = "TabCard"
		TabCardFrame.Parent = ScrollingFrame
		TabCardFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
		TabCardFrame.BackgroundTransparency = 0.2
		TabCardFrame.BorderSizePixel = 0
		TabCardFrame.ClipsDescendants = true
		TabCardFrameCorner.Parent = TabCardFrame
		TabCardFrameCorner.CornerRadius = UDim.new(0, 16)
		TabCardFrameStroke.Parent = TabCardFrame
		TabCardFrameStroke.Color = Color3.fromRGB(120, 120, 150)
		TabCardFrameStroke.Thickness = 2
		TabCardFrameStroke.Transparency = 0.75
		BannerImageLabel.Name = "Banner"
		BannerImageLabel.Parent = TabCardFrame
		BannerImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
		BannerImageLabel.BackgroundTransparency = 1
		BannerImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
		BannerImageLabel.Size = UDim2.new(1, 0, 1, 0)
		BannerImageLabel.ScaleType = Enum.ScaleType.Crop
		BannerImageLabel.ZIndex = 2
		BannerImageLabel.ImageTransparency = 1

		if Banner then
			if type(Banner) == "string" and (Banner:find("http") or Banner:find("https")) then
				task.spawn(function()
					local ok, result = pcall(function()
						return request({
							Url = Banner,
							Method = "GET",
						})
					end)

					if ok and result and result.StatusCode == 200 then
						local match = Banner:match("%.([^%.%?&#/]+)") or "png"
						local text = "TabBanner_" .. tick() .. "." .. match

						writefile(text, result.Body)
						BannerImageLabel.Image = (getcustomasset or getsynasset or function(arg)
							return "rbxasset://" .. arg
						end)(text)
					else
						BannerImageLabel.Image = GetIcon(Banner)
					end

					task.wait(0.1)
					tw({
						v = BannerImageLabel,
						t = 0.6,
						s = "Quad",
						d = "Out",
						g = {
							ImageTransparency = 0,
						},
					}):Play()
				end)
			else
				BannerImageLabel.Image = GetIcon(Banner)
				task.spawn(function()
					task.wait(0.1)
					tw({
						v = BannerImageLabel,
						t = 0.6,
						s = "Quad",
						d = "Out",
						g = {
							ImageTransparency = 0,
						},
					}):Play()
				end)
			end
		end

		BannerImageLabelCorner.Parent = BannerImageLabel
		BannerImageLabelCorner.CornerRadius = UDim.new(0, 16)
		OverlayFrameB.Name = "Overlay"
		OverlayFrameB.Parent = TabCardFrame
		OverlayFrameB.AnchorPoint = Vector2.new(0.5, 0.5)
		OverlayFrameB.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		OverlayFrameB.BackgroundTransparency = 0.2
		OverlayFrameB.Position = UDim2.new(0.5, 0, 0.5, 0)
		OverlayFrameB.Size = UDim2.new(1, 0, 1, 0)
		OverlayFrameB.ZIndex = 3
		OverlayFrameBCorner.Parent = OverlayFrameB
		OverlayFrameBCorner.CornerRadius = UDim.new(0, 16)
		OverlayFrameBGradient.Parent = OverlayFrameB
		OverlayFrameBGradient.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 170, 255)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)),
		})
		OverlayFrameBGradient.Rotation = 50
		OverlayFrameBGradient.Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 0.7),
			NumberSequenceKeypoint.new(1, 0.9),
		})
		BadgeFrame.Name = "BadgeFrame"
		BadgeFrame.Parent = TabCardFrame
		BadgeFrame.AnchorPoint = Vector2.new(1, 0)
		BadgeFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		BadgeFrame.Position = UDim2.new(1, -8, 0, 8)
		BadgeFrame.Size = UDim2.new(0, 32, 0, 18)
		BadgeFrame.ZIndex = 6
		BadgeFrameCorner.CornerRadius = UDim.new(1, 0)
		BadgeFrameCorner.Parent = BadgeFrame
		BadgeFrameGradient.Parent = BadgeFrame
		BadgeFrameGradient.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 200, 255)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 100, 255)),
		})
		BadgeFrameGradient.Rotation = 45
		BadgeLabelTextLabel.Name = "BadgeLabel"
		BadgeLabelTextLabel.Parent = BadgeFrame
		BadgeLabelTextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
		BadgeLabelTextLabel.BackgroundTransparency = 1
		BadgeLabelTextLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
		BadgeLabelTextLabel.Size = UDim2.new(1, -4, 1, -4)
		BadgeLabelTextLabel.Font = Enum.Font.GothamBold
		BadgeLabelTextLabel.Text = "0"
		BadgeLabelTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		BadgeLabelTextLabel.TextSize = 12
		BadgeLabelTextLabel.TextStrokeTransparency = 0.5
		BadgeLabelTextLabel.ZIndex = 7

		local Left

		if Icon and Icon ~= "" then
			IconImageLabelB.Name = "Icon"
			IconImageLabelB.Parent = TabCardFrame
			IconImageLabelB.AnchorPoint = Vector2.new(0, 0.5)
			IconImageLabelB.BackgroundTransparency = 1
			IconImageLabelB.Position = UDim2.new(0, 8, 0.5, 0)
			IconImageLabelB.Size = UDim2.new(0, 32, 0, 32)
			IconImageLabelB.Image = GetIcon(Icon)
			IconImageLabelB.ScaleType = Enum.ScaleType.Fit
			IconImageLabelB.ZIndex = 5
			HubNameTextLabel.Name = "HubName"
			HubNameTextLabel.Parent = TabCardFrame
			HubNameTextLabel.AnchorPoint = Vector2.new(0, 0.5)
			HubNameTextLabel.BackgroundTransparency = 1
			HubNameTextLabel.Position = UDim2.new(0, 45, 0.5, -15)
			HubNameTextLabel.Size = UDim2.new(0.65, 0, 0, 20)
			HubNameTextLabel.Font = Enum.Font.GothamBold
			HubNameTextLabel.Text = title
			HubNameTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			HubNameTextLabel.TextSize = 12
			HubNameTextLabel.TextStrokeTransparency = 0.3
			HubNameTextLabel.TextXAlignment = Enum.TextXAlignment.Left
			HubNameTextLabel.TextScaled = true
			HubNameTextLabel.TextWrapped = true
			HubNameTextLabel.ZIndex = 5

			local UITextSizeConstraint = Instance.new("UITextSizeConstraint")

			UITextSizeConstraint.Parent = HubNameTextLabel
			UITextSizeConstraint.MaxTextSize = 12
			UITextSizeConstraint.MinTextSize = 9
			TitleTextLabelB.Position = UDim2.new(0, 45, 0.5, 6)
			TitleTextLabelB.Size = UDim2.new(0.65, 0, 0, 18)
			TitleTextLabelB.TextSize = 11
			TitleTextLabelB.TextTransparency = 0.4
			TitleTextLabelB.Name = "Title"
			TitleTextLabelB.Parent = TabCardFrame
			TitleTextLabelB.AnchorPoint = Vector2.new(0, 0.5)
			TitleTextLabelB.BackgroundTransparency = 1
			TitleTextLabelB.Font = Enum.Font.GothamBold
			TitleTextLabelB.Text = DescB or title
			TitleTextLabelB.TextColor3 = Color3.fromRGB(255, 255, 255)
			TitleTextLabelB.TextStrokeTransparency = 0.5
			TitleTextLabelB.TextScaled = true
			TitleTextLabelB.TextWrapped = true
			Left = Enum.TextXAlignment.Left or Enum.TextXAlignment.Center
		else
			TitleTextLabelB.Position = UDim2.new(0.5, 0, 0.92, 0)
			TitleTextLabelB.Size = UDim2.new(0.85, 0, 0, 26)
			TitleTextLabelB.TextSize = 15
			TitleTextLabelB.TextTransparency = 0
			TitleTextLabelB.Name = "Title"
			TitleTextLabelB.Parent = TabCardFrame
			TitleTextLabelB.AnchorPoint = Vector2.new(Icon and 0 or 0.5, Icon and 0.5 or 1)
			TitleTextLabelB.BackgroundTransparency = 1
			TitleTextLabelB.Font = Enum.Font.GothamBold
			TitleTextLabelB.Text = Icon and DescB or title
			TitleTextLabelB.TextColor3 = Color3.fromRGB(255, 255, 255)
			TitleTextLabelB.TextStrokeTransparency = Icon and 0.5 or 0.3
			TitleTextLabelB.TextScaled = true
			TitleTextLabelB.TextWrapped = true
			Left = Icon and Enum.TextXAlignment.Left or Enum.TextXAlignment.Center
		end

		TitleTextLabelB.TextXAlignment = Left
		TitleTextLabelB.ZIndex = 5

		local UITextSizeConstraint = Instance.new("UITextSizeConstraint")

		UITextSizeConstraint.Parent = TitleTextLabelB
		UITextSizeConstraint.MaxTextSize = Icon and 11 or 15
		UITextSizeConstraint.MinTextSize = Icon and 8 or 11
		BackgroundFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
			local X = BackgroundFrame.AbsoluteSize.X

			if Icon and Icon ~= "" then
				local UITextSizeConstraint = HubNameTextLabel and HubNameTextLabel:FindFirstChildOfClass("UITextSizeConstraint")
				local UITextSizeConstraintB = TitleTextLabelB and TitleTextLabelB:FindFirstChildOfClass("UITextSizeConstraint")

				if UITextSizeConstraint and UITextSizeConstraintB then
					if X >= 600 then
						UITextSizeConstraint.MaxTextSize = 13
						UITextSizeConstraintB.MaxTextSize = 12
					elseif X >= 500 then
						UITextSizeConstraint.MaxTextSize = 12
						UITextSizeConstraintB.MaxTextSize = 11
					else
						UITextSizeConstraint.MaxTextSize = 11
						UITextSizeConstraintB.MaxTextSize = 10
					end
				end
			else
				local UITextSizeConstraint = TitleTextLabelB and TitleTextLabelB:FindFirstChildOfClass("UITextSizeConstraint")

				if UITextSizeConstraint then
					if X >= 600 then
						UITextSizeConstraint.MaxTextSize = 16
					elseif X >= 500 then
						UITextSizeConstraint.MaxTextSize = 15
					else
						UITextSizeConstraint.MaxTextSize = 14
					end
				end
			end
		end)

		local PagesFrame = Instance.new("Frame")

		PagesFrame.Name = "Pages"
		PagesFrame.Parent = BackgroundFrame
		PagesFrame.AnchorPoint = Vector2.new(0.5, 0.5)
		PagesFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		PagesFrame.BackgroundTransparency = 1
		PagesFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
		PagesFrame.BorderSizePixel = 0
		PagesFrame.Position = UDim2.new(0.5, 0, 0.58, 0)
		PagesFrame.Size = UDim2.new(0.97, 0, 0.73, 0)
		PagesFrame.Visible = false

		local SearchFrame = Instance.new("Frame")
		local SearchFrameCorner = Instance.new("UICorner")
		local SearchFrameStroke = Instance.new("UIStroke")
		local SearchGlowImageLabel = Instance.new("ImageLabel")
		local SearchImageImageLabel = Instance.new("ImageLabel")
		local SearchBoxFrame = Instance.new("Frame")
		local TextBox = Instance.new("TextBox")
		local SearchUnderlineFrame = Instance.new("Frame")
		local SearchUnderlineActiveFrame = Instance.new("Frame")
		local SearchUnderlineFrameCorner = Instance.new("UICorner")
		local SearchUnderlineActiveFrameCorner = Instance.new("UICorner")
		local SearchUnderlineActiveFrameGradient = Instance.new("UIGradient")

		SearchFrame.Name = "SearchFrame"
		SearchFrame.Parent = PagesFrame
		SearchFrame.AnchorPoint = Vector2.new(0.5, 0)
		SearchFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
		SearchFrame.BackgroundTransparency = 0.25
		SearchFrame.BorderSizePixel = 0
		SearchFrame.ClipsDescendants = false
		SearchFrame.Position = UDim2.new(0.5, 0, 0, 0)
		SearchFrame.Size = UDim2.new(1, 0, 0, 38)
		SearchFrameCorner.CornerRadius = UDim.new(0, 14)
		SearchFrameCorner.Parent = SearchFrame
		SearchFrameStroke.Parent = SearchFrame
		SearchFrameStroke.Color = Color3.fromRGB(110, 110, 140)
		SearchFrameStroke.Thickness = 2
		SearchFrameStroke.Transparency = 0.7
		SearchGlowImageLabel.Name = "SearchGlow"
		SearchGlowImageLabel.Parent = SearchFrame
		SearchGlowImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
		SearchGlowImageLabel.BackgroundTransparency = 1
		SearchGlowImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
		SearchGlowImageLabel.Size = UDim2.new(1, 70, 1, 70)
		SearchGlowImageLabel.Image = "rbxassetid://8992230677"
		SearchGlowImageLabel.ImageColor3 = Color3.fromRGB(0, 170, 255)
		SearchGlowImageLabel.ImageTransparency = 0.9
		SearchGlowImageLabel.ScaleType = Enum.ScaleType.Slice
		SearchGlowImageLabel.SliceCenter = Rect.new(99, 99, 99, 99)
		SearchGlowImageLabel.ZIndex = 0
		SearchImageImageLabel.Name = "SearchImage"
		SearchImageImageLabel.Parent = SearchFrame
		SearchImageImageLabel.AnchorPoint = Vector2.new(0, 0.5)
		SearchImageImageLabel.BackgroundTransparency = 1
		SearchImageImageLabel.Position = UDim2.new(0, 14, 0.5, 0)
		SearchImageImageLabel.Size = UDim2.new(0, 20, 0, 20)
		SearchImageImageLabel.Image = "rbxassetid://18557078698"
		SearchImageImageLabel.ImageColor3 = Color3.fromRGB(110, 210, 255)
		SearchBoxFrame.Name = "SearchBoxFrame"
		SearchBoxFrame.Parent = SearchFrame
		SearchBoxFrame.BackgroundTransparency = 1
		SearchBoxFrame.BorderSizePixel = 0
		SearchBoxFrame.ClipsDescendants = true
		SearchBoxFrame.Position = UDim2.new(0, 42, 0, 0)
		SearchBoxFrame.Size = UDim2.new(1, -52, 1, -6)
		TextBox.Name = "SearchBox"
		TextBox.Parent = SearchBoxFrame
		TextBox.BackgroundTransparency = 1
		TextBox.BorderSizePixel = 0
		TextBox.Position = UDim2.new(0, 0, 0, 0)
		TextBox.Size = UDim2.new(1, 0, 1, 0)
		TextBox.Font = Enum.Font.GothamBold
		TextBox.PlaceholderColor3 = Color3.fromRGB(145, 145, 170)
		TextBox.PlaceholderText = "Search elements..."
		TextBox.Text = ""
		TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
		TextBox.TextSize = 13
		TextBox.TextXAlignment = Enum.TextXAlignment.Left
		SearchUnderlineFrame.Name = "SearchUnderline"
		SearchUnderlineFrame.Parent = SearchFrame
		SearchUnderlineFrame.AnchorPoint = Vector2.new(0.5, 1)
		SearchUnderlineFrame.BackgroundColor3 = Color3.fromRGB(85, 85, 110)
		SearchUnderlineFrame.BackgroundTransparency = 0.75
		SearchUnderlineFrame.BorderSizePixel = 0
		SearchUnderlineFrame.Position = UDim2.new(0.5, 0, 1, -4)
		SearchUnderlineFrame.Size = UDim2.new(1, -24, 0, 3)
		SearchUnderlineFrameCorner.CornerRadius = UDim.new(1, 0)
		SearchUnderlineFrameCorner.Parent = SearchUnderlineFrame
		SearchUnderlineActiveFrame.Name = "SearchUnderlineActive"
		SearchUnderlineActiveFrame.Parent = SearchUnderlineFrame
		SearchUnderlineActiveFrame.AnchorPoint = Vector2.new(0, 0.5)
		SearchUnderlineActiveFrame.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
		SearchUnderlineActiveFrame.BackgroundTransparency = 0.999
		SearchUnderlineActiveFrame.BorderSizePixel = 0
		SearchUnderlineActiveFrame.Position = UDim2.new(0, 0, 0.5, 0)
		SearchUnderlineActiveFrame.Size = UDim2.new(1, 0, 1, 0)
		SearchUnderlineActiveFrameCorner.CornerRadius = UDim.new(1, 0)
		SearchUnderlineActiveFrameCorner.Parent = SearchUnderlineActiveFrame
		SearchUnderlineActiveFrameGradient.Parent = SearchUnderlineActiveFrame
		SearchUnderlineActiveFrameGradient.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 170, 255)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)),
		})
		TextBox.Focused:Connect(function()
			tw({
				v = SearchUnderlineActiveFrame,
				t = 0.4,
				s = "Quad",
				d = "Out",
				g = {
					BackgroundTransparency = 0,
				},
			}):Play()
			tw({
				v = SearchFrameStroke,
				t = 0.4,
				s = "Quad",
				d = "Out",
				g = {
					Transparency = 0.25,
				},
			}):Play()
			tw({
				v = SearchGlowImageLabel,
				t = 0.4,
				s = "Quad",
				d = "Out",
				g = {
					ImageTransparency = 0.82,
				},
			}):Play()
			tw({
				v = SearchImageImageLabel,
				t = 0.4,
				s = "Quad",
				d = "Out",
				g = {
					ImageColor3 = Color3.fromRGB(0, 255, 127),
				},
			}):Play()
			tw({
				v = SearchFrame,
				t = 0.4,
				s = "Quad",
				d = "Out",
				g = {
					BackgroundTransparency = 0.15,
				},
			}):Play()
		end)
		TextBox.FocusLost:Connect(function()
			tw({
				v = SearchUnderlineActiveFrame,
				t = 0.4,
				s = "Quad",
				d = "Out",
				g = {
					BackgroundTransparency = 0.999,
				},
			}):Play()
			tw({
				v = SearchFrameStroke,
				t = 0.4,
				s = "Quad",
				d = "Out",
				g = {
					Transparency = 0.7,
				},
			}):Play()
			tw({
				v = SearchGlowImageLabel,
				t = 0.4,
				s = "Quad",
				d = "Out",
				g = {
					ImageTransparency = 0.9,
				},
			}):Play()
			tw({
				v = SearchImageImageLabel,
				t = 0.4,
				s = "Quad",
				d = "Out",
				g = {
					ImageColor3 = Color3.fromRGB(110, 210, 255),
				},
			}):Play()
			tw({
				v = SearchFrame,
				t = 0.4,
				s = "Quad",
				d = "Out",
				g = {
					BackgroundTransparency = 0.25,
				},
			}):Play()
		end)

		local ContentFrame = Instance.new("Frame")
		local ContentFrameListLayout = Instance.new("UIListLayout")

		ContentFrame.Name = "ContentFrame"
		ContentFrame.Parent = PagesFrame
		ContentFrame.AnchorPoint = Vector2.new(0.5, 0)
		ContentFrame.BackgroundTransparency = 1
		ContentFrame.BorderSizePixel = 0
		ContentFrame.Position = UDim2.new(0.5, 0, 0, 50)
		ContentFrame.Size = UDim2.new(1, 0, 1, -50)
		ContentFrameListLayout.Parent = ContentFrame
		ContentFrameListLayout.Padding = UDim.new(0, 10)
		ContentFrameListLayout.FillDirection = Enum.FillDirection.Horizontal
		ContentFrameListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		ContentFrameListLayout.VerticalAlignment = Enum.VerticalAlignment.Top
		ContentFrameListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

		local ColumnFrames = {}
		local SearchItems, GetColumn

		if Columns == 1 then
			local SingleColumnScrollingFrame = Instance.new("ScrollingFrame")
			local SingleColumnScrollingFrameListLayout = Instance.new("UIListLayout")

			SingleColumnScrollingFrame.Name = "SingleColumn"
			SingleColumnScrollingFrame.Parent = ContentFrame
			SingleColumnScrollingFrame.Active = true
			SingleColumnScrollingFrame.BackgroundTransparency = 1
			SingleColumnScrollingFrame.BorderSizePixel = 0
			SingleColumnScrollingFrame.Size = UDim2.new(0, 500, 1, 0)
			SingleColumnScrollingFrame.ClipsDescendants = true
			SingleColumnScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 140)
			SingleColumnScrollingFrame.ScrollBarImageTransparency = 0.5
			SingleColumnScrollingFrame.ScrollBarThickness = 4
			SingleColumnScrollingFrameListLayout.Parent = SingleColumnScrollingFrame
			SingleColumnScrollingFrameListLayout.Padding = UDim.new(0, 8)
			SingleColumnScrollingFrameListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			SingleColumnScrollingFrameListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
			SingleColumnScrollingFrameListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
				SingleColumnScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, SingleColumnScrollingFrameListLayout.AbsoluteContentSize.Y + 20)
			end)
			ColumnFrames[1] = SingleColumnScrollingFrame
			SearchItems = {}
			BackgroundFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
				ScaleElements(BackgroundFrame, Columns, ColumnFrames, SearchItems)
			end)
			TextBox:GetPropertyChangedSignal("Text"):Connect(function()
				local lowered = string.lower(TextBox.Text)

				for _, v in pairs(SearchItems) do
					if v.Frame and v.SearchName then
						local loweredB = string.lower(v.SearchName)

						if lowered == "" or string.find(loweredB, lowered, 1, true) then
							v.Frame.Visible = true

							if v.HighlightFrame then
								tw({
									v = v.HighlightFrame,
									t = 0.3,
									s = "Quad",
									d = "Out",
									g = {
										BackgroundTransparency = 0.7,
									},
								}):Play()
								task.delay(0.5, function()
									tw({
										v = v.HighlightFrame,
										t = 0.3,
										s = "Quad",
										d = "Out",
										g = {
											BackgroundTransparency = 1,
										},
									}):Play()
								end)
							end
						else
							v.Frame.Visible = false
						end
					end
				end
			end)

			local udim = UDim2.new(0.5, 0, 0.5, 0)

			tabCardFrameClick.MouseEnter:Connect(function()
				tw({
					v = TabCardFrame,
					t = 0.3,
					s = "Quad",
					d = "Out",
					g = {
						BackgroundTransparency = 0.05,
						Position = UDim2.new(0.5, 0, 0.48, 0),
					},
				}):Play()
				tw({
					v = TabCardFrameStroke,
					t = 0.3,
					s = "Quad",
					d = "Out",
					g = {
						Transparency = 0.35,
					},
				}):Play()
				tw({
					v = TitleTextLabelB,
					t = 0.3,
					s = "Quad",
					d = "Out",
					g = {
						TextStrokeTransparency = 0.1,
					},
				}):Play()
				tw({
					v = BannerImageLabel,
					t = 0.3,
					s = "Quad",
					d = "Out",
					g = {
						Size = UDim2.new(1.05, 0, 1.05, 0),
					},
				}):Play()
			end)
			tabCardFrameClick.MouseLeave:Connect(function()
				tw({
					v = TabCardFrame,
					t = 0.3,
					s = "Quad",
					d = "Out",
					g = {
						BackgroundTransparency = 0.2,
						Position = udim,
					},
				}):Play()
				tw({
					v = TabCardFrameStroke,
					t = 0.3,
					s = "Quad",
					d = "Out",
					g = {
						Transparency = 0.75,
					},
				}):Play()
				tw({
					v = TitleTextLabelB,
					t = 0.3,
					s = "Quad",
					d = "Out",
					g = {
						TextStrokeTransparency = 0.3,
					},
				}):Play()
				tw({
					v = BannerImageLabel,
					t = 0.3,
					s = "Quad",
					d = "Out",
					g = {
						Size = UDim2.new(1, 0, 1, 0),
					},
				}):Play()
			end)
			tabCardFrameClick.MouseButton1Click:Connect(function()
				HeaderFrameB.Position = UDim2.new(0, -38, 0, 0)
				tw({
					v = HeaderFrameB,
					t = 0.4,
					s = "Back",
					d = "Out",
					g = {
						Position = UDim2.new(0, 0, 0, 0),
					},
				}):Play()
				tw({
					v = TextLabel,
					t = 0.5,
					s = "Back",
					d = "Out",
					g = {
						TextTransparency = 1,
					},
				}):Play()
				tw({
					v = DescTextLabel,
					t = 0.5,
					s = "Back",
					d = "Out",
					g = {
						TextTransparency = 1,
					},
				}):Play()
				tw({
					v = LineFrameB,
					t = 0.5,
					s = "Back",
					d = "Out",
					g = {
						BackgroundTransparency = 1,
					},
				}):Play()
				DescTextLabel.Text = DescB
				TextLabel.Text = title
				delay(0.25, function()
					tw({
						v = TextLabel,
						t = 0.5,
						s = "Back",
						d = "Out",
						g = {
							TextTransparency = 0,
						},
					}):Play()
					tw({
						v = DescTextLabel,
						t = 0.5,
						s = "Back",
						d = "Out",
						g = {
							TextTransparency = 0.35,
						},
					}):Play()
					tw({
						v = LineFrameB,
						t = 0.5,
						s = "Back",
						d = "Out",
						g = {
							BackgroundTransparency = 0,
						},
					}):Play()
				end)
				ReturnFrame.Visible = true
				ReturnFrameStroke.Enabled = true
				ReturnFrame.Position = UDim2.new(0.95, 0, 0.055, 0)
				tw({
					v = ReturnFrame,
					t = 0.4,
					s = "Back",
					d = "Out",
					g = {
						Position = UDim2.new(0.77, 0, 0.055, 0),
					},
				}):Play()
				tw({
					v = ReturnFrame,
					t = 0.4,
					s = "Back",
					d = "Out",
					g = {
						BackgroundTransparency = 0,
					},
				}):Play()
				tw({
					v = ReturnFrameStroke,
					t = 0.4,
					s = "Back",
					d = "Out",
					g = {
						Transparency = 0,
					},
				}):Play()
				tw({
					v = ReturnFrameImage,
					t = 0.4,
					s = "Back",
					d = "Out",
					g = {
						ImageTransparency = 0.75,
					},
				}):Play()
				tw({
					v = ReturnFrameLabel,
					t = 0.4,
					s = "Back",
					d = "Out",
					g = {
						TextTransparency = 0,
					},
				}):Play()
				tw({
					v = ScrollingFrame,
					t = 0.4,
					s = "Bounce",
					d = "Out",
					g = {
						Size = UDim2.new(0.96, 0, 0, 0),
					},
				}):Play()
				ScrollingFrame.Visible = false
				PagesFrame.Size = UDim2.new(0.97, 0, 0, 0)
				tw({
					v = PagesFrame,
					t = 0.3,
					s = "Back",
					d = "Out",
					g = {
						Size = UDim2.new(0.97, 0, 0.73, 0),
					},
				}):Play()
				PagesFrame.Visible = true
				EffectClick2(tabCardFrameClick, TabCardFrame)
			end)
			GetColumn = function(arg)
				if Columns == 1 then
					return ColumnFrames[1]
				end

				if not arg then
					return ColumnFrames[1]
				end

				local lowered = string.lower(tostring(arg))

				if lowered == "b" or lowered == "r" or lowered == "right" or arg == 2 then
					return ColumnFrames[2]
				end

				if lowered == "a" or lowered == "l" or lowered == "left" or arg == 1 then
					return ColumnFrames[1]
				end

				return ColumnFrames[1]
			end
			Library.Elements = {}
			Library.Elements.Toggle = function(self, options)
				local title = options.Title
				local desc = options.Desc

				desc = desc or ""

				local icon = options.Icon
				local visible, StatusTextTextLabel, items, textB, handler

				if icon then
					local Side = options.Side or "l"
					local Value = options.Value or false
					local Callback = options.Callback or function() end

					visible = options.ShowStatusText ~= false

					local StatusTextType = options.StatusTextType or "TrueFalse"

					number += 1
					BadgeLabelTextLabel.Text = tostring(number)
					tw({
						v = BadgeFrame,
						t = 0.3,
						s = "Back",
						d = "Out",
						g = {
							Size = UDim2.new(0, math.max(32, #tostring(number) * 10 + 12), 0, 18),
						},
					}):Play()

					if icon ~= "" then
						local ToggleImageFrame = Instance.new("Frame")
						local TitleTextLabel = Instance.new("TextLabel")
						local ToggleImageFrameCorner = Instance.new("UICorner")
						local ToggleImageFrameImage = Instance.new("ImageLabel")
						local ToggleImageFrameImageGradient = Instance.new("UIGradient")
						local iconImageLabel = Instance.new("ImageLabel")
						local DescTextLabel = Instance.new("TextLabel")
						local CheckFrame = Instance.new("Frame")
						local ColorFrame = Instance.new("Frame")
						local ColorFrameGradient = Instance.new("UIGradient")
						local ColorFrameCorner = Instance.new("UICorner")
						local ColorFrameImage = Instance.new("ImageLabel")
						local CheckFrameCorner = Instance.new("UICorner")

						Instance.new("UIStroke")

						local HighlightFrameB = Instance.new("Frame")
						local HighlightFrameBCorner = Instance.new("UICorner")
						local StatusTextTextLabel = Instance.new("TextLabel")
						local toggleImageFrameClick = click(ToggleImageFrame)

						ToggleImageFrame.Name = "ToggleImage"
						ToggleImageFrame.Parent = GetColumn(Side)
						ToggleImageFrame.AnchorPoint = Vector2.new(0.5, 0.5)
						ToggleImageFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
						ToggleImageFrame.BackgroundTransparency = 0.2
						ToggleImageFrame.BorderSizePixel = 0
						ToggleImageFrame.Size = UDim2.new(0.97, 0, 0, 55)
						ToggleImageFrame.ClipsDescendants = true
						HighlightFrameB.Name = "HighlightFrame"
						HighlightFrameB.Parent = ToggleImageFrame
						HighlightFrameB.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
						HighlightFrameB.BackgroundTransparency = 1
						HighlightFrameB.Size = UDim2.new(1, 0, 1, 0)
						HighlightFrameB.ZIndex = 2
						HighlightFrameBCorner.CornerRadius = UDim.new(0, 12)
						HighlightFrameBCorner.Parent = HighlightFrameB
						TitleTextLabel.Name = "Title"
						TitleTextLabel.Parent = ToggleImageFrame
						TitleTextLabel.AnchorPoint = Vector2.new(0, 0.5)
						TitleTextLabel.BackgroundTransparency = 1
						TitleTextLabel.Position = UDim2.new(0, 55, 0.35, 0)
						TitleTextLabel.Size = UDim2.new(0.45, 0, 0, 18)
						TitleTextLabel.Font = Enum.Font.GothamBold
						TitleTextLabel.RichText = true
						TitleTextLabel.Text = title
						TitleTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
						TitleTextLabel.TextSize = 14
						TitleTextLabel.TextTransparency = 0
						TitleTextLabel.TextXAlignment = Enum.TextXAlignment.Left
						TitleTextLabel.TextScaled = true
						TitleTextLabel.TextWrapped = true

						local TitleTextLabelTextConstraint = Instance.new("UITextSizeConstraint")

						TitleTextLabelTextConstraint.Parent = TitleTextLabel
						TitleTextLabelTextConstraint.MaxTextSize = 14
						TitleTextLabelTextConstraint.MinTextSize = 10
						ToggleImageFrameCorner.Parent = ToggleImageFrame
						ToggleImageFrameCorner.CornerRadius = UDim.new(0, 12)
						ToggleImageFrameImage.Parent = ToggleImageFrame
						ToggleImageFrameImage.AnchorPoint = Vector2.new(0.5, 0.5)
						ToggleImageFrameImage.BackgroundTransparency = 1
						ToggleImageFrameImage.Position = UDim2.new(0.5, 0, 0.5, 0)
						ToggleImageFrameImage.Size = UDim2.new(1, 50, 1, 0)
						ToggleImageFrameImage.Image = "rbxassetid://72380279434385"
						ToggleImageFrameImage.ImageTransparency = 0.9
						ToggleImageFrameImage.ScaleType = Enum.ScaleType.Crop
						ToggleImageFrameImageGradient.Parent = ToggleImageFrameImage
						ToggleImageFrameImageGradient.Color = ColorSequence.new({
							ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
							ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 170, 255)),
							ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)),
						})
						iconImageLabel.Name = "icon"
						iconImageLabel.Parent = ToggleImageFrame
						iconImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
						iconImageLabel.BackgroundTransparency = 1
						iconImageLabel.Position = UDim2.new(0, 27, 0.5, 0)
						iconImageLabel.Size = UDim2.new(0, 38, 0, 38)
						iconImageLabel.Image = GetIcon(icon)
						iconImageLabel.ImageTransparency = Value and 0 or 0.4
						iconImageLabel.ScaleType = Enum.ScaleType.Fit
						DescTextLabel.Name = "Desc"
						DescTextLabel.Parent = ToggleImageFrame
						DescTextLabel.AnchorPoint = Vector2.new(0, 0.5)
						DescTextLabel.BackgroundTransparency = 1
						DescTextLabel.Position = UDim2.new(0, 55, 0.68, 0)
						DescTextLabel.Size = UDim2.new(0.45, 0, 0, 15)
						DescTextLabel.Font = Enum.Font.Gotham
						DescTextLabel.RichText = true
						DescTextLabel.Text = desc
						DescTextLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
						DescTextLabel.TextSize = 11
						DescTextLabel.TextTransparency = 0.3
						DescTextLabel.TextXAlignment = Enum.TextXAlignment.Left
						DescTextLabel.TextScaled = true
						DescTextLabel.TextWrapped = true

						local DescTextLabelTextConstraint = Instance.new("UITextSizeConstraint")

						DescTextLabelTextConstraint.Parent = DescTextLabel
						DescTextLabelTextConstraint.MaxTextSize = 11
						DescTextLabelTextConstraint.MinTextSize = 8
						StatusTextTextLabel.Name = "StatusText"
						StatusTextTextLabel.Parent = ToggleImageFrame
						StatusTextTextLabel.AnchorPoint = Vector2.new(1, 0.5)
						StatusTextTextLabel.BackgroundTransparency = 1
						StatusTextTextLabel.Position = UDim2.new(0.95, -38, 0.5, 0)
						StatusTextTextLabel.Size = UDim2.new(0, 60, 0, 20)
						StatusTextTextLabel.Font = Enum.Font.GothamBold

						local text = visible
						local setValue, MouseButton1Click, value, Connect

						if text then
							text = StatusTextType == "idk"

							local color, backgroundTransparency, uDim

							if text then
								text = Value and "True"

								if text then
									StatusTextTextLabel.Text = text
									color = Value and Color3.fromRGB(0, 255, 127) or Color3.fromRGB(255, 100, 100)
									StatusTextTextLabel.TextColor3 = color
									StatusTextTextLabel.TextSize = 12
									StatusTextTextLabel.TextTransparency = 0
									StatusTextTextLabel.TextXAlignment = Enum.TextXAlignment.Right
									StatusTextTextLabel.Visible = visible
									CheckFrame.Name = "Check"
									CheckFrame.Parent = ToggleImageFrame
									CheckFrame.AnchorPoint = Vector2.new(1, 0.5)
									CheckFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
									CheckFrame.BorderSizePixel = 0
									CheckFrame.Position = UDim2.new(0.95, 0, 0.5, 0)
									CheckFrame.Size = UDim2.new(0, 25, 0, 25)
									CheckFrame.ClipsDescendants = true
									ColorFrame.Name = "ColorFrame"
									ColorFrame.Parent = CheckFrame
									ColorFrame.AnchorPoint = Vector2.new(0.5, 0.5)
									ColorFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
									ColorFrame.BorderSizePixel = 0
									ColorFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
									ColorFrame.Size = UDim2.new(1, 0, 1, 0)
									backgroundTransparency = Value and 0 or 1
									ColorFrame.BackgroundTransparency = backgroundTransparency
									ColorFrameGradient.Parent = ColorFrame
									ColorFrameGradient.Color = ColorSequence.new({
										ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
										ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 170, 255)),
										ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)),
									})
									ColorFrameGradient.Rotation = 48
									ColorFrameCorner.Parent = ColorFrame
									ColorFrameCorner.CornerRadius = UDim.new(0, 5)
									ColorFrameImage.Parent = ColorFrame
									ColorFrameImage.AnchorPoint = Vector2.new(0.5, 0.5)
									ColorFrameImage.BackgroundTransparency = 1
									ColorFrameImage.Position = UDim2.new(0.5, 0, 0.5, 0)
									uDim = Value and UDim2.new(0, 13, 0, 13) or UDim2.new(0, 0, 0, 0)
									ColorFrameImage.Size = uDim
									ColorFrameImage.Image = "rbxassetid://86682186031062"
									ColorFrameImage.ScaleType = Enum.ScaleType.Crop
									CheckFrameCorner.Parent = CheckFrame
									CheckFrameCorner.CornerRadius = UDim.new(0, 5)
									setValue = function(value)
										Value = value

										if Value then
											Callback(Value)
											tw({
												v = ColorFrame,
												t = 0.25,
												s = "Quad",
												d = "Out",
												g = {
													BackgroundTransparency = 0,
												},
											}):Play()
											tw({
												v = ColorFrameImage,
												t = 0.15,
												s = "Back",
												d = "Out",
												g = {
													Size = UDim2.new(0, 18, 0, 18),
												},
											}):Play()
											tw({
												v = iconImageLabel,
												t = 0.2,
												s = "Quad",
												d = "Out",
												g = {
													ImageTransparency = 0,
												},
											}):Play()
											delay(0.08, function()
												tw({
													v = ColorFrameImage,
													t = 0.2,
													s = "Back",
													d = "Out",
													g = {
														Size = UDim2.new(0, 13, 0, 13),
													},
												}):Play()
											end)

											if visible then
												StatusTextTextLabel.Text = StatusTextType == "OnOff" and "ON" or "true"
												tw({
													v = StatusTextTextLabel,
													t = 0.2,
													s = "Quad",
													d = "Out",
													g = {
														TextColor3 = Color3.fromRGB(0, 255, 127),
													},
												}):Play()
											end
										else
											Callback(Value)
											tw({
												v = ColorFrame,
												t = 0.25,
												s = "Quad",
												d = "Out",
												g = {
													BackgroundTransparency = 1,
												},
											}):Play()
											tw({
												v = ColorFrameImage,
												t = 0.2,
												s = "Quad",
												d = "Out",
												g = {
													Size = UDim2.new(0, 0, 0, 0),
												},
											}):Play()
											tw({
												v = iconImageLabel,
												t = 0.2,
												s = "Quad",
												d = "Out",
												g = {
													ImageTransparency = 0.4,
												},
											}):Play()

											if visible then
												StatusTextTextLabel.Text = StatusTextType == "OnOff" and "OFF" or "false"
												tw({
													v = StatusTextTextLabel,
													t = 0.2,
													s = "Quad",
													d = "Out",
													g = {
														TextColor3 = Color3.fromRGB(255, 100, 100),
													},
												}):Play()
											end
										end
									end
									MouseButton1Click = toggleImageFrameClick.MouseButton1Click
									value = MouseButton1Click
									Connect = MouseButton1Click.Connect
								else
									StatusTextTextLabel.Text = "False"
									StatusTextTextLabel.TextColor3 = Value and Color3.fromRGB(0, 255, 127)
										or Color3.fromRGB(255, 100, 100)
									StatusTextTextLabel.TextSize = 12
									StatusTextTextLabel.TextTransparency = 0
									StatusTextTextLabel.TextXAlignment = Enum.TextXAlignment.Right
									StatusTextTextLabel.Visible = visible
									CheckFrame.Name = "Check"
									CheckFrame.Parent = ToggleImageFrame
									CheckFrame.AnchorPoint = Vector2.new(1, 0.5)
									CheckFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
									CheckFrame.BorderSizePixel = 0
									CheckFrame.Position = UDim2.new(0.95, 0, 0.5, 0)
									CheckFrame.Size = UDim2.new(0, 25, 0, 25)
									CheckFrame.ClipsDescendants = true
									ColorFrame.Name = "ColorFrame"
									ColorFrame.Parent = CheckFrame
									ColorFrame.AnchorPoint = Vector2.new(0.5, 0.5)
									ColorFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
									ColorFrame.BorderSizePixel = 0
									ColorFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
									ColorFrame.Size = UDim2.new(1, 0, 1, 0)
									ColorFrame.BackgroundTransparency = Value and 0 or 1
									ColorFrameGradient.Parent = ColorFrame
									ColorFrameGradient.Color = ColorSequence.new({
										ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
										ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 170, 255)),
										ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)),
									})
									ColorFrameGradient.Rotation = 48
									ColorFrameCorner.Parent = ColorFrame
									ColorFrameCorner.CornerRadius = UDim.new(0, 5)
									ColorFrameImage.Parent = ColorFrame
									ColorFrameImage.AnchorPoint = Vector2.new(0.5, 0.5)
									ColorFrameImage.BackgroundTransparency = 1
									ColorFrameImage.Position = UDim2.new(0.5, 0, 0.5, 0)
									ColorFrameImage.Size = Value and UDim2.new(0, 13, 0, 13) or UDim2.new(0, 0, 0, 0)
									ColorFrameImage.Image = "rbxassetid://86682186031062"
									ColorFrameImage.ScaleType = Enum.ScaleType.Crop
									CheckFrameCorner.Parent = CheckFrame
									CheckFrameCorner.CornerRadius = UDim.new(0, 5)
									setValue = function(value)
										Value = value

										if Value then
											Callback(Value)
											tw({
												v = ColorFrame,
												t = 0.25,
												s = "Quad",
												d = "Out",
												g = {
													BackgroundTransparency = 0,
												},
											}):Play()
											tw({
												v = ColorFrameImage,
												t = 0.15,
												s = "Back",
												d = "Out",
												g = {
													Size = UDim2.new(0, 18, 0, 18),
												},
											}):Play()
											tw({
												v = iconImageLabel,
												t = 0.2,
												s = "Quad",
												d = "Out",
												g = {
													ImageTransparency = 0,
												},
											}):Play()
											delay(0.08, function()
												tw({
													v = ColorFrameImage,
													t = 0.2,
													s = "Back",
													d = "Out",
													g = {
														Size = UDim2.new(0, 13, 0, 13),
													},
												}):Play()
											end)

											if visible then
												StatusTextTextLabel.Text = StatusTextType == "OnOff" and "ON" or "true"
												tw({
													v = StatusTextTextLabel,
													t = 0.2,
													s = "Quad",
													d = "Out",
													g = {
														TextColor3 = Color3.fromRGB(0, 255, 127),
													},
												}):Play()
											end
										else
											Callback(Value)
											tw({
												v = ColorFrame,
												t = 0.25,
												s = "Quad",
												d = "Out",
												g = {
													BackgroundTransparency = 1,
												},
											}):Play()
											tw({
												v = ColorFrameImage,
												t = 0.2,
												s = "Quad",
												d = "Out",
												g = {
													Size = UDim2.new(0, 0, 0, 0),
												},
											}):Play()
											tw({
												v = iconImageLabel,
												t = 0.2,
												s = "Quad",
												d = "Out",
												g = {
													ImageTransparency = 0.4,
												},
											}):Play()

											if visible then
												StatusTextTextLabel.Text = StatusTextType == "OnOff" and "OFF" or "false"
												tw({
													v = StatusTextTextLabel,
													t = 0.2,
													s = "Quad",
													d = "Out",
													g = {
														TextColor3 = Color3.fromRGB(255, 100, 100),
													},
												}):Play()
											end
										end
									end

									local MouseButton1Click2 = toggleImageFrameClick.MouseButton1Click

									value = MouseButton1Click2
									Connect = MouseButton1Click2.Connect
								end
							else
								text = tostring(Value) or ""
								StatusTextTextLabel.Text = text
								color = Value and Color3.fromRGB(0, 255, 127) or Color3.fromRGB(255, 100, 100)
								StatusTextTextLabel.TextColor3 = color
								StatusTextTextLabel.TextSize = 12
								StatusTextTextLabel.TextTransparency = 0
								StatusTextTextLabel.TextXAlignment = Enum.TextXAlignment.Right
								StatusTextTextLabel.Visible = visible
								CheckFrame.Name = "Check"
								CheckFrame.Parent = ToggleImageFrame
								CheckFrame.AnchorPoint = Vector2.new(1, 0.5)
								CheckFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
								CheckFrame.BorderSizePixel = 0
								CheckFrame.Position = UDim2.new(0.95, 0, 0.5, 0)
								CheckFrame.Size = UDim2.new(0, 25, 0, 25)
								CheckFrame.ClipsDescendants = true
								ColorFrame.Name = "ColorFrame"
								ColorFrame.Parent = CheckFrame
								ColorFrame.AnchorPoint = Vector2.new(0.5, 0.5)
								ColorFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
								ColorFrame.BorderSizePixel = 0
								ColorFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
								ColorFrame.Size = UDim2.new(1, 0, 1, 0)
								backgroundTransparency = Value and 0 or 1
								ColorFrame.BackgroundTransparency = backgroundTransparency
								ColorFrameGradient.Parent = ColorFrame
								ColorFrameGradient.Color = ColorSequence.new({
									ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
									ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 170, 255)),
									ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)),
								})
								ColorFrameGradient.Rotation = 48
								ColorFrameCorner.Parent = ColorFrame
								ColorFrameCorner.CornerRadius = UDim.new(0, 5)
								ColorFrameImage.Parent = ColorFrame
								ColorFrameImage.AnchorPoint = Vector2.new(0.5, 0.5)
								ColorFrameImage.BackgroundTransparency = 1
								ColorFrameImage.Position = UDim2.new(0.5, 0, 0.5, 0)
								uDim = Value and UDim2.new(0, 13, 0, 13) or UDim2.new(0, 0, 0, 0)
								ColorFrameImage.Size = uDim
								ColorFrameImage.Image = "rbxassetid://86682186031062"
								ColorFrameImage.ScaleType = Enum.ScaleType.Crop
								CheckFrameCorner.Parent = CheckFrame
								CheckFrameCorner.CornerRadius = UDim.new(0, 5)
								setValue = function(value)
									Value = value

									if Value then
										Callback(Value)
										tw({
											v = ColorFrame,
											t = 0.25,
											s = "Quad",
											d = "Out",
											g = {
												BackgroundTransparency = 0,
											},
										}):Play()
										tw({
											v = ColorFrameImage,
											t = 0.15,
											s = "Back",
											d = "Out",
											g = {
												Size = UDim2.new(0, 18, 0, 18),
											},
										}):Play()
										tw({
											v = iconImageLabel,
											t = 0.2,
											s = "Quad",
											d = "Out",
											g = {
												ImageTransparency = 0,
											},
										}):Play()
										delay(0.08, function()
											tw({
												v = ColorFrameImage,
												t = 0.2,
												s = "Back",
												d = "Out",
												g = {
													Size = UDim2.new(0, 13, 0, 13),
												},
											}):Play()
										end)

										if visible then
											StatusTextTextLabel.Text = StatusTextType == "OnOff" and "ON" or "true"
											tw({
												v = StatusTextTextLabel,
												t = 0.2,
												s = "Quad",
												d = "Out",
												g = {
													TextColor3 = Color3.fromRGB(0, 255, 127),
												},
											}):Play()
										end
									else
										Callback(Value)
										tw({
											v = ColorFrame,
											t = 0.25,
											s = "Quad",
											d = "Out",
											g = {
												BackgroundTransparency = 1,
											},
										}):Play()
										tw({
											v = ColorFrameImage,
											t = 0.2,
											s = "Quad",
											d = "Out",
											g = {
												Size = UDim2.new(0, 0, 0, 0),
											},
										}):Play()
										tw({
											v = iconImageLabel,
											t = 0.2,
											s = "Quad",
											d = "Out",
											g = {
												ImageTransparency = 0.4,
											},
										}):Play()

										if visible then
											StatusTextTextLabel.Text = StatusTextType == "OnOff" and "OFF" or "false"
											tw({
												v = StatusTextTextLabel,
												t = 0.2,
												s = "Quad",
												d = "Out",
												g = {
													TextColor3 = Color3.fromRGB(255, 100, 100),
												},
											}):Play()
										end
									end
								end
								MouseButton1Click = toggleImageFrameClick.MouseButton1Click
								value = MouseButton1Click
								Connect = MouseButton1Click.Connect
							end
						else
							StatusTextTextLabel.Text = ""
							StatusTextTextLabel.TextColor3 = Value and Color3.fromRGB(0, 255, 127)
								or Color3.fromRGB(255, 100, 100)
							StatusTextTextLabel.TextSize = 12
							StatusTextTextLabel.TextTransparency = 0
							StatusTextTextLabel.TextXAlignment = Enum.TextXAlignment.Right
							StatusTextTextLabel.Visible = visible
							CheckFrame.Name = "Check"
							CheckFrame.Parent = ToggleImageFrame
							CheckFrame.AnchorPoint = Vector2.new(1, 0.5)
							CheckFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
							CheckFrame.BorderSizePixel = 0
							CheckFrame.Position = UDim2.new(0.95, 0, 0.5, 0)
							CheckFrame.Size = UDim2.new(0, 25, 0, 25)
							CheckFrame.ClipsDescendants = true
							ColorFrame.Name = "ColorFrame"
							ColorFrame.Parent = CheckFrame
							ColorFrame.AnchorPoint = Vector2.new(0.5, 0.5)
							ColorFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
							ColorFrame.BorderSizePixel = 0
							ColorFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
							ColorFrame.Size = UDim2.new(1, 0, 1, 0)
							ColorFrame.BackgroundTransparency = Value and 0 or 1
							ColorFrameGradient.Parent = ColorFrame
							ColorFrameGradient.Color = ColorSequence.new({
								ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
								ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 170, 255)),
								ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)),
							})
							ColorFrameGradient.Rotation = 48
							ColorFrameCorner.Parent = ColorFrame
							ColorFrameCorner.CornerRadius = UDim.new(0, 5)
							ColorFrameImage.Parent = ColorFrame
							ColorFrameImage.AnchorPoint = Vector2.new(0.5, 0.5)
							ColorFrameImage.BackgroundTransparency = 1
							ColorFrameImage.Position = UDim2.new(0.5, 0, 0.5, 0)
							ColorFrameImage.Size = Value and UDim2.new(0, 13, 0, 13) or UDim2.new(0, 0, 0, 0)
							ColorFrameImage.Image = "rbxassetid://86682186031062"
							ColorFrameImage.ScaleType = Enum.ScaleType.Crop
							CheckFrameCorner.Parent = CheckFrame
							CheckFrameCorner.CornerRadius = UDim.new(0, 5)
							setValue = function(value)
								Value = value

								if Value then
									Callback(Value)
									tw({
										v = ColorFrame,
										t = 0.25,
										s = "Quad",
										d = "Out",
										g = {
											BackgroundTransparency = 0,
										},
									}):Play()
									tw({
										v = ColorFrameImage,
										t = 0.15,
										s = "Back",
										d = "Out",
										g = {
											Size = UDim2.new(0, 18, 0, 18),
										},
									}):Play()
									tw({
										v = iconImageLabel,
										t = 0.2,
										s = "Quad",
										d = "Out",
										g = {
											ImageTransparency = 0,
										},
									}):Play()
									delay(0.08, function()
										tw({
											v = ColorFrameImage,
											t = 0.2,
											s = "Back",
											d = "Out",
											g = {
												Size = UDim2.new(0, 13, 0, 13),
											},
										}):Play()
									end)

									if visible then
										StatusTextTextLabel.Text = StatusTextType == "OnOff" and "ON" or "true"
										tw({
											v = StatusTextTextLabel,
											t = 0.2,
											s = "Quad",
											d = "Out",
											g = {
												TextColor3 = Color3.fromRGB(0, 255, 127),
											},
										}):Play()
									end
								else
									Callback(Value)
									tw({
										v = ColorFrame,
										t = 0.25,
										s = "Quad",
										d = "Out",
										g = {
											BackgroundTransparency = 1,
										},
									}):Play()
									tw({
										v = ColorFrameImage,
										t = 0.2,
										s = "Quad",
										d = "Out",
										g = {
											Size = UDim2.new(0, 0, 0, 0),
										},
									}):Play()
									tw({
										v = iconImageLabel,
										t = 0.2,
										s = "Quad",
										d = "Out",
										g = {
											ImageTransparency = 0.4,
										},
									}):Play()

									if visible then
										StatusTextTextLabel.Text = StatusTextType == "OnOff" and "OFF" or "false"
										tw({
											v = StatusTextTextLabel,
											t = 0.2,
											s = "Quad",
											d = "Out",
											g = {
												TextColor3 = Color3.fromRGB(255, 100, 100),
											},
										}):Play()
									end
								end
							end
							MouseButton1Click = toggleImageFrameClick.MouseButton1Click
							value = MouseButton1Click
							Connect = MouseButton1Click.Connect
						end

						Connect(value, function()
							EffectClick2(toggleImageFrameClick, ToggleImageFrame)
							setValue(not Value)
						end)
						table.insert(SearchItems, {
							Frame = ToggleImageFrame,
							SearchName = title,
							HighlightFrame = HighlightFrameB,
						})

						return {
							SetValue = function(self, value)
								setValue(value)
							end,
							GetValue = function()
								return Value
							end,
							SetTitle = function(self, text)
								TitleTextLabel.Text = text

								for _, v in pairs(SearchItems) do
									if v.Frame ~= ToggleImageFrame then
										continue
									end

									v.SearchName = text

									return
								end
							end,
							SetDesc = function(self, text)
								DescTextLabel.Text = text
							end,
							SetIcon = function(self, icon)
								iconImageLabel.Image = GetIcon(icon)
							end,
							Visible = function(self, visible)
								ToggleImageFrame.Visible = visible
							end,
							SetStatusTextType = function(self, statusTextType)
								StatusTextType = statusTextType

								if visible then
									StatusTextTextLabel.Text = statusTextType == "OnOff" and (Value and "ON" or "OFF") or tostring(Value)
								end
							end,
							ShowStatus = function(self, visibleB)
								visible = visibleB
								StatusTextTextLabel.Visible = visibleB
							end,
						}
					end

					local ToggleFrame = Instance.new("Frame")
					local TitleTextLabel = Instance.new("TextLabel")
					local ToggleFrameCorner = Instance.new("UICorner")
					local ToggleFrameImage = Instance.new("ImageLabel")
					local ToggleFrameImageGradient = Instance.new("UIGradient")
					local CheckFrame = Instance.new("Frame")
					local ColorFrame = Instance.new("Frame")
					local ColorFrameGradient = Instance.new("UIGradient")
					local ColorFrameCorner = Instance.new("UICorner")
					local ColorFrameImage = Instance.new("ImageLabel")
					local CheckFrameCorner = Instance.new("UICorner")
					local DescTextLabel = Instance.new("TextLabel")

					Instance.new("UIStroke")

					local HighlightFrameB = Instance.new("Frame")
					local HighlightFrameBCorner = Instance.new("UICorner")

					StatusTextTextLabel = Instance.new("TextLabel")

					local toggleFrameClick = click(ToggleFrame)

					ToggleFrame.Name = "Toggle"
					ToggleFrame.Parent = GetColumn(Side)
					ToggleFrame.AnchorPoint = Vector2.new(0.5, 0.5)
					ToggleFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
					ToggleFrame.BackgroundTransparency = 0.2
					ToggleFrame.BorderSizePixel = 0
					ToggleFrame.Size = UDim2.new(0.97, 0, 0, 55)
					ToggleFrame.ClipsDescendants = true
					HighlightFrameB.Name = "HighlightFrame"
					HighlightFrameB.Parent = ToggleFrame
					HighlightFrameB.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					HighlightFrameB.BackgroundTransparency = 1
					HighlightFrameB.Size = UDim2.new(1, 0, 1, 0)
					HighlightFrameB.ZIndex = 2
					HighlightFrameBCorner.CornerRadius = UDim.new(0, 12)
					HighlightFrameBCorner.Parent = HighlightFrameB
					TitleTextLabel.Name = "Title"
					TitleTextLabel.Parent = ToggleFrame
					TitleTextLabel.AnchorPoint = Vector2.new(0, 0.5)
					TitleTextLabel.BackgroundTransparency = 1
					TitleTextLabel.Position = UDim2.new(0.03, 0, 0.35, 0)
					TitleTextLabel.Size = UDim2.new(0.62, 0, 0, 18)
					TitleTextLabel.Font = Enum.Font.GothamBold
					TitleTextLabel.RichText = true
					TitleTextLabel.Text = title
					TitleTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
					TitleTextLabel.TextSize = 14
					TitleTextLabel.TextTransparency = 0
					TitleTextLabel.TextXAlignment = Enum.TextXAlignment.Left
					TitleTextLabel.TextScaled = true
					TitleTextLabel.TextWrapped = true

					local TitleTextLabelTextConstraint = Instance.new("UITextSizeConstraint")

					TitleTextLabelTextConstraint.Parent = TitleTextLabel
					TitleTextLabelTextConstraint.MaxTextSize = 14
					TitleTextLabelTextConstraint.MinTextSize = 10
					ToggleFrameCorner.Parent = ToggleFrame
					ToggleFrameCorner.CornerRadius = UDim.new(0, 12)
					ToggleFrameImage.Parent = ToggleFrame
					ToggleFrameImage.AnchorPoint = Vector2.new(0.5, 0.5)
					ToggleFrameImage.BackgroundTransparency = 1
					ToggleFrameImage.Position = UDim2.new(0.5, 0, 0.5, 0)
					ToggleFrameImage.Size = UDim2.new(1, 50, 1, 0)
					ToggleFrameImage.Image = "rbxassetid://72380279434385"
					ToggleFrameImage.ImageTransparency = 0.9
					ToggleFrameImage.ScaleType = Enum.ScaleType.Crop
					ToggleFrameImageGradient.Parent = ToggleFrameImage
					ToggleFrameImageGradient.Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
						ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 170, 255)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)),
					})
					StatusTextTextLabel.Name = "StatusText"
					StatusTextTextLabel.Parent = ToggleFrame
					StatusTextTextLabel.AnchorPoint = Vector2.new(1, 0.5)
					StatusTextTextLabel.BackgroundTransparency = 1
					StatusTextTextLabel.Position = UDim2.new(0.95, -38, 0.5, 0)
					StatusTextTextLabel.Size = UDim2.new(0, 60, 0, 20)
					StatusTextTextLabel.Font = Enum.Font.GothamBold
					StatusTextTextLabel.Text = visible
							and (StatusTextType == "Idk" and (Value and "True" or "False") or tostring(Value))
						or ""
					StatusTextTextLabel.TextColor3 = Value and Color3.fromRGB(0, 255, 127) or Color3.fromRGB(255, 100, 100)
					StatusTextTextLabel.TextSize = 12
					StatusTextTextLabel.TextTransparency = 0
					StatusTextTextLabel.TextXAlignment = Enum.TextXAlignment.Right
					StatusTextTextLabel.Visible = visible
					CheckFrame.Name = "Check"
					CheckFrame.Parent = ToggleFrame
					CheckFrame.AnchorPoint = Vector2.new(1, 0.5)
					CheckFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
					CheckFrame.BorderSizePixel = 0
					CheckFrame.Position = UDim2.new(0.95, 0, 0.5, 0)
					CheckFrame.Size = UDim2.new(0, 25, 0, 25)
					CheckFrame.ClipsDescendants = true
					ColorFrame.Name = "ColorFrame"
					ColorFrame.Parent = CheckFrame
					ColorFrame.AnchorPoint = Vector2.new(0.5, 0.5)
					ColorFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					ColorFrame.BorderSizePixel = 0
					ColorFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
					ColorFrame.Size = UDim2.new(1, 0, 1, 0)
					ColorFrame.BackgroundTransparency = Value and 0 or 1
					ColorFrameGradient.Parent = ColorFrame
					ColorFrameGradient.Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
						ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 170, 255)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)),
					})
					ColorFrameGradient.Rotation = 48
					ColorFrameCorner.Parent = ColorFrame
					ColorFrameCorner.CornerRadius = UDim.new(0, 5)
					ColorFrameImage.Parent = ColorFrame
					ColorFrameImage.AnchorPoint = Vector2.new(0.5, 0.5)
					ColorFrameImage.BackgroundTransparency = 1
					ColorFrameImage.Position = UDim2.new(0.5, 0, 0.5, 0)
					ColorFrameImage.Size = Value and UDim2.new(0, 13, 0, 13) or UDim2.new(0, 0, 0, 0)
					ColorFrameImage.Image = "rbxassetid://86682186031062"
					ColorFrameImage.ScaleType = Enum.ScaleType.Crop
					CheckFrameCorner.Parent = CheckFrame
					CheckFrameCorner.CornerRadius = UDim.new(0, 5)
					DescTextLabel.Name = "Desc"
					DescTextLabel.Parent = ToggleFrame
					DescTextLabel.AnchorPoint = Vector2.new(0, 0.5)
					DescTextLabel.BackgroundTransparency = 1
					DescTextLabel.Position = UDim2.new(0.03, 0, 0.68, 0)
					DescTextLabel.Size = UDim2.new(0.62, 0, 0, 15)
					DescTextLabel.Font = Enum.Font.Gotham
					DescTextLabel.RichText = true
					DescTextLabel.Text = desc
					DescTextLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
					DescTextLabel.TextSize = 11
					DescTextLabel.TextTransparency = 0.3
					DescTextLabel.TextXAlignment = Enum.TextXAlignment.Left
					DescTextLabel.TextScaled = true
					DescTextLabel.TextWrapped = true

					local DescTextLabelTextConstraint = Instance.new("UITextSizeConstraint")

					DescTextLabelTextConstraint.Parent = DescTextLabel
					DescTextLabelTextConstraint.MaxTextSize = 11
					DescTextLabelTextConstraint.MinTextSize = 8

					local function helper(self)
						Value = self

						if Value then
							Callback(Value)
							tw({
								v = ColorFrame,
								t = 0.25,
								s = "Quad",
								d = "Out",
								g = {
									BackgroundTransparency = 0,
								},
							}):Play()
							tw({
								v = ColorFrameImage,
								t = 0.15,
								s = "Back",
								d = "Out",
								g = {
									Size = UDim2.new(0, 18, 0, 18),
								},
							}):Play()
							delay(0.08, function()
								tw({
									v = ColorFrameImage,
									t = 0.2,
									s = "Back",
									d = "Out",
									g = {
										Size = UDim2.new(0, 13, 0, 13),
									},
								}):Play()
							end)

							if visible then
								StatusTextTextLabel.Text = StatusTextType == "OnOff" and "ON" or "true"
								tw({
									v = StatusTextTextLabel,
									t = 0.2,
									s = "Quad",
									d = "Out",
									g = {
										TextColor3 = Color3.fromRGB(0, 255, 127),
									},
								}):Play()
							end
						else
							Callback(Value)
							tw({
								v = ColorFrame,
								t = 0.25,
								s = "Quad",
								d = "Out",
								g = {
									BackgroundTransparency = 1,
								},
							}):Play()
							tw({
								v = ColorFrameImage,
								t = 0.2,
								s = "Quad",
								d = "Out",
								g = {
									Size = UDim2.new(0, 0, 0, 0),
								},
							}):Play()

							if visible then
								StatusTextTextLabel.Text = StatusTextType == "OnOff" and "OFF" or "false"
								tw({
									v = StatusTextTextLabel,
									t = 0.2,
									s = "Quad",
									d = "Out",
									g = {
										TextColor3 = Color3.fromRGB(255, 100, 100),
									},
								}):Play()
							end
						end
					end

					toggleFrameClick.MouseButton1Click:Connect(function()
						EffectClick2(toggleFrameClick, ToggleFrame)
						helper(not Value)
					end)
					table.insert(SearchItems, {
						Frame = ToggleFrame,
						SearchName = title,
						HighlightFrame = HighlightFrameB,
					})
					items = {
						SetValue = function(self, value)
							helper(value)
						end,
						GetValue = function()
							return Value
						end,
						SetTitle = function(self, text)
							TitleTextLabel.Text = text

							for _, v in pairs(SearchItems) do
								if v.Frame == ToggleFrame then
									v.SearchName = text

									break
								end
							end
						end,
						SetDesc = function(self, text)
							DescTextLabel.Text = text
						end,
						Visible = function(self, visible)
							ToggleFrame.Visible = visible
						end,
					}
					textB = "SetStatusTextType"
					handler = function(_, statusTextType)
						StatusTextType = statusTextType

						if visible then
							StatusTextTextLabel.Text = statusTextType == "OnOff" and (Value and "ON" or "OFF") or tostring(Value)
						end
					end
				else
					local Side = options.Side or "l"
					local Value = options.Value or false
					local Callback = options.Callback or function() end

					visible = options.ShowStatusText ~= false

					local StatusTextType = options.StatusTextType or "TrueFalse"

					number += 1
					BadgeLabelTextLabel.Text = tostring(number)
					tw({
						v = BadgeFrame,
						t = 0.3,
						s = "Back",
						d = "Out",
						g = {
							Size = UDim2.new(0, math.max(32, #tostring(number) * 10 + 12), 0, 18),
						},
					}):Play()

					local ToggleFrame = Instance.new("Frame")
					local TitleTextLabel = Instance.new("TextLabel")
					local ToggleFrameCorner = Instance.new("UICorner")
					local ToggleFrameImage = Instance.new("ImageLabel")
					local ToggleFrameImageGradient = Instance.new("UIGradient")
					local CheckFrame = Instance.new("Frame")
					local ColorFrame = Instance.new("Frame")
					local ColorFrameGradient = Instance.new("UIGradient")
					local ColorFrameCorner = Instance.new("UICorner")
					local ColorFrameImage = Instance.new("ImageLabel")
					local CheckFrameCorner = Instance.new("UICorner")
					local DescTextLabel = Instance.new("TextLabel")

					Instance.new("UIStroke")

					local HighlightFrameB = Instance.new("Frame")
					local HighlightFrameBCorner = Instance.new("UICorner")

					StatusTextTextLabel = Instance.new("TextLabel")

					local toggleFrameClick = click(ToggleFrame)

					ToggleFrame.Name = "Toggle"
					ToggleFrame.Parent = GetColumn(Side)
					ToggleFrame.AnchorPoint = Vector2.new(0.5, 0.5)
					ToggleFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
					ToggleFrame.BackgroundTransparency = 0.2
					ToggleFrame.BorderSizePixel = 0
					ToggleFrame.Size = UDim2.new(0.97, 0, 0, 55)
					ToggleFrame.ClipsDescendants = true
					HighlightFrameB.Name = "HighlightFrame"
					HighlightFrameB.Parent = ToggleFrame
					HighlightFrameB.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					HighlightFrameB.BackgroundTransparency = 1
					HighlightFrameB.Size = UDim2.new(1, 0, 1, 0)
					HighlightFrameB.ZIndex = 2
					HighlightFrameBCorner.CornerRadius = UDim.new(0, 12)
					HighlightFrameBCorner.Parent = HighlightFrameB
					TitleTextLabel.Name = "Title"
					TitleTextLabel.Parent = ToggleFrame
					TitleTextLabel.AnchorPoint = Vector2.new(0, 0.5)
					TitleTextLabel.BackgroundTransparency = 1
					TitleTextLabel.Position = UDim2.new(0.03, 0, 0.35, 0)
					TitleTextLabel.Size = UDim2.new(0.62, 0, 0, 18)
					TitleTextLabel.Font = Enum.Font.GothamBold
					TitleTextLabel.RichText = true
					TitleTextLabel.Text = title
					TitleTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
					TitleTextLabel.TextSize = 14
					TitleTextLabel.TextTransparency = 0
					TitleTextLabel.TextXAlignment = Enum.TextXAlignment.Left
					TitleTextLabel.TextScaled = true
					TitleTextLabel.TextWrapped = true

					local TitleTextLabelTextConstraint = Instance.new("UITextSizeConstraint")

					TitleTextLabelTextConstraint.Parent = TitleTextLabel
					TitleTextLabelTextConstraint.MaxTextSize = 14
					TitleTextLabelTextConstraint.MinTextSize = 10
					ToggleFrameCorner.Parent = ToggleFrame
					ToggleFrameCorner.CornerRadius = UDim.new(0, 12)
					ToggleFrameImage.Parent = ToggleFrame
					ToggleFrameImage.AnchorPoint = Vector2.new(0.5, 0.5)
					ToggleFrameImage.BackgroundTransparency = 1
					ToggleFrameImage.Position = UDim2.new(0.5, 0, 0.5, 0)
					ToggleFrameImage.Size = UDim2.new(1, 50, 1, 0)
					ToggleFrameImage.Image = "rbxassetid://72380279434385"
					ToggleFrameImage.ImageTransparency = 0.9
					ToggleFrameImage.ScaleType = Enum.ScaleType.Crop
					ToggleFrameImageGradient.Parent = ToggleFrameImage
					ToggleFrameImageGradient.Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
						ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 170, 255)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)),
					})
					StatusTextTextLabel.Name = "StatusText"
					StatusTextTextLabel.Parent = ToggleFrame
					StatusTextTextLabel.AnchorPoint = Vector2.new(1, 0.5)
					StatusTextTextLabel.BackgroundTransparency = 1
					StatusTextTextLabel.Position = UDim2.new(0.95, -38, 0.5, 0)
					StatusTextTextLabel.Size = UDim2.new(0, 60, 0, 20)
					StatusTextTextLabel.Font = Enum.Font.GothamBold
					StatusTextTextLabel.Text = visible
							and (StatusTextType == "Idk" and (Value and "True" or "False") or tostring(Value))
						or ""
					StatusTextTextLabel.TextColor3 = Value and Color3.fromRGB(0, 255, 127) or Color3.fromRGB(255, 100, 100)
					StatusTextTextLabel.TextSize = 12
					StatusTextTextLabel.TextTransparency = 0
					StatusTextTextLabel.TextXAlignment = Enum.TextXAlignment.Right
					StatusTextTextLabel.Visible = visible
					CheckFrame.Name = "Check"
					CheckFrame.Parent = ToggleFrame
					CheckFrame.AnchorPoint = Vector2.new(1, 0.5)
					CheckFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
					CheckFrame.BorderSizePixel = 0
					CheckFrame.Position = UDim2.new(0.95, 0, 0.5, 0)
					CheckFrame.Size = UDim2.new(0, 25, 0, 25)
					CheckFrame.ClipsDescendants = true
					ColorFrame.Name = "ColorFrame"
					ColorFrame.Parent = CheckFrame
					ColorFrame.AnchorPoint = Vector2.new(0.5, 0.5)
					ColorFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					ColorFrame.BorderSizePixel = 0
					ColorFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
					ColorFrame.Size = UDim2.new(1, 0, 1, 0)
					ColorFrame.BackgroundTransparency = Value and 0 or 1
					ColorFrameGradient.Parent = ColorFrame
					ColorFrameGradient.Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
						ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 170, 255)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)),
					})
					ColorFrameGradient.Rotation = 48
					ColorFrameCorner.Parent = ColorFrame
					ColorFrameCorner.CornerRadius = UDim.new(0, 5)
					ColorFrameImage.Parent = ColorFrame
					ColorFrameImage.AnchorPoint = Vector2.new(0.5, 0.5)
					ColorFrameImage.BackgroundTransparency = 1
					ColorFrameImage.Position = UDim2.new(0.5, 0, 0.5, 0)
					ColorFrameImage.Size = Value and UDim2.new(0, 13, 0, 13) or UDim2.new(0, 0, 0, 0)
					ColorFrameImage.Image = "rbxassetid://86682186031062"
					ColorFrameImage.ScaleType = Enum.ScaleType.Crop
					CheckFrameCorner.Parent = CheckFrame
					CheckFrameCorner.CornerRadius = UDim.new(0, 5)
					DescTextLabel.Name = "Desc"
					DescTextLabel.Parent = ToggleFrame
					DescTextLabel.AnchorPoint = Vector2.new(0, 0.5)
					DescTextLabel.BackgroundTransparency = 1
					DescTextLabel.Position = UDim2.new(0.03, 0, 0.68, 0)
					DescTextLabel.Size = UDim2.new(0.62, 0, 0, 15)
					DescTextLabel.Font = Enum.Font.Gotham
					DescTextLabel.RichText = true
					DescTextLabel.Text = desc
					DescTextLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
					DescTextLabel.TextSize = 11
					DescTextLabel.TextTransparency = 0.3
					DescTextLabel.TextXAlignment = Enum.TextXAlignment.Left
					DescTextLabel.TextScaled = true
					DescTextLabel.TextWrapped = true

					local DescTextLabelTextConstraint = Instance.new("UITextSizeConstraint")

					DescTextLabelTextConstraint.Parent = DescTextLabel
					DescTextLabelTextConstraint.MaxTextSize = 11
					DescTextLabelTextConstraint.MinTextSize = 8

					local function helper(self)
						Value = self

						if Value then
							Callback(Value)
							tw({
								v = ColorFrame,
								t = 0.25,
								s = "Quad",
								d = "Out",
								g = {
									BackgroundTransparency = 0,
								},
							}):Play()
							tw({
								v = ColorFrameImage,
								t = 0.15,
								s = "Back",
								d = "Out",
								g = {
									Size = UDim2.new(0, 18, 0, 18),
								},
							}):Play()
							delay(0.08, function()
								tw({
									v = ColorFrameImage,
									t = 0.2,
									s = "Back",
									d = "Out",
									g = {
										Size = UDim2.new(0, 13, 0, 13),
									},
								}):Play()
							end)

							if visible then
								StatusTextTextLabel.Text = StatusTextType == "OnOff" and "ON" or "true"
								tw({
									v = StatusTextTextLabel,
									t = 0.2,
									s = "Quad",
									d = "Out",
									g = {
										TextColor3 = Color3.fromRGB(0, 255, 127),
									},
								}):Play()
							end
						else
							Callback(Value)
							tw({
								v = ColorFrame,
								t = 0.25,
								s = "Quad",
								d = "Out",
								g = {
									BackgroundTransparency = 1,
								},
							}):Play()
							tw({
								v = ColorFrameImage,
								t = 0.2,
								s = "Quad",
								d = "Out",
								g = {
									Size = UDim2.new(0, 0, 0, 0),
								},
							}):Play()

							if visible then
								StatusTextTextLabel.Text = StatusTextType == "OnOff" and "OFF" or "false"
								tw({
									v = StatusTextTextLabel,
									t = 0.2,
									s = "Quad",
									d = "Out",
									g = {
										TextColor3 = Color3.fromRGB(255, 100, 100),
									},
								}):Play()
							end
						end
					end

					toggleFrameClick.MouseButton1Click:Connect(function()
						EffectClick2(toggleFrameClick, ToggleFrame)
						helper(not Value)
					end)
					table.insert(SearchItems, {
						Frame = ToggleFrame,
						SearchName = title,
						HighlightFrame = HighlightFrameB,
					})
					items = {
						SetValue = function(self, value)
							helper(value)
						end,
						GetValue = function()
							return Value
						end,
						SetTitle = function(self, text)
							TitleTextLabel.Text = text

							for _, v in pairs(SearchItems) do
								if v.Frame == ToggleFrame then
									v.SearchName = text

									break
								end
							end
						end,
						SetDesc = function(self, text)
							DescTextLabel.Text = text
						end,
						Visible = function(self, visible)
							ToggleFrame.Visible = visible
						end,
					}
					textB = "SetStatusTextType"
					handler = function(_, statusTextType)
						StatusTextType = statusTextType

						if visible then
							StatusTextTextLabel.Text = statusTextType == "OnOff" and (Value and "ON" or "OFF") or tostring(Value)
						end
					end
				end

				items[textB] = handler
				items.ShowStatus = function(self, visibleB)
					visible = visibleB
					StatusTextTextLabel.Visible = visibleB
				end

				return items
			end
		else
			local LeftScrollingFrame = Instance.new("ScrollingFrame")
			local LeftScrollingFrameListLayout = Instance.new("UIListLayout")

			LeftScrollingFrame.Name = "Left"
			LeftScrollingFrame.Parent = ContentFrame
			LeftScrollingFrame.Active = true
			LeftScrollingFrame.BackgroundTransparency = 1
			LeftScrollingFrame.BorderSizePixel = 0
			LeftScrollingFrame.Size = UDim2.new(0, 240, 1, 0)
			LeftScrollingFrame.ClipsDescendants = true
			LeftScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 140)
			LeftScrollingFrame.ScrollBarImageTransparency = 0.5
			LeftScrollingFrame.ScrollBarThickness = 4
			LeftScrollingFrameListLayout.Parent = LeftScrollingFrame
			LeftScrollingFrameListLayout.Padding = UDim.new(0, 8)
			LeftScrollingFrameListLayout.SortOrder = Enum.SortOrder.LayoutOrder

			local RightScrollingFrame = Instance.new("ScrollingFrame")
			local RightScrollingFrameListLayout = Instance.new("UIListLayout")

			RightScrollingFrame.Name = "Right"
			RightScrollingFrame.Parent = ContentFrame
			RightScrollingFrame.Active = true
			RightScrollingFrame.BackgroundTransparency = 1
			RightScrollingFrame.BorderSizePixel = 0
			RightScrollingFrame.Size = UDim2.new(0, 240, 1, 0)
			RightScrollingFrame.ClipsDescendants = true
			RightScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 140)
			RightScrollingFrame.ScrollBarImageTransparency = 0.5
			RightScrollingFrame.ScrollBarThickness = 4
			RightScrollingFrameListLayout.Parent = RightScrollingFrame
			RightScrollingFrameListLayout.Padding = UDim.new(0, 8)
			RightScrollingFrameListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			LeftScrollingFrameListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
				LeftScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, LeftScrollingFrameListLayout.AbsoluteContentSize.Y + 20)
			end)
			RightScrollingFrameListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
				RightScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, RightScrollingFrameListLayout.AbsoluteContentSize.Y + 20)
			end)
			ColumnFrames[1] = LeftScrollingFrame
			ColumnFrames[2] = RightScrollingFrame
			SearchItems = {}
			BackgroundFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
				ScaleElements(BackgroundFrame, Columns, ColumnFrames, SearchItems)
			end)
			TextBox:GetPropertyChangedSignal("Text"):Connect(function()
				local lowered = string.lower(TextBox.Text)

				for _, v in pairs(SearchItems) do
					if v.Frame and v.SearchName then
						local loweredB = string.lower(v.SearchName)

						if lowered == "" or string.find(loweredB, lowered, 1, true) then
							v.Frame.Visible = true

							if v.HighlightFrame then
								tw({
									v = v.HighlightFrame,
									t = 0.3,
									s = "Quad",
									d = "Out",
									g = {
										BackgroundTransparency = 0.7,
									},
								}):Play()
								task.delay(0.5, function()
									tw({
										v = v.HighlightFrame,
										t = 0.3,
										s = "Quad",
										d = "Out",
										g = {
											BackgroundTransparency = 1,
										},
									}):Play()
								end)
							end
						else
							v.Frame.Visible = false
						end
					end
				end
			end)

			local udim = UDim2.new(0.5, 0, 0.5, 0)

			tabCardFrameClick.MouseEnter:Connect(function()
				tw({
					v = TabCardFrame,
					t = 0.3,
					s = "Quad",
					d = "Out",
					g = {
						BackgroundTransparency = 0.05,
						Position = UDim2.new(0.5, 0, 0.48, 0),
					},
				}):Play()
				tw({
					v = TabCardFrameStroke,
					t = 0.3,
					s = "Quad",
					d = "Out",
					g = {
						Transparency = 0.35,
					},
				}):Play()
				tw({
					v = TitleTextLabelB,
					t = 0.3,
					s = "Quad",
					d = "Out",
					g = {
						TextStrokeTransparency = 0.1,
					},
				}):Play()
				tw({
					v = BannerImageLabel,
					t = 0.3,
					s = "Quad",
					d = "Out",
					g = {
						Size = UDim2.new(1.05, 0, 1.05, 0),
					},
				}):Play()
			end)
			tabCardFrameClick.MouseLeave:Connect(function()
				tw({
					v = TabCardFrame,
					t = 0.3,
					s = "Quad",
					d = "Out",
					g = {
						BackgroundTransparency = 0.2,
						Position = udim,
					},
				}):Play()
				tw({
					v = TabCardFrameStroke,
					t = 0.3,
					s = "Quad",
					d = "Out",
					g = {
						Transparency = 0.75,
					},
				}):Play()
				tw({
					v = TitleTextLabelB,
					t = 0.3,
					s = "Quad",
					d = "Out",
					g = {
						TextStrokeTransparency = 0.3,
					},
				}):Play()
				tw({
					v = BannerImageLabel,
					t = 0.3,
					s = "Quad",
					d = "Out",
					g = {
						Size = UDim2.new(1, 0, 1, 0),
					},
				}):Play()
			end)
			tabCardFrameClick.MouseButton1Click:Connect(function()
				HeaderFrameB.Position = UDim2.new(0, -38, 0, 0)
				tw({
					v = HeaderFrameB,
					t = 0.4,
					s = "Back",
					d = "Out",
					g = {
						Position = UDim2.new(0, 0, 0, 0),
					},
				}):Play()
				tw({
					v = TextLabel,
					t = 0.5,
					s = "Back",
					d = "Out",
					g = {
						TextTransparency = 1,
					},
				}):Play()
				tw({
					v = DescTextLabel,
					t = 0.5,
					s = "Back",
					d = "Out",
					g = {
						TextTransparency = 1,
					},
				}):Play()
				tw({
					v = LineFrameB,
					t = 0.5,
					s = "Back",
					d = "Out",
					g = {
						BackgroundTransparency = 1,
					},
				}):Play()
				DescTextLabel.Text = DescB
				TextLabel.Text = title
				delay(0.25, function()
					tw({
						v = TextLabel,
						t = 0.5,
						s = "Back",
						d = "Out",
						g = {
							TextTransparency = 0,
						},
					}):Play()
					tw({
						v = DescTextLabel,
						t = 0.5,
						s = "Back",
						d = "Out",
						g = {
							TextTransparency = 0.35,
						},
					}):Play()
					tw({
						v = LineFrameB,
						t = 0.5,
						s = "Back",
						d = "Out",
						g = {
							BackgroundTransparency = 0,
						},
					}):Play()
				end)
				ReturnFrame.Visible = true
				ReturnFrameStroke.Enabled = true
				ReturnFrame.Position = UDim2.new(0.95, 0, 0.055, 0)
				tw({
					v = ReturnFrame,
					t = 0.4,
					s = "Back",
					d = "Out",
					g = {
						Position = UDim2.new(0.77, 0, 0.055, 0),
					},
				}):Play()
				tw({
					v = ReturnFrame,
					t = 0.4,
					s = "Back",
					d = "Out",
					g = {
						BackgroundTransparency = 0,
					},
				}):Play()
				tw({
					v = ReturnFrameStroke,
					t = 0.4,
					s = "Back",
					d = "Out",
					g = {
						Transparency = 0,
					},
				}):Play()
				tw({
					v = ReturnFrameImage,
					t = 0.4,
					s = "Back",
					d = "Out",
					g = {
						ImageTransparency = 0.75,
					},
				}):Play()
				tw({
					v = ReturnFrameLabel,
					t = 0.4,
					s = "Back",
					d = "Out",
					g = {
						TextTransparency = 0,
					},
				}):Play()
				tw({
					v = ScrollingFrame,
					t = 0.4,
					s = "Bounce",
					d = "Out",
					g = {
						Size = UDim2.new(0.96, 0, 0, 0),
					},
				}):Play()
				ScrollingFrame.Visible = false
				PagesFrame.Size = UDim2.new(0.97, 0, 0, 0)
				tw({
					v = PagesFrame,
					t = 0.3,
					s = "Back",
					d = "Out",
					g = {
						Size = UDim2.new(0.97, 0, 0.73, 0),
					},
				}):Play()
				PagesFrame.Visible = true
				EffectClick2(tabCardFrameClick, TabCardFrame)
			end)
			GetColumn = function(arg)
				if Columns == 1 then
					return ColumnFrames[1]
				end

				if not arg then
					return ColumnFrames[1]
				end

				local lowered = string.lower(tostring(arg))

				if lowered == "b" or lowered == "r" or lowered == "right" or arg == 2 then
					return ColumnFrames[2]
				end

				if lowered == "a" or lowered == "l" or lowered == "left" or arg == 1 then
					return ColumnFrames[1]
				end

				return ColumnFrames[1]
			end
			Library.Elements = {}
			Library.Elements.Toggle = function(self, options)
				local title = options.Title
				local desc = options.Desc

				desc = desc or ""

				local icon = options.Icon
				local visible, StatusTextTextLabel, items, textB, handler

				if icon then
					local Side = options.Side or "l"
					local Value = options.Value or false
					local Callback = options.Callback or function() end

					visible = options.ShowStatusText ~= false

					local StatusTextType = options.StatusTextType or "TrueFalse"

					number += 1
					BadgeLabelTextLabel.Text = tostring(number)
					tw({
						v = BadgeFrame,
						t = 0.3,
						s = "Back",
						d = "Out",
						g = {
							Size = UDim2.new(0, math.max(32, #tostring(number) * 10 + 12), 0, 18),
						},
					}):Play()

					if icon ~= "" then
						local ToggleImageFrame = Instance.new("Frame")
						local TitleTextLabel = Instance.new("TextLabel")
						local ToggleImageFrameCorner = Instance.new("UICorner")
						local ToggleImageFrameImage = Instance.new("ImageLabel")
						local ToggleImageFrameImageGradient = Instance.new("UIGradient")
						local iconImageLabel = Instance.new("ImageLabel")
						local DescTextLabel = Instance.new("TextLabel")
						local CheckFrame = Instance.new("Frame")
						local ColorFrame = Instance.new("Frame")
						local ColorFrameGradient = Instance.new("UIGradient")
						local ColorFrameCorner = Instance.new("UICorner")
						local ColorFrameImage = Instance.new("ImageLabel")
						local CheckFrameCorner = Instance.new("UICorner")

						Instance.new("UIStroke")

						local HighlightFrameB = Instance.new("Frame")
						local HighlightFrameBCorner = Instance.new("UICorner")
						local StatusTextTextLabel = Instance.new("TextLabel")
						local toggleImageFrameClick = click(ToggleImageFrame)

						ToggleImageFrame.Name = "ToggleImage"
						ToggleImageFrame.Parent = GetColumn(Side)
						ToggleImageFrame.AnchorPoint = Vector2.new(0.5, 0.5)
						ToggleImageFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
						ToggleImageFrame.BackgroundTransparency = 0.2
						ToggleImageFrame.BorderSizePixel = 0
						ToggleImageFrame.Size = UDim2.new(0.97, 0, 0, 55)
						ToggleImageFrame.ClipsDescendants = true
						HighlightFrameB.Name = "HighlightFrame"
						HighlightFrameB.Parent = ToggleImageFrame
						HighlightFrameB.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
						HighlightFrameB.BackgroundTransparency = 1
						HighlightFrameB.Size = UDim2.new(1, 0, 1, 0)
						HighlightFrameB.ZIndex = 2
						HighlightFrameBCorner.CornerRadius = UDim.new(0, 12)
						HighlightFrameBCorner.Parent = HighlightFrameB
						TitleTextLabel.Name = "Title"
						TitleTextLabel.Parent = ToggleImageFrame
						TitleTextLabel.AnchorPoint = Vector2.new(0, 0.5)
						TitleTextLabel.BackgroundTransparency = 1
						TitleTextLabel.Position = UDim2.new(0, 55, 0.35, 0)
						TitleTextLabel.Size = UDim2.new(0.45, 0, 0, 18)
						TitleTextLabel.Font = Enum.Font.GothamBold
						TitleTextLabel.RichText = true
						TitleTextLabel.Text = title
						TitleTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
						TitleTextLabel.TextSize = 14
						TitleTextLabel.TextTransparency = 0
						TitleTextLabel.TextXAlignment = Enum.TextXAlignment.Left
						TitleTextLabel.TextScaled = true
						TitleTextLabel.TextWrapped = true

						local TitleTextLabelTextConstraint = Instance.new("UITextSizeConstraint")

						TitleTextLabelTextConstraint.Parent = TitleTextLabel
						TitleTextLabelTextConstraint.MaxTextSize = 14
						TitleTextLabelTextConstraint.MinTextSize = 10
						ToggleImageFrameCorner.Parent = ToggleImageFrame
						ToggleImageFrameCorner.CornerRadius = UDim.new(0, 12)
						ToggleImageFrameImage.Parent = ToggleImageFrame
						ToggleImageFrameImage.AnchorPoint = Vector2.new(0.5, 0.5)
						ToggleImageFrameImage.BackgroundTransparency = 1
						ToggleImageFrameImage.Position = UDim2.new(0.5, 0, 0.5, 0)
						ToggleImageFrameImage.Size = UDim2.new(1, 50, 1, 0)
						ToggleImageFrameImage.Image = "rbxassetid://72380279434385"
						ToggleImageFrameImage.ImageTransparency = 0.9
						ToggleImageFrameImage.ScaleType = Enum.ScaleType.Crop
						ToggleImageFrameImageGradient.Parent = ToggleImageFrameImage
						ToggleImageFrameImageGradient.Color = ColorSequence.new({
							ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
							ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 170, 255)),
							ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)),
						})
						iconImageLabel.Name = "icon"
						iconImageLabel.Parent = ToggleImageFrame
						iconImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
						iconImageLabel.BackgroundTransparency = 1
						iconImageLabel.Position = UDim2.new(0, 27, 0.5, 0)
						iconImageLabel.Size = UDim2.new(0, 38, 0, 38)
						iconImageLabel.Image = GetIcon(icon)
						iconImageLabel.ImageTransparency = Value and 0 or 0.4
						iconImageLabel.ScaleType = Enum.ScaleType.Fit
						DescTextLabel.Name = "Desc"
						DescTextLabel.Parent = ToggleImageFrame
						DescTextLabel.AnchorPoint = Vector2.new(0, 0.5)
						DescTextLabel.BackgroundTransparency = 1
						DescTextLabel.Position = UDim2.new(0, 55, 0.68, 0)
						DescTextLabel.Size = UDim2.new(0.45, 0, 0, 15)
						DescTextLabel.Font = Enum.Font.Gotham
						DescTextLabel.RichText = true
						DescTextLabel.Text = desc
						DescTextLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
						DescTextLabel.TextSize = 11
						DescTextLabel.TextTransparency = 0.3
						DescTextLabel.TextXAlignment = Enum.TextXAlignment.Left
						DescTextLabel.TextScaled = true
						DescTextLabel.TextWrapped = true

						local DescTextLabelTextConstraint = Instance.new("UITextSizeConstraint")

						DescTextLabelTextConstraint.Parent = DescTextLabel
						DescTextLabelTextConstraint.MaxTextSize = 11
						DescTextLabelTextConstraint.MinTextSize = 8
						StatusTextTextLabel.Name = "StatusText"
						StatusTextTextLabel.Parent = ToggleImageFrame
						StatusTextTextLabel.AnchorPoint = Vector2.new(1, 0.5)
						StatusTextTextLabel.BackgroundTransparency = 1
						StatusTextTextLabel.Position = UDim2.new(0.95, -38, 0.5, 0)
						StatusTextTextLabel.Size = UDim2.new(0, 60, 0, 20)
						StatusTextTextLabel.Font = Enum.Font.GothamBold

						local text = visible
						local setValue, MouseButton1Click, value, Connect

						if text then
							text = StatusTextType == "idk"

							local color, backgroundTransparency, uDim

							if text then
								text = Value and "True"

								if text then
									StatusTextTextLabel.Text = text
									color = Value and Color3.fromRGB(0, 255, 127) or Color3.fromRGB(255, 100, 100)
									StatusTextTextLabel.TextColor3 = color
									StatusTextTextLabel.TextSize = 12
									StatusTextTextLabel.TextTransparency = 0
									StatusTextTextLabel.TextXAlignment = Enum.TextXAlignment.Right
									StatusTextTextLabel.Visible = visible
									CheckFrame.Name = "Check"
									CheckFrame.Parent = ToggleImageFrame
									CheckFrame.AnchorPoint = Vector2.new(1, 0.5)
									CheckFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
									CheckFrame.BorderSizePixel = 0
									CheckFrame.Position = UDim2.new(0.95, 0, 0.5, 0)
									CheckFrame.Size = UDim2.new(0, 25, 0, 25)
									CheckFrame.ClipsDescendants = true
									ColorFrame.Name = "ColorFrame"
									ColorFrame.Parent = CheckFrame
									ColorFrame.AnchorPoint = Vector2.new(0.5, 0.5)
									ColorFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
									ColorFrame.BorderSizePixel = 0
									ColorFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
									ColorFrame.Size = UDim2.new(1, 0, 1, 0)
									backgroundTransparency = Value and 0 or 1
									ColorFrame.BackgroundTransparency = backgroundTransparency
									ColorFrameGradient.Parent = ColorFrame
									ColorFrameGradient.Color = ColorSequence.new({
										ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
										ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 170, 255)),
										ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)),
									})
									ColorFrameGradient.Rotation = 48
									ColorFrameCorner.Parent = ColorFrame
									ColorFrameCorner.CornerRadius = UDim.new(0, 5)
									ColorFrameImage.Parent = ColorFrame
									ColorFrameImage.AnchorPoint = Vector2.new(0.5, 0.5)
									ColorFrameImage.BackgroundTransparency = 1
									ColorFrameImage.Position = UDim2.new(0.5, 0, 0.5, 0)
									uDim = Value and UDim2.new(0, 13, 0, 13) or UDim2.new(0, 0, 0, 0)
									ColorFrameImage.Size = uDim
									ColorFrameImage.Image = "rbxassetid://86682186031062"
									ColorFrameImage.ScaleType = Enum.ScaleType.Crop
									CheckFrameCorner.Parent = CheckFrame
									CheckFrameCorner.CornerRadius = UDim.new(0, 5)
									setValue = function(value)
										Value = value

										if Value then
											Callback(Value)
											tw({
												v = ColorFrame,
												t = 0.25,
												s = "Quad",
												d = "Out",
												g = {
													BackgroundTransparency = 0,
												},
											}):Play()
											tw({
												v = ColorFrameImage,
												t = 0.15,
												s = "Back",
												d = "Out",
												g = {
													Size = UDim2.new(0, 18, 0, 18),
												},
											}):Play()
											tw({
												v = iconImageLabel,
												t = 0.2,
												s = "Quad",
												d = "Out",
												g = {
													ImageTransparency = 0,
												},
											}):Play()
											delay(0.08, function()
												tw({
													v = ColorFrameImage,
													t = 0.2,
													s = "Back",
													d = "Out",
													g = {
														Size = UDim2.new(0, 13, 0, 13),
													},
												}):Play()
											end)

											if visible then
												StatusTextTextLabel.Text = StatusTextType == "OnOff" and "ON" or "true"
												tw({
													v = StatusTextTextLabel,
													t = 0.2,
													s = "Quad",
													d = "Out",
													g = {
														TextColor3 = Color3.fromRGB(0, 255, 127),
													},
												}):Play()
											end
										else
											Callback(Value)
											tw({
												v = ColorFrame,
												t = 0.25,
												s = "Quad",
												d = "Out",
												g = {
													BackgroundTransparency = 1,
												},
											}):Play()
											tw({
												v = ColorFrameImage,
												t = 0.2,
												s = "Quad",
												d = "Out",
												g = {
													Size = UDim2.new(0, 0, 0, 0),
												},
											}):Play()
											tw({
												v = iconImageLabel,
												t = 0.2,
												s = "Quad",
												d = "Out",
												g = {
													ImageTransparency = 0.4,
												},
											}):Play()

											if visible then
												StatusTextTextLabel.Text = StatusTextType == "OnOff" and "OFF" or "false"
												tw({
													v = StatusTextTextLabel,
													t = 0.2,
													s = "Quad",
													d = "Out",
													g = {
														TextColor3 = Color3.fromRGB(255, 100, 100),
													},
												}):Play()
											end
										end
									end
									MouseButton1Click = toggleImageFrameClick.MouseButton1Click
									value = MouseButton1Click
									Connect = MouseButton1Click.Connect
								else
									StatusTextTextLabel.Text = "False"
									StatusTextTextLabel.TextColor3 = Value and Color3.fromRGB(0, 255, 127)
										or Color3.fromRGB(255, 100, 100)
									StatusTextTextLabel.TextSize = 12
									StatusTextTextLabel.TextTransparency = 0
									StatusTextTextLabel.TextXAlignment = Enum.TextXAlignment.Right
									StatusTextTextLabel.Visible = visible
									CheckFrame.Name = "Check"
									CheckFrame.Parent = ToggleImageFrame
									CheckFrame.AnchorPoint = Vector2.new(1, 0.5)
									CheckFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
									CheckFrame.BorderSizePixel = 0
									CheckFrame.Position = UDim2.new(0.95, 0, 0.5, 0)
									CheckFrame.Size = UDim2.new(0, 25, 0, 25)
									CheckFrame.ClipsDescendants = true
									ColorFrame.Name = "ColorFrame"
									ColorFrame.Parent = CheckFrame
									ColorFrame.AnchorPoint = Vector2.new(0.5, 0.5)
									ColorFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
									ColorFrame.BorderSizePixel = 0
									ColorFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
									ColorFrame.Size = UDim2.new(1, 0, 1, 0)
									ColorFrame.BackgroundTransparency = Value and 0 or 1
									ColorFrameGradient.Parent = ColorFrame
									ColorFrameGradient.Color = ColorSequence.new({
										ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
										ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 170, 255)),
										ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)),
									})
									ColorFrameGradient.Rotation = 48
									ColorFrameCorner.Parent = ColorFrame
									ColorFrameCorner.CornerRadius = UDim.new(0, 5)
									ColorFrameImage.Parent = ColorFrame
									ColorFrameImage.AnchorPoint = Vector2.new(0.5, 0.5)
									ColorFrameImage.BackgroundTransparency = 1
									ColorFrameImage.Position = UDim2.new(0.5, 0, 0.5, 0)
									ColorFrameImage.Size = Value and UDim2.new(0, 13, 0, 13) or UDim2.new(0, 0, 0, 0)
									ColorFrameImage.Image = "rbxassetid://86682186031062"
									ColorFrameImage.ScaleType = Enum.ScaleType.Crop
									CheckFrameCorner.Parent = CheckFrame
									CheckFrameCorner.CornerRadius = UDim.new(0, 5)
									setValue = function(value)
										Value = value

										if Value then
											Callback(Value)
											tw({
												v = ColorFrame,
												t = 0.25,
												s = "Quad",
												d = "Out",
												g = {
													BackgroundTransparency = 0,
												},
											}):Play()
											tw({
												v = ColorFrameImage,
												t = 0.15,
												s = "Back",
												d = "Out",
												g = {
													Size = UDim2.new(0, 18, 0, 18),
												},
											}):Play()
											tw({
												v = iconImageLabel,
												t = 0.2,
												s = "Quad",
												d = "Out",
												g = {
													ImageTransparency = 0,
												},
											}):Play()
											delay(0.08, function()
												tw({
													v = ColorFrameImage,
													t = 0.2,
													s = "Back",
													d = "Out",
													g = {
														Size = UDim2.new(0, 13, 0, 13),
													},
												}):Play()
											end)

											if visible then
												StatusTextTextLabel.Text = StatusTextType == "OnOff" and "ON" or "true"
												tw({
													v = StatusTextTextLabel,
													t = 0.2,
													s = "Quad",
													d = "Out",
													g = {
														TextColor3 = Color3.fromRGB(0, 255, 127),
													},
												}):Play()
											end
										else
											Callback(Value)
											tw({
												v = ColorFrame,
												t = 0.25,
												s = "Quad",
												d = "Out",
												g = {
													BackgroundTransparency = 1,
												},
											}):Play()
											tw({
												v = ColorFrameImage,
												t = 0.2,
												s = "Quad",
												d = "Out",
												g = {
													Size = UDim2.new(0, 0, 0, 0),
												},
											}):Play()
											tw({
												v = iconImageLabel,
												t = 0.2,
												s = "Quad",
												d = "Out",
												g = {
													ImageTransparency = 0.4,
												},
											}):Play()

											if visible then
												StatusTextTextLabel.Text = StatusTextType == "OnOff" and "OFF" or "false"
												tw({
													v = StatusTextTextLabel,
													t = 0.2,
													s = "Quad",
													d = "Out",
													g = {
														TextColor3 = Color3.fromRGB(255, 100, 100),
													},
												}):Play()
											end
										end
									end

									local MouseButton1Click2 = toggleImageFrameClick.MouseButton1Click

									value = MouseButton1Click2
									Connect = MouseButton1Click2.Connect
								end
							else
								text = tostring(Value) or ""
								StatusTextTextLabel.Text = text
								color = Value and Color3.fromRGB(0, 255, 127) or Color3.fromRGB(255, 100, 100)
								StatusTextTextLabel.TextColor3 = color
								StatusTextTextLabel.TextSize = 12
								StatusTextTextLabel.TextTransparency = 0
								StatusTextTextLabel.TextXAlignment = Enum.TextXAlignment.Right
								StatusTextTextLabel.Visible = visible
								CheckFrame.Name = "Check"
								CheckFrame.Parent = ToggleImageFrame
								CheckFrame.AnchorPoint = Vector2.new(1, 0.5)
								CheckFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
								CheckFrame.BorderSizePixel = 0
								CheckFrame.Position = UDim2.new(0.95, 0, 0.5, 0)
								CheckFrame.Size = UDim2.new(0, 25, 0, 25)
								CheckFrame.ClipsDescendants = true
								ColorFrame.Name = "ColorFrame"
								ColorFrame.Parent = CheckFrame
								ColorFrame.AnchorPoint = Vector2.new(0.5, 0.5)
								ColorFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
								ColorFrame.BorderSizePixel = 0
								ColorFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
								ColorFrame.Size = UDim2.new(1, 0, 1, 0)
								backgroundTransparency = Value and 0 or 1
								ColorFrame.BackgroundTransparency = backgroundTransparency
								ColorFrameGradient.Parent = ColorFrame
								ColorFrameGradient.Color = ColorSequence.new({
									ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
									ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 170, 255)),
									ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)),
								})
								ColorFrameGradient.Rotation = 48
								ColorFrameCorner.Parent = ColorFrame
								ColorFrameCorner.CornerRadius = UDim.new(0, 5)
								ColorFrameImage.Parent = ColorFrame
								ColorFrameImage.AnchorPoint = Vector2.new(0.5, 0.5)
								ColorFrameImage.BackgroundTransparency = 1
								ColorFrameImage.Position = UDim2.new(0.5, 0, 0.5, 0)
								uDim = Value and UDim2.new(0, 13, 0, 13) or UDim2.new(0, 0, 0, 0)
								ColorFrameImage.Size = uDim
								ColorFrameImage.Image = "rbxassetid://86682186031062"
								ColorFrameImage.ScaleType = Enum.ScaleType.Crop
								CheckFrameCorner.Parent = CheckFrame
								CheckFrameCorner.CornerRadius = UDim.new(0, 5)
								setValue = function(value)
									Value = value

									if Value then
										Callback(Value)
										tw({
											v = ColorFrame,
											t = 0.25,
											s = "Quad",
											d = "Out",
											g = {
												BackgroundTransparency = 0,
											},
										}):Play()
										tw({
											v = ColorFrameImage,
											t = 0.15,
											s = "Back",
											d = "Out",
											g = {
												Size = UDim2.new(0, 18, 0, 18),
											},
										}):Play()
										tw({
											v = iconImageLabel,
											t = 0.2,
											s = "Quad",
											d = "Out",
											g = {
												ImageTransparency = 0,
											},
										}):Play()
										delay(0.08, function()
											tw({
												v = ColorFrameImage,
												t = 0.2,
												s = "Back",
												d = "Out",
												g = {
													Size = UDim2.new(0, 13, 0, 13),
												},
											}):Play()
										end)

										if visible then
											StatusTextTextLabel.Text = StatusTextType == "OnOff" and "ON" or "true"
											tw({
												v = StatusTextTextLabel,
												t = 0.2,
												s = "Quad",
												d = "Out",
												g = {
													TextColor3 = Color3.fromRGB(0, 255, 127),
												},
											}):Play()
										end
									else
										Callback(Value)
										tw({
											v = ColorFrame,
											t = 0.25,
											s = "Quad",
											d = "Out",
											g = {
												BackgroundTransparency = 1,
											},
										}):Play()
										tw({
											v = ColorFrameImage,
											t = 0.2,
											s = "Quad",
											d = "Out",
											g = {
												Size = UDim2.new(0, 0, 0, 0),
											},
										}):Play()
										tw({
											v = iconImageLabel,
											t = 0.2,
											s = "Quad",
											d = "Out",
											g = {
												ImageTransparency = 0.4,
											},
										}):Play()

										if visible then
											StatusTextTextLabel.Text = StatusTextType == "OnOff" and "OFF" or "false"
											tw({
												v = StatusTextTextLabel,
												t = 0.2,
												s = "Quad",
												d = "Out",
												g = {
													TextColor3 = Color3.fromRGB(255, 100, 100),
												},
											}):Play()
										end
									end
								end
								MouseButton1Click = toggleImageFrameClick.MouseButton1Click
								value = MouseButton1Click
								Connect = MouseButton1Click.Connect
							end
						else
							StatusTextTextLabel.Text = ""
							StatusTextTextLabel.TextColor3 = Value and Color3.fromRGB(0, 255, 127)
								or Color3.fromRGB(255, 100, 100)
							StatusTextTextLabel.TextSize = 12
							StatusTextTextLabel.TextTransparency = 0
							StatusTextTextLabel.TextXAlignment = Enum.TextXAlignment.Right
							StatusTextTextLabel.Visible = visible
							CheckFrame.Name = "Check"
							CheckFrame.Parent = ToggleImageFrame
							CheckFrame.AnchorPoint = Vector2.new(1, 0.5)
							CheckFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
							CheckFrame.BorderSizePixel = 0
							CheckFrame.Position = UDim2.new(0.95, 0, 0.5, 0)
							CheckFrame.Size = UDim2.new(0, 25, 0, 25)
							CheckFrame.ClipsDescendants = true
							ColorFrame.Name = "ColorFrame"
							ColorFrame.Parent = CheckFrame
							ColorFrame.AnchorPoint = Vector2.new(0.5, 0.5)
							ColorFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
							ColorFrame.BorderSizePixel = 0
							ColorFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
							ColorFrame.Size = UDim2.new(1, 0, 1, 0)
							ColorFrame.BackgroundTransparency = Value and 0 or 1
							ColorFrameGradient.Parent = ColorFrame
							ColorFrameGradient.Color = ColorSequence.new({
								ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
								ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 170, 255)),
								ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)),
							})
							ColorFrameGradient.Rotation = 48
							ColorFrameCorner.Parent = ColorFrame
							ColorFrameCorner.CornerRadius = UDim.new(0, 5)
							ColorFrameImage.Parent = ColorFrame
							ColorFrameImage.AnchorPoint = Vector2.new(0.5, 0.5)
							ColorFrameImage.BackgroundTransparency = 1
							ColorFrameImage.Position = UDim2.new(0.5, 0, 0.5, 0)
							ColorFrameImage.Size = Value and UDim2.new(0, 13, 0, 13) or UDim2.new(0, 0, 0, 0)
							ColorFrameImage.Image = "rbxassetid://86682186031062"
							ColorFrameImage.ScaleType = Enum.ScaleType.Crop
							CheckFrameCorner.Parent = CheckFrame
							CheckFrameCorner.CornerRadius = UDim.new(0, 5)
							setValue = function(value)
								Value = value

								if Value then
									Callback(Value)
									tw({
										v = ColorFrame,
										t = 0.25,
										s = "Quad",
										d = "Out",
										g = {
											BackgroundTransparency = 0,
										},
									}):Play()
									tw({
										v = ColorFrameImage,
										t = 0.15,
										s = "Back",
										d = "Out",
										g = {
											Size = UDim2.new(0, 18, 0, 18),
										},
									}):Play()
									tw({
										v = iconImageLabel,
										t = 0.2,
										s = "Quad",
										d = "Out",
										g = {
											ImageTransparency = 0,
										},
									}):Play()
									delay(0.08, function()
										tw({
											v = ColorFrameImage,
											t = 0.2,
											s = "Back",
											d = "Out",
											g = {
												Size = UDim2.new(0, 13, 0, 13),
											},
										}):Play()
									end)

									if visible then
										StatusTextTextLabel.Text = StatusTextType == "OnOff" and "ON" or "true"
										tw({
											v = StatusTextTextLabel,
											t = 0.2,
											s = "Quad",
											d = "Out",
											g = {
												TextColor3 = Color3.fromRGB(0, 255, 127),
											},
										}):Play()
									end
								else
									Callback(Value)
									tw({
										v = ColorFrame,
										t = 0.25,
										s = "Quad",
										d = "Out",
										g = {
											BackgroundTransparency = 1,
										},
									}):Play()
									tw({
										v = ColorFrameImage,
										t = 0.2,
										s = "Quad",
										d = "Out",
										g = {
											Size = UDim2.new(0, 0, 0, 0),
										},
									}):Play()
									tw({
										v = iconImageLabel,
										t = 0.2,
										s = "Quad",
										d = "Out",
										g = {
											ImageTransparency = 0.4,
										},
									}):Play()

									if visible then
										StatusTextTextLabel.Text = StatusTextType == "OnOff" and "OFF" or "false"
										tw({
											v = StatusTextTextLabel,
											t = 0.2,
											s = "Quad",
											d = "Out",
											g = {
												TextColor3 = Color3.fromRGB(255, 100, 100),
											},
										}):Play()
									end
								end
							end
							MouseButton1Click = toggleImageFrameClick.MouseButton1Click
							value = MouseButton1Click
							Connect = MouseButton1Click.Connect
						end

						Connect(value, function()
							EffectClick2(toggleImageFrameClick, ToggleImageFrame)
							setValue(not Value)
						end)
						table.insert(SearchItems, {
							Frame = ToggleImageFrame,
							SearchName = title,
							HighlightFrame = HighlightFrameB,
						})

						return {
							SetValue = function(self, value)
								setValue(value)
							end,
							GetValue = function()
								return Value
							end,
							SetTitle = function(self, text)
								TitleTextLabel.Text = text

								for _, v in pairs(SearchItems) do
									if v.Frame ~= ToggleImageFrame then
										continue
									end

									v.SearchName = text

									return
								end
							end,
							SetDesc = function(self, text)
								DescTextLabel.Text = text
							end,
							SetIcon = function(self, icon)
								iconImageLabel.Image = GetIcon(icon)
							end,
							Visible = function(self, visible)
								ToggleImageFrame.Visible = visible
							end,
							SetStatusTextType = function(self, statusTextType)
								StatusTextType = statusTextType

								if visible then
									StatusTextTextLabel.Text = statusTextType == "OnOff" and (Value and "ON" or "OFF") or tostring(Value)
								end
							end,
							ShowStatus = function(self, visibleB)
								visible = visibleB
								StatusTextTextLabel.Visible = visibleB
							end,
						}
					end

					local ToggleFrame = Instance.new("Frame")
					local TitleTextLabel = Instance.new("TextLabel")
					local ToggleFrameCorner = Instance.new("UICorner")
					local ToggleFrameImage = Instance.new("ImageLabel")
					local ToggleFrameImageGradient = Instance.new("UIGradient")
					local CheckFrame = Instance.new("Frame")
					local ColorFrame = Instance.new("Frame")
					local ColorFrameGradient = Instance.new("UIGradient")
					local ColorFrameCorner = Instance.new("UICorner")
					local ColorFrameImage = Instance.new("ImageLabel")
					local CheckFrameCorner = Instance.new("UICorner")
					local DescTextLabel = Instance.new("TextLabel")

					Instance.new("UIStroke")

					local HighlightFrameB = Instance.new("Frame")
					local HighlightFrameBCorner = Instance.new("UICorner")

					StatusTextTextLabel = Instance.new("TextLabel")

					local toggleFrameClick = click(ToggleFrame)

					ToggleFrame.Name = "Toggle"
					ToggleFrame.Parent = GetColumn(Side)
					ToggleFrame.AnchorPoint = Vector2.new(0.5, 0.5)
					ToggleFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
					ToggleFrame.BackgroundTransparency = 0.2
					ToggleFrame.BorderSizePixel = 0
					ToggleFrame.Size = UDim2.new(0.97, 0, 0, 55)
					ToggleFrame.ClipsDescendants = true
					HighlightFrameB.Name = "HighlightFrame"
					HighlightFrameB.Parent = ToggleFrame
					HighlightFrameB.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					HighlightFrameB.BackgroundTransparency = 1
					HighlightFrameB.Size = UDim2.new(1, 0, 1, 0)
					HighlightFrameB.ZIndex = 2
					HighlightFrameBCorner.CornerRadius = UDim.new(0, 12)
					HighlightFrameBCorner.Parent = HighlightFrameB
					TitleTextLabel.Name = "Title"
					TitleTextLabel.Parent = ToggleFrame
					TitleTextLabel.AnchorPoint = Vector2.new(0, 0.5)
					TitleTextLabel.BackgroundTransparency = 1
					TitleTextLabel.Position = UDim2.new(0.03, 0, 0.35, 0)
					TitleTextLabel.Size = UDim2.new(0.62, 0, 0, 18)
					TitleTextLabel.Font = Enum.Font.GothamBold
					TitleTextLabel.RichText = true
					TitleTextLabel.Text = title
					TitleTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
					TitleTextLabel.TextSize = 14
					TitleTextLabel.TextTransparency = 0
					TitleTextLabel.TextXAlignment = Enum.TextXAlignment.Left
					TitleTextLabel.TextScaled = true
					TitleTextLabel.TextWrapped = true

					local TitleTextLabelTextConstraint = Instance.new("UITextSizeConstraint")

					TitleTextLabelTextConstraint.Parent = TitleTextLabel
					TitleTextLabelTextConstraint.MaxTextSize = 14
					TitleTextLabelTextConstraint.MinTextSize = 10
					ToggleFrameCorner.Parent = ToggleFrame
					ToggleFrameCorner.CornerRadius = UDim.new(0, 12)
					ToggleFrameImage.Parent = ToggleFrame
					ToggleFrameImage.AnchorPoint = Vector2.new(0.5, 0.5)
					ToggleFrameImage.BackgroundTransparency = 1
					ToggleFrameImage.Position = UDim2.new(0.5, 0, 0.5, 0)
					ToggleFrameImage.Size = UDim2.new(1, 50, 1, 0)
					ToggleFrameImage.Image = "rbxassetid://72380279434385"
					ToggleFrameImage.ImageTransparency = 0.9
					ToggleFrameImage.ScaleType = Enum.ScaleType.Crop
					ToggleFrameImageGradient.Parent = ToggleFrameImage
					ToggleFrameImageGradient.Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
						ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 170, 255)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)),
					})
					StatusTextTextLabel.Name = "StatusText"
					StatusTextTextLabel.Parent = ToggleFrame
					StatusTextTextLabel.AnchorPoint = Vector2.new(1, 0.5)
					StatusTextTextLabel.BackgroundTransparency = 1
					StatusTextTextLabel.Position = UDim2.new(0.95, -38, 0.5, 0)
					StatusTextTextLabel.Size = UDim2.new(0, 60, 0, 20)
					StatusTextTextLabel.Font = Enum.Font.GothamBold
					StatusTextTextLabel.Text = visible
							and (StatusTextType == "Idk" and (Value and "True" or "False") or tostring(Value))
						or ""
					StatusTextTextLabel.TextColor3 = Value and Color3.fromRGB(0, 255, 127) or Color3.fromRGB(255, 100, 100)
					StatusTextTextLabel.TextSize = 12
					StatusTextTextLabel.TextTransparency = 0
					StatusTextTextLabel.TextXAlignment = Enum.TextXAlignment.Right
					StatusTextTextLabel.Visible = visible
					CheckFrame.Name = "Check"
					CheckFrame.Parent = ToggleFrame
					CheckFrame.AnchorPoint = Vector2.new(1, 0.5)
					CheckFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
					CheckFrame.BorderSizePixel = 0
					CheckFrame.Position = UDim2.new(0.95, 0, 0.5, 0)
					CheckFrame.Size = UDim2.new(0, 25, 0, 25)
					CheckFrame.ClipsDescendants = true
					ColorFrame.Name = "ColorFrame"
					ColorFrame.Parent = CheckFrame
					ColorFrame.AnchorPoint = Vector2.new(0.5, 0.5)
					ColorFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					ColorFrame.BorderSizePixel = 0
					ColorFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
					ColorFrame.Size = UDim2.new(1, 0, 1, 0)
					ColorFrame.BackgroundTransparency = Value and 0 or 1
					ColorFrameGradient.Parent = ColorFrame
					ColorFrameGradient.Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
						ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 170, 255)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)),
					})
					ColorFrameGradient.Rotation = 48
					ColorFrameCorner.Parent = ColorFrame
					ColorFrameCorner.CornerRadius = UDim.new(0, 5)
					ColorFrameImage.Parent = ColorFrame
					ColorFrameImage.AnchorPoint = Vector2.new(0.5, 0.5)
					ColorFrameImage.BackgroundTransparency = 1
					ColorFrameImage.Position = UDim2.new(0.5, 0, 0.5, 0)
					ColorFrameImage.Size = Value and UDim2.new(0, 13, 0, 13) or UDim2.new(0, 0, 0, 0)
					ColorFrameImage.Image = "rbxassetid://86682186031062"
					ColorFrameImage.ScaleType = Enum.ScaleType.Crop
					CheckFrameCorner.Parent = CheckFrame
					CheckFrameCorner.CornerRadius = UDim.new(0, 5)
					DescTextLabel.Name = "Desc"
					DescTextLabel.Parent = ToggleFrame
					DescTextLabel.AnchorPoint = Vector2.new(0, 0.5)
					DescTextLabel.BackgroundTransparency = 1
					DescTextLabel.Position = UDim2.new(0.03, 0, 0.68, 0)
					DescTextLabel.Size = UDim2.new(0.62, 0, 0, 15)
					DescTextLabel.Font = Enum.Font.Gotham
					DescTextLabel.RichText = true
					DescTextLabel.Text = desc
					DescTextLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
					DescTextLabel.TextSize = 11
					DescTextLabel.TextTransparency = 0.3
					DescTextLabel.TextXAlignment = Enum.TextXAlignment.Left
					DescTextLabel.TextScaled = true
					DescTextLabel.TextWrapped = true

					local DescTextLabelTextConstraint = Instance.new("UITextSizeConstraint")

					DescTextLabelTextConstraint.Parent = DescTextLabel
					DescTextLabelTextConstraint.MaxTextSize = 11
					DescTextLabelTextConstraint.MinTextSize = 8

					local function helper(self)
						Value = self

						if Value then
							Callback(Value)
							tw({
								v = ColorFrame,
								t = 0.25,
								s = "Quad",
								d = "Out",
								g = {
									BackgroundTransparency = 0,
								},
							}):Play()
							tw({
								v = ColorFrameImage,
								t = 0.15,
								s = "Back",
								d = "Out",
								g = {
									Size = UDim2.new(0, 18, 0, 18),
								},
							}):Play()
							delay(0.08, function()
								tw({
									v = ColorFrameImage,
									t = 0.2,
									s = "Back",
									d = "Out",
									g = {
										Size = UDim2.new(0, 13, 0, 13),
									},
								}):Play()
							end)

							if visible then
								StatusTextTextLabel.Text = StatusTextType == "OnOff" and "ON" or "true"
								tw({
									v = StatusTextTextLabel,
									t = 0.2,
									s = "Quad",
									d = "Out",
									g = {
										TextColor3 = Color3.fromRGB(0, 255, 127),
									},
								}):Play()
							end
						else
							Callback(Value)
							tw({
								v = ColorFrame,
								t = 0.25,
								s = "Quad",
								d = "Out",
								g = {
									BackgroundTransparency = 1,
								},
							}):Play()
							tw({
								v = ColorFrameImage,
								t = 0.2,
								s = "Quad",
								d = "Out",
								g = {
									Size = UDim2.new(0, 0, 0, 0),
								},
							}):Play()

							if visible then
								StatusTextTextLabel.Text = StatusTextType == "OnOff" and "OFF" or "false"
								tw({
									v = StatusTextTextLabel,
									t = 0.2,
									s = "Quad",
									d = "Out",
									g = {
										TextColor3 = Color3.fromRGB(255, 100, 100),
									},
								}):Play()
							end
						end
					end

					toggleFrameClick.MouseButton1Click:Connect(function()
						EffectClick2(toggleFrameClick, ToggleFrame)
						helper(not Value)
					end)
					table.insert(SearchItems, {
						Frame = ToggleFrame,
						SearchName = title,
						HighlightFrame = HighlightFrameB,
					})
					items = {
						SetValue = function(self, value)
							helper(value)
						end,
						GetValue = function()
							return Value
						end,
						SetTitle = function(self, text)
							TitleTextLabel.Text = text

							for _, v in pairs(SearchItems) do
								if v.Frame == ToggleFrame then
									v.SearchName = text

									break
								end
							end
						end,
						SetDesc = function(self, text)
							DescTextLabel.Text = text
						end,
						Visible = function(self, visible)
							ToggleFrame.Visible = visible
						end,
					}
					textB = "SetStatusTextType"
					handler = function(_, statusTextType)
						StatusTextType = statusTextType

						if visible then
							StatusTextTextLabel.Text = statusTextType == "OnOff" and (Value and "ON" or "OFF") or tostring(Value)
						end
					end
				else
					local Side = options.Side or "l"
					local Value = options.Value or false
					local Callback = options.Callback or function() end

					visible = options.ShowStatusText ~= false

					local StatusTextType = options.StatusTextType or "TrueFalse"

					number += 1
					BadgeLabelTextLabel.Text = tostring(number)
					tw({
						v = BadgeFrame,
						t = 0.3,
						s = "Back",
						d = "Out",
						g = {
							Size = UDim2.new(0, math.max(32, #tostring(number) * 10 + 12), 0, 18),
						},
					}):Play()

					local ToggleFrame = Instance.new("Frame")
					local TitleTextLabel = Instance.new("TextLabel")
					local ToggleFrameCorner = Instance.new("UICorner")
					local ToggleFrameImage = Instance.new("ImageLabel")
					local ToggleFrameImageGradient = Instance.new("UIGradient")
					local CheckFrame = Instance.new("Frame")
					local ColorFrame = Instance.new("Frame")
					local ColorFrameGradient = Instance.new("UIGradient")
					local ColorFrameCorner = Instance.new("UICorner")
					local ColorFrameImage = Instance.new("ImageLabel")
					local CheckFrameCorner = Instance.new("UICorner")
					local DescTextLabel = Instance.new("TextLabel")

					Instance.new("UIStroke")

					local HighlightFrameB = Instance.new("Frame")
					local HighlightFrameBCorner = Instance.new("UICorner")

					StatusTextTextLabel = Instance.new("TextLabel")

					local toggleFrameClick = click(ToggleFrame)

					ToggleFrame.Name = "Toggle"
					ToggleFrame.Parent = GetColumn(Side)
					ToggleFrame.AnchorPoint = Vector2.new(0.5, 0.5)
					ToggleFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
					ToggleFrame.BackgroundTransparency = 0.2
					ToggleFrame.BorderSizePixel = 0
					ToggleFrame.Size = UDim2.new(0.97, 0, 0, 55)
					ToggleFrame.ClipsDescendants = true
					HighlightFrameB.Name = "HighlightFrame"
					HighlightFrameB.Parent = ToggleFrame
					HighlightFrameB.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					HighlightFrameB.BackgroundTransparency = 1
					HighlightFrameB.Size = UDim2.new(1, 0, 1, 0)
					HighlightFrameB.ZIndex = 2
					HighlightFrameBCorner.CornerRadius = UDim.new(0, 12)
					HighlightFrameBCorner.Parent = HighlightFrameB
					TitleTextLabel.Name = "Title"
					TitleTextLabel.Parent = ToggleFrame
					TitleTextLabel.AnchorPoint = Vector2.new(0, 0.5)
					TitleTextLabel.BackgroundTransparency = 1
					TitleTextLabel.Position = UDim2.new(0.03, 0, 0.35, 0)
					TitleTextLabel.Size = UDim2.new(0.62, 0, 0, 18)
					TitleTextLabel.Font = Enum.Font.GothamBold
					TitleTextLabel.RichText = true
					TitleTextLabel.Text = title
					TitleTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
					TitleTextLabel.TextSize = 14
					TitleTextLabel.TextTransparency = 0
					TitleTextLabel.TextXAlignment = Enum.TextXAlignment.Left
					TitleTextLabel.TextScaled = true
					TitleTextLabel.TextWrapped = true

					local TitleTextLabelTextConstraint = Instance.new("UITextSizeConstraint")

					TitleTextLabelTextConstraint.Parent = TitleTextLabel
					TitleTextLabelTextConstraint.MaxTextSize = 14
					TitleTextLabelTextConstraint.MinTextSize = 10
					ToggleFrameCorner.Parent = ToggleFrame
					ToggleFrameCorner.CornerRadius = UDim.new(0, 12)
					ToggleFrameImage.Parent = ToggleFrame
					ToggleFrameImage.AnchorPoint = Vector2.new(0.5, 0.5)
					ToggleFrameImage.BackgroundTransparency = 1
					ToggleFrameImage.Position = UDim2.new(0.5, 0, 0.5, 0)
					ToggleFrameImage.Size = UDim2.new(1, 50, 1, 0)
					ToggleFrameImage.Image = "rbxassetid://72380279434385"
					ToggleFrameImage.ImageTransparency = 0.9
					ToggleFrameImage.ScaleType = Enum.ScaleType.Crop
					ToggleFrameImageGradient.Parent = ToggleFrameImage
					ToggleFrameImageGradient.Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
						ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 170, 255)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)),
					})
					StatusTextTextLabel.Name = "StatusText"
					StatusTextTextLabel.Parent = ToggleFrame
					StatusTextTextLabel.AnchorPoint = Vector2.new(1, 0.5)
					StatusTextTextLabel.BackgroundTransparency = 1
					StatusTextTextLabel.Position = UDim2.new(0.95, -38, 0.5, 0)
					StatusTextTextLabel.Size = UDim2.new(0, 60, 0, 20)
					StatusTextTextLabel.Font = Enum.Font.GothamBold
					StatusTextTextLabel.Text = visible
							and (StatusTextType == "Idk" and (Value and "True" or "False") or tostring(Value))
						or ""
					StatusTextTextLabel.TextColor3 = Value and Color3.fromRGB(0, 255, 127) or Color3.fromRGB(255, 100, 100)
					StatusTextTextLabel.TextSize = 12
					StatusTextTextLabel.TextTransparency = 0
					StatusTextTextLabel.TextXAlignment = Enum.TextXAlignment.Right
					StatusTextTextLabel.Visible = visible
					CheckFrame.Name = "Check"
					CheckFrame.Parent = ToggleFrame
					CheckFrame.AnchorPoint = Vector2.new(1, 0.5)
					CheckFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
					CheckFrame.BorderSizePixel = 0
					CheckFrame.Position = UDim2.new(0.95, 0, 0.5, 0)
					CheckFrame.Size = UDim2.new(0, 25, 0, 25)
					CheckFrame.ClipsDescendants = true
					ColorFrame.Name = "ColorFrame"
					ColorFrame.Parent = CheckFrame
					ColorFrame.AnchorPoint = Vector2.new(0.5, 0.5)
					ColorFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					ColorFrame.BorderSizePixel = 0
					ColorFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
					ColorFrame.Size = UDim2.new(1, 0, 1, 0)
					ColorFrame.BackgroundTransparency = Value and 0 or 1
					ColorFrameGradient.Parent = ColorFrame
					ColorFrameGradient.Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
						ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 170, 255)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)),
					})
					ColorFrameGradient.Rotation = 48
					ColorFrameCorner.Parent = ColorFrame
					ColorFrameCorner.CornerRadius = UDim.new(0, 5)
					ColorFrameImage.Parent = ColorFrame
					ColorFrameImage.AnchorPoint = Vector2.new(0.5, 0.5)
					ColorFrameImage.BackgroundTransparency = 1
					ColorFrameImage.Position = UDim2.new(0.5, 0, 0.5, 0)
					ColorFrameImage.Size = Value and UDim2.new(0, 13, 0, 13) or UDim2.new(0, 0, 0, 0)
					ColorFrameImage.Image = "rbxassetid://86682186031062"
					ColorFrameImage.ScaleType = Enum.ScaleType.Crop
					CheckFrameCorner.Parent = CheckFrame
					CheckFrameCorner.CornerRadius = UDim.new(0, 5)
					DescTextLabel.Name = "Desc"
					DescTextLabel.Parent = ToggleFrame
					DescTextLabel.AnchorPoint = Vector2.new(0, 0.5)
					DescTextLabel.BackgroundTransparency = 1
					DescTextLabel.Position = UDim2.new(0.03, 0, 0.68, 0)
					DescTextLabel.Size = UDim2.new(0.62, 0, 0, 15)
					DescTextLabel.Font = Enum.Font.Gotham
					DescTextLabel.RichText = true
					DescTextLabel.Text = desc
					DescTextLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
					DescTextLabel.TextSize = 11
					DescTextLabel.TextTransparency = 0.3
					DescTextLabel.TextXAlignment = Enum.TextXAlignment.Left
					DescTextLabel.TextScaled = true
					DescTextLabel.TextWrapped = true

					local DescTextLabelTextConstraint = Instance.new("UITextSizeConstraint")

					DescTextLabelTextConstraint.Parent = DescTextLabel
					DescTextLabelTextConstraint.MaxTextSize = 11
					DescTextLabelTextConstraint.MinTextSize = 8

					local function helper(self)
						Value = self

						if Value then
							Callback(Value)
							tw({
								v = ColorFrame,
								t = 0.25,
								s = "Quad",
								d = "Out",
								g = {
									BackgroundTransparency = 0,
								},
							}):Play()
							tw({
								v = ColorFrameImage,
								t = 0.15,
								s = "Back",
								d = "Out",
								g = {
									Size = UDim2.new(0, 18, 0, 18),
								},
							}):Play()
							delay(0.08, function()
								tw({
									v = ColorFrameImage,
									t = 0.2,
									s = "Back",
									d = "Out",
									g = {
										Size = UDim2.new(0, 13, 0, 13),
									},
								}):Play()
							end)

							if visible then
								StatusTextTextLabel.Text = StatusTextType == "OnOff" and "ON" or "true"
								tw({
									v = StatusTextTextLabel,
									t = 0.2,
									s = "Quad",
									d = "Out",
									g = {
										TextColor3 = Color3.fromRGB(0, 255, 127),
									},
								}):Play()
							end
						else
							Callback(Value)
							tw({
								v = ColorFrame,
								t = 0.25,
								s = "Quad",
								d = "Out",
								g = {
									BackgroundTransparency = 1,
								},
							}):Play()
							tw({
								v = ColorFrameImage,
								t = 0.2,
								s = "Quad",
								d = "Out",
								g = {
									Size = UDim2.new(0, 0, 0, 0),
								},
							}):Play()

							if visible then
								StatusTextTextLabel.Text = StatusTextType == "OnOff" and "OFF" or "false"
								tw({
									v = StatusTextTextLabel,
									t = 0.2,
									s = "Quad",
									d = "Out",
									g = {
										TextColor3 = Color3.fromRGB(255, 100, 100),
									},
								}):Play()
							end
						end
					end

					toggleFrameClick.MouseButton1Click:Connect(function()
						EffectClick2(toggleFrameClick, ToggleFrame)
						helper(not Value)
					end)
					table.insert(SearchItems, {
						Frame = ToggleFrame,
						SearchName = title,
						HighlightFrame = HighlightFrameB,
					})
					items = {
						SetValue = function(self, value)
							helper(value)
						end,
						GetValue = function()
							return Value
						end,
						SetTitle = function(self, text)
							TitleTextLabel.Text = text

							for _, v in pairs(SearchItems) do
								if v.Frame == ToggleFrame then
									v.SearchName = text

									break
								end
							end
						end,
						SetDesc = function(self, text)
							DescTextLabel.Text = text
						end,
						Visible = function(self, visible)
							ToggleFrame.Visible = visible
						end,
					}
					textB = "SetStatusTextType"
					handler = function(_, statusTextType)
						StatusTextType = statusTextType

						if visible then
							StatusTextTextLabel.Text = statusTextType == "OnOff" and (Value and "ON" or "OFF") or tostring(Value)
						end
					end
				end

				items[textB] = handler
				items.ShowStatus = function(self, visibleB)
					visible = visibleB
					StatusTextTextLabel.Visible = visibleB
				end

				return items
			end
		end

		Library.Elements.Discord = function(self, options)
			local Link = options.Link or "discord.gg/example"
			local Side = options.Side or "l"

			number += 1
			BadgeLabelTextLabel.Text = tostring(number)
			tw({
				v = BadgeFrame,
				t = 0.3,
				s = "Back",
				d = "Out",
				g = {
					Size = UDim2.new(0, math.max(32, #tostring(number) * 10 + 12), 0, 18),
				},
			}):Play()

			local DiscordFrame = Instance.new("Frame")
			local DiscordFrameCorner = Instance.new("UICorner")
			local DiscordFrameStroke = Instance.new("UIStroke")
			local DiscordFrameImage = Instance.new("ImageLabel")
			local DiscordFrameGradient = Instance.new("UIGradient")
			local IconImageLabel = Instance.new("ImageLabel")
			local TitleTextLabel = Instance.new("TextLabel")
			local LinkTextLabel = Instance.new("TextLabel")
			local CopyIconImageLabel = Instance.new("ImageLabel")
			local HighlightFrameB = Instance.new("Frame")
			local HighlightFrameBCorner = Instance.new("UICorner")
			local discordFrameClick = click(DiscordFrame)

			DiscordFrame.Name = "Discord"
			DiscordFrame.Parent = GetColumn(Side)
			DiscordFrame.AnchorPoint = Vector2.new(0.5, 0.5)
			DiscordFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			DiscordFrame.BorderSizePixel = 0
			DiscordFrame.Size = UDim2.new(0.97, 0, 0, 65)
			DiscordFrame.ClipsDescendants = true
			DiscordFrameCorner.Parent = DiscordFrame
			DiscordFrameCorner.CornerRadius = UDim.new(0, 12)
			DiscordFrameStroke.Parent = DiscordFrame
			DiscordFrameStroke.Color = Color3.fromRGB(142, 130, 255)
			DiscordFrameStroke.Thickness = 2
			DiscordFrameStroke.Transparency = 0.6
			HighlightFrameB.Name = "HighlightFrame"
			HighlightFrameB.Parent = DiscordFrame
			HighlightFrameB.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			HighlightFrameB.BackgroundTransparency = 1
			HighlightFrameB.Size = UDim2.new(1, 0, 1, 0)
			HighlightFrameB.ZIndex = 2
			HighlightFrameBCorner.CornerRadius = UDim.new(0, 12)
			HighlightFrameBCorner.Parent = HighlightFrameB
			DiscordFrameGradient.Parent = DiscordFrame
			DiscordFrameGradient.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(88, 101, 242)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(114, 137, 218)),
			})
			DiscordFrameGradient.Rotation = 45
			DiscordFrameImage.Parent = DiscordFrame
			DiscordFrameImage.AnchorPoint = Vector2.new(0.5, 0.5)
			DiscordFrameImage.BackgroundTransparency = 1
			DiscordFrameImage.Position = UDim2.new(0.5, 0, 0.5, 0)
			DiscordFrameImage.Size = UDim2.new(1, 50, 1, 0)
			DiscordFrameImage.Image = "rbxassetid://72380279434385"
			DiscordFrameImage.ImageTransparency = 0.85
			DiscordFrameImage.ScaleType = Enum.ScaleType.Crop
			IconImageLabel.Name = "Icon"
			IconImageLabel.Parent = DiscordFrame
			IconImageLabel.AnchorPoint = Vector2.new(0, 0.5)
			IconImageLabel.BackgroundTransparency = 1
			IconImageLabel.Position = UDim2.new(0, 12, 0.5, 0)
			IconImageLabel.Size = UDim2.new(0, 40, 0, 40)
			IconImageLabel.Image = "rbxassetid://94937742565147"
			IconImageLabel.ScaleType = Enum.ScaleType.Fit
			TitleTextLabel.Name = "Title"
			TitleTextLabel.Parent = DiscordFrame
			TitleTextLabel.BackgroundTransparency = 1
			TitleTextLabel.Position = UDim2.new(0, 60, 0, 12)
			TitleTextLabel.Size = UDim2.new(0.65, 0, 0, 18)
			TitleTextLabel.Font = Enum.Font.GothamBold
			TitleTextLabel.Text = "Discord Server"
			TitleTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			TitleTextLabel.TextSize = 15
			TitleTextLabel.TextXAlignment = Enum.TextXAlignment.Left
			TitleTextLabel.TextScaled = true
			TitleTextLabel.TextWrapped = true

			local TitleTextLabelTextConstraint = Instance.new("UITextSizeConstraint")

			TitleTextLabelTextConstraint.Parent = TitleTextLabel
			TitleTextLabelTextConstraint.MaxTextSize = 15
			TitleTextLabelTextConstraint.MinTextSize = 11
			LinkTextLabel.Name = "Link"
			LinkTextLabel.Parent = DiscordFrame
			LinkTextLabel.BackgroundTransparency = 1
			LinkTextLabel.Position = UDim2.new(0, 60, 0, 35)
			LinkTextLabel.Size = UDim2.new(0.6, 0, 0, 16)
			LinkTextLabel.Font = Enum.Font.GothamBold
			LinkTextLabel.Text = Link
			LinkTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			LinkTextLabel.TextSize = 12
			LinkTextLabel.TextTransparency = 0.3
			LinkTextLabel.TextXAlignment = Enum.TextXAlignment.Left
			LinkTextLabel.TextScaled = true
			LinkTextLabel.TextWrapped = true

			local LinkTextLabelTextConstraint = Instance.new("UITextSizeConstraint")

			LinkTextLabelTextConstraint.Parent = LinkTextLabel
			LinkTextLabelTextConstraint.MaxTextSize = 12
			LinkTextLabelTextConstraint.MinTextSize = 8
			CopyIconImageLabel.Name = "CopyIcon"
			CopyIconImageLabel.Parent = DiscordFrame
			CopyIconImageLabel.AnchorPoint = Vector2.new(1, 0.5)
			CopyIconImageLabel.BackgroundTransparency = 1
			CopyIconImageLabel.Position = UDim2.new(0.96, 0, 0.5, 0)
			CopyIconImageLabel.Size = UDim2.new(0, 24, 0, 24)
			CopyIconImageLabel.Image = "rbxassetid://7734053495"
			CopyIconImageLabel.ImageColor3 = Color3.fromRGB(255, 255, 255)
			CopyIconImageLabel.ScaleType = Enum.ScaleType.Fit
			discordFrameClick.MouseEnter:Connect(function()
				tw({
					v = DiscordFrame,
					t = 0.2,
					s = "Quad",
					d = "Out",
					g = {
						Size = UDim2.new(0.97, 0, 0, 70),
					},
				}):Play()
				tw({
					v = DiscordFrameStroke,
					t = 0.2,
					s = "Quad",
					d = "Out",
					g = {
						Transparency = 0.3,
					},
				}):Play()
				tw({
					v = CopyIconImageLabel,
					t = 0.2,
					s = "Back",
					d = "Out",
					g = {
						Size = UDim2.new(0, 28, 0, 28),
					},
				}):Play()
			end)
			discordFrameClick.MouseLeave:Connect(function()
				tw({
					v = DiscordFrame,
					t = 0.2,
					s = "Quad",
					d = "Out",
					g = {
						Size = UDim2.new(0.97, 0, 0, 65),
					},
				}):Play()
				tw({
					v = DiscordFrameStroke,
					t = 0.2,
					s = "Quad",
					d = "Out",
					g = {
						Transparency = 0.6,
					},
				}):Play()
				tw({
					v = CopyIconImageLabel,
					t = 0.2,
					s = "Back",
					d = "Out",
					g = {
						Size = UDim2.new(0, 24, 0, 24),
					},
				}):Play()
			end)
			discordFrameClick.MouseButton1Click:Connect(function()
				pcall(setclipboard, Link)
				EffectClick2(discordFrameClick, DiscordFrame)
				tw({
					v = IconImageLabel,
					t = 0.15,
					s = "Back",
					d = "Out",
					g = {
						Rotation = -15,
					},
				}):Play()
				task.wait(0.1)
				tw({
					v = IconImageLabel,
					t = 0.15,
					s = "Bounce",
					d = "Out",
					g = {
						Rotation = 15,
					},
				}):Play()
				task.wait(0.1)
				tw({
					v = IconImageLabel,
					t = 0.15,
					s = "Back",
					d = "Out",
					g = {
						Rotation = 0,
					},
				}):Play()
				tw({
					v = CopyIconImageLabel,
					t = 0.2,
					s = "Bounce",
					d = "Out",
					g = {
						Size = UDim2.new(0, 32, 0, 32),
					},
				}):Play()
				task.wait(0.1)
				tw({
					v = CopyIconImageLabel,
					t = 0.2,
					s = "Bounce",
					d = "Out",
					g = {
						Size = UDim2.new(0, 24, 0, 24),
					},
				}):Play()

				local DiscordFrameLabel = Instance.new("TextLabel")

				DiscordFrameLabel.Parent = DiscordFrame
				DiscordFrameLabel.AnchorPoint = Vector2.new(0.5, 0.5)
				DiscordFrameLabel.BackgroundTransparency = 1
				DiscordFrameLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
				DiscordFrameLabel.Size = UDim2.new(0, 0, 0, 20)
				DiscordFrameLabel.Font = Enum.Font.GothamBold
				DiscordFrameLabel.Text = ""
				DiscordFrameLabel.TextColor3 = Color3.fromRGB(0, 255, 127)
				DiscordFrameLabel.TextSize = 14
				DiscordFrameLabel.TextTransparency = 1
				DiscordFrameLabel.ZIndex = 10
				tw({
					v = DiscordFrameLabel,
					t = 0.2,
					s = "Back",
					d = "Out",
					g = {
						TextTransparency = 0,
						Size = UDim2.new(0, 80, 0, 20),
					},
				}):Play()
				task.wait(1.5)
				tw({
					v = DiscordFrameLabel,
					t = 0.3,
					s = "Quad",
					d = "Out",
					g = {
						TextTransparency = 1,
					},
				}):Play()
				task.wait(0.3)
				DiscordFrameLabel:Destroy()
			end)
			table.insert(SearchItems, {
				Frame = DiscordFrame,
				SearchName = "Discord",
				HighlightFrame = HighlightFrameB,
			})

			return {
				SetLink = function(self, link)
					Link = link
					LinkTextLabel.Text = link
				end,
				Visible = function(self, visible)
					DiscordFrame.Visible = visible
				end,
			}
		end
		Library.Elements.ThumnailsImage = function(self, options)
			local BannerB = options.Banner or ""
			local TitleB = options.Title or ""
			local SizeY = options.SizeY
			local Side = options.Side or "l"
			local flag = options.ShowTitle ~= false
			local flagB = SizeY == nil

			number += 1
			BadgeLabelTextLabel.Text = tostring(number)
			tw({
				v = BadgeFrame,
				t = 0.3,
				s = "Back",
				d = "Out",
				g = {
					Size = UDim2.new(0, math.max(32, #tostring(number) * 10 + 12), 0, 18),
				},
			}):Play()

			local value = SizeY or 120
			local ImageFrame = Instance.new("Frame")
			local ImageFrameCorner = Instance.new("UICorner")
			local ImageImageLabel = Instance.new("ImageLabel")
			local ImageImageLabelCorner = Instance.new("UICorner")
			local LoadingFrame = Instance.new("Frame")
			local LoadingFrameCorner = Instance.new("UICorner")
			local BarFrame = Instance.new("Frame")
			local BarFrameCorner = Instance.new("UICorner")
			local BarFrameGradient = Instance.new("UIGradient")
			local HighlightFrameB = Instance.new("Frame")
			local HighlightFrameBCorner = Instance.new("UICorner")
			local ClickDetectorTextButton = Instance.new("TextButton")
			local TitleTextLabel

			ImageFrame.Name = "ImageFrame"
			ImageFrame.Parent = GetColumn(Side)
			ImageFrame.AnchorPoint = Vector2.new(0.5, 0.5)
			ImageFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
			ImageFrame.BackgroundTransparency = 0.2
			ImageFrame.BorderSizePixel = 0
			ImageFrame.Size = UDim2.new(0.97, 0, 0, value)
			ImageFrame.ClipsDescendants = true
			ImageFrameCorner.Parent = ImageFrame
			ImageFrameCorner.CornerRadius = UDim.new(0, 12)
			HighlightFrameB.Name = "HighlightFrame"
			HighlightFrameB.Parent = ImageFrame
			HighlightFrameB.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			HighlightFrameB.BackgroundTransparency = 1
			HighlightFrameB.Size = UDim2.new(1, 0, 1, 0)
			HighlightFrameB.ZIndex = 2
			HighlightFrameBCorner.CornerRadius = UDim.new(0, 12)
			HighlightFrameBCorner.Parent = HighlightFrameB
			ImageImageLabel.Name = "Image"
			ImageImageLabel.Parent = ImageFrame
			ImageImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
			ImageImageLabel.BackgroundTransparency = 1
			ImageImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
			ImageImageLabel.Size = UDim2.new(1, 0, 1, 0)
			ImageImageLabel.Image = GetIcon(BannerB)
			ImageImageLabel.ScaleType = Enum.ScaleType.Fit
			ImageImageLabel.ImageTransparency = 1
			ImageImageLabelCorner.Parent = ImageImageLabel
			ImageImageLabelCorner.CornerRadius = UDim.new(0, 12)
			ClickDetectorTextButton.Name = "ClickDetector"
			ClickDetectorTextButton.Parent = ImageFrame
			ClickDetectorTextButton.BackgroundTransparency = 1
			ClickDetectorTextButton.Size = UDim2.new(1, 0, 1, 0)
			ClickDetectorTextButton.Text = ""
			ClickDetectorTextButton.ZIndex = 3
			ClickDetectorTextButton.AutoButtonColor = false

			local UDim2_

			if flag and TitleB ~= "" then
				local TitleBackgroundFrame = Instance.new("Frame")

				TitleBackgroundFrame.Name = "TitleBackground"
				TitleBackgroundFrame.Parent = ImageFrame
				TitleBackgroundFrame.AnchorPoint = Vector2.new(0.5, 1)
				TitleBackgroundFrame.Position = UDim2.new(0.5, 0, 1, 0)
				TitleBackgroundFrame.Size = UDim2.new(1, 0, 0, 35)
				TitleBackgroundFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
				TitleBackgroundFrame.BackgroundTransparency = 0.2
				TitleBackgroundFrame.BorderSizePixel = 0
				TitleBackgroundFrame.ZIndex = 2

				local TitleBackgroundFrameCorner = Instance.new("UICorner")

				TitleBackgroundFrameCorner.Parent = TitleBackgroundFrame
				TitleBackgroundFrameCorner.CornerRadius = UDim.new(0, 12)

				local TitleBackgroundFrameGradient = Instance.new("UIGradient")

				TitleBackgroundFrameGradient.Parent = TitleBackgroundFrame
				TitleBackgroundFrameGradient.Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
					ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 20)),
				})
				TitleBackgroundFrameGradient.Rotation = 90
				TitleBackgroundFrameGradient.Transparency = NumberSequence.new({
					NumberSequenceKeypoint.new(0, 0.3),
					NumberSequenceKeypoint.new(1, 0),
				})
				TitleTextLabel = Instance.new("TextLabel")
				TitleTextLabel.Name = "Title"
				TitleTextLabel.Parent = TitleBackgroundFrame
				TitleTextLabel.AnchorPoint = Vector2.new(0, 0.5)
				TitleTextLabel.BackgroundTransparency = 1
				TitleTextLabel.Position = UDim2.new(0.05, 0, 0.5, 0)
				TitleTextLabel.Size = UDim2.new(0.9, 0, 0.7, 0)
				TitleTextLabel.Font = Enum.Font.GothamBold
				TitleTextLabel.RichText = true
				TitleTextLabel.Text = TitleB
				TitleTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
				TitleTextLabel.TextSize = 13
				TitleTextLabel.TextTransparency = 0
				TitleTextLabel.TextXAlignment = Enum.TextXAlignment.Left
				TitleTextLabel.TextScaled = true
				TitleTextLabel.TextWrapped = true
				TitleTextLabel.ZIndex = 3

				local TitleTextLabelTextConstraint = Instance.new("UITextSizeConstraint")

				TitleTextLabelTextConstraint.Parent = TitleTextLabel
				TitleTextLabelTextConstraint.MaxTextSize = 13
				TitleTextLabelTextConstraint.MinTextSize = 9
				LoadingFrame.Name = "Loading"
				LoadingFrame.Parent = ImageFrame
				LoadingFrame.AnchorPoint = Vector2.new(0.5, 0.5)
				LoadingFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
				LoadingFrame.BackgroundTransparency = 0.3
				UDim2_ = UDim2
			else
				LoadingFrame.Name = "Loading"
				LoadingFrame.Parent = ImageFrame
				LoadingFrame.AnchorPoint = Vector2.new(0.5, 0.5)
				LoadingFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
				LoadingFrame.BackgroundTransparency = 0.3
				UDim2_ = UDim2
			end

			LoadingFrame.Position = UDim2_.new(0.5, 0, 0.5, 0)
			LoadingFrame.Size = UDim2.new(0.7, 0, 0, 4)
			LoadingFrameCorner.Parent = LoadingFrame
			LoadingFrameCorner.CornerRadius = UDim.new(1, 0)
			BarFrame.Name = "Bar"
			BarFrame.Parent = LoadingFrame
			BarFrame.AnchorPoint = Vector2.new(0, 0.5)
			BarFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			BarFrame.Position = UDim2.new(0, 0, 0.5, 0)
			BarFrame.Size = UDim2.new(0, 0, 1, 0)
			BarFrameCorner.Parent = BarFrame
			BarFrameCorner.CornerRadius = UDim.new(1, 0)
			BarFrameGradient.Parent = BarFrame
			BarFrameGradient.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
				ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 170, 255)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)),
			})

			local function helper()
				local FullscreenImageViewerScreenGui = Instance.new("ScreenGui")
				local OverlayFrame = Instance.new("Frame")
				local OverlayButtonTextButton = Instance.new("TextButton")
				local FullImageImageLabel = Instance.new("ImageLabel")
				local FullImageImageLabelCorner = Instance.new("UICorner")
				local InfoLabelTextLabel = Instance.new("TextLabel")
				local ImageSizeLabelTextLabel = Instance.new("TextLabel")

				FullscreenImageViewerScreenGui.Name = "FullscreenImageViewer"
				FullscreenImageViewerScreenGui.Parent = game:GetService("CoreGui")
				FullscreenImageViewerScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
				FullscreenImageViewerScreenGui.DisplayOrder = 999999
				OverlayFrame.Name = "Overlay"
				OverlayFrame.Parent = FullscreenImageViewerScreenGui
				OverlayFrame.BackgroundTransparency = 1
				OverlayFrame.Size = UDim2.new(1, 0, 1, 0)
				OverlayButtonTextButton.Name = "OverlayButton"
				OverlayButtonTextButton.Parent = OverlayFrame
				OverlayButtonTextButton.BackgroundTransparency = 1
				OverlayButtonTextButton.Size = UDim2.new(1, 0, 1, 0)
				OverlayButtonTextButton.Text = ""
				OverlayButtonTextButton.AutoButtonColor = false
				FullImageImageLabel.Name = "FullImage"
				FullImageImageLabel.Parent = OverlayFrame
				FullImageImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
				FullImageImageLabel.BackgroundTransparency = 1
				FullImageImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
				FullImageImageLabel.Size = UDim2.new(0, 0, 0, 0)
				FullImageImageLabel.Image = ImageImageLabel.Image
				FullImageImageLabel.ScaleType = Enum.ScaleType.Fit
				FullImageImageLabel.ImageTransparency = 1
				FullImageImageLabel.ZIndex = 2
				FullImageImageLabelCorner.Parent = FullImageImageLabel
				FullImageImageLabelCorner.CornerRadius = UDim.new(0, 20)
				InfoLabelTextLabel.Name = "InfoLabel"
				InfoLabelTextLabel.Parent = OverlayFrame
				InfoLabelTextLabel.AnchorPoint = Vector2.new(0.5, 1)
				InfoLabelTextLabel.BackgroundTransparency = 1
				InfoLabelTextLabel.Position = UDim2.new(0.5, 0, 1, -20)
				InfoLabelTextLabel.Size = UDim2.new(0, 250, 0, 30)
				InfoLabelTextLabel.Font = Enum.Font.GothamBold
				InfoLabelTextLabel.Text = "Click to close"
				InfoLabelTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
				InfoLabelTextLabel.TextSize = 16
				InfoLabelTextLabel.TextTransparency = 1
				InfoLabelTextLabel.ZIndex = 3
				ImageSizeLabelTextLabel.Name = "ImageSizeLabel"
				ImageSizeLabelTextLabel.Parent = OverlayFrame
				ImageSizeLabelTextLabel.AnchorPoint = Vector2.new(0.5, 0)
				ImageSizeLabelTextLabel.BackgroundTransparency = 1
				ImageSizeLabelTextLabel.Position = UDim2.new(0.5, 0, 0, 20)
				ImageSizeLabelTextLabel.Size = UDim2.new(0, 250, 0, 30)
				ImageSizeLabelTextLabel.Font = Enum.Font.GothamBold
				ImageSizeLabelTextLabel.Text = ""
				ImageSizeLabelTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
				ImageSizeLabelTextLabel.TextSize = 15
				ImageSizeLabelTextLabel.TextTransparency = 1
				ImageSizeLabelTextLabel.ZIndex = 3

				local ContentProvider = game:GetService("ContentProvider")

				task.spawn(function()
					pcall(function()
						ContentProvider:PreloadAsync({ ImageImageLabel.Image })
					end)
				end)
				tw({
					v = FullImageImageLabel,
					t = 0.4,
					s = "Back",
					d = "Out",
					g = {
						Size = UDim2.new(0, OverlayFrame.AbsoluteSize.X * 0.9, 0, OverlayFrame.AbsoluteSize.Y * 0.85),
						ImageTransparency = 0,
					},
				}):Play()
				tw({
					v = InfoLabelTextLabel,
					t = 0.3,
					s = "Quad",
					d = "Out",
					g = {
						TextTransparency = 0.2,
					},
				}):Play()
				task.wait(0.1)

				local X = FullImageImageLabel.AbsoluteSize.X
				local Y = FullImageImageLabel.AbsoluteSize.Y

				if X > 0 and Y > 0 then
					ImageSizeLabelTextLabel.Text = string.format("%d × %d", math.floor(X), math.floor(Y))
					tw({
						v = ImageSizeLabelTextLabel,
						t = 0.3,
						s = "Quad",
						d = "Out",
						g = {
							TextTransparency = 0.4,
						},
					}):Play()
				end

				local function helper()
					tw({
						v = FullImageImageLabel,
						t = 0.3,
						s = "Back",
						d = "In",
						g = {
							ImageTransparency = 1,
							Size = UDim2.new(0, 0, 0, 0),
						},
					}):Play()
					tw({
						v = InfoLabelTextLabel,
						t = 0.2,
						s = "Quad",
						d = "Out",
						g = {
							TextTransparency = 1,
						},
					}):Play()
					tw({
						v = ImageSizeLabelTextLabel,
						t = 0.2,
						s = "Quad",
						d = "Out",
						g = {
							TextTransparency = 1,
						},
					}):Play()
					task.wait(0.3)
					FullscreenImageViewerScreenGui:Destroy()
				end

				OverlayButtonTextButton.MouseButton1Click:Connect(helper)

				local connection

				connection = game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
					if not (input.KeyCode ~= Enum.KeyCode.Escape or gameProcessed) then
						helper()

						if connection then
							connection:Disconnect()
						end
					end
				end)
			end

			if flagB then
				task.spawn(function()
					task.wait(0.1)
					value = math.clamp(GetColumn(Side).AbsoluteSize.X * 0.97 * 0.6, 100, 300)
					ImageFrame.Size = UDim2.new(0.97, 0, 0, value)
				end)
			end

			task.spawn(function()
				for i = 0, 100, 4 do
					tw({
						v = BarFrame,
						t = 0.08,
						s = "Linear",
						d = "Out",
						g = {
							Size = UDim2.new(i / 100, 0, 1, 0),
						},
					}):Play()
					task.wait(0.04)
				end

				tw({
					v = ImageImageLabel,
					t = 0.5,
					s = "Quad",
					d = "Out",
					g = {
						ImageTransparency = 0,
					},
				}):Play()
				tw({
					v = LoadingFrame,
					t = 0.3,
					s = "Quad",
					d = "Out",
					g = {
						BackgroundTransparency = 1,
					},
				}):Play()
				tw({
					v = BarFrame,
					t = 0.3,
					s = "Quad",
					d = "Out",
					g = {
						BackgroundTransparency = 1,
					},
				}):Play()
				task.wait(0.3)
				LoadingFrame:Destroy()
			end)
			ClickDetectorTextButton.MouseEnter:Connect(function()
				tw({
					v = ImageFrame,
					t = 0.2,
					s = "Quad",
					d = "Out",
					g = {
						BackgroundTransparency = 0.1,
					},
				}):Play()
				tw({
					v = ImageImageLabel,
					t = 0.2,
					s = "Quad",
					d = "Out",
					g = {
						Size = UDim2.new(1.03, 0, 1.03, 0),
					},
				}):Play()
			end)
			ClickDetectorTextButton.MouseLeave:Connect(function()
				tw({
					v = ImageFrame,
					t = 0.2,
					s = "Quad",
					d = "Out",
					g = {
						BackgroundTransparency = 0.2,
					},
				}):Play()
				tw({
					v = ImageImageLabel,
					t = 0.2,
					s = "Quad",
					d = "Out",
					g = {
						Size = UDim2.new(1, 0, 1, 0),
					},
				}):Play()
			end)
			ClickDetectorTextButton.MouseButton1Click:Connect(function()
				local RippleFrame = Instance.new("Frame")
				local RippleFrameCorner = Instance.new("UICorner")

				RippleFrame.Name = "Ripple"
				RippleFrame.Parent = ImageFrame
				RippleFrame.AnchorPoint = Vector2.new(0.5, 0.5)
				RippleFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
				RippleFrame.Size = UDim2.new(0, 0, 0, 0)
				RippleFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				RippleFrame.BackgroundTransparency = 0.5
				RippleFrame.ZIndex = 5
				RippleFrameCorner.Parent = RippleFrame
				RippleFrameCorner.CornerRadius = UDim.new(1, 0)
				tw({
					v = RippleFrame,
					t = 0.6,
					s = "Quad",
					d = "Out",
					g = {
						Size = UDim2.new(2.5, 0, 2.5, 0),
						BackgroundTransparency = 1,
					},
				}):Play()
				task.wait(0.6)
				RippleFrame:Destroy()
				helper()
			end)
			table.insert(SearchItems, {
				Frame = ImageFrame,
				SearchName = TitleB ~= "" and TitleB or "Image",
				HighlightFrame = HighlightFrameB,
			})

			return {
				SetImage = function(self, image)
					ImageImageLabel.ImageTransparency = 1
					ImageImageLabel.Image = GetIcon(image)
					tw({
						v = ImageImageLabel,
						t = 0.5,
						s = "Quad",
						d = "Out",
						g = {
							ImageTransparency = 0,
						},
					}):Play()
				end,
				SetHeight = function(self, valueB)
					value = valueB
					tw({
						v = ImageFrame,
						t = 0.3,
						s = "Back",
						d = "Out",
						g = {
							Size = UDim2.new(0.97, 0, 0, valueB),
						},
					}):Play()
				end,
				SetTitle = function(self, text)
					if TitleTextLabel then
						TitleTextLabel.Text = text

						for _, v in pairs(SearchItems) do
							if v.Frame == ImageFrame then
								v.SearchName = text

								break
							end
						end
					end
				end,
				Visible = function(self, visible)
					ImageFrame.Visible = visible
				end,
			}
		end
		Library.Elements.Keybind = function(self, options)
			local TitleB = options.Title or "Keybind"
			local DescB = options.Desc or ""
			local Key = options.Key or Enum.KeyCode.Q
			local Value = options.Value or false
			local Side = options.Side or "l"
			local Callback = options.Callback or function() end
			local Mode = options.Mode or "Toggle"

			number += 1
			BadgeLabelTextLabel.Text = tostring(number)
			tw({
				v = BadgeFrame,
				t = 0.3,
				s = "Back",
				d = "Out",
				g = {
					Size = UDim2.new(0, math.max(32, #tostring(number) * 10 + 12), 0, 18),
				},
			}):Play()

			local KeybindFrame = Instance.new("Frame")
			local KeybindFrameCorner = Instance.new("UICorner")
			local KeybindFrameImage = Instance.new("ImageLabel")
			local KeybindFrameImageGradient = Instance.new("UIGradient")
			local TitleTextLabel = Instance.new("TextLabel")
			local DescTextLabel = Instance.new("TextLabel")
			local StatusTextTextLabel = Instance.new("TextLabel")
			local KeyDisplayFrame = Instance.new("Frame")
			local KeyDisplayFrameCorner = Instance.new("UICorner")
			local KeyDisplayFrameGradient = Instance.new("UIGradient")
			local KeyTextTextLabel = Instance.new("TextLabel")
			local KeyIconImageLabel = Instance.new("ImageLabel")
			local ModeButtonTextButton = Instance.new("TextButton")
			local ModeButtonTextButtonCorner = Instance.new("UICorner")
			local ModeTextTextLabel = Instance.new("TextLabel")
			local HighlightFrame = Instance.new("Frame")
			local HighlightFrameCorner = Instance.new("UICorner")
			local keybindFrameClick = click(KeybindFrame)

			KeybindFrame.Name = "Keybind"
			KeybindFrame.Parent = GetColumn(Side)
			KeybindFrame.AnchorPoint = Vector2.new(0.5, 0.5)
			KeybindFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
			KeybindFrame.BackgroundTransparency = 0.2
			KeybindFrame.BorderSizePixel = 0
			KeybindFrame.Size = UDim2.new(0.97, 0, 0, DescB ~= "" and 70 or 55)
			KeybindFrame.ClipsDescendants = true
			KeybindFrameCorner.Parent = KeybindFrame
			KeybindFrameCorner.CornerRadius = UDim.new(0, 12)
			HighlightFrame.Name = "HighlightFrame"
			HighlightFrame.Parent = KeybindFrame
			HighlightFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			HighlightFrame.BackgroundTransparency = 1
			HighlightFrame.Size = UDim2.new(1, 0, 1, 0)
			HighlightFrame.ZIndex = 2
			HighlightFrameCorner.CornerRadius = UDim.new(0, 12)
			HighlightFrameCorner.Parent = HighlightFrame
			KeybindFrameImage.Parent = KeybindFrame
			KeybindFrameImage.AnchorPoint = Vector2.new(0.5, 0.5)
			KeybindFrameImage.BackgroundTransparency = 1
			KeybindFrameImage.Position = UDim2.new(0.5, 0, 0.5, 0)
			KeybindFrameImage.Size = UDim2.new(1, 50, 1, 0)
			KeybindFrameImage.Image = "rbxassetid://72380279434385"
			KeybindFrameImage.ImageTransparency = 0.9
			KeybindFrameImage.ScaleType = Enum.ScaleType.Crop
			KeybindFrameImageGradient.Parent = KeybindFrameImage
			KeybindFrameImageGradient.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
				ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 170, 255)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)),
			})
			TitleTextLabel.Name = "Title"
			TitleTextLabel.Parent = KeybindFrame
			TitleTextLabel.BackgroundTransparency = 1
			TitleTextLabel.Position = UDim2.new(0.04, 0, 0, 10)
			TitleTextLabel.Size = UDim2.new(0.5, 0, 0, 18)
			TitleTextLabel.Font = Enum.Font.GothamBold
			TitleTextLabel.Text = TitleB
			TitleTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			TitleTextLabel.TextSize = 14
			TitleTextLabel.TextTransparency = 0
			TitleTextLabel.TextXAlignment = Enum.TextXAlignment.Left
			TitleTextLabel.TextScaled = true
			TitleTextLabel.TextWrapped = true

			local TitleTextLabelTextConstraint = Instance.new("UITextSizeConstraint")

			TitleTextLabelTextConstraint.Parent = TitleTextLabel
			TitleTextLabelTextConstraint.MaxTextSize = 14
			TitleTextLabelTextConstraint.MinTextSize = 10
			StatusTextTextLabel.Name = "StatusText"
			StatusTextTextLabel.Parent = KeybindFrame
			StatusTextTextLabel.AnchorPoint = Vector2.new(0, 0.5)
			StatusTextTextLabel.BackgroundTransparency = 1
			StatusTextTextLabel.Position = UDim2.new(0.04, 0, 0, 32)
			StatusTextTextLabel.Size = UDim2.new(0.5, 0, 0, 14)
			StatusTextTextLabel.Font = Enum.Font.GothamBold
			StatusTextTextLabel.Text = Value and "On" or "Off"
			StatusTextTextLabel.TextColor3 = Value and Color3.fromRGB(0, 255, 127) or Color3.fromRGB(255, 100, 100)
			StatusTextTextLabel.TextSize = 11
			StatusTextTextLabel.TextTransparency = 0
			StatusTextTextLabel.TextXAlignment = Enum.TextXAlignment.Left

			if DescB ~= "" then
				DescTextLabel.Name = "Desc"
				DescTextLabel.Parent = KeybindFrame
				DescTextLabel.BackgroundTransparency = 1
				DescTextLabel.Position = UDim2.new(0.04, 0, 1, -20)
				DescTextLabel.Size = UDim2.new(0.92, 0, 0, 14)
				DescTextLabel.Font = Enum.Font.Gotham
				DescTextLabel.Text = DescB
				DescTextLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
				DescTextLabel.TextSize = 12
				DescTextLabel.TextTransparency = 0.3
				DescTextLabel.TextXAlignment = Enum.TextXAlignment.Left
				DescTextLabel.TextScaled = true
				DescTextLabel.TextWrapped = true

				local DescTextLabelTextConstraint = Instance.new("UITextSizeConstraint")

				DescTextLabelTextConstraint.Parent = DescTextLabel
				DescTextLabelTextConstraint.MaxTextSize = 12
				DescTextLabelTextConstraint.MinTextSize = 9
			end

			ModeButtonTextButton.Name = "ModeButton"
			ModeButtonTextButton.Parent = KeybindFrame
			ModeButtonTextButton.AnchorPoint = Vector2.new(1, 0)
			ModeButtonTextButton.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
			ModeButtonTextButton.BackgroundTransparency = 0.3
			ModeButtonTextButton.Position = UDim2.new(0.96, 0, 0, 8)
			ModeButtonTextButton.Size = UDim2.new(0, 70, 0, 20)
			ModeButtonTextButton.Text = ""
			ModeButtonTextButton.AutoButtonColor = false
			ModeButtonTextButtonCorner.Parent = ModeButtonTextButton
			ModeButtonTextButtonCorner.CornerRadius = UDim.new(0, 6)
			ModeTextTextLabel.Name = "ModeText"
			ModeTextTextLabel.Parent = ModeButtonTextButton
			ModeTextTextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
			ModeTextTextLabel.BackgroundTransparency = 1
			ModeTextTextLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
			ModeTextTextLabel.Size = UDim2.new(0.9, 0, 0.8, 0)
			ModeTextTextLabel.Font = Enum.Font.GothamBold
			ModeTextTextLabel.Text = Mode
			ModeTextTextLabel.TextColor3 = Color3.fromRGB(200, 200, 220)
			ModeTextTextLabel.TextSize = 10
			ModeTextTextLabel.TextScaled = true

			local ModeTextTextLabelTextConstraint = Instance.new("UITextSizeConstraint")

			ModeTextTextLabelTextConstraint.Parent = ModeTextTextLabel
			ModeTextTextLabelTextConstraint.MaxTextSize = 10
			ModeTextTextLabelTextConstraint.MinTextSize = 7
			KeyDisplayFrame.Name = "KeyDisplay"
			KeyDisplayFrame.Parent = KeybindFrame
			KeyDisplayFrame.AnchorPoint = Vector2.new(1, 0)
			KeyDisplayFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			KeyDisplayFrame.BackgroundTransparency = 0.85
			KeyDisplayFrame.Position = UDim2.new(0.96, 0, 0, 32)
			KeyDisplayFrame.Size = UDim2.new(0, 55, 0, 28)
			KeyDisplayFrameCorner.Parent = KeyDisplayFrame
			KeyDisplayFrameCorner.CornerRadius = UDim.new(0, 8)
			KeyDisplayFrameGradient.Parent = KeyDisplayFrame
			KeyDisplayFrameGradient.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
				ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 170, 255)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)),
			})
			KeyDisplayFrameGradient.Rotation = 45
			KeyIconImageLabel.Name = "KeyIcon"
			KeyIconImageLabel.Parent = KeyDisplayFrame
			KeyIconImageLabel.AnchorPoint = Vector2.new(0, 0.5)
			KeyIconImageLabel.BackgroundTransparency = 1
			KeyIconImageLabel.Position = UDim2.new(0.08, 0, 0.5, 0)
			KeyIconImageLabel.Size = UDim2.new(0, 14, 0, 14)
			KeyIconImageLabel.Image = "rbxassetid://10723407389"
			KeyIconImageLabel.ImageColor3 = Color3.fromRGB(255, 255, 255)
			KeyIconImageLabel.ImageTransparency = 0
			KeyTextTextLabel.Name = "KeyText"
			KeyTextTextLabel.Parent = KeyDisplayFrame
			KeyTextTextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
			KeyTextTextLabel.BackgroundTransparency = 1
			KeyTextTextLabel.Position = UDim2.new(0.6, 0, 0.5, 0)
			KeyTextTextLabel.Size = UDim2.new(0.65, 0, 0.7, 0)
			KeyTextTextLabel.Font = Enum.Font.GothamBold
			KeyTextTextLabel.Text = tostring(Key):gsub("Enum.KeyCode.", "")
			KeyTextTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			KeyTextTextLabel.TextSize = 13
			KeyTextTextLabel.TextScaled = true

			local KeyTextTextLabelTextConstraint = Instance.new("UITextSizeConstraint")

			KeyTextTextLabelTextConstraint.Parent = KeyTextTextLabel
			KeyTextTextLabelTextConstraint.MaxTextSize = 13
			KeyTextTextLabelTextConstraint.MinTextSize = 8

			local function helper()
				KeyDisplayFrame.Size = UDim2.new(
					0,
					math.max(
						game:GetService("TextService")
							:GetTextSize(KeyTextTextLabel.Text, 13, KeyTextTextLabel.Font, Vector2.new(1000, 1000)).X + 28,
						45
					),
					0,
					28
				)
			end

			helper()

			local flag = false

			local function helperB()
				if flag then
					return
				end

				flag = true
				KeyTextTextLabel.Text = "..."
				KeyIconImageLabel.ImageTransparency = 0.5
				helper()
				tw({
					v = KeyDisplayFrame,
					t = 0.2,
					s = "Back",
					d = "Out",
					g = {
						BackgroundTransparency = 0.7,
						Size = UDim2.new(0, KeyDisplayFrame.Size.X.Offset + 5, 0, 31),
					},
				}):Play()

				local connection

				connection = UserInputService.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.Keyboard then
						Key = input.KeyCode
						KeyTextTextLabel.Text = tostring(Key):gsub("Enum.KeyCode.", "")
						KeyIconImageLabel.ImageTransparency = 0
						helper()
						tw({
							v = KeyDisplayFrame,
							t = 0.2,
							s = "Back",
							d = "Out",
							g = {
								BackgroundTransparency = 0.85,
								Size = UDim2.new(0, KeyDisplayFrame.Size.X.Offset, 0, 28),
							},
						}):Play()
						connection:Disconnect()
						flag = false
						pcall(Callback, Key, Value, Mode)
					end
				end)
			end
			local function helperC(self)
				Value = self
				StatusTextTextLabel.Text = Value and "On" or "Off"
				tw({
					v = StatusTextTextLabel,
					t = 0.2,
					s = "Quad",
					d = "Out",
					g = {
						TextColor3 = Value and Color3.fromRGB(0, 255, 127) or Color3.fromRGB(255, 100, 100),
					},
				}):Play()

				if Value then
					tw({
						v = KeyDisplayFrame,
						t = 0.15,
						s = "Back",
						d = "Out",
						g = {
							BackgroundTransparency = 0.75,
						},
					}):Play()
					tw({
						v = KeyIconImageLabel,
						t = 0.15,
						s = "Back",
						d = "Out",
						g = {
							Size = UDim2.new(0, 16, 0, 16),
						},
					}):Play()
					task.wait(0.08)
					tw({
						v = KeyIconImageLabel,
						t = 0.15,
						s = "Back",
						d = "Out",
						g = {
							Size = UDim2.new(0, 14, 0, 14),
						},
					}):Play()
				else
					tw({
						v = KeyDisplayFrame,
						t = 0.2,
						s = "Quad",
						d = "Out",
						g = {
							BackgroundTransparency = 0.85,
						},
					}):Play()
				end
			end

			UserInputService.InputBegan:Connect(function(input, gameProcessed)
				if not (gameProcessed or input.KeyCode ~= Key or flag) then
					if Mode == "Toggle" then
						helperC(not Value)
						pcall(Callback, Key, Value, Mode)
					elseif Mode == "Hold" then
						helperC(true)
						pcall(Callback, Key, true, Mode)
					end
				end
			end)

			if Mode == "Hold" then
				UserInputService.InputEnded:Connect(function(input)
					if not (input.KeyCode ~= Key or flag) then
						helperC(false)
						pcall(Callback, Key, false, Mode)
					end
				end)
			end

			ModeButtonTextButton.MouseButton1Click:Connect(function()
				local flag = Mode == "Toggle" and "Hold"

				Mode = flag or "Toggle"
				ModeTextTextLabel.Text = Mode
				tw({
					v = ModeButtonTextButton,
					t = 0.2,
					s = "Back",
					d = "Out",
					g = {
						BackgroundTransparency = 0.1,
					},
				}):Play()
				task.wait(0.1)
				tw({
					v = ModeButtonTextButton,
					t = 0.2,
					s = "Back",
					d = "Out",
					g = {
						BackgroundTransparency = 0.3,
					},
				}):Play()
				pcall(Callback, Key, Value, Mode)
			end)
			ModeButtonTextButton.MouseEnter:Connect(function()
				tw({
					v = ModeButtonTextButton,
					t = 0.15,
					s = "Quad",
					d = "Out",
					g = {
						BackgroundTransparency = 0.2,
					},
				}):Play()
			end)
			ModeButtonTextButton.MouseLeave:Connect(function()
				tw({
					v = ModeButtonTextButton,
					t = 0.15,
					s = "Quad",
					d = "Out",
					g = {
						BackgroundTransparency = 0.3,
					},
				}):Play()
			end)
			keybindFrameClick.MouseButton1Click:Connect(function()
				EffectClick2(keybindFrameClick, KeybindFrame)
				helperB()
			end)

			return {
				SetKey = function(self, key)
					Key = key
					KeyTextTextLabel.Text = tostring(Key):gsub("Enum.KeyCode.", "")
					helper()
				end,
				GetKey = function()
					return Key
				end,
				SetValue = function(self, value)
					helperC(value)
				end,
				GetValue = function()
					return Value
				end,
				SetMode = function(self, mode)
					Mode = mode
					ModeTextTextLabel.Text = Mode
				end,
				GetMode = function()
					return Mode
				end,
				SetTitle = function(self, text)
					TitleTextLabel.Text = text
				end,
				SetDesc = function(self, text)
					if DescTextLabel then
						DescTextLabel.Text = text
					end
				end,
				Visible = function(self, visible)
					KeybindFrame.Visible = visible
				end,
			}
		end
		Library.Elements.Textbox = function(self, options)
			local TitleB = options.Title or "My Textbox"
			local DescB = options.Desc or "Description"
			local Value = options.Value or ""
			local PlaceHolder = options.PlaceHolder or "Enter text here..."
			local ClearOnFocus = options.ClearOnFocus or true
			local Side = options.Side or "l"
			local Callback = options.Callback or function() end

			number += 1
			BadgeLabelTextLabel.Text = tostring(number)
			tw({
				v = BadgeFrame,
				t = 0.3,
				s = "Back",
				d = "Out",
				g = {
					Size = UDim2.new(0, math.max(32, #tostring(number) * 10 + 12), 0, 18),
				},
			}):Play()

			local TextboxFrame = Instance.new("Frame")
			local TextboxFrameCorner = Instance.new("UICorner")
			local TextboxFrameStroke = Instance.new("UIStroke")
			local TextboxFrameImage = Instance.new("ImageLabel")
			local TextboxFrameImageGradient = Instance.new("UIGradient")
			local TitleTextLabel = Instance.new("TextLabel")
			local DescTextLabel = Instance.new("TextLabel")
			local InputFrame = Instance.new("Frame")
			local InputFrameCorner = Instance.new("UICorner")
			local InputFrameStroke = Instance.new("UIStroke")
			local InputFrameStrokeGradient = Instance.new("UIGradient")
			local EditTextBox = Instance.new("TextBox")
			local FocusGlowImageLabel = Instance.new("ImageLabel")
			local HighlightFrameB = Instance.new("Frame")
			local HighlightFrameBCorner = Instance.new("UICorner")

			TextboxFrame.Name = "Textbox"
			TextboxFrame.Parent = GetColumn(Side)
			TextboxFrame.AnchorPoint = Vector2.new(0.5, 0.5)
			TextboxFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
			TextboxFrame.BackgroundTransparency = 0.35
			TextboxFrame.BorderSizePixel = 0
			TextboxFrame.Size = UDim2.new(0.97, 0, 0, DescB ~= "" and 85 or 60)
			TextboxFrame.ClipsDescendants = true
			TextboxFrameCorner.Parent = TextboxFrame
			TextboxFrameCorner.CornerRadius = UDim.new(0, 12)
			TextboxFrameStroke.Parent = TextboxFrame
			TextboxFrameStroke.Color = Color3.fromRGB(110, 110, 140)
			TextboxFrameStroke.Thickness = 2
			TextboxFrameStroke.Transparency = 0.75
			HighlightFrameB.Name = "HighlightFrame"
			HighlightFrameB.Parent = TextboxFrame
			HighlightFrameB.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			HighlightFrameB.BackgroundTransparency = 1
			HighlightFrameB.Size = UDim2.new(1, 0, 1, 0)
			HighlightFrameB.ZIndex = 2
			HighlightFrameBCorner.CornerRadius = UDim.new(0, 12)
			HighlightFrameBCorner.Parent = HighlightFrameB
			TextboxFrameImage.Parent = TextboxFrame
			TextboxFrameImage.AnchorPoint = Vector2.new(0.5, 0.5)
			TextboxFrameImage.BackgroundTransparency = 1
			TextboxFrameImage.Position = UDim2.new(0.5, 0, 0.5, 0)
			TextboxFrameImage.Size = UDim2.new(1, 50, 1, 0)
			TextboxFrameImage.Image = "rbxassetid://72380279434385"
			TextboxFrameImage.ImageTransparency = 0.85
			TextboxFrameImage.ScaleType = Enum.ScaleType.Crop
			TextboxFrameImageGradient.Parent = TextboxFrameImage
			TextboxFrameImageGradient.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
				ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 170, 255)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)),
			})
			TitleTextLabel.Name = "Title"
			TitleTextLabel.Parent = TextboxFrame
			TitleTextLabel.BackgroundTransparency = 1
			TitleTextLabel.Position = UDim2.new(0.04, 0, 0, 8)
			TitleTextLabel.Size = UDim2.new(0.92, 0, 0, 18)
			TitleTextLabel.Font = Enum.Font.GothamBold
			TitleTextLabel.Text = TitleB
			TitleTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			TitleTextLabel.TextSize = 14
			TitleTextLabel.TextXAlignment = Enum.TextXAlignment.Left
			TitleTextLabel.TextScaled = true
			TitleTextLabel.TextWrapped = true

			local TitleTextLabelTextConstraint = Instance.new("UITextSizeConstraint")

			TitleTextLabelTextConstraint.Parent = TitleTextLabel
			TitleTextLabelTextConstraint.MaxTextSize = 14
			TitleTextLabelTextConstraint.MinTextSize = 10

			if DescB == "" then
				InputFrame.Name = "InputFrame"
				InputFrame.Parent = TextboxFrame
				InputFrame.AnchorPoint = Vector2.new(0.5, 1)
				InputFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				InputFrame.BackgroundTransparency = 0.92
				InputFrame.Position = UDim2.new(0.5, 0, 1, -8)
				InputFrame.Size = UDim2.new(0.92, 0, 0, 32)
				InputFrameCorner.Parent = InputFrame
				InputFrameCorner.CornerRadius = UDim.new(0, 8)
				InputFrameStroke.Parent = InputFrame
				InputFrameStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
				InputFrameStroke.Color = Color3.fromRGB(255, 255, 255)
				InputFrameStroke.Thickness = 1.5
				InputFrameStroke.Transparency = 0.7
				InputFrameStrokeGradient.Parent = InputFrameStroke
				InputFrameStrokeGradient.Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
					ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 170, 255)),
					ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)),
				})
				FocusGlowImageLabel.Name = "FocusGlow"
				FocusGlowImageLabel.Parent = InputFrame
				FocusGlowImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
				FocusGlowImageLabel.BackgroundTransparency = 1
				FocusGlowImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
			else
				DescTextLabel.Name = "Desc"
				DescTextLabel.Parent = TextboxFrame
				DescTextLabel.BackgroundTransparency = 1
				DescTextLabel.Position = UDim2.new(0.04, 0, 0, 28)
				DescTextLabel.Size = UDim2.new(0.92, 0, 0, 14)
				DescTextLabel.Font = Enum.Font.Gotham
				DescTextLabel.Text = DescB
				DescTextLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
				DescTextLabel.TextSize = 11
				DescTextLabel.TextTransparency = 0.4
				DescTextLabel.TextXAlignment = Enum.TextXAlignment.Left
				DescTextLabel.TextScaled = true
				DescTextLabel.TextWrapped = true

				local DescTextLabelTextConstraint = Instance.new("UITextSizeConstraint")

				DescTextLabelTextConstraint.Parent = DescTextLabel
				DescTextLabelTextConstraint.MaxTextSize = 11
				DescTextLabelTextConstraint.MinTextSize = 8
				InputFrame.Name = "InputFrame"
				InputFrame.Parent = TextboxFrame
				InputFrame.AnchorPoint = Vector2.new(0.5, 1)
				InputFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				InputFrame.BackgroundTransparency = 0.92
				InputFrame.Position = UDim2.new(0.5, 0, 1, -8)
				InputFrame.Size = UDim2.new(0.92, 0, 0, 32)
				InputFrameCorner.Parent = InputFrame
				InputFrameCorner.CornerRadius = UDim.new(0, 8)
				InputFrameStroke.Parent = InputFrame
				InputFrameStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
				InputFrameStroke.Color = Color3.fromRGB(255, 255, 255)
				InputFrameStroke.Thickness = 1.5
				InputFrameStroke.Transparency = 0.7
				InputFrameStrokeGradient.Parent = InputFrameStroke
				InputFrameStrokeGradient.Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
					ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 170, 255)),
					ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)),
				})
				FocusGlowImageLabel.Name = "FocusGlow"
				FocusGlowImageLabel.Parent = InputFrame
				FocusGlowImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
				FocusGlowImageLabel.BackgroundTransparency = 1
				FocusGlowImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
			end

			FocusGlowImageLabel.Size = UDim2.new(1, 40, 1, 40)
			FocusGlowImageLabel.Image = "rbxassetid://8992230677"
			FocusGlowImageLabel.ImageColor3 = Color3.fromRGB(0, 170, 255)
			FocusGlowImageLabel.ImageTransparency = 1
			FocusGlowImageLabel.ScaleType = Enum.ScaleType.Slice
			FocusGlowImageLabel.SliceCenter = Rect.new(99, 99, 99, 99)
			FocusGlowImageLabel.ZIndex = 0
			EditTextBox.Name = "Edit"
			EditTextBox.Parent = InputFrame
			EditTextBox.Active = true
			EditTextBox.AnchorPoint = Vector2.new(0.5, 0.5)
			EditTextBox.BackgroundTransparency = 1
			EditTextBox.Position = UDim2.new(0.5, 0, 0.5, 0)
			EditTextBox.Size = UDim2.new(0.92, 0, 0.8, 0)
			EditTextBox.Font = Enum.Font.GothamBold
			EditTextBox.PlaceholderColor3 = Color3.fromRGB(140, 140, 140)
			EditTextBox.PlaceholderText = PlaceHolder
			EditTextBox.Text = Value
			EditTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
			EditTextBox.TextSize = 13
			EditTextBox.ClearTextOnFocus = ClearOnFocus
			EditTextBox.TextScaled = true
			EditTextBox.TextWrapped = true

			local EditTextBoxTextConstraint = Instance.new("UITextSizeConstraint")

			EditTextBoxTextConstraint.Parent = EditTextBox
			EditTextBoxTextConstraint.MaxTextSize = 13
			EditTextBoxTextConstraint.MinTextSize = 9
			EditTextBox.Focused:Connect(function()
				tw({
					v = InputFrameStroke,
					t = 0.3,
					s = "Quad",
					d = "Out",
					g = {
						Transparency = 0.2,
					},
				}):Play()
				tw({
					v = InputFrame,
					t = 0.3,
					s = "Quad",
					d = "Out",
					g = {
						BackgroundTransparency = 0.85,
					},
				}):Play()
				tw({
					v = FocusGlowImageLabel,
					t = 0.3,
					s = "Quad",
					d = "Out",
					g = {
						ImageTransparency = 0.85,
					},
				}):Play()
				tw({
					v = TextboxFrameStroke,
					t = 0.3,
					s = "Quad",
					d = "Out",
					g = {
						Transparency = 0.4,
					},
				}):Play()
			end)
			EditTextBox.FocusLost:Connect(function(enterPressed)
				tw({
					v = InputFrameStroke,
					t = 0.3,
					s = "Quad",
					d = "Out",
					g = {
						Transparency = 0.7,
					},
				}):Play()
				tw({
					v = InputFrame,
					t = 0.3,
					s = "Quad",
					d = "Out",
					g = {
						BackgroundTransparency = 0.92,
					},
				}):Play()
				tw({
					v = FocusGlowImageLabel,
					t = 0.3,
					s = "Quad",
					d = "Out",
					g = {
						ImageTransparency = 1,
					},
				}):Play()
				tw({
					v = TextboxFrameStroke,
					t = 0.3,
					s = "Quad",
					d = "Out",
					g = {
						Transparency = 0.75,
					},
				}):Play()

				if enterPressed and #EditTextBox.Text > 0 then
					Value = EditTextBox.Text
					pcall(Callback, Value)
				end
			end)
			table.insert(SearchItems, {
				Frame = TextboxFrame,
				SearchName = TitleB,
				HighlightFrame = HighlightFrameB,
			})

			return {
				SetValue = function(self, value)
					Value = value
					EditTextBox.Text = value
				end,
				GetValue = function()
					return EditTextBox.Text
				end,
				SetTitle = function(self, text)
					TitleTextLabel.Text = text

					for _, v in pairs(SearchItems) do
						if v.Frame == TextboxFrame then
							v.SearchName = text

							break
						end
					end
				end,
				SetDesc = function(self, text)
					if DescTextLabel then
						DescTextLabel.Text = text
					end
				end,
				Visible = function(self, visible)
					TextboxFrame.Visible = visible
				end,
			}
		end
		Library.Elements.Slider = function(self, options)
			local TitleB = options.Title or "Slider"
			local DescB = options.Desc or ""
			local Min = options.Min or 0
			local Max = options.Max or 100
			local Rounding = options.Rounding or 0
			local Value = options.Value or Min
			local Side = options.Side or "l"
			local Callback = options.Callback or function() end

			number += 1
			BadgeLabelTextLabel.Text = tostring(number)
			tw({
				v = BadgeFrame,
				t = 0.3,
				s = "Back",
				d = "Out",
				g = {
					Size = UDim2.new(0, math.max(32, #tostring(number) * 10 + 12), 0, 18),
				},
			}):Play()

			local SliderFrame = Instance.new("Frame")
			local SliderFrameCorner = Instance.new("UICorner")
			local SliderFrameStroke = Instance.new("UIStroke")
			local SliderFrameImage = Instance.new("ImageLabel")
			local SliderFrameImageGradient = Instance.new("UIGradient")
			local TitleTextLabel = Instance.new("TextLabel")
			local DescTextLabel = Instance.new("TextLabel")
			local ValueDisplayFrame = Instance.new("Frame")
			local ValueDisplayFrameCorner = Instance.new("UICorner")
			local ValueDisplayFrameGradient = Instance.new("UIGradient")
			local ValueTextTextLabel = Instance.new("TextLabel")
			local SliderBarFrame = Instance.new("Frame")
			local SliderBarFrameCorner = Instance.new("UICorner")
			local BarFillFrame = Instance.new("Frame")
			local BarFillFrameCorner = Instance.new("UICorner")
			local BarFillFrameGradient = Instance.new("UIGradient")
			local SliderCircleFrame = Instance.new("Frame")
			local SliderCircleFrameCorner = Instance.new("UICorner")
			local SliderCircleFrameGradient = Instance.new("UIGradient")
			local HighlightFrameB = Instance.new("Frame")
			local HighlightFrameBCorner = Instance.new("UICorner")
			local sliderBarFrameClick = click(SliderBarFrame)

			SliderFrame.Name = "Slider"
			SliderFrame.Parent = GetColumn(Side)
			SliderFrame.AnchorPoint = Vector2.new(0.5, 0.5)
			SliderFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
			SliderFrame.BackgroundTransparency = 0.35
			SliderFrame.BorderSizePixel = 0
			SliderFrame.Size = UDim2.new(0.97, 0, 0, DescB ~= "" and 75 or 65)
			SliderFrame.ClipsDescendants = true
			SliderFrameCorner.Parent = SliderFrame
			SliderFrameCorner.CornerRadius = UDim.new(0, 12)
			SliderFrameStroke.Parent = SliderFrame
			SliderFrameStroke.Color = Color3.fromRGB(110, 110, 140)
			SliderFrameStroke.Thickness = 2
			SliderFrameStroke.Transparency = 0.75
			HighlightFrameB.Name = "HighlightFrame"
			HighlightFrameB.Parent = SliderFrame
			HighlightFrameB.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			HighlightFrameB.BackgroundTransparency = 1
			HighlightFrameB.Size = UDim2.new(1, 0, 1, 0)
			HighlightFrameB.ZIndex = 2
			HighlightFrameBCorner.CornerRadius = UDim.new(0, 12)
			HighlightFrameBCorner.Parent = HighlightFrameB
			SliderFrameImage.Parent = SliderFrame
			SliderFrameImage.AnchorPoint = Vector2.new(0.5, 0.5)
			SliderFrameImage.BackgroundTransparency = 1
			SliderFrameImage.Position = UDim2.new(0.5, 0, 0.5, 0)
			SliderFrameImage.Size = UDim2.new(1, 50, 1, 0)
			SliderFrameImage.Image = "rbxassetid://72380279434385"
			SliderFrameImage.ImageTransparency = 0.85
			SliderFrameImage.ScaleType = Enum.ScaleType.Crop
			SliderFrameImageGradient.Parent = SliderFrameImage
			SliderFrameImageGradient.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
				ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 170, 255)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)),
			})
			TitleTextLabel.Name = "Title"
			TitleTextLabel.Parent = SliderFrame
			TitleTextLabel.BackgroundTransparency = 1
			TitleTextLabel.Position = UDim2.new(0.04, 0, 0, 8)
			TitleTextLabel.Size = UDim2.new(0.65, 0, 0, 18)
			TitleTextLabel.Font = Enum.Font.GothamBold
			TitleTextLabel.Text = TitleB
			TitleTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			TitleTextLabel.TextSize = 14
			TitleTextLabel.TextXAlignment = Enum.TextXAlignment.Left
			TitleTextLabel.TextScaled = true
			TitleTextLabel.TextWrapped = true

			local TitleTextLabelTextConstraint = Instance.new("UITextSizeConstraint")

			TitleTextLabelTextConstraint.Parent = TitleTextLabel
			TitleTextLabelTextConstraint.MaxTextSize = 14
			TitleTextLabelTextConstraint.MinTextSize = 10
			ValueDisplayFrame.Name = "ValueDisplay"
			ValueDisplayFrame.Parent = SliderFrame
			ValueDisplayFrame.AnchorPoint = Vector2.new(1, 0)
			ValueDisplayFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ValueDisplayFrame.BackgroundTransparency = 0.9
			ValueDisplayFrame.Position = UDim2.new(0.96, 0, 0, 8)
			ValueDisplayFrame.Size = UDim2.new(0, 50, 0, 22)
			ValueDisplayFrameCorner.Parent = ValueDisplayFrame
			ValueDisplayFrameCorner.CornerRadius = UDim.new(0, 6)
			ValueDisplayFrameGradient.Parent = ValueDisplayFrame
			ValueDisplayFrameGradient.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
				ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 170, 255)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)),
			})
			ValueTextTextLabel.Name = "ValueText"
			ValueTextTextLabel.Parent = ValueDisplayFrame
			ValueTextTextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
			ValueTextTextLabel.BackgroundTransparency = 1
			ValueTextTextLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
			ValueTextTextLabel.Size = UDim2.new(0.9, 0, 0.8, 0)
			ValueTextTextLabel.Font = Enum.Font.GothamBold
			ValueTextTextLabel.Text = tostring(Value)
			ValueTextTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			ValueTextTextLabel.TextSize = 12
			ValueTextTextLabel.TextScaled = true

			local ValueTextTextLabelTextConstraint = Instance.new("UITextSizeConstraint")

			ValueTextTextLabelTextConstraint.Parent = ValueTextTextLabel
			ValueTextTextLabelTextConstraint.MaxTextSize = 12
			ValueTextTextLabelTextConstraint.MinTextSize = 8

			if DescB ~= "" then
				DescTextLabel.Name = "Desc"
				DescTextLabel.Parent = SliderFrame
				DescTextLabel.BackgroundTransparency = 1
				DescTextLabel.Position = UDim2.new(0.04, 0, 0, 28)
				DescTextLabel.Size = UDim2.new(0.92, 0, 0, 14)
				DescTextLabel.Font = Enum.Font.Gotham
				DescTextLabel.Text = DescB
				DescTextLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
				DescTextLabel.TextSize = 11
				DescTextLabel.TextTransparency = 0.4
				DescTextLabel.TextXAlignment = Enum.TextXAlignment.Left
				DescTextLabel.TextScaled = true
				DescTextLabel.TextWrapped = true

				local DescTextLabelTextConstraint = Instance.new("UITextSizeConstraint")

				DescTextLabelTextConstraint.Parent = DescTextLabel
				DescTextLabelTextConstraint.MaxTextSize = 11
				DescTextLabelTextConstraint.MinTextSize = 8
			end

			SliderBarFrame.Name = "SliderBar"
			SliderBarFrame.Parent = SliderFrame
			SliderBarFrame.AnchorPoint = Vector2.new(0.5, 1)
			SliderBarFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
			SliderBarFrame.Position = UDim2.new(0.5, 0, 1, -10)
			SliderBarFrame.Size = UDim2.new(0.92, 0, 0, 8)
			SliderBarFrameCorner.Parent = SliderBarFrame
			SliderBarFrameCorner.CornerRadius = UDim.new(1, 0)
			BarFillFrame.Name = "BarFill"
			BarFillFrame.Parent = SliderBarFrame
			BarFillFrame.AnchorPoint = Vector2.new(0, 0.5)
			BarFillFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			BarFillFrame.Position = UDim2.new(0, 0, 0.5, 0)
			BarFillFrame.Size = UDim2.new(0.5, 0, 1, 0)
			BarFillFrameCorner.Parent = BarFillFrame
			BarFillFrameCorner.CornerRadius = UDim.new(1, 0)
			BarFillFrameGradient.Parent = BarFillFrame
			BarFillFrameGradient.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
				ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 170, 255)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)),
			})
			SliderCircleFrame.Name = "SliderCircle"
			SliderCircleFrame.Parent = SliderBarFrame
			SliderCircleFrame.AnchorPoint = Vector2.new(0.5, 0.5)
			SliderCircleFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SliderCircleFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
			SliderCircleFrame.Size = UDim2.new(0, 18, 0, 18)
			SliderCircleFrameCorner.Parent = SliderCircleFrame
			SliderCircleFrameCorner.CornerRadius = UDim.new(1, 0)
			SliderCircleFrameGradient.Parent = SliderCircleFrame
			SliderCircleFrameGradient.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
				ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 170, 255)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)),
			})

			local function helper(self, arg)
				local value = 10 ^ arg

				return math.floor(self * value + 0.5) / value
			end
			local function helperB(self, arg)
				local value = helper(math.clamp(self, Min, Max), Rounding)

				Value = value

				local amount = (value - Min) / (Max - Min)

				if arg then
					tw({
						v = BarFillFrame,
						t = 0.15,
						s = "Quad",
						d = "Out",
						g = {
							Size = UDim2.new(amount, 0, 1, 0),
						},
					}):Play()
					tw({
						v = SliderCircleFrame,
						t = 0.15,
						s = "Quad",
						d = "Out",
						g = {
							Position = UDim2.new(amount, 0, 0.5, 0),
						},
					}):Play()
				else
					BarFillFrame.Size = UDim2.new(amount, 0, 1, 0)
					SliderCircleFrame.Position = UDim2.new(amount, 0, 0.5, 0)
				end

				ValueTextTextLabel.Text = tostring(helper(value, Rounding))
				ValueDisplayFrame.Size = UDim2.new(
					0,
					math.max(
						game:GetService("TextService")
							:GetTextSize(
								ValueTextTextLabel.Text,
								ValueTextTextLabel.TextSize,
								ValueTextTextLabel.Font,
								Vector2.new(1000, 1000)
							).X + 16,
						40
					),
					0,
					22
				)
				pcall(Callback, value)
			end

			helperB(Value, false)

			local function helper(self)
				local amount = Max - Min

				helperB(
					math.clamp((self.Position.X - SliderBarFrame.AbsolutePosition.X) / SliderBarFrame.AbsoluteSize.X, 0, 1) * amount
						+ Min,
					true
				)
			end

			local flag = false

			sliderBarFrameClick.InputBegan:Connect(function(input)
				if
					input.UserInputType == Enum.UserInputType.MouseButton1
					or input.UserInputType == Enum.UserInputType.Touch
				then
					flag = true
					helper(input)
					tw({
						v = SliderCircleFrame,
						t = 0.2,
						s = "Back",
						d = "Out",
						g = {
							Size = UDim2.new(0, 22, 0, 22),
						},
					}):Play()
					tw({
						v = SliderFrameStroke,
						t = 0.2,
						s = "Quad",
						d = "Out",
						g = {
							Transparency = 0.4,
						},
					}):Play()
				end
			end)
			sliderBarFrameClick.InputEnded:Connect(function(input)
				if
					input.UserInputType == Enum.UserInputType.MouseButton1
					or input.UserInputType == Enum.UserInputType.Touch
				then
					flag = false
					tw({
						v = SliderCircleFrame,
						t = 0.2,
						s = "Back",
						d = "Out",
						g = {
							Size = UDim2.new(0, 18, 0, 18),
						},
					}):Play()
					tw({
						v = SliderFrameStroke,
						t = 0.2,
						s = "Quad",
						d = "Out",
						g = {
							Transparency = 0.75,
						},
					}):Play()
				end
			end)
			UserInputService.InputChanged:Connect(function(input)
				if flag then
					if
						input.UserInputType == Enum.UserInputType.MouseMovement
						or input.UserInputType == Enum.UserInputType.Touch
					then
						helper(input)
					end
				end
			end)
			table.insert(SearchItems, {
				Frame = SliderFrame,
				SearchName = TitleB,
				HighlightFrame = HighlightFrameB,
			})

			return {
				SetValue = function(self, value)
					helperB(value, true)
				end,
				GetValue = function()
					return Value
				end,
				SetTitle = function(self, text)
					TitleTextLabel.Text = text

					for _, v in pairs(SearchItems) do
						if v.Frame == SliderFrame then
							v.SearchName = text

							break
						end
					end
				end,
				SetDesc = function(self, text)
					if DescTextLabel then
						DescTextLabel.Text = text
					end
				end,
				SetMin = function(self, min)
					Min = min
					helperB(Value, true)
				end,
				SetMax = function(self, max)
					Max = max
					helperB(Value, true)
				end,
				Visible = function(self, visible)
					SliderFrame.Visible = visible
				end,
			}
		end
		Library.Elements.Label = function(self, options)
			local TitleB = options.Title or "Label"
			local Side = options.Side or "l"

			number += 1
			BadgeLabelTextLabel.Text = tostring(number)
			tw({
				v = BadgeFrame,
				t = 0.3,
				s = "Back",
				d = "Out",
				g = {
					Size = UDim2.new(0, math.max(32, #tostring(number) * 10 + 12), 0, 18),
				},
			}):Play()

			local LabelFrame = Instance.new("Frame")
			local LabelFrameCorner = Instance.new("UICorner")
			local LabelFrameStroke = Instance.new("UIStroke")
			local LabelFrameImage = Instance.new("ImageLabel")
			local LabelFrameImageGradient = Instance.new("UIGradient")
			local LabelFrameLabel = Instance.new("TextLabel")
			local HighlightFrameB = Instance.new("Frame")
			local HighlightFrameBCorner = Instance.new("UICorner")

			LabelFrame.Name = "Label"
			LabelFrame.Parent = GetColumn(Side)
			LabelFrame.AnchorPoint = Vector2.new(0.5, 0.5)
			LabelFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
			LabelFrame.BackgroundTransparency = 0.35
			LabelFrame.BorderSizePixel = 0
			LabelFrame.Size = UDim2.new(0.97, 0, 0, 35)
			LabelFrame.ClipsDescendants = true
			LabelFrameCorner.Parent = LabelFrame
			LabelFrameCorner.CornerRadius = UDim.new(0, 10)
			LabelFrameStroke.Parent = LabelFrame
			LabelFrameStroke.Color = Color3.fromRGB(110, 110, 140)
			LabelFrameStroke.Thickness = 2
			LabelFrameStroke.Transparency = 0.75
			HighlightFrameB.Name = "HighlightFrame"
			HighlightFrameB.Parent = LabelFrame
			HighlightFrameB.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			HighlightFrameB.BackgroundTransparency = 1
			HighlightFrameB.Size = UDim2.new(1, 0, 1, 0)
			HighlightFrameB.ZIndex = 2
			HighlightFrameBCorner.CornerRadius = UDim.new(0, 10)
			HighlightFrameBCorner.Parent = HighlightFrameB
			LabelFrameImage.Parent = LabelFrame
			LabelFrameImage.AnchorPoint = Vector2.new(0.5, 0.5)
			LabelFrameImage.BackgroundTransparency = 1
			LabelFrameImage.Position = UDim2.new(0.5, 0, 0.5, 0)
			LabelFrameImage.Size = UDim2.new(1, 50, 1, 0)
			LabelFrameImage.Image = "rbxassetid://72380279434385"
			LabelFrameImage.ImageTransparency = 0.85
			LabelFrameImage.ScaleType = Enum.ScaleType.Crop
			LabelFrameImageGradient.Parent = LabelFrameImage
			LabelFrameImageGradient.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
				ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 170, 255)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)),
			})
			LabelFrameLabel.Parent = LabelFrame
			LabelFrameLabel.AnchorPoint = Vector2.new(0.5, 0.5)
			LabelFrameLabel.BackgroundTransparency = 1
			LabelFrameLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
			LabelFrameLabel.Size = UDim2.new(0.95, 0, 0.8, 0)
			LabelFrameLabel.Font = Enum.Font.GothamBold
			LabelFrameLabel.RichText = true
			LabelFrameLabel.Text = TitleB
			LabelFrameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			LabelFrameLabel.TextSize = 14
			LabelFrameLabel.TextScaled = true
			LabelFrameLabel.TextWrapped = true

			local LabelFrameLabelTextConstraint = Instance.new("UITextSizeConstraint")

			LabelFrameLabelTextConstraint.Parent = LabelFrameLabel
			LabelFrameLabelTextConstraint.MaxTextSize = 14
			LabelFrameLabelTextConstraint.MinTextSize = 10
			table.insert(SearchItems, {
				Frame = LabelFrame,
				SearchName = TitleB,
				HighlightFrame = HighlightFrameB,
			})

			return {
				SetText = function(self, text)
					LabelFrameLabel.Text = text

					for _, v in pairs(SearchItems) do
						if v.Frame == LabelFrame then
							v.SearchName = text

							break
						end
					end
				end,
				Visible = function(self, visible)
					LabelFrame.Visible = visible
				end,
			}
		end
		Library.Elements.Paragraph = function(self, options)
			local TitleB = options.Title or "Paragraph"
			local DescB = options.Desc or "Description"
			local Side = options.Side or "l"

			number += 1
			BadgeLabelTextLabel.Text = tostring(number)
			tw({
				v = BadgeFrame,
				t = 0.3,
				s = "Back",
				d = "Out",
				g = {
					Size = UDim2.new(0, math.max(32, #tostring(number) * 10 + 12), 0, 18),
				},
			}):Play()

			local ParagraphFrame = Instance.new("Frame")
			local ParagraphFrameCorner = Instance.new("UICorner")
			local ParagraphFrameStroke = Instance.new("UIStroke")
			local ParagraphFrameImage = Instance.new("ImageLabel")
			local ParagraphFrameImageGradient = Instance.new("UIGradient")
			local ContainerFrame = Instance.new("Frame")
			local ContainerFrameListLayout = Instance.new("UIListLayout")
			local ContainerFramePadding = Instance.new("UIPadding")
			local TitleTextLabel = Instance.new("TextLabel")
			local DescTextLabel = Instance.new("TextLabel")
			local HighlightFrameB = Instance.new("Frame")
			local HighlightFrameBCorner = Instance.new("UICorner")

			ParagraphFrame.Name = "Paragraph"
			ParagraphFrame.Parent = GetColumn(Side)
			ParagraphFrame.AnchorPoint = Vector2.new(0.5, 0.5)
			ParagraphFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
			ParagraphFrame.BackgroundTransparency = 0.35
			ParagraphFrame.BorderSizePixel = 0
			ParagraphFrame.Size = UDim2.new(0.97, 0, 0, 90)
			ParagraphFrame.ClipsDescendants = false
			ParagraphFrameCorner.Parent = ParagraphFrame
			ParagraphFrameCorner.CornerRadius = UDim.new(0, 12)
			ParagraphFrameStroke.Parent = ParagraphFrame
			ParagraphFrameStroke.Color = Color3.fromRGB(110, 110, 140)
			ParagraphFrameStroke.Thickness = 2
			ParagraphFrameStroke.Transparency = 0.75
			HighlightFrameB.Name = "HighlightFrame"
			HighlightFrameB.Parent = ParagraphFrame
			HighlightFrameB.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			HighlightFrameB.BackgroundTransparency = 1
			HighlightFrameB.Size = UDim2.new(1, 0, 1, 0)
			HighlightFrameB.ZIndex = 2
			HighlightFrameBCorner.CornerRadius = UDim.new(0, 12)
			HighlightFrameBCorner.Parent = HighlightFrameB
			ParagraphFrameImage.Parent = ParagraphFrame
			ParagraphFrameImage.AnchorPoint = Vector2.new(0.5, 0.5)
			ParagraphFrameImage.BackgroundTransparency = 1
			ParagraphFrameImage.Position = UDim2.new(0.5, 0, 0.5, 0)
			ParagraphFrameImage.Size = UDim2.new(1, 50, 1, 0)
			ParagraphFrameImage.Image = "rbxassetid://72380279434385"
			ParagraphFrameImage.ImageTransparency = 0.85
			ParagraphFrameImage.ScaleType = Enum.ScaleType.Crop
			ParagraphFrameImageGradient.Parent = ParagraphFrameImage
			ParagraphFrameImageGradient.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
				ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 170, 255)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)),
			})
			ContainerFrame.Name = "Container"
			ContainerFrame.Parent = ParagraphFrame
			ContainerFrame.AnchorPoint = Vector2.new(0.5, 0)
			ContainerFrame.BackgroundTransparency = 1
			ContainerFrame.Position = UDim2.new(0.5, 0, 0, 0)
			ContainerFrame.Size = UDim2.new(1, 0, 1, 0)
			ContainerFrameListLayout.Parent = ContainerFrame
			ContainerFrameListLayout.Padding = UDim.new(0, 6)
			ContainerFrameListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			ContainerFrameListLayout.VerticalAlignment = Enum.VerticalAlignment.Top
			ContainerFramePadding.Parent = ContainerFrame
			ContainerFramePadding.PaddingLeft = UDim.new(0, 14)
			ContainerFramePadding.PaddingRight = UDim.new(0, 14)
			ContainerFramePadding.PaddingTop = UDim.new(0, 12)
			ContainerFramePadding.PaddingBottom = UDim.new(0, 12)
			TitleTextLabel.Name = "Title"
			TitleTextLabel.Parent = ContainerFrame
			TitleTextLabel.BackgroundTransparency = 1
			TitleTextLabel.Size = UDim2.new(1, 0, 0, 20)
			TitleTextLabel.Font = Enum.Font.GothamBold
			TitleTextLabel.RichText = true
			TitleTextLabel.Text = TitleB
			TitleTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			TitleTextLabel.TextSize = 15
			TitleTextLabel.TextXAlignment = Enum.TextXAlignment.Left
			TitleTextLabel.TextYAlignment = Enum.TextYAlignment.Top
			TitleTextLabel.TextWrapped = true
			TitleTextLabel.AutomaticSize = Enum.AutomaticSize.Y

			local TitleTextLabelTextConstraint = Instance.new("UITextSizeConstraint")

			TitleTextLabelTextConstraint.Parent = TitleTextLabel
			TitleTextLabelTextConstraint.MaxTextSize = 15
			TitleTextLabelTextConstraint.MinTextSize = 11
			DescTextLabel.Name = "Desc"
			DescTextLabel.Parent = ContainerFrame
			DescTextLabel.BackgroundTransparency = 1
			DescTextLabel.Size = UDim2.new(1, 0, 0, 0)
			DescTextLabel.Font = Enum.Font.Gotham
			DescTextLabel.RichText = true
			DescTextLabel.Text = DescB
			DescTextLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
			DescTextLabel.TextSize = 13
			DescTextLabel.TextTransparency = 0.3
			DescTextLabel.TextXAlignment = Enum.TextXAlignment.Left
			DescTextLabel.TextYAlignment = Enum.TextYAlignment.Top
			DescTextLabel.TextWrapped = true
			DescTextLabel.AutomaticSize = Enum.AutomaticSize.Y

			local DescTextLabelTextConstraint = Instance.new("UITextSizeConstraint")

			DescTextLabelTextConstraint.Parent = DescTextLabel
			DescTextLabelTextConstraint.MaxTextSize = 13
			DescTextLabelTextConstraint.MinTextSize = 9

			local function helper()
				task.wait(0.1)

				local maximum = math.max(TitleTextLabel.AbsoluteSize.Y + DescTextLabel.AbsoluteSize.Y + 6 + 24, 70)

				tw({
					v = ParagraphFrame,
					t = 0.3,
					s = "Quad",
					d = "Out",
					g = {
						Size = UDim2.new(0.97, 0, 0, maximum),
					},
				}):Play()
			end

			TitleTextLabel:GetPropertyChangedSignal("AbsoluteSize"):Connect(helper)
			DescTextLabel:GetPropertyChangedSignal("AbsoluteSize"):Connect(helper)
			ParagraphFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
				task.wait(0.05)
				helper()
			end)
			task.spawn(helper)
			table.insert(SearchItems, {
				Frame = ParagraphFrame,
				SearchName = TitleB,
				HighlightFrame = HighlightFrameB,
			})

			return {
				SetTitle = function(self, text)
					TitleTextLabel.Text = text

					for _, v in pairs(SearchItems) do
						if v.Frame == ParagraphFrame then
							v.SearchName = text

							break
						end
					end
				end,
				SetDesc = function(self, descB)
					DescB = descB
					DescTextLabel.Text = descB
					task.wait(0.05)
					helper()
				end,
				Visible = function(self, visible)
					ParagraphFrame.Visible = visible
				end,
			}
		end
		Library.Elements.Button = function(self, options)
			local title = options.Title
			local DescB = options.Desc or nil
			local Side = options.Side or "l"
			local Callback = options.Callback
			local IconB = options.Icon or nil

			number += 1
			BadgeLabelTextLabel.Text = tostring(number)
			tw({
				v = BadgeFrame,
				t = 0.3,
				s = "Back",
				d = "Out",
				g = {
					Size = UDim2.new(0, math.max(32, #tostring(number) * 10 + 12), 0, 18),
				},
			}):Play()

			if not (IconB or DescB) then
				local ButtonFrame = Instance.new("Frame")
				local ButtonFrameGradient = Instance.new("UIGradient")
				local TitleTextLabel = Instance.new("TextLabel")
				local ButtonFrameCorner = Instance.new("UICorner")
				local ButtonFrameImage = Instance.new("ImageLabel")
				local ButtonFrameStroke = Instance.new("UIStroke")
				local HighlightFrameB = Instance.new("Frame")
				local HighlightFrameBCorner = Instance.new("UICorner")
				local buttonFrameClick = click(ButtonFrame)

				ButtonFrame.Name = "Button"
				ButtonFrame.Parent = GetColumn(Side)
				ButtonFrame.AnchorPoint = Vector2.new(0.5, 0.5)
				ButtonFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ButtonFrame.BorderSizePixel = 0
				ButtonFrame.Size = UDim2.new(0.97, 0, 0, 35)
				ButtonFrame.ClipsDescendants = true
				ButtonFrameGradient.Parent = ButtonFrame
				ButtonFrameGradient.Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
					ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 170, 255)),
					ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)),
				})
				ButtonFrameStroke.Parent = ButtonFrame
				ButtonFrameStroke.Color = Color3.fromRGB(255, 255, 255)
				ButtonFrameStroke.Thickness = 2
				ButtonFrameStroke.Transparency = 0.65
				HighlightFrameB.Name = "HighlightFrame"
				HighlightFrameB.Parent = ButtonFrame
				HighlightFrameB.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				HighlightFrameB.BackgroundTransparency = 1
				HighlightFrameB.Size = UDim2.new(1, 0, 1, 0)
				HighlightFrameB.ZIndex = 2
				HighlightFrameBCorner.CornerRadius = UDim.new(0, 10)
				HighlightFrameBCorner.Parent = HighlightFrameB
				TitleTextLabel.Name = "Title"
				TitleTextLabel.Parent = ButtonFrame
				TitleTextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
				TitleTextLabel.BackgroundTransparency = 1
				TitleTextLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
				TitleTextLabel.Size = UDim2.new(0.95, 0, 0.8, 0)
				TitleTextLabel.Font = Enum.Font.GothamBold
				TitleTextLabel.Text = title
				TitleTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
				TitleTextLabel.TextSize = 14
				TitleTextLabel.TextScaled = true
				TitleTextLabel.TextWrapped = true

				local TitleTextLabelTextConstraint = Instance.new("UITextSizeConstraint")

				TitleTextLabelTextConstraint.Parent = TitleTextLabel
				TitleTextLabelTextConstraint.MaxTextSize = 14
				TitleTextLabelTextConstraint.MinTextSize = 10
				ButtonFrameCorner.Parent = ButtonFrame
				ButtonFrameCorner.CornerRadius = UDim.new(0, 10)
				ButtonFrameImage.Parent = ButtonFrame
				ButtonFrameImage.AnchorPoint = Vector2.new(0.5, 0.5)
				ButtonFrameImage.BackgroundTransparency = 1
				ButtonFrameImage.Position = UDim2.new(0.5, 0, 0.5, 0)
				ButtonFrameImage.Size = UDim2.new(1, 50, 1, 0)
				ButtonFrameImage.Image = "rbxassetid://72380279434385"
				ButtonFrameImage.ImageTransparency = 0.7
				ButtonFrameImage.ScaleType = Enum.ScaleType.Crop
				buttonFrameClick.MouseButton1Click:Connect(function()
					Callback()
					tw({
						v = ButtonFrame,
						t = 0.2,
						s = "Bounce",
						d = "Out",
						g = {
							Size = UDim2.new(0.9, 0, 0, 35),
						},
					}):Play()
					delay(0.08, function()
						tw({
							v = ButtonFrame,
							t = 0.2,
							s = "Bounce",
							d = "Out",
							g = {
								Size = UDim2.new(0.97, 0, 0, 35),
							},
						}):Play()
					end)
					EffectClick(buttonFrameClick, ButtonFrame)
				end)
				table.insert(SearchItems, {
					Frame = ButtonFrame,
					SearchName = title,
					HighlightFrame = HighlightFrameB,
				})

				return {
					Fire = function()
						Callback()
					end,
					UpdateTitle = function(self, text)
						TitleTextLabel.Text = text

						for _, v in pairs(SearchItems) do
							if v.Frame == ButtonFrame then
								v.SearchName = text

								break
							end
						end
					end,
					Visible = function(self, visible)
						ButtonFrame.Visible = visible
					end,
				}
			end

			local ButtonImageFrame = Instance.new("Frame")
			local TitleTextLabel = Instance.new("TextLabel")
			local ButtonImageFrameCorner = Instance.new("UICorner")
			local ButtonImageFrameImage = Instance.new("ImageLabel")
			local ButtonImageFrameImageGradient = Instance.new("UIGradient")
			local iconImageLabel = Instance.new("ImageLabel")
			local DescTextLabel = Instance.new("TextLabel")
			local nextImageLabel = Instance.new("ImageLabel")
			local ButtonImageFrameStroke = Instance.new("UIStroke")
			local HighlightFrameB = Instance.new("Frame")
			local HighlightFrameBCorner = Instance.new("UICorner")
			local buttonImageFrameClick = click(ButtonImageFrame)

			ButtonImageFrame.Name = "ButtonImage"
			ButtonImageFrame.Parent = GetColumn(Side)
			ButtonImageFrame.AnchorPoint = Vector2.new(0.5, 0.5)
			ButtonImageFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
			ButtonImageFrame.BackgroundTransparency = 0.35
			ButtonImageFrame.BorderSizePixel = 0
			ButtonImageFrame.Size = UDim2.new(0.97, 0, 0, 55)
			ButtonImageFrame.ClipsDescendants = true
			ButtonImageFrameStroke.Parent = ButtonImageFrame
			ButtonImageFrameStroke.Color = Color3.fromRGB(110, 110, 140)
			ButtonImageFrameStroke.Thickness = 2
			ButtonImageFrameStroke.Transparency = 0.75
			HighlightFrameB.Name = "HighlightFrame"
			HighlightFrameB.Parent = ButtonImageFrame
			HighlightFrameB.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			HighlightFrameB.BackgroundTransparency = 1
			HighlightFrameB.Size = UDim2.new(1, 0, 1, 0)
			HighlightFrameB.ZIndex = 2
			HighlightFrameBCorner.CornerRadius = UDim.new(0, 12)
			HighlightFrameBCorner.Parent = HighlightFrameB
			TitleTextLabel.Name = "Title"
			TitleTextLabel.Parent = ButtonImageFrame
			TitleTextLabel.AnchorPoint = Vector2.new(0, 0.5)
			TitleTextLabel.BackgroundTransparency = 1
			TitleTextLabel.Position = UDim2.new(0, 55, 0.35, 0)
			TitleTextLabel.Size = UDim2.new(0.65, 0, 0, 18)
			TitleTextLabel.Font = Enum.Font.GothamBold
			TitleTextLabel.RichText = true
			TitleTextLabel.Text = title
			TitleTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			TitleTextLabel.TextSize = 14
			TitleTextLabel.TextXAlignment = Enum.TextXAlignment.Left
			TitleTextLabel.TextScaled = true
			TitleTextLabel.TextWrapped = true

			local TitleTextLabelTextConstraint = Instance.new("UITextSizeConstraint")

			TitleTextLabelTextConstraint.Parent = TitleTextLabel
			TitleTextLabelTextConstraint.MaxTextSize = 14
			TitleTextLabelTextConstraint.MinTextSize = 10
			ButtonImageFrameCorner.Parent = ButtonImageFrame
			ButtonImageFrameCorner.CornerRadius = UDim.new(0, 12)
			ButtonImageFrameImage.Parent = ButtonImageFrame
			ButtonImageFrameImage.AnchorPoint = Vector2.new(0.5, 0.5)
			ButtonImageFrameImage.BackgroundTransparency = 1
			ButtonImageFrameImage.Position = UDim2.new(0.5, 0, 0.5, 0)
			ButtonImageFrameImage.Size = UDim2.new(1, 50, 1, 0)
			ButtonImageFrameImage.Image = "rbxassetid://72380279434385"
			ButtonImageFrameImage.ImageTransparency = 0.85
			ButtonImageFrameImage.ScaleType = Enum.ScaleType.Crop
			ButtonImageFrameImageGradient.Parent = ButtonImageFrameImage
			ButtonImageFrameImageGradient.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
				ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 170, 255)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)),
			})
			iconImageLabel.Name = "icon"
			iconImageLabel.Parent = ButtonImageFrame
			iconImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
			iconImageLabel.BackgroundTransparency = 1
			iconImageLabel.Position = UDim2.new(0, 27, 0.5, 0)
			iconImageLabel.Size = UDim2.new(0, 38, 0, 38)
			iconImageLabel.Image = GetIcon(IconB)
			iconImageLabel.ScaleType = Enum.ScaleType.Fit
			DescTextLabel.Name = "Desc"
			DescTextLabel.Parent = ButtonImageFrame
			DescTextLabel.AnchorPoint = Vector2.new(0, 0.5)
			DescTextLabel.BackgroundTransparency = 1
			DescTextLabel.Position = UDim2.new(0, 55, 0.68, 0)
			DescTextLabel.Size = UDim2.new(0.65, 0, 0, 15)
			DescTextLabel.Font = Enum.Font.GothamBold
			DescTextLabel.RichText = true
			DescTextLabel.Text = DescB
			DescTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			DescTextLabel.TextSize = 11
			DescTextLabel.TextTransparency = 0.4
			DescTextLabel.TextXAlignment = Enum.TextXAlignment.Left
			DescTextLabel.TextScaled = true
			DescTextLabel.TextWrapped = true

			local DescTextLabelTextConstraint = Instance.new("UITextSizeConstraint")

			DescTextLabelTextConstraint.Parent = DescTextLabel
			DescTextLabelTextConstraint.MaxTextSize = 11
			DescTextLabelTextConstraint.MinTextSize = 8
			nextImageLabel.Name = "next"
			nextImageLabel.Parent = ButtonImageFrame
			nextImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
			nextImageLabel.BackgroundTransparency = 1
			nextImageLabel.Position = UDim2.new(1, -16, 0.5, 0)
			nextImageLabel.Size = UDim2.new(0, 20, 0, 20)
			nextImageLabel.Image = "rbxassetid://108028847031522"
			nextImageLabel.ScaleType = Enum.ScaleType.Fit
			buttonImageFrameClick.MouseButton1Click:Connect(function()
				Callback()
				tw({
					v = nextImageLabel,
					t = 0.2,
					s = "Bounce",
					d = "Out",
					g = {
						Position = UDim2.new(1, -12, 0.5, 0),
					},
				}):Play()
				delay(0.08, function()
					tw({
						v = nextImageLabel,
						t = 0.2,
						s = "Bounce",
						d = "Out",
						g = {
							Position = UDim2.new(1, -16, 0.5, 0),
						},
					}):Play()
				end)
				EffectClick2(buttonImageFrameClick, ButtonImageFrame)
			end)
			table.insert(SearchItems, {
				Frame = ButtonImageFrame,
				SearchName = title,
				HighlightFrame = HighlightFrameB,
			})

			return {
				Fire = function()
					Callback()
				end,
				Title = function(self, text)
					TitleTextLabel.Text = text

					for _, v in pairs(SearchItems) do
						if v.Frame == ButtonImageFrame then
							v.SearchName = text

							break
						end
					end
				end,
				Desc = function(self, text)
					DescTextLabel.Text = text
				end,
				Icon = function(self, arg)
					iconImageLabel.Image = GetIcon(arg)
				end,
				Visible = function(self, visible)
					ButtonImageFrame.Visible = visible
				end,
			}
		end
		Library.Elements.Dropdown = function(self, options)
			local TitleB = options.Title or "Dropdown"
			local DescB = options.Desc or ""
			local List = options.List or {}
			local Value = options.Value or ""
			local Multi = options.Multi or false
			local Side = options.Side
			local Callback, DropdownFrame, DropdownFrameStroke, TitleTextLabel, DescTextLabel, ValueDisplayTextLabel, ArrowIconImageLabel, ArrowIconImageLabelGradient, HighlightFrameB, ClickDropdownTextButton, DropdownMenuFrame, TitleTextLabelB, SearchBoxTextBox, SearchBoxTextBoxStroke, MenuScrollScrollingFrame, isAnimating, isOpen, selectedValues, updateDisplayText, addItem, dropdownApi, closeDropdown, openDropdown, connection, listenForOutsideClick, DropdownMenuFrameCorner, DropdownMenuFrameStroke, EffectImageLabel, HeaderFrameB, LineFrameB, LineFrameBGradient, SearchBoxTextBoxCorner, SearchBoxTextBoxStrokeGradient, MenuScrollScrollingFrameListLayout

			if Side then
				Callback = options.Callback or function() end
				number += 1
				BadgeLabelTextLabel.Text = tostring(number)
				tw({
					v = BadgeFrame,
					t = 0.3,
					s = "Back",
					d = "Out",
					g = {
						Size = UDim2.new(0, math.max(32, #tostring(number) * 10 + 12), 0, 18),
					},
				}):Play()
				DropdownFrame = Instance.new("Frame")

				local DropdownFrameCorner = Instance.new("UICorner")

				DropdownFrameStroke = Instance.new("UIStroke")

				local DropdownFrameImage = Instance.new("ImageLabel")
				local DropdownFrameImageGradient = Instance.new("UIGradient")

				TitleTextLabel = Instance.new("TextLabel")
				DescTextLabel = Instance.new("TextLabel")
				ValueDisplayTextLabel = Instance.new("TextLabel")

				local ValueDisplayTextLabelGradient = Instance.new("UIGradient")

				ArrowIconImageLabel = Instance.new("ImageLabel")
				ArrowIconImageLabelGradient = Instance.new("UIGradient")
				HighlightFrameB = Instance.new("Frame")

				local HighlightFrameBCorner = Instance.new("UICorner")

				ClickDropdownTextButton = Instance.new("TextButton")
				DropdownFrame.Name = "Dropdown"
				DropdownFrame.Parent = GetColumn(Side)
				DropdownFrame.AnchorPoint = Vector2.new(0.5, 0.5)
				DropdownFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
				DropdownFrame.BackgroundTransparency = 0.35
				DropdownFrame.BorderSizePixel = 0

				local uDim2New = UDim2.new
				local value = 0.97
				local numberB = 0
				local numberC = 0

				DropdownFrame.Size = uDim2New(value, numberB, numberC, DescB ~= "" and 65 or 50)
				DropdownFrame.ClipsDescendants = true
				DropdownFrameCorner.Parent = DropdownFrame
				DropdownFrameCorner.CornerRadius = UDim.new(0, 12)
				DropdownFrameStroke.Parent = DropdownFrame
				DropdownFrameStroke.Color = Color3.fromRGB(110, 110, 140)
				DropdownFrameStroke.Thickness = 2
				DropdownFrameStroke.Transparency = 0.75
				HighlightFrameB.Name = "HighlightFrame"
				HighlightFrameB.Parent = DropdownFrame
				HighlightFrameB.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				HighlightFrameB.BackgroundTransparency = 1
				HighlightFrameB.Size = UDim2.new(1, 0, 1, 0)
				HighlightFrameB.ZIndex = 2
				HighlightFrameBCorner.CornerRadius = UDim.new(0, 12)
				HighlightFrameBCorner.Parent = HighlightFrameB
				DropdownFrameImage.Parent = DropdownFrame
				DropdownFrameImage.AnchorPoint = Vector2.new(0.5, 0.5)
				DropdownFrameImage.BackgroundTransparency = 1
				DropdownFrameImage.Position = UDim2.new(0.5, 0, 0.5, 0)
				DropdownFrameImage.Size = UDim2.new(1, 50, 1, 0)
				DropdownFrameImage.Image = "rbxassetid://72380279434385"
				DropdownFrameImage.ImageTransparency = 0.85
				DropdownFrameImage.ScaleType = Enum.ScaleType.Crop
				DropdownFrameImageGradient.Parent = DropdownFrameImage
				DropdownFrameImageGradient.Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
					ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 170, 255)),
					ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)),
				})
				TitleTextLabel.Name = "Title"
				TitleTextLabel.Parent = DropdownFrame
				TitleTextLabel.BackgroundTransparency = 1
				TitleTextLabel.Position = UDim2.new(0.04, 0, 0, 6)
				TitleTextLabel.Size = UDim2.new(0.75, 0, 0, 16)
				TitleTextLabel.Font = Enum.Font.GothamBold
				TitleTextLabel.Text = TitleB
				TitleTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
				TitleTextLabel.TextSize = 14
				TitleTextLabel.TextXAlignment = Enum.TextXAlignment.Left
				TitleTextLabel.TextScaled = true
				TitleTextLabel.TextWrapped = true

				local TitleTextLabelTextConstraint = Instance.new("UITextSizeConstraint")

				TitleTextLabelTextConstraint.Parent = TitleTextLabel
				TitleTextLabelTextConstraint.MaxTextSize = 14
				TitleTextLabelTextConstraint.MinTextSize = 10
				ValueDisplayTextLabel.Name = "ValueDisplay"
				ValueDisplayTextLabel.Parent = DropdownFrame
				ValueDisplayTextLabel.BackgroundTransparency = 1
				ValueDisplayTextLabel.Position = UDim2.new(0.04, numberC, 0, DescB ~= "" and 28 or 24)
				ValueDisplayTextLabel.Size = UDim2.new(0.85, 0, 0, 16)
				ValueDisplayTextLabel.Font = Enum.Font.GothamBold
				ValueDisplayTextLabel.Text = type(Value) == "table" and "Multiple Selected"
					or Value ~= "" and tostring(Value)
					or "Select..."
				ValueDisplayTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
				ValueDisplayTextLabel.TextSize = 12
				ValueDisplayTextLabel.TextXAlignment = Enum.TextXAlignment.Left
				ValueDisplayTextLabel.TextScaled = true
				ValueDisplayTextLabel.TextWrapped = true

				local ValueDisplayTextLabelTextConstraint = Instance.new("UITextSizeConstraint")

				ValueDisplayTextLabelTextConstraint.Parent = ValueDisplayTextLabel
				ValueDisplayTextLabelTextConstraint.MaxTextSize = 12
				ValueDisplayTextLabelTextConstraint.MinTextSize = 8
				ValueDisplayTextLabelGradient.Parent = ValueDisplayTextLabel
				ValueDisplayTextLabelGradient.Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
					ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 170, 255)),
					ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)),
				})
				ValueDisplayTextLabelGradient.Rotation = 90

				if DescB == "" then
					ArrowIconImageLabel.Name = "ArrowIcon"
					ArrowIconImageLabel.Parent = DropdownFrame
					ArrowIconImageLabel.AnchorPoint = Vector2.new(1, 0.5)
					ArrowIconImageLabel.BackgroundTransparency = 1
					ArrowIconImageLabel.Position = UDim2.new(0.96, 0, 0.5, 0)
					ArrowIconImageLabel.Size = UDim2.new(0, 24, 0, 24)
					ArrowIconImageLabel.Image = "rbxassetid://129573215183311"
					ArrowIconImageLabel.ScaleType = Enum.ScaleType.Fit
					ArrowIconImageLabelGradient.Parent = ArrowIconImageLabel
					ArrowIconImageLabelGradient.Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
						ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 170, 255)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)),
					})
					DropdownMenuFrame = Instance.new("Frame")
					DropdownMenuFrameCorner = Instance.new("UICorner")
					DropdownMenuFrameStroke = Instance.new("UIStroke")
					EffectImageLabel = Instance.new("ImageLabel")
					HeaderFrameB = Instance.new("Frame")
					TitleTextLabelB = Instance.new("TextLabel")
					LineFrameB = Instance.new("Frame")
					LineFrameBGradient = Instance.new("UIGradient")
					SearchBoxTextBox = Instance.new("TextBox")
					SearchBoxTextBoxCorner = Instance.new("UICorner")
					SearchBoxTextBoxStroke = Instance.new("UIStroke")
					SearchBoxTextBoxStrokeGradient = Instance.new("UIGradient")
					MenuScrollScrollingFrame = Instance.new("ScrollingFrame")
					MenuScrollScrollingFrameListLayout = Instance.new("UIListLayout")
					DropdownMenuFrame.Name = "DropdownMenu"
					DropdownMenuFrame.Parent = BackgroundFrame
					DropdownMenuFrame.AnchorPoint = Vector2.new(1, 0.5)
					DropdownMenuFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
					DropdownMenuFrame.BackgroundTransparency = 0.05
					DropdownMenuFrame.Position = UDim2.new(1, 0, 0.5, 0)
					DropdownMenuFrame.Size = UDim2.new(0, 0, 1, 0)
					DropdownMenuFrame.ClipsDescendants = true
					DropdownMenuFrame.Visible = false
					DropdownMenuFrame.ZIndex = 100
					DropdownMenuFrameCorner.Parent = DropdownMenuFrame
					DropdownMenuFrameCorner.CornerRadius = UDim.new(0, 16)
					DropdownMenuFrameStroke.Parent = DropdownMenuFrame
					DropdownMenuFrameStroke.Color = Color3.fromRGB(110, 110, 140)
					DropdownMenuFrameStroke.Thickness = 2
					DropdownMenuFrameStroke.Transparency = 0.6
					EffectImageLabel.Name = "Effect"
					EffectImageLabel.Parent = DropdownMenuFrame
					EffectImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
					EffectImageLabel.BackgroundTransparency = 1
					EffectImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
					EffectImageLabel.Size = UDim2.new(1, 0, 1, 0)
					EffectImageLabel.Image = "rbxassetid://132687652275989"
					EffectImageLabel.ImageColor3 = Color3.fromRGB(0, 255, 127)
					EffectImageLabel.ImageTransparency = 0.5
					EffectImageLabel.ScaleType = Enum.ScaleType.Crop
					EffectImageLabel.ZIndex = 100
					HeaderFrameB.Name = "Header"
					HeaderFrameB.Parent = DropdownMenuFrame
					HeaderFrameB.BackgroundTransparency = 1
					HeaderFrameB.Size = UDim2.new(1, 0, 0, 70)
					HeaderFrameB.ZIndex = 101
					TitleTextLabelB.Name = "Title"
					TitleTextLabelB.Parent = HeaderFrameB
					TitleTextLabelB.BackgroundTransparency = 1
					TitleTextLabelB.Position = UDim2.new(0, 16, 0, 12)
					TitleTextLabelB.Size = UDim2.new(1, -32, 0, 24)
					TitleTextLabelB.Font = Enum.Font.GothamBold
					TitleTextLabelB.Text = TitleB
					TitleTextLabelB.TextColor3 = Color3.fromRGB(255, 255, 255)
					TitleTextLabelB.TextSize = 18
					TitleTextLabelB.TextXAlignment = Enum.TextXAlignment.Left
					TitleTextLabelB.ZIndex = 101
					LineFrameB.Name = "Line"
					LineFrameB.Parent = HeaderFrameB
					LineFrameB.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					LineFrameB.BorderSizePixel = 0
					LineFrameB.Position = UDim2.new(0, 16, 0, 42)
					LineFrameB.Size = UDim2.new(0, 60, 0, 2)
					LineFrameB.ZIndex = 101
					LineFrameBGradient.Parent = LineFrameB
					LineFrameBGradient.Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
						ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 170, 255)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)),
					})
					SearchBoxTextBox.Name = "SearchBox"
					SearchBoxTextBox.Parent = HeaderFrameB
					SearchBoxTextBox.AnchorPoint = Vector2.new(0.5, 1)
					SearchBoxTextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					SearchBoxTextBox.BackgroundTransparency = 0.92
					SearchBoxTextBox.Position = UDim2.new(0.5, 0, 1, -4)
					SearchBoxTextBox.Size = UDim2.new(0, 0, 0, 28)
					SearchBoxTextBox.Font = Enum.Font.GothamBold
					SearchBoxTextBox.PlaceholderColor3 = Color3.fromRGB(140, 140, 140)
					SearchBoxTextBox.PlaceholderText = "Search..."
					SearchBoxTextBox.Text = ""
					SearchBoxTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
					SearchBoxTextBox.TextSize = 12
					SearchBoxTextBox.ClearTextOnFocus = false
					SearchBoxTextBox.ZIndex = 102
					SearchBoxTextBoxCorner.Parent = SearchBoxTextBox
					SearchBoxTextBoxCorner.CornerRadius = UDim.new(0, 8)
					SearchBoxTextBoxStroke.Parent = SearchBoxTextBox
					SearchBoxTextBoxStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
					SearchBoxTextBoxStroke.Color = Color3.fromRGB(255, 255, 255)
					SearchBoxTextBoxStroke.Thickness = 1.5
					SearchBoxTextBoxStroke.Transparency = 0.7
					SearchBoxTextBoxStrokeGradient.Parent = SearchBoxTextBoxStroke
					SearchBoxTextBoxStrokeGradient.Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
						ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 170, 255)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)),
					})
					MenuScrollScrollingFrame.Name = "MenuScroll"
					MenuScrollScrollingFrame.Parent = DropdownMenuFrame
					MenuScrollScrollingFrame.Active = true
					MenuScrollScrollingFrame.BackgroundTransparency = 1
					MenuScrollScrollingFrame.BorderSizePixel = 0
					MenuScrollScrollingFrame.Position = UDim2.new(0, 8, 0, 78)
					MenuScrollScrollingFrame.Size = UDim2.new(1, -16, 1, -86)
					MenuScrollScrollingFrame.ClipsDescendants = true
					MenuScrollScrollingFrame.ScrollBarThickness = 4
					MenuScrollScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(0, 170, 255)
					MenuScrollScrollingFrame.ScrollBarImageTransparency = 0.7
					MenuScrollScrollingFrame.ZIndex = 101
					MenuScrollScrollingFrameListLayout.Parent = MenuScrollScrollingFrame
					MenuScrollScrollingFrameListLayout.Padding = UDim.new(0, 4)
					MenuScrollScrollingFrameListLayout.SortOrder = Enum.SortOrder.LayoutOrder
					MenuScrollScrollingFrameListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
						MenuScrollScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, MenuScrollScrollingFrameListLayout.AbsoluteContentSize.Y + 8)
					end)
					isAnimating = false
					isOpen = false
					selectedValues = {}

					if type(Value) == "table" then
						for _, v in pairs(Value) do
							selectedValues[v] = true
						end

						updateDisplayText = function()
							if Multi then
								local items = {}

								for k, v in pairs(selectedValues) do
									if v then
										table.insert(items, k)
									end
								end

								if #items > 0 then
									ValueDisplayTextLabel.Text = #items .. " Selected"
								else
									ValueDisplayTextLabel.Text = "Select..."
								end
							else
								local flag = false

								for k, v in pairs(selectedValues) do
									if v then
										ValueDisplayTextLabel.Text = k
										flag = true

										break
									end
								end

								if not flag then
									ValueDisplayTextLabel.Text = "Select..."
								end
							end
						end
						closeDropdown = function()
							if isAnimating or not isOpen then
								return
							end

							isAnimating = true
							isOpen = false
							tw({
								v = DropdownMenuFrame,
								t = 0.25,
								s = "Quad",
								d = "Out",
								g = {
									Size = UDim2.new(0, 0, 1, 0),
								},
							}):Play()
							tw({
								v = SearchBoxTextBox,
								t = 0.2,
								s = "Quad",
								d = "Out",
								g = {
									Size = UDim2.new(0, 0, 0, 28),
								},
							}):Play()
							tw({
								v = ArrowIconImageLabel,
								t = 0.25,
								s = "Quad",
								d = "Out",
								g = {
									Rotation = 0,
								},
							}):Play()
							tw({
								v = DropdownFrameStroke,
								t = 0.25,
								s = "Quad",
								d = "Out",
								g = {
									Transparency = 0.75,
								},
							}):Play()
							task.spawn(function()
								task.wait(0.25)

								if not isOpen then
									DropdownMenuFrame.Visible = false
								end

								isAnimating = false
							end)
						end
						openDropdown = function()
							if isAnimating or isOpen then
								return
							end

							isAnimating = true
							isOpen = true
							DropdownMenuFrame.Visible = true
							SearchBoxTextBox.Text = ""
							tw({
								v = DropdownMenuFrame,
								t = 0.3,
								s = "Back",
								d = "Out",
								g = {
									Size = UDim2.new(0, 240, 1, 0),
								},
							}):Play()
							tw({
								v = SearchBoxTextBox,
								t = 0.25,
								s = "Back",
								d = "Out",
								g = {
									Size = UDim2.new(0.9, 0, 0, 28),
								},
							}):Play()
							tw({
								v = ArrowIconImageLabel,
								t = 0.3,
								s = "Back",
								d = "Out",
								g = {
									Rotation = 180,
								},
							}):Play()
							tw({
								v = DropdownFrameStroke,
								t = 0.3,
								s = "Quad",
								d = "Out",
								g = {
									Transparency = 0.4,
								},
							}):Play()
							task.spawn(function()
								task.wait(0.3)
								isAnimating = false
							end)
						end
						ClickDropdownTextButton.Name = "ClickDropdown"
						ClickDropdownTextButton.Parent = DropdownFrame
						ClickDropdownTextButton.BackgroundTransparency = 1
						ClickDropdownTextButton.Size = UDim2.new(1, 0, 1, 0)
						ClickDropdownTextButton.Position = UDim2.new(0, 0, 0, 0)
						ClickDropdownTextButton.BorderSizePixel = 0
						ClickDropdownTextButton.AutoButtonColor = false
						ClickDropdownTextButton.ZIndex = 10
						ClickDropdownTextButton.Text = ""
						ClickDropdownTextButton.MouseButton1Click:Connect(function()
							if isAnimating then
								return
							end

							if isOpen then
								closeDropdown()
							else
								openDropdown()
							end

							EffectClick2(ClickDropdownTextButton, DropdownFrame)
						end)
						connection = nil
						listenForOutsideClick = function()
							if connection then
								connection:Disconnect()
								connection = nil
							end

							connection = UserInputService.InputBegan:Connect(function(input)
								if not isOpen or isAnimating then
									return
								end

								if
									input.UserInputType == Enum.UserInputType.MouseButton1
									or input.UserInputType == Enum.UserInputType.Touch
								then
									local mouseLocation = UserInputService:GetMouseLocation()
									local AbsolutePosition = DropdownMenuFrame.AbsolutePosition
									local AbsoluteSize = DropdownMenuFrame.AbsoluteSize
									local absolutePosition = DropdownFrame.AbsolutePosition
									local absoluteSize = DropdownFrame.AbsoluteSize

									if
										not (
											mouseLocation.X >= AbsolutePosition.X
												and mouseLocation.X <= AbsolutePosition.X + AbsoluteSize.X
												and mouseLocation.Y >= AbsolutePosition.Y
												and mouseLocation.Y <= AbsolutePosition.Y + AbsoluteSize.Y
											or mouseLocation.X >= absolutePosition.X
												and mouseLocation.X <= absolutePosition.X + absoluteSize.X
												and mouseLocation.Y >= absolutePosition.Y
												and mouseLocation.Y <= absolutePosition.Y + absoluteSize.Y
										)
									then
										closeDropdown()
									end
								end
							end)
						end
						SearchBoxTextBox:GetPropertyChangedSignal("Text"):Connect(function()
							local lowered = string.lower(SearchBoxTextBox.Text)

							for _, child in pairs(MenuScrollScrollingFrame:GetChildren()) do
								if child:IsA("Frame") and child.Name == "Item" then
									local ItemTitle = child:FindFirstChild("ItemTitle")

									if ItemTitle then
										local loweredB = string.lower(ItemTitle.Text)

										child.Visible = lowered == "" or string.find(loweredB, lowered, 1, true) ~= nil
									end
								end
							end
						end)
						SearchBoxTextBox.Focused:Connect(function()
							tw({
								v = SearchBoxTextBoxStroke,
								t = 0.3,
								s = "Quad",
								d = "Out",
								g = {
									Transparency = 0.3,
								},
							}):Play()
						end)
						SearchBoxTextBox.FocusLost:Connect(function()
							tw({
								v = SearchBoxTextBoxStroke,
								t = 0.3,
								s = "Quad",
								d = "Out",
								g = {
									Transparency = 0.7,
								},
							}):Play()
						end)
						addItem = function(text)
							local ItemFrame = Instance.new("Frame")
							local ItemFrameCorner = Instance.new("UICorner")
							local ItemTitleTextLabel = Instance.new("TextLabel")
							local IndicatorFrame = Instance.new("Frame")
							local IndicatorFrameCorner = Instance.new("UICorner")
							local IndicatorFrameGradient = Instance.new("UIGradient")

							ItemFrame.Name = "Item"
							ItemFrame.Parent = MenuScrollScrollingFrame
							ItemFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
							ItemFrame.BackgroundTransparency = 0.4
							ItemFrame.Size = UDim2.new(1, 0, 0, 32)
							ItemFrame.ZIndex = 102
							ItemFrameCorner.Parent = ItemFrame
							ItemFrameCorner.CornerRadius = UDim.new(0, 8)
							ItemTitleTextLabel.Name = "ItemTitle"
							ItemTitleTextLabel.Parent = ItemFrame
							ItemTitleTextLabel.BackgroundTransparency = 1
							ItemTitleTextLabel.Position = UDim2.new(0, 12, 0, 0)
							ItemTitleTextLabel.Size = UDim2.new(1, -44, 1, 0)
							ItemTitleTextLabel.Font = Enum.Font.GothamBold
							ItemTitleTextLabel.Text = text
							ItemTitleTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
							ItemTitleTextLabel.TextSize = 13
							ItemTitleTextLabel.TextTransparency = selectedValues[text] and 0 or 0.5
							ItemTitleTextLabel.TextXAlignment = Enum.TextXAlignment.Left
							ItemTitleTextLabel.TextScaled = true
							ItemTitleTextLabel.TextWrapped = true
							ItemTitleTextLabel.ZIndex = 103

							local ItemTitleTextLabelTextConstraint = Instance.new("UITextSizeConstraint")

							ItemTitleTextLabelTextConstraint.Parent = ItemTitleTextLabel
							ItemTitleTextLabelTextConstraint.MaxTextSize = 13
							ItemTitleTextLabelTextConstraint.MinTextSize = 9
							IndicatorFrame.Name = "Indicator"
							IndicatorFrame.Parent = ItemFrame
							IndicatorFrame.AnchorPoint = Vector2.new(0, 0.5)
							IndicatorFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
							IndicatorFrame.Position = UDim2.new(0, 0, 0.5, 0)
							IndicatorFrame.Size = UDim2.new(0, selectedValues[text] and 4 or 0, 0, 32)
							IndicatorFrame.BackgroundTransparency = selectedValues[text] and 0 or 1
							IndicatorFrame.ZIndex = 102
							IndicatorFrameCorner.Parent = IndicatorFrame
							IndicatorFrameCorner.CornerRadius = UDim.new(1, 0)
							IndicatorFrameGradient.Parent = IndicatorFrame
							IndicatorFrameGradient.Color = ColorSequence.new({
								ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
								ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 170, 255)),
								ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)),
							})
							IndicatorFrameGradient.Rotation = 90

							local ClickTextButton = Instance.new("TextButton")

							ClickTextButton.Name = "Click"
							ClickTextButton.Parent = ItemFrame
							ClickTextButton.BackgroundTransparency = 1
							ClickTextButton.BorderSizePixel = 0
							ClickTextButton.Size = UDim2.new(1, 0, 1, 0)
							ClickTextButton.Position = UDim2.new(0, 0, 0, 0)
							ClickTextButton.ZIndex = 120
							ClickTextButton.AutoButtonColor = false
							ClickTextButton.Font = Enum.Font.SourceSans
							ClickTextButton.Text = ""
							ClickTextButton.MouseEnter:Connect(function()
								tw({
									v = ItemFrame,
									t = 0.2,
									s = "Quad",
									d = "Out",
									g = {
										BackgroundTransparency = 0.2,
									},
								}):Play()
							end)
							ClickTextButton.MouseLeave:Connect(function()
								tw({
									v = ItemFrame,
									t = 0.2,
									s = "Quad",
									d = "Out",
									g = {
										BackgroundTransparency = 0.4,
									},
								}):Play()
							end)
							ClickTextButton.MouseButton1Click:Connect(function()
								EffectClick2(ClickTextButton, ItemFrame)

								if Multi then
									selectedValues[text] = not selectedValues[text]

									local items, task_

									if selectedValues[text] then
										tw({
											v = ItemTitleTextLabel,
											t = 0.2,
											s = "Quad",
											d = "Out",
											g = {
												TextTransparency = 0,
											},
										}):Play()
										tw({
											v = IndicatorFrame,
											t = 0.2,
											s = "Back",
											d = "Out",
											g = {
												Size = UDim2.new(0, 4, 0, 32),
												BackgroundTransparency = 0,
											},
										}):Play()
										items = {}

										for k, v in pairs(selectedValues) do
											if v then
												table.insert(items, k)
											end
										end

										updateDisplayText()
										task_ = task
									else
										tw({
											v = ItemTitleTextLabel,
											t = 0.2,
											s = "Quad",
											d = "Out",
											g = {
												TextTransparency = 0.5,
											},
										}):Play()
										tw({
											v = IndicatorFrame,
											t = 0.2,
											s = "Back",
											d = "Out",
											g = {
												Size = UDim2.new(0, 0, 0, 32),
												BackgroundTransparency = 1,
											},
										}):Play()
										items = {}

										for k, v in pairs(selectedValues) do
											if v then
												table.insert(items, k)
											end
										end

										updateDisplayText()
										task_ = task
									end

									task_.spawn(function()
										pcall(Callback, items)
									end)
								else
									for k in pairs(selectedValues) do
										selectedValues[k] = false
									end

									selectedValues[text] = true

									for _, child in pairs(MenuScrollScrollingFrame:GetChildren()) do
										if child:IsA("Frame") and child.Name == "Item" then
											local ItemTitle = child:FindFirstChild("ItemTitle")
											local Indicator = child:FindFirstChild("Indicator")

											if ItemTitle and Indicator then
												tw({
													v = ItemTitle,
													t = 0.2,
													s = "Quad",
													d = "Out",
													g = {
														TextTransparency = 0.5,
													},
												}):Play()
												tw({
													v = Indicator,
													t = 0.2,
													s = "Back",
													d = "Out",
													g = {
														Size = UDim2.new(0, 0, 0, 32),
														BackgroundTransparency = 1,
													},
												}):Play()
											end
										end
									end

									tw({
										v = ItemTitleTextLabel,
										t = 0.2,
										s = "Quad",
										d = "Out",
										g = {
											TextTransparency = 0,
										},
									}):Play()
									tw({
										v = IndicatorFrame,
										t = 0.2,
										s = "Back",
										d = "Out",
										g = {
											Size = UDim2.new(0, 4, 0, 32),
											BackgroundTransparency = 0,
										},
									}):Play()
									updateDisplayText()
									task.spawn(function()
										pcall(Callback, text)
									end)
									task.wait(0.15)
									closeDropdown()
								end
							end)
						end

						for _, v in pairs(List) do
							addItem(v)
						end

						updateDisplayText()
						listenForOutsideClick()
						table.insert(SearchItems, {
							Frame = DropdownFrame,
							SearchName = TitleB,
							HighlightFrame = HighlightFrameB,
						})
						DropdownFrame.Destroying:Connect(function()
							if connection then
								connection:Disconnect()
								connection = nil
							end

							if DropdownMenuFrame then
								DropdownMenuFrame:Destroy()
							end
						end)
						dropdownApi = {
							Add = function(self, item)
								if not table.find(List, item) then
									table.insert(List, item)
									addItem(item)
								end
							end,
							Remove = function(self, item)
								for k, v in pairs(List) do
									if v == item then
										table.remove(List, k)

										break
									end
								end

								for _, child in pairs(MenuScrollScrollingFrame:GetChildren()) do
									if child:IsA("Frame") and child.Name == "Item" then
										local ItemTitle = child:FindFirstChild("ItemTitle")

										if ItemTitle and ItemTitle.Text == item then
											child:Destroy()

											break
										end
									end
								end

								selectedValues[item] = nil
								updateDisplayText()
							end,
							Clear = function()
								for _, child in pairs(MenuScrollScrollingFrame:GetChildren()) do
									if child:IsA("Frame") and child.Name == "Item" then
										child:Destroy()
									end
								end

								List = {}
								selectedValues = {}
								updateDisplayText()
							end,
							SetValue = function(self, value)
								selectedValues = {}

								local valueB, valueC, valueD, ItemTitle, Indicator, tween, tweenB, tweenC, tweenD

								if type(value) == "table" then
									local iterator, iterTable, iterKey = pairs(value)
									local iteratorB = geniter(iterator, iterTable, iterKey)

									for _, v in iterator, iterTable, iterKey do
										while true do
											selectedValues[v] = true

											local packed = table.pack(iteratorB())

											if not packed[1] then
												break
											end

											v = packed[3]
										end

										local iterator, iterTable, iterKey = pairs(MenuScrollScrollingFrame:GetChildren())

										for _, entry in iterator, iterTable, iterKey do
											if entry:IsA("Frame") and entry.Name == "Item" then
												local child = entry:FindFirstChild("ItemTitle")
												local childB = entry:FindFirstChild("Indicator")

												if child and childB then
													if selectedValues[child.Text] then
														tw({
															v = child,
															t = 0.2,
															s = "Quad",
															d = "Out",
															g = {
																TextTransparency = 0,
															},
														}):Play()
														tw({
															v = childB,
															t = 0.2,
															s = "Back",
															d = "Out",
															g = {
																Size = UDim2.new(0, 4, 0, 32),
																BackgroundTransparency = 0,
															},
														}):Play()
													else
														tw({
															v = child,
															t = 0.2,
															s = "Quad",
															d = "Out",
															g = {
																TextTransparency = 0.5,
															},
														}):Play()
														tw({
															v = childB,
															t = 0.2,
															s = "Back",
															d = "Out",
															g = {
																Size = UDim2.new(0, 0, 0, 32),
																BackgroundTransparency = 1,
															},
														}):Play()
													end
												end
											end
										end

										updateDisplayText()

										return
									end

									valueB, valueC, valueD = pairs(MenuScrollScrollingFrame:GetChildren())

									for _, v in valueB, valueC, valueD do
										if v:IsA("Frame") and v.Name == "Item" then
											ItemTitle = v:FindFirstChild("ItemTitle")
											Indicator = v:FindFirstChild("Indicator")

											if ItemTitle and Indicator then
												if selectedValues[ItemTitle.Text] then
													tween = tw({
														v = ItemTitle,
														t = 0.2,
														s = "Quad",
														d = "Out",
														g = {
															TextTransparency = 0,
														},
													})
													tween:Play()
													tweenB = tw({
														v = Indicator,
														t = 0.2,
														s = "Back",
														d = "Out",
														g = {
															Size = UDim2.new(0, 4, 0, 32),
															BackgroundTransparency = 0,
														},
													})
													tweenB:Play()
												else
													tweenC = tw({
														v = ItemTitle,
														t = 0.2,
														s = "Quad",
														d = "Out",
														g = {
															TextTransparency = 0.5,
														},
													})
													tweenC:Play()
													tweenD = tw({
														v = Indicator,
														t = 0.2,
														s = "Back",
														d = "Out",
														g = {
															Size = UDim2.new(0, 0, 0, 32),
															BackgroundTransparency = 1,
														},
													})
													tweenD:Play()
												end
											end
										end
									end
								elseif type(value) == "string" and value ~= "" then
									selectedValues[value] = true
									valueB, valueC, valueD = pairs(MenuScrollScrollingFrame:GetChildren())

									for _, v in valueB, valueC, valueD do
										if v:IsA("Frame") and v.Name == "Item" then
											ItemTitle = v:FindFirstChild("ItemTitle")
											Indicator = v:FindFirstChild("Indicator")

											if ItemTitle and Indicator then
												if selectedValues[ItemTitle.Text] then
													tween = tw({
														v = ItemTitle,
														t = 0.2,
														s = "Quad",
														d = "Out",
														g = {
															TextTransparency = 0,
														},
													})
													tween:Play()
													tweenB = tw({
														v = Indicator,
														t = 0.2,
														s = "Back",
														d = "Out",
														g = {
															Size = UDim2.new(0, 4, 0, 32),
															BackgroundTransparency = 0,
														},
													})
													tweenB:Play()
												else
													tweenC = tw({
														v = ItemTitle,
														t = 0.2,
														s = "Quad",
														d = "Out",
														g = {
															TextTransparency = 0.5,
														},
													})
													tweenC:Play()
													tweenD = tw({
														v = Indicator,
														t = 0.2,
														s = "Back",
														d = "Out",
														g = {
															Size = UDim2.new(0, 0, 0, 32),
															BackgroundTransparency = 1,
														},
													})
													tweenD:Play()
												end
											end
										end
									end
								else
									valueB, valueC, valueD = pairs(MenuScrollScrollingFrame:GetChildren())

									for _, v in valueB, valueC, valueD do
										if v:IsA("Frame") and v.Name == "Item" then
											ItemTitle = v:FindFirstChild("ItemTitle")
											Indicator = v:FindFirstChild("Indicator")

											if ItemTitle and Indicator then
												if selectedValues[ItemTitle.Text] then
													tw({
														v = ItemTitle,
														t = 0.2,
														s = "Quad",
														d = "Out",
														g = {
															TextTransparency = 0,
														},
													}):Play()
													tw({
														v = Indicator,
														t = 0.2,
														s = "Back",
														d = "Out",
														g = {
															Size = UDim2.new(0, 4, 0, 32),
															BackgroundTransparency = 0,
														},
													}):Play()
												else
													tw({
														v = ItemTitle,
														t = 0.2,
														s = "Quad",
														d = "Out",
														g = {
															TextTransparency = 0.5,
														},
													}):Play()
													tw({
														v = Indicator,
														t = 0.2,
														s = "Back",
														d = "Out",
														g = {
															Size = UDim2.new(0, 0, 0, 32),
															BackgroundTransparency = 1,
														},
													}):Play()
												end
											end
										end
									end
								end

								updateDisplayText()
							end,
							GetValue = function()
								if not Multi then
									for k, v in pairs(selectedValues) do
										if v then
											return k
										end
									end

									return nil
								end

								local items = {}

								for k, v in pairs(selectedValues) do
									if v then
										table.insert(items, k)
									end
								end

								return items
							end,
							SetTitle = function(self, text)
								TitleTextLabel.Text = text
								TitleTextLabelB.Text = text

								for _, v in pairs(SearchItems) do
									if v.Frame == DropdownFrame then
										v.SearchName = text

										break
									end
								end
							end,
							SetDesc = function(self, text)
								if DescTextLabel then
									DescTextLabel.Text = text
								end
							end,
							Visible = function(self, visible)
								DropdownFrame.Visible = visible

								if not visible and isOpen then
									closeDropdown()
								end
							end,
						}
					elseif Value == "" then
						updateDisplayText = function()
							if Multi then
								local items = {}

								for k, v in pairs(selectedValues) do
									if v then
										table.insert(items, k)
									end
								end

								if #items > 0 then
									ValueDisplayTextLabel.Text = #items .. " Selected"
								else
									ValueDisplayTextLabel.Text = "Select..."
								end
							else
								local flag = false

								for k, v in pairs(selectedValues) do
									if v then
										ValueDisplayTextLabel.Text = k
										flag = true

										break
									end
								end

								if not flag then
									ValueDisplayTextLabel.Text = "Select..."
								end
							end
						end
						closeDropdown = function()
							if isAnimating or not isOpen then
								return
							end

							isAnimating = true
							isOpen = false
							tw({
								v = DropdownMenuFrame,
								t = 0.25,
								s = "Quad",
								d = "Out",
								g = {
									Size = UDim2.new(0, 0, 1, 0),
								},
							}):Play()
							tw({
								v = SearchBoxTextBox,
								t = 0.2,
								s = "Quad",
								d = "Out",
								g = {
									Size = UDim2.new(0, 0, 0, 28),
								},
							}):Play()
							tw({
								v = ArrowIconImageLabel,
								t = 0.25,
								s = "Quad",
								d = "Out",
								g = {
									Rotation = 0,
								},
							}):Play()
							tw({
								v = DropdownFrameStroke,
								t = 0.25,
								s = "Quad",
								d = "Out",
								g = {
									Transparency = 0.75,
								},
							}):Play()
							task.spawn(function()
								task.wait(0.25)

								if not isOpen then
									DropdownMenuFrame.Visible = false
								end

								isAnimating = false
							end)
						end
						openDropdown = function()
							if isAnimating or isOpen then
								return
							end

							isAnimating = true
							isOpen = true
							DropdownMenuFrame.Visible = true
							SearchBoxTextBox.Text = ""
							tw({
								v = DropdownMenuFrame,
								t = 0.3,
								s = "Back",
								d = "Out",
								g = {
									Size = UDim2.new(0, 240, 1, 0),
								},
							}):Play()
							tw({
								v = SearchBoxTextBox,
								t = 0.25,
								s = "Back",
								d = "Out",
								g = {
									Size = UDim2.new(0.9, 0, 0, 28),
								},
							}):Play()
							tw({
								v = ArrowIconImageLabel,
								t = 0.3,
								s = "Back",
								d = "Out",
								g = {
									Rotation = 180,
								},
							}):Play()
							tw({
								v = DropdownFrameStroke,
								t = 0.3,
								s = "Quad",
								d = "Out",
								g = {
									Transparency = 0.4,
								},
							}):Play()
							task.spawn(function()
								task.wait(0.3)
								isAnimating = false
							end)
						end
						ClickDropdownTextButton.Name = "ClickDropdown"
						ClickDropdownTextButton.Parent = DropdownFrame
						ClickDropdownTextButton.BackgroundTransparency = 1
						ClickDropdownTextButton.Size = UDim2.new(1, 0, 1, 0)
						ClickDropdownTextButton.Position = UDim2.new(0, 0, 0, 0)
						ClickDropdownTextButton.BorderSizePixel = 0
						ClickDropdownTextButton.AutoButtonColor = false
						ClickDropdownTextButton.ZIndex = 10
						ClickDropdownTextButton.Text = ""
						ClickDropdownTextButton.MouseButton1Click:Connect(function()
							if isAnimating then
								return
							end

							if isOpen then
								closeDropdown()
							else
								openDropdown()
							end

							EffectClick2(ClickDropdownTextButton, DropdownFrame)
						end)
						connection = nil
						listenForOutsideClick = function()
							if connection then
								connection:Disconnect()
								connection = nil
							end

							connection = UserInputService.InputBegan:Connect(function(input)
								if not isOpen or isAnimating then
									return
								end

								if
									input.UserInputType == Enum.UserInputType.MouseButton1
									or input.UserInputType == Enum.UserInputType.Touch
								then
									local mouseLocation = UserInputService:GetMouseLocation()
									local AbsolutePosition = DropdownMenuFrame.AbsolutePosition
									local AbsoluteSize = DropdownMenuFrame.AbsoluteSize
									local absolutePosition = DropdownFrame.AbsolutePosition
									local absoluteSize = DropdownFrame.AbsoluteSize

									if
										not (
											mouseLocation.X >= AbsolutePosition.X
												and mouseLocation.X <= AbsolutePosition.X + AbsoluteSize.X
												and mouseLocation.Y >= AbsolutePosition.Y
												and mouseLocation.Y <= AbsolutePosition.Y + AbsoluteSize.Y
											or mouseLocation.X >= absolutePosition.X
												and mouseLocation.X <= absolutePosition.X + absoluteSize.X
												and mouseLocation.Y >= absolutePosition.Y
												and mouseLocation.Y <= absolutePosition.Y + absoluteSize.Y
										)
									then
										closeDropdown()
									end
								end
							end)
						end
						SearchBoxTextBox:GetPropertyChangedSignal("Text"):Connect(function()
							local lowered = string.lower(SearchBoxTextBox.Text)

							for _, child in pairs(MenuScrollScrollingFrame:GetChildren()) do
								if child:IsA("Frame") and child.Name == "Item" then
									local ItemTitle = child:FindFirstChild("ItemTitle")

									if ItemTitle then
										local loweredB = string.lower(ItemTitle.Text)

										child.Visible = lowered == "" or string.find(loweredB, lowered, 1, true) ~= nil
									end
								end
							end
						end)
						SearchBoxTextBox.Focused:Connect(function()
							tw({
								v = SearchBoxTextBoxStroke,
								t = 0.3,
								s = "Quad",
								d = "Out",
								g = {
									Transparency = 0.3,
								},
							}):Play()
						end)
						SearchBoxTextBox.FocusLost:Connect(function()
							tw({
								v = SearchBoxTextBoxStroke,
								t = 0.3,
								s = "Quad",
								d = "Out",
								g = {
									Transparency = 0.7,
								},
							}):Play()
						end)
						addItem = function(text)
							local ItemFrame = Instance.new("Frame")
							local ItemFrameCorner = Instance.new("UICorner")
							local ItemTitleTextLabel = Instance.new("TextLabel")
							local IndicatorFrame = Instance.new("Frame")
							local IndicatorFrameCorner = Instance.new("UICorner")
							local IndicatorFrameGradient = Instance.new("UIGradient")

							ItemFrame.Name = "Item"
							ItemFrame.Parent = MenuScrollScrollingFrame
							ItemFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
							ItemFrame.BackgroundTransparency = 0.4
							ItemFrame.Size = UDim2.new(1, 0, 0, 32)
							ItemFrame.ZIndex = 102
							ItemFrameCorner.Parent = ItemFrame
							ItemFrameCorner.CornerRadius = UDim.new(0, 8)
							ItemTitleTextLabel.Name = "ItemTitle"
							ItemTitleTextLabel.Parent = ItemFrame
							ItemTitleTextLabel.BackgroundTransparency = 1
							ItemTitleTextLabel.Position = UDim2.new(0, 12, 0, 0)
							ItemTitleTextLabel.Size = UDim2.new(1, -44, 1, 0)
							ItemTitleTextLabel.Font = Enum.Font.GothamBold
							ItemTitleTextLabel.Text = text
							ItemTitleTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
							ItemTitleTextLabel.TextSize = 13
							ItemTitleTextLabel.TextTransparency = selectedValues[text] and 0 or 0.5
							ItemTitleTextLabel.TextXAlignment = Enum.TextXAlignment.Left
							ItemTitleTextLabel.TextScaled = true
							ItemTitleTextLabel.TextWrapped = true
							ItemTitleTextLabel.ZIndex = 103

							local ItemTitleTextLabelTextConstraint = Instance.new("UITextSizeConstraint")

							ItemTitleTextLabelTextConstraint.Parent = ItemTitleTextLabel
							ItemTitleTextLabelTextConstraint.MaxTextSize = 13
							ItemTitleTextLabelTextConstraint.MinTextSize = 9
							IndicatorFrame.Name = "Indicator"
							IndicatorFrame.Parent = ItemFrame
							IndicatorFrame.AnchorPoint = Vector2.new(0, 0.5)
							IndicatorFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
							IndicatorFrame.Position = UDim2.new(0, 0, 0.5, 0)
							IndicatorFrame.Size = UDim2.new(0, selectedValues[text] and 4 or 0, 0, 32)
							IndicatorFrame.BackgroundTransparency = selectedValues[text] and 0 or 1
							IndicatorFrame.ZIndex = 102
							IndicatorFrameCorner.Parent = IndicatorFrame
							IndicatorFrameCorner.CornerRadius = UDim.new(1, 0)
							IndicatorFrameGradient.Parent = IndicatorFrame
							IndicatorFrameGradient.Color = ColorSequence.new({
								ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
								ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 170, 255)),
								ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)),
							})
							IndicatorFrameGradient.Rotation = 90

							local ClickTextButton = Instance.new("TextButton")

							ClickTextButton.Name = "Click"
							ClickTextButton.Parent = ItemFrame
							ClickTextButton.BackgroundTransparency = 1
							ClickTextButton.BorderSizePixel = 0
							ClickTextButton.Size = UDim2.new(1, 0, 1, 0)
							ClickTextButton.Position = UDim2.new(0, 0, 0, 0)
							ClickTextButton.ZIndex = 120
							ClickTextButton.AutoButtonColor = false
							ClickTextButton.Font = Enum.Font.SourceSans
							ClickTextButton.Text = ""
							ClickTextButton.MouseEnter:Connect(function()
								tw({
									v = ItemFrame,
									t = 0.2,
									s = "Quad",
									d = "Out",
									g = {
										BackgroundTransparency = 0.2,
									},
								}):Play()
							end)
							ClickTextButton.MouseLeave:Connect(function()
								tw({
									v = ItemFrame,
									t = 0.2,
									s = "Quad",
									d = "Out",
									g = {
										BackgroundTransparency = 0.4,
									},
								}):Play()
							end)
							ClickTextButton.MouseButton1Click:Connect(function()
								EffectClick2(ClickTextButton, ItemFrame)

								if Multi then
									selectedValues[text] = not selectedValues[text]

									local items, task_

									if selectedValues[text] then
										tw({
											v = ItemTitleTextLabel,
											t = 0.2,
											s = "Quad",
											d = "Out",
											g = {
												TextTransparency = 0,
											},
										}):Play()
										tw({
											v = IndicatorFrame,
											t = 0.2,
											s = "Back",
											d = "Out",
											g = {
												Size = UDim2.new(0, 4, 0, 32),
												BackgroundTransparency = 0,
											},
										}):Play()
										items = {}

										for k, v in pairs(selectedValues) do
											if v then
												table.insert(items, k)
											end
										end

										updateDisplayText()
										task_ = task
									else
										tw({
											v = ItemTitleTextLabel,
											t = 0.2,
											s = "Quad",
											d = "Out",
											g = {
												TextTransparency = 0.5,
											},
										}):Play()
										tw({
											v = IndicatorFrame,
											t = 0.2,
											s = "Back",
											d = "Out",
											g = {
												Size = UDim2.new(0, 0, 0, 32),
												BackgroundTransparency = 1,
											},
										}):Play()
										items = {}

										for k, v in pairs(selectedValues) do
											if v then
												table.insert(items, k)
											end
										end

										updateDisplayText()
										task_ = task
									end

									task_.spawn(function()
										pcall(Callback, items)
									end)
								else
									for k in pairs(selectedValues) do
										selectedValues[k] = false
									end

									selectedValues[text] = true

									for _, child in pairs(MenuScrollScrollingFrame:GetChildren()) do
										if child:IsA("Frame") and child.Name == "Item" then
											local ItemTitle = child:FindFirstChild("ItemTitle")
											local Indicator = child:FindFirstChild("Indicator")

											if ItemTitle and Indicator then
												tw({
													v = ItemTitle,
													t = 0.2,
													s = "Quad",
													d = "Out",
													g = {
														TextTransparency = 0.5,
													},
												}):Play()
												tw({
													v = Indicator,
													t = 0.2,
													s = "Back",
													d = "Out",
													g = {
														Size = UDim2.new(0, 0, 0, 32),
														BackgroundTransparency = 1,
													},
												}):Play()
											end
										end
									end

									tw({
										v = ItemTitleTextLabel,
										t = 0.2,
										s = "Quad",
										d = "Out",
										g = {
											TextTransparency = 0,
										},
									}):Play()
									tw({
										v = IndicatorFrame,
										t = 0.2,
										s = "Back",
										d = "Out",
										g = {
											Size = UDim2.new(0, 4, 0, 32),
											BackgroundTransparency = 0,
										},
									}):Play()
									updateDisplayText()
									task.spawn(function()
										pcall(Callback, text)
									end)
									task.wait(0.15)
									closeDropdown()
								end
							end)
						end

						for _, v in pairs(List) do
							addItem(v)
						end

						updateDisplayText()
						listenForOutsideClick()
						table.insert(SearchItems, {
							Frame = DropdownFrame,
							SearchName = TitleB,
							HighlightFrame = HighlightFrameB,
						})
						DropdownFrame.Destroying:Connect(function()
							if connection then
								connection:Disconnect()
								connection = nil
							end

							if DropdownMenuFrame then
								DropdownMenuFrame:Destroy()
							end
						end)
						dropdownApi = {
							Add = function(self, item)
								if not table.find(List, item) then
									table.insert(List, item)
									addItem(item)
								end
							end,
							Remove = function(self, item)
								for k, v in pairs(List) do
									if v == item then
										table.remove(List, k)

										break
									end
								end

								for _, child in pairs(MenuScrollScrollingFrame:GetChildren()) do
									if child:IsA("Frame") and child.Name == "Item" then
										local ItemTitle = child:FindFirstChild("ItemTitle")

										if ItemTitle and ItemTitle.Text == item then
											child:Destroy()

											break
										end
									end
								end

								selectedValues[item] = nil
								updateDisplayText()
							end,
							Clear = function()
								for _, child in pairs(MenuScrollScrollingFrame:GetChildren()) do
									if child:IsA("Frame") and child.Name == "Item" then
										child:Destroy()
									end
								end

								List = {}
								selectedValues = {}
								updateDisplayText()
							end,
							SetValue = function(self, value)
								selectedValues = {}

								local valueB, valueC, valueD, ItemTitle, Indicator, tween, tweenB, tweenC, tweenD

								if type(value) == "table" then
									local iterator, iterTable, iterKey = pairs(value)
									local iteratorB = geniter(iterator, iterTable, iterKey)

									for _, v in iterator, iterTable, iterKey do
										while true do
											selectedValues[v] = true

											local packed = table.pack(iteratorB())

											if not packed[1] then
												break
											end

											v = packed[3]
										end

										local iterator, iterTable, iterKey = pairs(MenuScrollScrollingFrame:GetChildren())

										for _, entry in iterator, iterTable, iterKey do
											if entry:IsA("Frame") and entry.Name == "Item" then
												local child = entry:FindFirstChild("ItemTitle")
												local childB = entry:FindFirstChild("Indicator")

												if child and childB then
													if selectedValues[child.Text] then
														tw({
															v = child,
															t = 0.2,
															s = "Quad",
															d = "Out",
															g = {
																TextTransparency = 0,
															},
														}):Play()
														tw({
															v = childB,
															t = 0.2,
															s = "Back",
															d = "Out",
															g = {
																Size = UDim2.new(0, 4, 0, 32),
																BackgroundTransparency = 0,
															},
														}):Play()
													else
														tw({
															v = child,
															t = 0.2,
															s = "Quad",
															d = "Out",
															g = {
																TextTransparency = 0.5,
															},
														}):Play()
														tw({
															v = childB,
															t = 0.2,
															s = "Back",
															d = "Out",
															g = {
																Size = UDim2.new(0, 0, 0, 32),
																BackgroundTransparency = 1,
															},
														}):Play()
													end
												end
											end
										end

										updateDisplayText()

										return
									end

									valueB, valueC, valueD = pairs(MenuScrollScrollingFrame:GetChildren())

									for _, v in valueB, valueC, valueD do
										if v:IsA("Frame") and v.Name == "Item" then
											ItemTitle = v:FindFirstChild("ItemTitle")
											Indicator = v:FindFirstChild("Indicator")

											if ItemTitle and Indicator then
												if selectedValues[ItemTitle.Text] then
													tween = tw({
														v = ItemTitle,
														t = 0.2,
														s = "Quad",
														d = "Out",
														g = {
															TextTransparency = 0,
														},
													})
													tween:Play()
													tweenB = tw({
														v = Indicator,
														t = 0.2,
														s = "Back",
														d = "Out",
														g = {
															Size = UDim2.new(0, 4, 0, 32),
															BackgroundTransparency = 0,
														},
													})
													tweenB:Play()
												else
													tweenC = tw({
														v = ItemTitle,
														t = 0.2,
														s = "Quad",
														d = "Out",
														g = {
															TextTransparency = 0.5,
														},
													})
													tweenC:Play()
													tweenD = tw({
														v = Indicator,
														t = 0.2,
														s = "Back",
														d = "Out",
														g = {
															Size = UDim2.new(0, 0, 0, 32),
															BackgroundTransparency = 1,
														},
													})
													tweenD:Play()
												end
											end
										end
									end
								elseif type(value) == "string" and value ~= "" then
									selectedValues[value] = true
									valueB, valueC, valueD = pairs(MenuScrollScrollingFrame:GetChildren())

									for _, v in valueB, valueC, valueD do
										if v:IsA("Frame") and v.Name == "Item" then
											ItemTitle = v:FindFirstChild("ItemTitle")
											Indicator = v:FindFirstChild("Indicator")

											if ItemTitle and Indicator then
												if selectedValues[ItemTitle.Text] then
													tween = tw({
														v = ItemTitle,
														t = 0.2,
														s = "Quad",
														d = "Out",
														g = {
															TextTransparency = 0,
														},
													})
													tween:Play()
													tweenB = tw({
														v = Indicator,
														t = 0.2,
														s = "Back",
														d = "Out",
														g = {
															Size = UDim2.new(0, 4, 0, 32),
															BackgroundTransparency = 0,
														},
													})
													tweenB:Play()
												else
													tweenC = tw({
														v = ItemTitle,
														t = 0.2,
														s = "Quad",
														d = "Out",
														g = {
															TextTransparency = 0.5,
														},
													})
													tweenC:Play()
													tweenD = tw({
														v = Indicator,
														t = 0.2,
														s = "Back",
														d = "Out",
														g = {
															Size = UDim2.new(0, 0, 0, 32),
															BackgroundTransparency = 1,
														},
													})
													tweenD:Play()
												end
											end
										end
									end
								else
									valueB, valueC, valueD = pairs(MenuScrollScrollingFrame:GetChildren())

									for _, v in valueB, valueC, valueD do
										if v:IsA("Frame") and v.Name == "Item" then
											ItemTitle = v:FindFirstChild("ItemTitle")
											Indicator = v:FindFirstChild("Indicator")

											if ItemTitle and Indicator then
												if selectedValues[ItemTitle.Text] then
													tw({
														v = ItemTitle,
														t = 0.2,
														s = "Quad",
														d = "Out",
														g = {
															TextTransparency = 0,
														},
													}):Play()
													tw({
														v = Indicator,
														t = 0.2,
														s = "Back",
														d = "Out",
														g = {
															Size = UDim2.new(0, 4, 0, 32),
															BackgroundTransparency = 0,
														},
													}):Play()
												else
													tw({
														v = ItemTitle,
														t = 0.2,
														s = "Quad",
														d = "Out",
														g = {
															TextTransparency = 0.5,
														},
													}):Play()
													tw({
														v = Indicator,
														t = 0.2,
														s = "Back",
														d = "Out",
														g = {
															Size = UDim2.new(0, 0, 0, 32),
															BackgroundTransparency = 1,
														},
													}):Play()
												end
											end
										end
									end
								end

								updateDisplayText()
							end,
							GetValue = function()
								if not Multi then
									for k, v in pairs(selectedValues) do
										if v then
											return k
										end
									end

									return nil
								end

								local items = {}

								for k, v in pairs(selectedValues) do
									if v then
										table.insert(items, k)
									end
								end

								return items
							end,
							SetTitle = function(self, text)
								TitleTextLabel.Text = text
								TitleTextLabelB.Text = text

								for _, v in pairs(SearchItems) do
									if v.Frame == DropdownFrame then
										v.SearchName = text

										break
									end
								end
							end,
							SetDesc = function(self, text)
								if DescTextLabel then
									DescTextLabel.Text = text
								end
							end,
							Visible = function(self, visible)
								DropdownFrame.Visible = visible

								if not visible and isOpen then
									closeDropdown()
								end
							end,
						}
					else
						selectedValues[Value] = true
						updateDisplayText = function()
							if Multi then
								local items = {}

								for k, v in pairs(selectedValues) do
									if v then
										table.insert(items, k)
									end
								end

								if #items > 0 then
									ValueDisplayTextLabel.Text = #items .. " Selected"
								else
									ValueDisplayTextLabel.Text = "Select..."
								end
							else
								local flag = false

								for k, v in pairs(selectedValues) do
									if v then
										ValueDisplayTextLabel.Text = k
										flag = true

										break
									end
								end

								if not flag then
									ValueDisplayTextLabel.Text = "Select..."
								end
							end
						end
						closeDropdown = function()
							if isAnimating or not isOpen then
								return
							end

							isAnimating = true
							isOpen = false
							tw({
								v = DropdownMenuFrame,
								t = 0.25,
								s = "Quad",
								d = "Out",
								g = {
									Size = UDim2.new(0, 0, 1, 0),
								},
							}):Play()
							tw({
								v = SearchBoxTextBox,
								t = 0.2,
								s = "Quad",
								d = "Out",
								g = {
									Size = UDim2.new(0, 0, 0, 28),
								},
							}):Play()
							tw({
								v = ArrowIconImageLabel,
								t = 0.25,
								s = "Quad",
								d = "Out",
								g = {
									Rotation = 0,
								},
							}):Play()
							tw({
								v = DropdownFrameStroke,
								t = 0.25,
								s = "Quad",
								d = "Out",
								g = {
									Transparency = 0.75,
								},
							}):Play()
							task.spawn(function()
								task.wait(0.25)

								if not isOpen then
									DropdownMenuFrame.Visible = false
								end

								isAnimating = false
							end)
						end
						openDropdown = function()
							if isAnimating or isOpen then
								return
							end

							isAnimating = true
							isOpen = true
							DropdownMenuFrame.Visible = true
							SearchBoxTextBox.Text = ""
							tw({
								v = DropdownMenuFrame,
								t = 0.3,
								s = "Back",
								d = "Out",
								g = {
									Size = UDim2.new(0, 240, 1, 0),
								},
							}):Play()
							tw({
								v = SearchBoxTextBox,
								t = 0.25,
								s = "Back",
								d = "Out",
								g = {
									Size = UDim2.new(0.9, 0, 0, 28),
								},
							}):Play()
							tw({
								v = ArrowIconImageLabel,
								t = 0.3,
								s = "Back",
								d = "Out",
								g = {
									Rotation = 180,
								},
							}):Play()
							tw({
								v = DropdownFrameStroke,
								t = 0.3,
								s = "Quad",
								d = "Out",
								g = {
									Transparency = 0.4,
								},
							}):Play()
							task.spawn(function()
								task.wait(0.3)
								isAnimating = false
							end)
						end
						ClickDropdownTextButton.Name = "ClickDropdown"
						ClickDropdownTextButton.Parent = DropdownFrame
						ClickDropdownTextButton.BackgroundTransparency = 1
						ClickDropdownTextButton.Size = UDim2.new(1, 0, 1, 0)
						ClickDropdownTextButton.Position = UDim2.new(0, 0, 0, 0)
						ClickDropdownTextButton.BorderSizePixel = 0
						ClickDropdownTextButton.AutoButtonColor = false
						ClickDropdownTextButton.ZIndex = 10
						ClickDropdownTextButton.Text = ""
						ClickDropdownTextButton.MouseButton1Click:Connect(function()
							if isAnimating then
								return
							end

							if isOpen then
								closeDropdown()
							else
								openDropdown()
							end

							EffectClick2(ClickDropdownTextButton, DropdownFrame)
						end)
						connection = nil
						listenForOutsideClick = function()
							if connection then
								connection:Disconnect()
								connection = nil
							end

							connection = UserInputService.InputBegan:Connect(function(input)
								if not isOpen or isAnimating then
									return
								end

								if
									input.UserInputType == Enum.UserInputType.MouseButton1
									or input.UserInputType == Enum.UserInputType.Touch
								then
									local mouseLocation = UserInputService:GetMouseLocation()
									local AbsolutePosition = DropdownMenuFrame.AbsolutePosition
									local AbsoluteSize = DropdownMenuFrame.AbsoluteSize
									local absolutePosition = DropdownFrame.AbsolutePosition
									local absoluteSize = DropdownFrame.AbsoluteSize

									if
										not (
											mouseLocation.X >= AbsolutePosition.X
												and mouseLocation.X <= AbsolutePosition.X + AbsoluteSize.X
												and mouseLocation.Y >= AbsolutePosition.Y
												and mouseLocation.Y <= AbsolutePosition.Y + AbsoluteSize.Y
											or mouseLocation.X >= absolutePosition.X
												and mouseLocation.X <= absolutePosition.X + absoluteSize.X
												and mouseLocation.Y >= absolutePosition.Y
												and mouseLocation.Y <= absolutePosition.Y + absoluteSize.Y
										)
									then
										closeDropdown()
									end
								end
							end)
						end
						SearchBoxTextBox:GetPropertyChangedSignal("Text"):Connect(function()
							local lowered = string.lower(SearchBoxTextBox.Text)

							for _, child in pairs(MenuScrollScrollingFrame:GetChildren()) do
								if child:IsA("Frame") and child.Name == "Item" then
									local ItemTitle = child:FindFirstChild("ItemTitle")

									if ItemTitle then
										local loweredB = string.lower(ItemTitle.Text)

										child.Visible = lowered == "" or string.find(loweredB, lowered, 1, true) ~= nil
									end
								end
							end
						end)
						SearchBoxTextBox.Focused:Connect(function()
							tw({
								v = SearchBoxTextBoxStroke,
								t = 0.3,
								s = "Quad",
								d = "Out",
								g = {
									Transparency = 0.3,
								},
							}):Play()
						end)
						SearchBoxTextBox.FocusLost:Connect(function()
							tw({
								v = SearchBoxTextBoxStroke,
								t = 0.3,
								s = "Quad",
								d = "Out",
								g = {
									Transparency = 0.7,
								},
							}):Play()
						end)
						addItem = function(text)
							local ItemFrame = Instance.new("Frame")
							local ItemFrameCorner = Instance.new("UICorner")
							local ItemTitleTextLabel = Instance.new("TextLabel")
							local IndicatorFrame = Instance.new("Frame")
							local IndicatorFrameCorner = Instance.new("UICorner")
							local IndicatorFrameGradient = Instance.new("UIGradient")

							ItemFrame.Name = "Item"
							ItemFrame.Parent = MenuScrollScrollingFrame
							ItemFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
							ItemFrame.BackgroundTransparency = 0.4
							ItemFrame.Size = UDim2.new(1, 0, 0, 32)
							ItemFrame.ZIndex = 102
							ItemFrameCorner.Parent = ItemFrame
							ItemFrameCorner.CornerRadius = UDim.new(0, 8)
							ItemTitleTextLabel.Name = "ItemTitle"
							ItemTitleTextLabel.Parent = ItemFrame
							ItemTitleTextLabel.BackgroundTransparency = 1
							ItemTitleTextLabel.Position = UDim2.new(0, 12, 0, 0)
							ItemTitleTextLabel.Size = UDim2.new(1, -44, 1, 0)
							ItemTitleTextLabel.Font = Enum.Font.GothamBold
							ItemTitleTextLabel.Text = text
							ItemTitleTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
							ItemTitleTextLabel.TextSize = 13
							ItemTitleTextLabel.TextTransparency = selectedValues[text] and 0 or 0.5
							ItemTitleTextLabel.TextXAlignment = Enum.TextXAlignment.Left
							ItemTitleTextLabel.TextScaled = true
							ItemTitleTextLabel.TextWrapped = true
							ItemTitleTextLabel.ZIndex = 103

							local ItemTitleTextLabelTextConstraint = Instance.new("UITextSizeConstraint")

							ItemTitleTextLabelTextConstraint.Parent = ItemTitleTextLabel
							ItemTitleTextLabelTextConstraint.MaxTextSize = 13
							ItemTitleTextLabelTextConstraint.MinTextSize = 9
							IndicatorFrame.Name = "Indicator"
							IndicatorFrame.Parent = ItemFrame
							IndicatorFrame.AnchorPoint = Vector2.new(0, 0.5)
							IndicatorFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
							IndicatorFrame.Position = UDim2.new(0, 0, 0.5, 0)
							IndicatorFrame.Size = UDim2.new(0, selectedValues[text] and 4 or 0, 0, 32)
							IndicatorFrame.BackgroundTransparency = selectedValues[text] and 0 or 1
							IndicatorFrame.ZIndex = 102
							IndicatorFrameCorner.Parent = IndicatorFrame
							IndicatorFrameCorner.CornerRadius = UDim.new(1, 0)
							IndicatorFrameGradient.Parent = IndicatorFrame
							IndicatorFrameGradient.Color = ColorSequence.new({
								ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
								ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 170, 255)),
								ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)),
							})
							IndicatorFrameGradient.Rotation = 90

							local ClickTextButton = Instance.new("TextButton")

							ClickTextButton.Name = "Click"
							ClickTextButton.Parent = ItemFrame
							ClickTextButton.BackgroundTransparency = 1
							ClickTextButton.BorderSizePixel = 0
							ClickTextButton.Size = UDim2.new(1, 0, 1, 0)
							ClickTextButton.Position = UDim2.new(0, 0, 0, 0)
							ClickTextButton.ZIndex = 120
							ClickTextButton.AutoButtonColor = false
							ClickTextButton.Font = Enum.Font.SourceSans
							ClickTextButton.Text = ""
							ClickTextButton.MouseEnter:Connect(function()
								tw({
									v = ItemFrame,
									t = 0.2,
									s = "Quad",
									d = "Out",
									g = {
										BackgroundTransparency = 0.2,
									},
								}):Play()
							end)
							ClickTextButton.MouseLeave:Connect(function()
								tw({
									v = ItemFrame,
									t = 0.2,
									s = "Quad",
									d = "Out",
									g = {
										BackgroundTransparency = 0.4,
									},
								}):Play()
							end)
							ClickTextButton.MouseButton1Click:Connect(function()
								EffectClick2(ClickTextButton, ItemFrame)

								if Multi then
									selectedValues[text] = not selectedValues[text]

									local items, task_

									if selectedValues[text] then
										tw({
											v = ItemTitleTextLabel,
											t = 0.2,
											s = "Quad",
											d = "Out",
											g = {
												TextTransparency = 0,
											},
										}):Play()
										tw({
											v = IndicatorFrame,
											t = 0.2,
											s = "Back",
											d = "Out",
											g = {
												Size = UDim2.new(0, 4, 0, 32),
												BackgroundTransparency = 0,
											},
										}):Play()
										items = {}

										for k, v in pairs(selectedValues) do
											if v then
												table.insert(items, k)
											end
										end

										updateDisplayText()
										task_ = task
									else
										tw({
											v = ItemTitleTextLabel,
											t = 0.2,
											s = "Quad",
											d = "Out",
											g = {
												TextTransparency = 0.5,
											},
										}):Play()
										tw({
											v = IndicatorFrame,
											t = 0.2,
											s = "Back",
											d = "Out",
											g = {
												Size = UDim2.new(0, 0, 0, 32),
												BackgroundTransparency = 1,
											},
										}):Play()
										items = {}

										for k, v in pairs(selectedValues) do
											if v then
												table.insert(items, k)
											end
										end

										updateDisplayText()
										task_ = task
									end

									task_.spawn(function()
										pcall(Callback, items)
									end)
								else
									for k in pairs(selectedValues) do
										selectedValues[k] = false
									end

									selectedValues[text] = true

									for _, child in pairs(MenuScrollScrollingFrame:GetChildren()) do
										if child:IsA("Frame") and child.Name == "Item" then
											local ItemTitle = child:FindFirstChild("ItemTitle")
											local Indicator = child:FindFirstChild("Indicator")

											if ItemTitle and Indicator then
												tw({
													v = ItemTitle,
													t = 0.2,
													s = "Quad",
													d = "Out",
													g = {
														TextTransparency = 0.5,
													},
												}):Play()
												tw({
													v = Indicator,
													t = 0.2,
													s = "Back",
													d = "Out",
													g = {
														Size = UDim2.new(0, 0, 0, 32),
														BackgroundTransparency = 1,
													},
												}):Play()
											end
										end
									end

									tw({
										v = ItemTitleTextLabel,
										t = 0.2,
										s = "Quad",
										d = "Out",
										g = {
											TextTransparency = 0,
										},
									}):Play()
									tw({
										v = IndicatorFrame,
										t = 0.2,
										s = "Back",
										d = "Out",
										g = {
											Size = UDim2.new(0, 4, 0, 32),
											BackgroundTransparency = 0,
										},
									}):Play()
									updateDisplayText()
									task.spawn(function()
										pcall(Callback, text)
									end)
									task.wait(0.15)
									closeDropdown()
								end
							end)
						end

						for _, v in pairs(List) do
							addItem(v)
						end

						updateDisplayText()
						listenForOutsideClick()
						table.insert(SearchItems, {
							Frame = DropdownFrame,
							SearchName = TitleB,
							HighlightFrame = HighlightFrameB,
						})
						DropdownFrame.Destroying:Connect(function()
							if connection then
								connection:Disconnect()
								connection = nil
							end

							if DropdownMenuFrame then
								DropdownMenuFrame:Destroy()
							end
						end)
						dropdownApi = {
							Add = function(self, item)
								if not table.find(List, item) then
									table.insert(List, item)
									addItem(item)
								end
							end,
							Remove = function(self, item)
								for k, v in pairs(List) do
									if v == item then
										table.remove(List, k)

										break
									end
								end

								for _, child in pairs(MenuScrollScrollingFrame:GetChildren()) do
									if child:IsA("Frame") and child.Name == "Item" then
										local ItemTitle = child:FindFirstChild("ItemTitle")

										if ItemTitle and ItemTitle.Text == item then
											child:Destroy()

											break
										end
									end
								end

								selectedValues[item] = nil
								updateDisplayText()
							end,
							Clear = function()
								for _, child in pairs(MenuScrollScrollingFrame:GetChildren()) do
									if child:IsA("Frame") and child.Name == "Item" then
										child:Destroy()
									end
								end

								List = {}
								selectedValues = {}
								updateDisplayText()
							end,
							SetValue = function(self, value)
								selectedValues = {}

								local valueB, valueC, valueD, ItemTitle, Indicator, tween, tweenB, tweenC, tweenD

								if type(value) == "table" then
									local iterator, iterTable, iterKey = pairs(value)
									local iteratorB = geniter(iterator, iterTable, iterKey)

									for _, v in iterator, iterTable, iterKey do
										while true do
											selectedValues[v] = true

											local packed = table.pack(iteratorB())

											if not packed[1] then
												break
											end

											v = packed[3]
										end

										local iterator, iterTable, iterKey = pairs(MenuScrollScrollingFrame:GetChildren())

										for _, entry in iterator, iterTable, iterKey do
											if entry:IsA("Frame") and entry.Name == "Item" then
												local child = entry:FindFirstChild("ItemTitle")
												local childB = entry:FindFirstChild("Indicator")

												if child and childB then
													if selectedValues[child.Text] then
														tw({
															v = child,
															t = 0.2,
															s = "Quad",
															d = "Out",
															g = {
																TextTransparency = 0,
															},
														}):Play()
														tw({
															v = childB,
															t = 0.2,
															s = "Back",
															d = "Out",
															g = {
																Size = UDim2.new(0, 4, 0, 32),
																BackgroundTransparency = 0,
															},
														}):Play()
													else
														tw({
															v = child,
															t = 0.2,
															s = "Quad",
															d = "Out",
															g = {
																TextTransparency = 0.5,
															},
														}):Play()
														tw({
															v = childB,
															t = 0.2,
															s = "Back",
															d = "Out",
															g = {
																Size = UDim2.new(0, 0, 0, 32),
																BackgroundTransparency = 1,
															},
														}):Play()
													end
												end
											end
										end

										updateDisplayText()

										return
									end

									valueB, valueC, valueD = pairs(MenuScrollScrollingFrame:GetChildren())

									for _, v in valueB, valueC, valueD do
										if v:IsA("Frame") and v.Name == "Item" then
											ItemTitle = v:FindFirstChild("ItemTitle")
											Indicator = v:FindFirstChild("Indicator")

											if ItemTitle and Indicator then
												if selectedValues[ItemTitle.Text] then
													tween = tw({
														v = ItemTitle,
														t = 0.2,
														s = "Quad",
														d = "Out",
														g = {
															TextTransparency = 0,
														},
													})
													tween:Play()
													tweenB = tw({
														v = Indicator,
														t = 0.2,
														s = "Back",
														d = "Out",
														g = {
															Size = UDim2.new(0, 4, 0, 32),
															BackgroundTransparency = 0,
														},
													})
													tweenB:Play()
												else
													tweenC = tw({
														v = ItemTitle,
														t = 0.2,
														s = "Quad",
														d = "Out",
														g = {
															TextTransparency = 0.5,
														},
													})
													tweenC:Play()
													tweenD = tw({
														v = Indicator,
														t = 0.2,
														s = "Back",
														d = "Out",
														g = {
															Size = UDim2.new(0, 0, 0, 32),
															BackgroundTransparency = 1,
														},
													})
													tweenD:Play()
												end
											end
										end
									end
								elseif type(value) == "string" and value ~= "" then
									selectedValues[value] = true
									valueB, valueC, valueD = pairs(MenuScrollScrollingFrame:GetChildren())

									for _, v in valueB, valueC, valueD do
										if v:IsA("Frame") and v.Name == "Item" then
											ItemTitle = v:FindFirstChild("ItemTitle")
											Indicator = v:FindFirstChild("Indicator")

											if ItemTitle and Indicator then
												if selectedValues[ItemTitle.Text] then
													tween = tw({
														v = ItemTitle,
														t = 0.2,
														s = "Quad",
														d = "Out",
														g = {
															TextTransparency = 0,
														},
													})
													tween:Play()
													tweenB = tw({
														v = Indicator,
														t = 0.2,
														s = "Back",
														d = "Out",
														g = {
															Size = UDim2.new(0, 4, 0, 32),
															BackgroundTransparency = 0,
														},
													})
													tweenB:Play()
												else
													tweenC = tw({
														v = ItemTitle,
														t = 0.2,
														s = "Quad",
														d = "Out",
														g = {
															TextTransparency = 0.5,
														},
													})
													tweenC:Play()
													tweenD = tw({
														v = Indicator,
														t = 0.2,
														s = "Back",
														d = "Out",
														g = {
															Size = UDim2.new(0, 0, 0, 32),
															BackgroundTransparency = 1,
														},
													})
													tweenD:Play()
												end
											end
										end
									end
								else
									valueB, valueC, valueD = pairs(MenuScrollScrollingFrame:GetChildren())

									for _, v in valueB, valueC, valueD do
										if v:IsA("Frame") and v.Name == "Item" then
											ItemTitle = v:FindFirstChild("ItemTitle")
											Indicator = v:FindFirstChild("Indicator")

											if ItemTitle and Indicator then
												if selectedValues[ItemTitle.Text] then
													tw({
														v = ItemTitle,
														t = 0.2,
														s = "Quad",
														d = "Out",
														g = {
															TextTransparency = 0,
														},
													}):Play()
													tw({
														v = Indicator,
														t = 0.2,
														s = "Back",
														d = "Out",
														g = {
															Size = UDim2.new(0, 4, 0, 32),
															BackgroundTransparency = 0,
														},
													}):Play()
												else
													tw({
														v = ItemTitle,
														t = 0.2,
														s = "Quad",
														d = "Out",
														g = {
															TextTransparency = 0.5,
														},
													}):Play()
													tw({
														v = Indicator,
														t = 0.2,
														s = "Back",
														d = "Out",
														g = {
															Size = UDim2.new(0, 0, 0, 32),
															BackgroundTransparency = 1,
														},
													}):Play()
												end
											end
										end
									end
								end

								updateDisplayText()
							end,
							GetValue = function()
								if not Multi then
									for k, v in pairs(selectedValues) do
										if v then
											return k
										end
									end

									return nil
								end

								local items = {}

								for k, v in pairs(selectedValues) do
									if v then
										table.insert(items, k)
									end
								end

								return items
							end,
							SetTitle = function(self, text)
								TitleTextLabel.Text = text
								TitleTextLabelB.Text = text

								for _, v in pairs(SearchItems) do
									if v.Frame == DropdownFrame then
										v.SearchName = text

										break
									end
								end
							end,
							SetDesc = function(self, text)
								if DescTextLabel then
									DescTextLabel.Text = text
								end
							end,
							Visible = function(self, visible)
								DropdownFrame.Visible = visible

								if not visible and isOpen then
									closeDropdown()
								end
							end,
						}
					end
				else
					DescTextLabel.Name = "Desc"
					DescTextLabel.Parent = DropdownFrame
					DescTextLabel.BackgroundTransparency = 1
					DescTextLabel.Position = UDim2.new(0.04, 0, 0, 22)
					DescTextLabel.Size = UDim2.new(0.75, 0, 0, 12)
					DescTextLabel.Font = Enum.Font.Gotham
					DescTextLabel.Text = DescB
					DescTextLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
					DescTextLabel.TextSize = 10
					DescTextLabel.TextTransparency = 0.4
					DescTextLabel.TextXAlignment = Enum.TextXAlignment.Left
					DescTextLabel.TextScaled = true
					DescTextLabel.TextWrapped = true

					local DescTextLabelTextConstraint = Instance.new("UITextSizeConstraint")

					DescTextLabelTextConstraint.Parent = DescTextLabel
					DescTextLabelTextConstraint.MaxTextSize = 10
					DescTextLabelTextConstraint.MinTextSize = 7
					ArrowIconImageLabel.Name = "ArrowIcon"
					ArrowIconImageLabel.Parent = DropdownFrame
					ArrowIconImageLabel.AnchorPoint = Vector2.new(1, 0.5)
					ArrowIconImageLabel.BackgroundTransparency = 1
					ArrowIconImageLabel.Position = UDim2.new(0.96, 0, 0.5, 0)
					ArrowIconImageLabel.Size = UDim2.new(0, 24, 0, 24)
					ArrowIconImageLabel.Image = "rbxassetid://129573215183311"
					ArrowIconImageLabel.ScaleType = Enum.ScaleType.Fit
					ArrowIconImageLabelGradient.Parent = ArrowIconImageLabel
					ArrowIconImageLabelGradient.Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
						ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 170, 255)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)),
					})
					DropdownMenuFrame = Instance.new("Frame")

					local DropdownMenuFrameCorner = Instance.new("UICorner")
					local DropdownMenuFrameStroke = Instance.new("UIStroke")
					local EffectImageLabel = Instance.new("ImageLabel")
					local HeaderFrame = Instance.new("Frame")

					TitleTextLabelB = Instance.new("TextLabel")

					local LineFrame = Instance.new("Frame")
					local LineFrameGradient = Instance.new("UIGradient")

					SearchBoxTextBox = Instance.new("TextBox")

					local SearchBoxTextBoxCorner = Instance.new("UICorner")

					SearchBoxTextBoxStroke = Instance.new("UIStroke")

					local SearchBoxTextBoxStrokeGradient = Instance.new("UIGradient")

					MenuScrollScrollingFrame = Instance.new("ScrollingFrame")

					local MenuScrollScrollingFrameListLayout = Instance.new("UIListLayout")

					DropdownMenuFrame.Name = "DropdownMenu"
					DropdownMenuFrame.Parent = BackgroundFrame
					DropdownMenuFrame.AnchorPoint = Vector2.new(1, 0.5)
					DropdownMenuFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
					DropdownMenuFrame.BackgroundTransparency = 0.05
					DropdownMenuFrame.Position = UDim2.new(1, 0, 0.5, 0)
					DropdownMenuFrame.Size = UDim2.new(0, 0, 1, 0)
					DropdownMenuFrame.ClipsDescendants = true
					DropdownMenuFrame.Visible = false
					DropdownMenuFrame.ZIndex = 100
					DropdownMenuFrameCorner.Parent = DropdownMenuFrame
					DropdownMenuFrameCorner.CornerRadius = UDim.new(0, 16)
					DropdownMenuFrameStroke.Parent = DropdownMenuFrame
					DropdownMenuFrameStroke.Color = Color3.fromRGB(110, 110, 140)
					DropdownMenuFrameStroke.Thickness = 2
					DropdownMenuFrameStroke.Transparency = 0.6
					EffectImageLabel.Name = "Effect"
					EffectImageLabel.Parent = DropdownMenuFrame
					EffectImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
					EffectImageLabel.BackgroundTransparency = 1
					EffectImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
					EffectImageLabel.Size = UDim2.new(1, 0, 1, 0)
					EffectImageLabel.Image = "rbxassetid://132687652275989"
					EffectImageLabel.ImageColor3 = Color3.fromRGB(0, 255, 127)
					EffectImageLabel.ImageTransparency = 0.5
					EffectImageLabel.ScaleType = Enum.ScaleType.Crop
					EffectImageLabel.ZIndex = 100
					HeaderFrame.Name = "Header"
					HeaderFrame.Parent = DropdownMenuFrame
					HeaderFrame.BackgroundTransparency = 1
					HeaderFrame.Size = UDim2.new(1, 0, 0, 70)
					HeaderFrame.ZIndex = 101
					TitleTextLabelB.Name = "Title"
					TitleTextLabelB.Parent = HeaderFrame
					TitleTextLabelB.BackgroundTransparency = 1
					TitleTextLabelB.Position = UDim2.new(0, 16, 0, 12)
					TitleTextLabelB.Size = UDim2.new(1, -32, 0, 24)
					TitleTextLabelB.Font = Enum.Font.GothamBold
					TitleTextLabelB.Text = TitleB
					TitleTextLabelB.TextColor3 = Color3.fromRGB(255, 255, 255)
					TitleTextLabelB.TextSize = 18
					TitleTextLabelB.TextXAlignment = Enum.TextXAlignment.Left
					TitleTextLabelB.ZIndex = 101
					LineFrame.Name = "Line"
					LineFrame.Parent = HeaderFrame
					LineFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					LineFrame.BorderSizePixel = 0
					LineFrame.Position = UDim2.new(0, 16, 0, 42)
					LineFrame.Size = UDim2.new(0, 60, 0, 2)
					LineFrame.ZIndex = 101
					LineFrameGradient.Parent = LineFrame
					LineFrameGradient.Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
						ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 170, 255)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)),
					})
					SearchBoxTextBox.Name = "SearchBox"
					SearchBoxTextBox.Parent = HeaderFrame
					SearchBoxTextBox.AnchorPoint = Vector2.new(0.5, 1)
					SearchBoxTextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					SearchBoxTextBox.BackgroundTransparency = 0.92
					SearchBoxTextBox.Position = UDim2.new(0.5, 0, 1, -4)
					SearchBoxTextBox.Size = UDim2.new(0, 0, 0, 28)
					SearchBoxTextBox.Font = Enum.Font.GothamBold
					SearchBoxTextBox.PlaceholderColor3 = Color3.fromRGB(140, 140, 140)
					SearchBoxTextBox.PlaceholderText = "Search..."
					SearchBoxTextBox.Text = ""
					SearchBoxTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
					SearchBoxTextBox.TextSize = 12
					SearchBoxTextBox.ClearTextOnFocus = false
					SearchBoxTextBox.ZIndex = 102
					SearchBoxTextBoxCorner.Parent = SearchBoxTextBox
					SearchBoxTextBoxCorner.CornerRadius = UDim.new(0, 8)
					SearchBoxTextBoxStroke.Parent = SearchBoxTextBox
					SearchBoxTextBoxStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
					SearchBoxTextBoxStroke.Color = Color3.fromRGB(255, 255, 255)
					SearchBoxTextBoxStroke.Thickness = 1.5
					SearchBoxTextBoxStroke.Transparency = 0.7
					SearchBoxTextBoxStrokeGradient.Parent = SearchBoxTextBoxStroke
					SearchBoxTextBoxStrokeGradient.Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
						ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 170, 255)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)),
					})
					MenuScrollScrollingFrame.Name = "MenuScroll"
					MenuScrollScrollingFrame.Parent = DropdownMenuFrame
					MenuScrollScrollingFrame.Active = true
					MenuScrollScrollingFrame.BackgroundTransparency = 1
					MenuScrollScrollingFrame.BorderSizePixel = 0
					MenuScrollScrollingFrame.Position = UDim2.new(0, 8, 0, 78)
					MenuScrollScrollingFrame.Size = UDim2.new(1, -16, 1, -86)
					MenuScrollScrollingFrame.ClipsDescendants = true
					MenuScrollScrollingFrame.ScrollBarThickness = 4
					MenuScrollScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(0, 170, 255)
					MenuScrollScrollingFrame.ScrollBarImageTransparency = 0.7
					MenuScrollScrollingFrame.ZIndex = 101
					MenuScrollScrollingFrameListLayout.Parent = MenuScrollScrollingFrame
					MenuScrollScrollingFrameListLayout.Padding = UDim.new(0, 4)
					MenuScrollScrollingFrameListLayout.SortOrder = Enum.SortOrder.LayoutOrder
					MenuScrollScrollingFrameListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
						MenuScrollScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, MenuScrollScrollingFrameListLayout.AbsoluteContentSize.Y + 8)
					end)
					isAnimating = false
					isOpen = false
					selectedValues = {}

					if type(Value) == "table" then
						for _, v in pairs(Value) do
							selectedValues[v] = true
						end

						updateDisplayText = function()
							if Multi then
								local items = {}

								for k, v in pairs(selectedValues) do
									if v then
										table.insert(items, k)
									end
								end

								if #items > 0 then
									ValueDisplayTextLabel.Text = #items .. " Selected"
								else
									ValueDisplayTextLabel.Text = "Select..."
								end
							else
								local flag = false

								for k, v in pairs(selectedValues) do
									if v then
										ValueDisplayTextLabel.Text = k
										flag = true

										break
									end
								end

								if not flag then
									ValueDisplayTextLabel.Text = "Select..."
								end
							end
						end

						local function helper()
							if isAnimating or not isOpen then
								return
							end

							isAnimating = true
							isOpen = false
							tw({
								v = DropdownMenuFrame,
								t = 0.25,
								s = "Quad",
								d = "Out",
								g = {
									Size = UDim2.new(0, 0, 1, 0),
								},
							}):Play()
							tw({
								v = SearchBoxTextBox,
								t = 0.2,
								s = "Quad",
								d = "Out",
								g = {
									Size = UDim2.new(0, 0, 0, 28),
								},
							}):Play()
							tw({
								v = ArrowIconImageLabel,
								t = 0.25,
								s = "Quad",
								d = "Out",
								g = {
									Rotation = 0,
								},
							}):Play()
							tw({
								v = DropdownFrameStroke,
								t = 0.25,
								s = "Quad",
								d = "Out",
								g = {
									Transparency = 0.75,
								},
							}):Play()
							task.spawn(function()
								task.wait(0.25)

								if not isOpen then
									DropdownMenuFrame.Visible = false
								end

								isAnimating = false
							end)
						end
						local function helperB()
							if isAnimating or isOpen then
								return
							end

							isAnimating = true
							isOpen = true
							DropdownMenuFrame.Visible = true
							SearchBoxTextBox.Text = ""
							tw({
								v = DropdownMenuFrame,
								t = 0.3,
								s = "Back",
								d = "Out",
								g = {
									Size = UDim2.new(0, 240, 1, 0),
								},
							}):Play()
							tw({
								v = SearchBoxTextBox,
								t = 0.25,
								s = "Back",
								d = "Out",
								g = {
									Size = UDim2.new(0.9, 0, 0, 28),
								},
							}):Play()
							tw({
								v = ArrowIconImageLabel,
								t = 0.3,
								s = "Back",
								d = "Out",
								g = {
									Rotation = 180,
								},
							}):Play()
							tw({
								v = DropdownFrameStroke,
								t = 0.3,
								s = "Quad",
								d = "Out",
								g = {
									Transparency = 0.4,
								},
							}):Play()
							task.spawn(function()
								task.wait(0.3)
								isAnimating = false
							end)
						end

						ClickDropdownTextButton.Name = "ClickDropdown"
						ClickDropdownTextButton.Parent = DropdownFrame
						ClickDropdownTextButton.BackgroundTransparency = 1
						ClickDropdownTextButton.Size = UDim2.new(1, 0, 1, 0)
						ClickDropdownTextButton.Position = UDim2.new(0, 0, 0, 0)
						ClickDropdownTextButton.BorderSizePixel = 0
						ClickDropdownTextButton.AutoButtonColor = false
						ClickDropdownTextButton.ZIndex = 10
						ClickDropdownTextButton.Text = ""
						ClickDropdownTextButton.MouseButton1Click:Connect(function()
							if isAnimating then
								return
							end

							if isOpen then
								helper()
							else
								helperB()
							end

							EffectClick2(ClickDropdownTextButton, DropdownFrame)
						end)

						local connectionB

						local function helperB()
							if connectionB then
								connectionB:Disconnect()
								connectionB = nil
							end

							connectionB = UserInputService.InputBegan:Connect(function(input)
								if not isOpen or isAnimating then
									return
								end

								if
									input.UserInputType == Enum.UserInputType.MouseButton1
									or input.UserInputType == Enum.UserInputType.Touch
								then
									local mouseLocation = UserInputService:GetMouseLocation()
									local AbsolutePosition = DropdownMenuFrame.AbsolutePosition
									local AbsoluteSize = DropdownMenuFrame.AbsoluteSize
									local absolutePosition = DropdownFrame.AbsolutePosition
									local absoluteSize = DropdownFrame.AbsoluteSize

									if
										not (
											mouseLocation.X >= AbsolutePosition.X
												and mouseLocation.X <= AbsolutePosition.X + AbsoluteSize.X
												and mouseLocation.Y >= AbsolutePosition.Y
												and mouseLocation.Y <= AbsolutePosition.Y + AbsoluteSize.Y
											or mouseLocation.X >= absolutePosition.X
												and mouseLocation.X <= absolutePosition.X + absoluteSize.X
												and mouseLocation.Y >= absolutePosition.Y
												and mouseLocation.Y <= absolutePosition.Y + absoluteSize.Y
										)
									then
										helper()
									end
								end
							end)
						end

						SearchBoxTextBox:GetPropertyChangedSignal("Text"):Connect(function()
							local lowered = string.lower(SearchBoxTextBox.Text)

							for _, child in pairs(MenuScrollScrollingFrame:GetChildren()) do
								if child:IsA("Frame") and child.Name == "Item" then
									local ItemTitle = child:FindFirstChild("ItemTitle")

									if ItemTitle then
										local loweredB = string.lower(ItemTitle.Text)

										child.Visible = lowered == "" or string.find(loweredB, lowered, 1, true) ~= nil
									end
								end
							end
						end)
						SearchBoxTextBox.Focused:Connect(function()
							tw({
								v = SearchBoxTextBoxStroke,
								t = 0.3,
								s = "Quad",
								d = "Out",
								g = {
									Transparency = 0.3,
								},
							}):Play()
						end)
						SearchBoxTextBox.FocusLost:Connect(function()
							tw({
								v = SearchBoxTextBoxStroke,
								t = 0.3,
								s = "Quad",
								d = "Out",
								g = {
									Transparency = 0.7,
								},
							}):Play()
						end)
						addItem = function(text)
							local ItemFrame = Instance.new("Frame")
							local ItemFrameCorner = Instance.new("UICorner")
							local ItemTitleTextLabel = Instance.new("TextLabel")
							local IndicatorFrame = Instance.new("Frame")
							local IndicatorFrameCorner = Instance.new("UICorner")
							local IndicatorFrameGradient = Instance.new("UIGradient")

							ItemFrame.Name = "Item"
							ItemFrame.Parent = MenuScrollScrollingFrame
							ItemFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
							ItemFrame.BackgroundTransparency = 0.4
							ItemFrame.Size = UDim2.new(1, 0, 0, 32)
							ItemFrame.ZIndex = 102
							ItemFrameCorner.Parent = ItemFrame
							ItemFrameCorner.CornerRadius = UDim.new(0, 8)
							ItemTitleTextLabel.Name = "ItemTitle"
							ItemTitleTextLabel.Parent = ItemFrame
							ItemTitleTextLabel.BackgroundTransparency = 1
							ItemTitleTextLabel.Position = UDim2.new(0, 12, 0, 0)
							ItemTitleTextLabel.Size = UDim2.new(1, -44, 1, 0)
							ItemTitleTextLabel.Font = Enum.Font.GothamBold
							ItemTitleTextLabel.Text = text
							ItemTitleTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
							ItemTitleTextLabel.TextSize = 13
							ItemTitleTextLabel.TextTransparency = selectedValues[text] and 0 or 0.5
							ItemTitleTextLabel.TextXAlignment = Enum.TextXAlignment.Left
							ItemTitleTextLabel.TextScaled = true
							ItemTitleTextLabel.TextWrapped = true
							ItemTitleTextLabel.ZIndex = 103

							local ItemTitleTextLabelTextConstraint = Instance.new("UITextSizeConstraint")

							ItemTitleTextLabelTextConstraint.Parent = ItemTitleTextLabel
							ItemTitleTextLabelTextConstraint.MaxTextSize = 13
							ItemTitleTextLabelTextConstraint.MinTextSize = 9
							IndicatorFrame.Name = "Indicator"
							IndicatorFrame.Parent = ItemFrame
							IndicatorFrame.AnchorPoint = Vector2.new(0, 0.5)
							IndicatorFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
							IndicatorFrame.Position = UDim2.new(0, 0, 0.5, 0)
							IndicatorFrame.Size = UDim2.new(0, selectedValues[text] and 4 or 0, 0, 32)
							IndicatorFrame.BackgroundTransparency = selectedValues[text] and 0 or 1
							IndicatorFrame.ZIndex = 102
							IndicatorFrameCorner.Parent = IndicatorFrame
							IndicatorFrameCorner.CornerRadius = UDim.new(1, 0)
							IndicatorFrameGradient.Parent = IndicatorFrame
							IndicatorFrameGradient.Color = ColorSequence.new({
								ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
								ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 170, 255)),
								ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)),
							})
							IndicatorFrameGradient.Rotation = 90

							local ClickTextButton = Instance.new("TextButton")

							ClickTextButton.Name = "Click"
							ClickTextButton.Parent = ItemFrame
							ClickTextButton.BackgroundTransparency = 1
							ClickTextButton.BorderSizePixel = 0
							ClickTextButton.Size = UDim2.new(1, 0, 1, 0)
							ClickTextButton.Position = UDim2.new(0, 0, 0, 0)
							ClickTextButton.ZIndex = 120
							ClickTextButton.AutoButtonColor = false
							ClickTextButton.Font = Enum.Font.SourceSans
							ClickTextButton.Text = ""
							ClickTextButton.MouseEnter:Connect(function()
								tw({
									v = ItemFrame,
									t = 0.2,
									s = "Quad",
									d = "Out",
									g = {
										BackgroundTransparency = 0.2,
									},
								}):Play()
							end)
							ClickTextButton.MouseLeave:Connect(function()
								tw({
									v = ItemFrame,
									t = 0.2,
									s = "Quad",
									d = "Out",
									g = {
										BackgroundTransparency = 0.4,
									},
								}):Play()
							end)
							ClickTextButton.MouseButton1Click:Connect(function()
								EffectClick2(ClickTextButton, ItemFrame)

								if Multi then
									selectedValues[text] = not selectedValues[text]

									local items, task_

									if selectedValues[text] then
										tw({
											v = ItemTitleTextLabel,
											t = 0.2,
											s = "Quad",
											d = "Out",
											g = {
												TextTransparency = 0,
											},
										}):Play()
										tw({
											v = IndicatorFrame,
											t = 0.2,
											s = "Back",
											d = "Out",
											g = {
												Size = UDim2.new(0, 4, 0, 32),
												BackgroundTransparency = 0,
											},
										}):Play()
										items = {}

										for k, v in pairs(selectedValues) do
											if v then
												table.insert(items, k)
											end
										end

										updateDisplayText()
										task_ = task
									else
										tw({
											v = ItemTitleTextLabel,
											t = 0.2,
											s = "Quad",
											d = "Out",
											g = {
												TextTransparency = 0.5,
											},
										}):Play()
										tw({
											v = IndicatorFrame,
											t = 0.2,
											s = "Back",
											d = "Out",
											g = {
												Size = UDim2.new(0, 0, 0, 32),
												BackgroundTransparency = 1,
											},
										}):Play()
										items = {}

										for k, v in pairs(selectedValues) do
											if v then
												table.insert(items, k)
											end
										end

										updateDisplayText()
										task_ = task
									end

									task_.spawn(function()
										pcall(Callback, items)
									end)
								else
									for k in pairs(selectedValues) do
										selectedValues[k] = false
									end

									selectedValues[text] = true

									for _, child in pairs(MenuScrollScrollingFrame:GetChildren()) do
										if child:IsA("Frame") and child.Name == "Item" then
											local ItemTitle = child:FindFirstChild("ItemTitle")
											local Indicator = child:FindFirstChild("Indicator")

											if ItemTitle and Indicator then
												tw({
													v = ItemTitle,
													t = 0.2,
													s = "Quad",
													d = "Out",
													g = {
														TextTransparency = 0.5,
													},
												}):Play()
												tw({
													v = Indicator,
													t = 0.2,
													s = "Back",
													d = "Out",
													g = {
														Size = UDim2.new(0, 0, 0, 32),
														BackgroundTransparency = 1,
													},
												}):Play()
											end
										end
									end

									tw({
										v = ItemTitleTextLabel,
										t = 0.2,
										s = "Quad",
										d = "Out",
										g = {
											TextTransparency = 0,
										},
									}):Play()
									tw({
										v = IndicatorFrame,
										t = 0.2,
										s = "Back",
										d = "Out",
										g = {
											Size = UDim2.new(0, 4, 0, 32),
											BackgroundTransparency = 0,
										},
									}):Play()
									updateDisplayText()
									task.spawn(function()
										pcall(Callback, text)
									end)
									task.wait(0.15)
									helper()
								end
							end)
						end

						for _, v in pairs(List) do
							addItem(v)
						end

						updateDisplayText()
						helperB()
						table.insert(SearchItems, {
							Frame = DropdownFrame,
							SearchName = TitleB,
							HighlightFrame = HighlightFrameB,
						})
						DropdownFrame.Destroying:Connect(function()
							if connectionB then
								connectionB:Disconnect()
								connectionB = nil
							end

							if DropdownMenuFrame then
								DropdownMenuFrame:Destroy()
							end
						end)
						dropdownApi = {
							Add = function(self, item)
								if not table.find(List, item) then
									table.insert(List, item)
									addItem(item)
								end
							end,
							Remove = function(self, item)
								for k, v in pairs(List) do
									if v == item then
										table.remove(List, k)

										break
									end
								end

								for _, child in pairs(MenuScrollScrollingFrame:GetChildren()) do
									if child:IsA("Frame") and child.Name == "Item" then
										local ItemTitle = child:FindFirstChild("ItemTitle")

										if ItemTitle and ItemTitle.Text == item then
											child:Destroy()

											break
										end
									end
								end

								selectedValues[item] = nil
								updateDisplayText()
							end,
							Clear = function()
								for _, child in pairs(MenuScrollScrollingFrame:GetChildren()) do
									if child:IsA("Frame") and child.Name == "Item" then
										child:Destroy()
									end
								end

								List = {}
								selectedValues = {}
								updateDisplayText()
							end,
							SetValue = function(self, value)
								selectedValues = {}

								local valueB, valueC, valueD, ItemTitle, Indicator, tween, tweenB, tweenC, tweenD

								if type(value) == "table" then
									local iterator, iterTable, iterKey = pairs(value)
									local iteratorB = geniter(iterator, iterTable, iterKey)

									for _, v in iterator, iterTable, iterKey do
										while true do
											selectedValues[v] = true

											local packed = table.pack(iteratorB())

											if not packed[1] then
												break
											end

											v = packed[3]
										end

										local iterator, iterTable, iterKey = pairs(MenuScrollScrollingFrame:GetChildren())

										for _, entry in iterator, iterTable, iterKey do
											if entry:IsA("Frame") and entry.Name == "Item" then
												local child = entry:FindFirstChild("ItemTitle")
												local childB = entry:FindFirstChild("Indicator")

												if child and childB then
													if selectedValues[child.Text] then
														tw({
															v = child,
															t = 0.2,
															s = "Quad",
															d = "Out",
															g = {
																TextTransparency = 0,
															},
														}):Play()
														tw({
															v = childB,
															t = 0.2,
															s = "Back",
															d = "Out",
															g = {
																Size = UDim2.new(0, 4, 0, 32),
																BackgroundTransparency = 0,
															},
														}):Play()
													else
														tw({
															v = child,
															t = 0.2,
															s = "Quad",
															d = "Out",
															g = {
																TextTransparency = 0.5,
															},
														}):Play()
														tw({
															v = childB,
															t = 0.2,
															s = "Back",
															d = "Out",
															g = {
																Size = UDim2.new(0, 0, 0, 32),
																BackgroundTransparency = 1,
															},
														}):Play()
													end
												end
											end
										end

										updateDisplayText()

										return
									end

									valueB, valueC, valueD = pairs(MenuScrollScrollingFrame:GetChildren())

									for _, v in valueB, valueC, valueD do
										if v:IsA("Frame") and v.Name == "Item" then
											ItemTitle = v:FindFirstChild("ItemTitle")
											Indicator = v:FindFirstChild("Indicator")

											if ItemTitle and Indicator then
												if selectedValues[ItemTitle.Text] then
													tween = tw({
														v = ItemTitle,
														t = 0.2,
														s = "Quad",
														d = "Out",
														g = {
															TextTransparency = 0,
														},
													})
													tween:Play()
													tweenB = tw({
														v = Indicator,
														t = 0.2,
														s = "Back",
														d = "Out",
														g = {
															Size = UDim2.new(0, 4, 0, 32),
															BackgroundTransparency = 0,
														},
													})
													tweenB:Play()
												else
													tweenC = tw({
														v = ItemTitle,
														t = 0.2,
														s = "Quad",
														d = "Out",
														g = {
															TextTransparency = 0.5,
														},
													})
													tweenC:Play()
													tweenD = tw({
														v = Indicator,
														t = 0.2,
														s = "Back",
														d = "Out",
														g = {
															Size = UDim2.new(0, 0, 0, 32),
															BackgroundTransparency = 1,
														},
													})
													tweenD:Play()
												end
											end
										end
									end
								elseif type(value) == "string" and value ~= "" then
									selectedValues[value] = true
									valueB, valueC, valueD = pairs(MenuScrollScrollingFrame:GetChildren())

									for _, v in valueB, valueC, valueD do
										if v:IsA("Frame") and v.Name == "Item" then
											ItemTitle = v:FindFirstChild("ItemTitle")
											Indicator = v:FindFirstChild("Indicator")

											if ItemTitle and Indicator then
												if selectedValues[ItemTitle.Text] then
													tween = tw({
														v = ItemTitle,
														t = 0.2,
														s = "Quad",
														d = "Out",
														g = {
															TextTransparency = 0,
														},
													})
													tween:Play()
													tweenB = tw({
														v = Indicator,
														t = 0.2,
														s = "Back",
														d = "Out",
														g = {
															Size = UDim2.new(0, 4, 0, 32),
															BackgroundTransparency = 0,
														},
													})
													tweenB:Play()
												else
													tweenC = tw({
														v = ItemTitle,
														t = 0.2,
														s = "Quad",
														d = "Out",
														g = {
															TextTransparency = 0.5,
														},
													})
													tweenC:Play()
													tweenD = tw({
														v = Indicator,
														t = 0.2,
														s = "Back",
														d = "Out",
														g = {
															Size = UDim2.new(0, 0, 0, 32),
															BackgroundTransparency = 1,
														},
													})
													tweenD:Play()
												end
											end
										end
									end
								else
									valueB, valueC, valueD = pairs(MenuScrollScrollingFrame:GetChildren())

									for _, v in valueB, valueC, valueD do
										if v:IsA("Frame") and v.Name == "Item" then
											ItemTitle = v:FindFirstChild("ItemTitle")
											Indicator = v:FindFirstChild("Indicator")

											if ItemTitle and Indicator then
												if selectedValues[ItemTitle.Text] then
													tw({
														v = ItemTitle,
														t = 0.2,
														s = "Quad",
														d = "Out",
														g = {
															TextTransparency = 0,
														},
													}):Play()
													tw({
														v = Indicator,
														t = 0.2,
														s = "Back",
														d = "Out",
														g = {
															Size = UDim2.new(0, 4, 0, 32),
															BackgroundTransparency = 0,
														},
													}):Play()
												else
													tw({
														v = ItemTitle,
														t = 0.2,
														s = "Quad",
														d = "Out",
														g = {
															TextTransparency = 0.5,
														},
													}):Play()
													tw({
														v = Indicator,
														t = 0.2,
														s = "Back",
														d = "Out",
														g = {
															Size = UDim2.new(0, 0, 0, 32),
															BackgroundTransparency = 1,
														},
													}):Play()
												end
											end
										end
									end
								end

								updateDisplayText()
							end,
							GetValue = function()
								if not Multi then
									for k, v in pairs(selectedValues) do
										if v then
											return k
										end
									end

									return nil
								end

								local items = {}

								for k, v in pairs(selectedValues) do
									if v then
										table.insert(items, k)
									end
								end

								return items
							end,
							SetTitle = function(self, text)
								TitleTextLabel.Text = text
								TitleTextLabelB.Text = text

								for _, v in pairs(SearchItems) do
									if v.Frame == DropdownFrame then
										v.SearchName = text

										break
									end
								end
							end,
							SetDesc = function(self, text)
								if DescTextLabel then
									DescTextLabel.Text = text
								end
							end,
							Visible = function(self, visible)
								DropdownFrame.Visible = visible

								if not visible and isOpen then
									helper()
								end
							end,
						}
					elseif Value == "" then
						updateDisplayText = function()
							if Multi then
								local items = {}

								for k, v in pairs(selectedValues) do
									if v then
										table.insert(items, k)
									end
								end

								if #items > 0 then
									ValueDisplayTextLabel.Text = #items .. " Selected"
								else
									ValueDisplayTextLabel.Text = "Select..."
								end
							else
								local flag = false

								for k, v in pairs(selectedValues) do
									if v then
										ValueDisplayTextLabel.Text = k
										flag = true

										break
									end
								end

								if not flag then
									ValueDisplayTextLabel.Text = "Select..."
								end
							end
						end
						closeDropdown = function()
							if isAnimating or not isOpen then
								return
							end

							isAnimating = true
							isOpen = false
							tw({
								v = DropdownMenuFrame,
								t = 0.25,
								s = "Quad",
								d = "Out",
								g = {
									Size = UDim2.new(0, 0, 1, 0),
								},
							}):Play()
							tw({
								v = SearchBoxTextBox,
								t = 0.2,
								s = "Quad",
								d = "Out",
								g = {
									Size = UDim2.new(0, 0, 0, 28),
								},
							}):Play()
							tw({
								v = ArrowIconImageLabel,
								t = 0.25,
								s = "Quad",
								d = "Out",
								g = {
									Rotation = 0,
								},
							}):Play()
							tw({
								v = DropdownFrameStroke,
								t = 0.25,
								s = "Quad",
								d = "Out",
								g = {
									Transparency = 0.75,
								},
							}):Play()
							task.spawn(function()
								task.wait(0.25)

								if not isOpen then
									DropdownMenuFrame.Visible = false
								end

								isAnimating = false
							end)
						end
						openDropdown = function()
							if isAnimating or isOpen then
								return
							end

							isAnimating = true
							isOpen = true
							DropdownMenuFrame.Visible = true
							SearchBoxTextBox.Text = ""
							tw({
								v = DropdownMenuFrame,
								t = 0.3,
								s = "Back",
								d = "Out",
								g = {
									Size = UDim2.new(0, 240, 1, 0),
								},
							}):Play()
							tw({
								v = SearchBoxTextBox,
								t = 0.25,
								s = "Back",
								d = "Out",
								g = {
									Size = UDim2.new(0.9, 0, 0, 28),
								},
							}):Play()
							tw({
								v = ArrowIconImageLabel,
								t = 0.3,
								s = "Back",
								d = "Out",
								g = {
									Rotation = 180,
								},
							}):Play()
							tw({
								v = DropdownFrameStroke,
								t = 0.3,
								s = "Quad",
								d = "Out",
								g = {
									Transparency = 0.4,
								},
							}):Play()
							task.spawn(function()
								task.wait(0.3)
								isAnimating = false
							end)
						end
						ClickDropdownTextButton.Name = "ClickDropdown"
						ClickDropdownTextButton.Parent = DropdownFrame
						ClickDropdownTextButton.BackgroundTransparency = 1
						ClickDropdownTextButton.Size = UDim2.new(1, 0, 1, 0)
						ClickDropdownTextButton.Position = UDim2.new(0, 0, 0, 0)
						ClickDropdownTextButton.BorderSizePixel = 0
						ClickDropdownTextButton.AutoButtonColor = false
						ClickDropdownTextButton.ZIndex = 10
						ClickDropdownTextButton.Text = ""
						ClickDropdownTextButton.MouseButton1Click:Connect(function()
							if isAnimating then
								return
							end

							if isOpen then
								closeDropdown()
							else
								openDropdown()
							end

							EffectClick2(ClickDropdownTextButton, DropdownFrame)
						end)
						connection = nil
						listenForOutsideClick = function()
							if connection then
								connection:Disconnect()
								connection = nil
							end

							connection = UserInputService.InputBegan:Connect(function(input)
								if not isOpen or isAnimating then
									return
								end

								if
									input.UserInputType == Enum.UserInputType.MouseButton1
									or input.UserInputType == Enum.UserInputType.Touch
								then
									local mouseLocation = UserInputService:GetMouseLocation()
									local AbsolutePosition = DropdownMenuFrame.AbsolutePosition
									local AbsoluteSize = DropdownMenuFrame.AbsoluteSize
									local absolutePosition = DropdownFrame.AbsolutePosition
									local absoluteSize = DropdownFrame.AbsoluteSize

									if
										not (
											mouseLocation.X >= AbsolutePosition.X
												and mouseLocation.X <= AbsolutePosition.X + AbsoluteSize.X
												and mouseLocation.Y >= AbsolutePosition.Y
												and mouseLocation.Y <= AbsolutePosition.Y + AbsoluteSize.Y
											or mouseLocation.X >= absolutePosition.X
												and mouseLocation.X <= absolutePosition.X + absoluteSize.X
												and mouseLocation.Y >= absolutePosition.Y
												and mouseLocation.Y <= absolutePosition.Y + absoluteSize.Y
										)
									then
										closeDropdown()
									end
								end
							end)
						end
						SearchBoxTextBox:GetPropertyChangedSignal("Text"):Connect(function()
							local lowered = string.lower(SearchBoxTextBox.Text)

							for _, child in pairs(MenuScrollScrollingFrame:GetChildren()) do
								if child:IsA("Frame") and child.Name == "Item" then
									local ItemTitle = child:FindFirstChild("ItemTitle")

									if ItemTitle then
										local loweredB = string.lower(ItemTitle.Text)

										child.Visible = lowered == "" or string.find(loweredB, lowered, 1, true) ~= nil
									end
								end
							end
						end)
						SearchBoxTextBox.Focused:Connect(function()
							tw({
								v = SearchBoxTextBoxStroke,
								t = 0.3,
								s = "Quad",
								d = "Out",
								g = {
									Transparency = 0.3,
								},
							}):Play()
						end)
						SearchBoxTextBox.FocusLost:Connect(function()
							tw({
								v = SearchBoxTextBoxStroke,
								t = 0.3,
								s = "Quad",
								d = "Out",
								g = {
									Transparency = 0.7,
								},
							}):Play()
						end)
						addItem = function(text)
							local ItemFrame = Instance.new("Frame")
							local ItemFrameCorner = Instance.new("UICorner")
							local ItemTitleTextLabel = Instance.new("TextLabel")
							local IndicatorFrame = Instance.new("Frame")
							local IndicatorFrameCorner = Instance.new("UICorner")
							local IndicatorFrameGradient = Instance.new("UIGradient")

							ItemFrame.Name = "Item"
							ItemFrame.Parent = MenuScrollScrollingFrame
							ItemFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
							ItemFrame.BackgroundTransparency = 0.4
							ItemFrame.Size = UDim2.new(1, 0, 0, 32)
							ItemFrame.ZIndex = 102
							ItemFrameCorner.Parent = ItemFrame
							ItemFrameCorner.CornerRadius = UDim.new(0, 8)
							ItemTitleTextLabel.Name = "ItemTitle"
							ItemTitleTextLabel.Parent = ItemFrame
							ItemTitleTextLabel.BackgroundTransparency = 1
							ItemTitleTextLabel.Position = UDim2.new(0, 12, 0, 0)
							ItemTitleTextLabel.Size = UDim2.new(1, -44, 1, 0)
							ItemTitleTextLabel.Font = Enum.Font.GothamBold
							ItemTitleTextLabel.Text = text
							ItemTitleTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
							ItemTitleTextLabel.TextSize = 13
							ItemTitleTextLabel.TextTransparency = selectedValues[text] and 0 or 0.5
							ItemTitleTextLabel.TextXAlignment = Enum.TextXAlignment.Left
							ItemTitleTextLabel.TextScaled = true
							ItemTitleTextLabel.TextWrapped = true
							ItemTitleTextLabel.ZIndex = 103

							local ItemTitleTextLabelTextConstraint = Instance.new("UITextSizeConstraint")

							ItemTitleTextLabelTextConstraint.Parent = ItemTitleTextLabel
							ItemTitleTextLabelTextConstraint.MaxTextSize = 13
							ItemTitleTextLabelTextConstraint.MinTextSize = 9
							IndicatorFrame.Name = "Indicator"
							IndicatorFrame.Parent = ItemFrame
							IndicatorFrame.AnchorPoint = Vector2.new(0, 0.5)
							IndicatorFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
							IndicatorFrame.Position = UDim2.new(0, 0, 0.5, 0)
							IndicatorFrame.Size = UDim2.new(0, selectedValues[text] and 4 or 0, 0, 32)
							IndicatorFrame.BackgroundTransparency = selectedValues[text] and 0 or 1
							IndicatorFrame.ZIndex = 102
							IndicatorFrameCorner.Parent = IndicatorFrame
							IndicatorFrameCorner.CornerRadius = UDim.new(1, 0)
							IndicatorFrameGradient.Parent = IndicatorFrame
							IndicatorFrameGradient.Color = ColorSequence.new({
								ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
								ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 170, 255)),
								ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)),
							})
							IndicatorFrameGradient.Rotation = 90

							local ClickTextButton = Instance.new("TextButton")

							ClickTextButton.Name = "Click"
							ClickTextButton.Parent = ItemFrame
							ClickTextButton.BackgroundTransparency = 1
							ClickTextButton.BorderSizePixel = 0
							ClickTextButton.Size = UDim2.new(1, 0, 1, 0)
							ClickTextButton.Position = UDim2.new(0, 0, 0, 0)
							ClickTextButton.ZIndex = 120
							ClickTextButton.AutoButtonColor = false
							ClickTextButton.Font = Enum.Font.SourceSans
							ClickTextButton.Text = ""
							ClickTextButton.MouseEnter:Connect(function()
								tw({
									v = ItemFrame,
									t = 0.2,
									s = "Quad",
									d = "Out",
									g = {
										BackgroundTransparency = 0.2,
									},
								}):Play()
							end)
							ClickTextButton.MouseLeave:Connect(function()
								tw({
									v = ItemFrame,
									t = 0.2,
									s = "Quad",
									d = "Out",
									g = {
										BackgroundTransparency = 0.4,
									},
								}):Play()
							end)
							ClickTextButton.MouseButton1Click:Connect(function()
								EffectClick2(ClickTextButton, ItemFrame)

								if Multi then
									selectedValues[text] = not selectedValues[text]

									local items, task_

									if selectedValues[text] then
										tw({
											v = ItemTitleTextLabel,
											t = 0.2,
											s = "Quad",
											d = "Out",
											g = {
												TextTransparency = 0,
											},
										}):Play()
										tw({
											v = IndicatorFrame,
											t = 0.2,
											s = "Back",
											d = "Out",
											g = {
												Size = UDim2.new(0, 4, 0, 32),
												BackgroundTransparency = 0,
											},
										}):Play()
										items = {}

										for k, v in pairs(selectedValues) do
											if v then
												table.insert(items, k)
											end
										end

										updateDisplayText()
										task_ = task
									else
										tw({
											v = ItemTitleTextLabel,
											t = 0.2,
											s = "Quad",
											d = "Out",
											g = {
												TextTransparency = 0.5,
											},
										}):Play()
										tw({
											v = IndicatorFrame,
											t = 0.2,
											s = "Back",
											d = "Out",
											g = {
												Size = UDim2.new(0, 0, 0, 32),
												BackgroundTransparency = 1,
											},
										}):Play()
										items = {}

										for k, v in pairs(selectedValues) do
											if v then
												table.insert(items, k)
											end
										end

										updateDisplayText()
										task_ = task
									end

									task_.spawn(function()
										pcall(Callback, items)
									end)
								else
									for k in pairs(selectedValues) do
										selectedValues[k] = false
									end

									selectedValues[text] = true

									for _, child in pairs(MenuScrollScrollingFrame:GetChildren()) do
										if child:IsA("Frame") and child.Name == "Item" then
											local ItemTitle = child:FindFirstChild("ItemTitle")
											local Indicator = child:FindFirstChild("Indicator")

											if ItemTitle and Indicator then
												tw({
													v = ItemTitle,
													t = 0.2,
													s = "Quad",
													d = "Out",
													g = {
														TextTransparency = 0.5,
													},
												}):Play()
												tw({
													v = Indicator,
													t = 0.2,
													s = "Back",
													d = "Out",
													g = {
														Size = UDim2.new(0, 0, 0, 32),
														BackgroundTransparency = 1,
													},
												}):Play()
											end
										end
									end

									tw({
										v = ItemTitleTextLabel,
										t = 0.2,
										s = "Quad",
										d = "Out",
										g = {
											TextTransparency = 0,
										},
									}):Play()
									tw({
										v = IndicatorFrame,
										t = 0.2,
										s = "Back",
										d = "Out",
										g = {
											Size = UDim2.new(0, 4, 0, 32),
											BackgroundTransparency = 0,
										},
									}):Play()
									updateDisplayText()
									task.spawn(function()
										pcall(Callback, text)
									end)
									task.wait(0.15)
									closeDropdown()
								end
							end)
						end

						for _, v in pairs(List) do
							addItem(v)
						end

						updateDisplayText()
						listenForOutsideClick()
						table.insert(SearchItems, {
							Frame = DropdownFrame,
							SearchName = TitleB,
							HighlightFrame = HighlightFrameB,
						})
						DropdownFrame.Destroying:Connect(function()
							if connection then
								connection:Disconnect()
								connection = nil
							end

							if DropdownMenuFrame then
								DropdownMenuFrame:Destroy()
							end
						end)
						dropdownApi = {
							Add = function(self, item)
								if not table.find(List, item) then
									table.insert(List, item)
									addItem(item)
								end
							end,
							Remove = function(self, item)
								for k, v in pairs(List) do
									if v == item then
										table.remove(List, k)

										break
									end
								end

								for _, child in pairs(MenuScrollScrollingFrame:GetChildren()) do
									if child:IsA("Frame") and child.Name == "Item" then
										local ItemTitle = child:FindFirstChild("ItemTitle")

										if ItemTitle and ItemTitle.Text == item then
											child:Destroy()

											break
										end
									end
								end

								selectedValues[item] = nil
								updateDisplayText()
							end,
							Clear = function()
								for _, child in pairs(MenuScrollScrollingFrame:GetChildren()) do
									if child:IsA("Frame") and child.Name == "Item" then
										child:Destroy()
									end
								end

								List = {}
								selectedValues = {}
								updateDisplayText()
							end,
							SetValue = function(self, value)
								selectedValues = {}

								local valueB, valueC, valueD, ItemTitle, Indicator, tween, tweenB, tweenC, tweenD

								if type(value) == "table" then
									local iterator, iterTable, iterKey = pairs(value)
									local iteratorB = geniter(iterator, iterTable, iterKey)

									for _, v in iterator, iterTable, iterKey do
										while true do
											selectedValues[v] = true

											local packed = table.pack(iteratorB())

											if not packed[1] then
												break
											end

											v = packed[3]
										end

										local iterator, iterTable, iterKey = pairs(MenuScrollScrollingFrame:GetChildren())

										for _, entry in iterator, iterTable, iterKey do
											if entry:IsA("Frame") and entry.Name == "Item" then
												local child = entry:FindFirstChild("ItemTitle")
												local childB = entry:FindFirstChild("Indicator")

												if child and childB then
													if selectedValues[child.Text] then
														tw({
															v = child,
															t = 0.2,
															s = "Quad",
															d = "Out",
															g = {
																TextTransparency = 0,
															},
														}):Play()
														tw({
															v = childB,
															t = 0.2,
															s = "Back",
															d = "Out",
															g = {
																Size = UDim2.new(0, 4, 0, 32),
																BackgroundTransparency = 0,
															},
														}):Play()
													else
														tw({
															v = child,
															t = 0.2,
															s = "Quad",
															d = "Out",
															g = {
																TextTransparency = 0.5,
															},
														}):Play()
														tw({
															v = childB,
															t = 0.2,
															s = "Back",
															d = "Out",
															g = {
																Size = UDim2.new(0, 0, 0, 32),
																BackgroundTransparency = 1,
															},
														}):Play()
													end
												end
											end
										end

										updateDisplayText()

										return
									end

									valueB, valueC, valueD = pairs(MenuScrollScrollingFrame:GetChildren())

									for _, v in valueB, valueC, valueD do
										if v:IsA("Frame") and v.Name == "Item" then
											ItemTitle = v:FindFirstChild("ItemTitle")
											Indicator = v:FindFirstChild("Indicator")

											if ItemTitle and Indicator then
												if selectedValues[ItemTitle.Text] then
													tween = tw({
														v = ItemTitle,
														t = 0.2,
														s = "Quad",
														d = "Out",
														g = {
															TextTransparency = 0,
														},
													})
													tween:Play()
													tweenB = tw({
														v = Indicator,
														t = 0.2,
														s = "Back",
														d = "Out",
														g = {
															Size = UDim2.new(0, 4, 0, 32),
															BackgroundTransparency = 0,
														},
													})
													tweenB:Play()
												else
													tweenC = tw({
														v = ItemTitle,
														t = 0.2,
														s = "Quad",
														d = "Out",
														g = {
															TextTransparency = 0.5,
														},
													})
													tweenC:Play()
													tweenD = tw({
														v = Indicator,
														t = 0.2,
														s = "Back",
														d = "Out",
														g = {
															Size = UDim2.new(0, 0, 0, 32),
															BackgroundTransparency = 1,
														},
													})
													tweenD:Play()
												end
											end
										end
									end
								elseif type(value) == "string" and value ~= "" then
									selectedValues[value] = true
									valueB, valueC, valueD = pairs(MenuScrollScrollingFrame:GetChildren())

									for _, v in valueB, valueC, valueD do
										if v:IsA("Frame") and v.Name == "Item" then
											ItemTitle = v:FindFirstChild("ItemTitle")
											Indicator = v:FindFirstChild("Indicator")

											if ItemTitle and Indicator then
												if selectedValues[ItemTitle.Text] then
													tween = tw({
														v = ItemTitle,
														t = 0.2,
														s = "Quad",
														d = "Out",
														g = {
															TextTransparency = 0,
														},
													})
													tween:Play()
													tweenB = tw({
														v = Indicator,
														t = 0.2,
														s = "Back",
														d = "Out",
														g = {
															Size = UDim2.new(0, 4, 0, 32),
															BackgroundTransparency = 0,
														},
													})
													tweenB:Play()
												else
													tweenC = tw({
														v = ItemTitle,
														t = 0.2,
														s = "Quad",
														d = "Out",
														g = {
															TextTransparency = 0.5,
														},
													})
													tweenC:Play()
													tweenD = tw({
														v = Indicator,
														t = 0.2,
														s = "Back",
														d = "Out",
														g = {
															Size = UDim2.new(0, 0, 0, 32),
															BackgroundTransparency = 1,
														},
													})
													tweenD:Play()
												end
											end
										end
									end
								else
									valueB, valueC, valueD = pairs(MenuScrollScrollingFrame:GetChildren())

									for _, v in valueB, valueC, valueD do
										if v:IsA("Frame") and v.Name == "Item" then
											ItemTitle = v:FindFirstChild("ItemTitle")
											Indicator = v:FindFirstChild("Indicator")

											if ItemTitle and Indicator then
												if selectedValues[ItemTitle.Text] then
													tw({
														v = ItemTitle,
														t = 0.2,
														s = "Quad",
														d = "Out",
														g = {
															TextTransparency = 0,
														},
													}):Play()
													tw({
														v = Indicator,
														t = 0.2,
														s = "Back",
														d = "Out",
														g = {
															Size = UDim2.new(0, 4, 0, 32),
															BackgroundTransparency = 0,
														},
													}):Play()
												else
													tw({
														v = ItemTitle,
														t = 0.2,
														s = "Quad",
														d = "Out",
														g = {
															TextTransparency = 0.5,
														},
													}):Play()
													tw({
														v = Indicator,
														t = 0.2,
														s = "Back",
														d = "Out",
														g = {
															Size = UDim2.new(0, 0, 0, 32),
															BackgroundTransparency = 1,
														},
													}):Play()
												end
											end
										end
									end
								end

								updateDisplayText()
							end,
							GetValue = function()
								if not Multi then
									for k, v in pairs(selectedValues) do
										if v then
											return k
										end
									end

									return nil
								end

								local items = {}

								for k, v in pairs(selectedValues) do
									if v then
										table.insert(items, k)
									end
								end

								return items
							end,
							SetTitle = function(self, text)
								TitleTextLabel.Text = text
								TitleTextLabelB.Text = text

								for _, v in pairs(SearchItems) do
									if v.Frame == DropdownFrame then
										v.SearchName = text

										break
									end
								end
							end,
							SetDesc = function(self, text)
								if DescTextLabel then
									DescTextLabel.Text = text
								end
							end,
							Visible = function(self, visible)
								DropdownFrame.Visible = visible

								if not visible and isOpen then
									closeDropdown()
								end
							end,
						}
					else
						selectedValues[Value] = true
						updateDisplayText = function()
							if Multi then
								local items = {}

								for k, v in pairs(selectedValues) do
									if v then
										table.insert(items, k)
									end
								end

								if #items > 0 then
									ValueDisplayTextLabel.Text = #items .. " Selected"
								else
									ValueDisplayTextLabel.Text = "Select..."
								end
							else
								local flag = false

								for k, v in pairs(selectedValues) do
									if v then
										ValueDisplayTextLabel.Text = k
										flag = true

										break
									end
								end

								if not flag then
									ValueDisplayTextLabel.Text = "Select..."
								end
							end
						end
						closeDropdown = function()
							if isAnimating or not isOpen then
								return
							end

							isAnimating = true
							isOpen = false
							tw({
								v = DropdownMenuFrame,
								t = 0.25,
								s = "Quad",
								d = "Out",
								g = {
									Size = UDim2.new(0, 0, 1, 0),
								},
							}):Play()
							tw({
								v = SearchBoxTextBox,
								t = 0.2,
								s = "Quad",
								d = "Out",
								g = {
									Size = UDim2.new(0, 0, 0, 28),
								},
							}):Play()
							tw({
								v = ArrowIconImageLabel,
								t = 0.25,
								s = "Quad",
								d = "Out",
								g = {
									Rotation = 0,
								},
							}):Play()
							tw({
								v = DropdownFrameStroke,
								t = 0.25,
								s = "Quad",
								d = "Out",
								g = {
									Transparency = 0.75,
								},
							}):Play()
							task.spawn(function()
								task.wait(0.25)

								if not isOpen then
									DropdownMenuFrame.Visible = false
								end

								isAnimating = false
							end)
						end
						openDropdown = function()
							if isAnimating or isOpen then
								return
							end

							isAnimating = true
							isOpen = true
							DropdownMenuFrame.Visible = true
							SearchBoxTextBox.Text = ""
							tw({
								v = DropdownMenuFrame,
								t = 0.3,
								s = "Back",
								d = "Out",
								g = {
									Size = UDim2.new(0, 240, 1, 0),
								},
							}):Play()
							tw({
								v = SearchBoxTextBox,
								t = 0.25,
								s = "Back",
								d = "Out",
								g = {
									Size = UDim2.new(0.9, 0, 0, 28),
								},
							}):Play()
							tw({
								v = ArrowIconImageLabel,
								t = 0.3,
								s = "Back",
								d = "Out",
								g = {
									Rotation = 180,
								},
							}):Play()
							tw({
								v = DropdownFrameStroke,
								t = 0.3,
								s = "Quad",
								d = "Out",
								g = {
									Transparency = 0.4,
								},
							}):Play()
							task.spawn(function()
								task.wait(0.3)
								isAnimating = false
							end)
						end
						ClickDropdownTextButton.Name = "ClickDropdown"
						ClickDropdownTextButton.Parent = DropdownFrame
						ClickDropdownTextButton.BackgroundTransparency = 1
						ClickDropdownTextButton.Size = UDim2.new(1, 0, 1, 0)
						ClickDropdownTextButton.Position = UDim2.new(0, 0, 0, 0)
						ClickDropdownTextButton.BorderSizePixel = 0
						ClickDropdownTextButton.AutoButtonColor = false
						ClickDropdownTextButton.ZIndex = 10
						ClickDropdownTextButton.Text = ""
						ClickDropdownTextButton.MouseButton1Click:Connect(function()
							if isAnimating then
								return
							end

							if isOpen then
								closeDropdown()
							else
								openDropdown()
							end

							EffectClick2(ClickDropdownTextButton, DropdownFrame)
						end)
						connection = nil
						listenForOutsideClick = function()
							if connection then
								connection:Disconnect()
								connection = nil
							end

							connection = UserInputService.InputBegan:Connect(function(input)
								if not isOpen or isAnimating then
									return
								end

								if
									input.UserInputType == Enum.UserInputType.MouseButton1
									or input.UserInputType == Enum.UserInputType.Touch
								then
									local mouseLocation = UserInputService:GetMouseLocation()
									local AbsolutePosition = DropdownMenuFrame.AbsolutePosition
									local AbsoluteSize = DropdownMenuFrame.AbsoluteSize
									local absolutePosition = DropdownFrame.AbsolutePosition
									local absoluteSize = DropdownFrame.AbsoluteSize

									if
										not (
											mouseLocation.X >= AbsolutePosition.X
												and mouseLocation.X <= AbsolutePosition.X + AbsoluteSize.X
												and mouseLocation.Y >= AbsolutePosition.Y
												and mouseLocation.Y <= AbsolutePosition.Y + AbsoluteSize.Y
											or mouseLocation.X >= absolutePosition.X
												and mouseLocation.X <= absolutePosition.X + absoluteSize.X
												and mouseLocation.Y >= absolutePosition.Y
												and mouseLocation.Y <= absolutePosition.Y + absoluteSize.Y
										)
									then
										closeDropdown()
									end
								end
							end)
						end
						SearchBoxTextBox:GetPropertyChangedSignal("Text"):Connect(function()
							local lowered = string.lower(SearchBoxTextBox.Text)

							for _, child in pairs(MenuScrollScrollingFrame:GetChildren()) do
								if child:IsA("Frame") and child.Name == "Item" then
									local ItemTitle = child:FindFirstChild("ItemTitle")

									if ItemTitle then
										local loweredB = string.lower(ItemTitle.Text)

										child.Visible = lowered == "" or string.find(loweredB, lowered, 1, true) ~= nil
									end
								end
							end
						end)
						SearchBoxTextBox.Focused:Connect(function()
							tw({
								v = SearchBoxTextBoxStroke,
								t = 0.3,
								s = "Quad",
								d = "Out",
								g = {
									Transparency = 0.3,
								},
							}):Play()
						end)
						SearchBoxTextBox.FocusLost:Connect(function()
							tw({
								v = SearchBoxTextBoxStroke,
								t = 0.3,
								s = "Quad",
								d = "Out",
								g = {
									Transparency = 0.7,
								},
							}):Play()
						end)
						addItem = function(text)
							local ItemFrame = Instance.new("Frame")
							local ItemFrameCorner = Instance.new("UICorner")
							local ItemTitleTextLabel = Instance.new("TextLabel")
							local IndicatorFrame = Instance.new("Frame")
							local IndicatorFrameCorner = Instance.new("UICorner")
							local IndicatorFrameGradient = Instance.new("UIGradient")

							ItemFrame.Name = "Item"
							ItemFrame.Parent = MenuScrollScrollingFrame
							ItemFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
							ItemFrame.BackgroundTransparency = 0.4
							ItemFrame.Size = UDim2.new(1, 0, 0, 32)
							ItemFrame.ZIndex = 102
							ItemFrameCorner.Parent = ItemFrame
							ItemFrameCorner.CornerRadius = UDim.new(0, 8)
							ItemTitleTextLabel.Name = "ItemTitle"
							ItemTitleTextLabel.Parent = ItemFrame
							ItemTitleTextLabel.BackgroundTransparency = 1
							ItemTitleTextLabel.Position = UDim2.new(0, 12, 0, 0)
							ItemTitleTextLabel.Size = UDim2.new(1, -44, 1, 0)
							ItemTitleTextLabel.Font = Enum.Font.GothamBold
							ItemTitleTextLabel.Text = text
							ItemTitleTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
							ItemTitleTextLabel.TextSize = 13
							ItemTitleTextLabel.TextTransparency = selectedValues[text] and 0 or 0.5
							ItemTitleTextLabel.TextXAlignment = Enum.TextXAlignment.Left
							ItemTitleTextLabel.TextScaled = true
							ItemTitleTextLabel.TextWrapped = true
							ItemTitleTextLabel.ZIndex = 103

							local ItemTitleTextLabelTextConstraint = Instance.new("UITextSizeConstraint")

							ItemTitleTextLabelTextConstraint.Parent = ItemTitleTextLabel
							ItemTitleTextLabelTextConstraint.MaxTextSize = 13
							ItemTitleTextLabelTextConstraint.MinTextSize = 9
							IndicatorFrame.Name = "Indicator"
							IndicatorFrame.Parent = ItemFrame
							IndicatorFrame.AnchorPoint = Vector2.new(0, 0.5)
							IndicatorFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
							IndicatorFrame.Position = UDim2.new(0, 0, 0.5, 0)
							IndicatorFrame.Size = UDim2.new(0, selectedValues[text] and 4 or 0, 0, 32)
							IndicatorFrame.BackgroundTransparency = selectedValues[text] and 0 or 1
							IndicatorFrame.ZIndex = 102
							IndicatorFrameCorner.Parent = IndicatorFrame
							IndicatorFrameCorner.CornerRadius = UDim.new(1, 0)
							IndicatorFrameGradient.Parent = IndicatorFrame
							IndicatorFrameGradient.Color = ColorSequence.new({
								ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
								ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 170, 255)),
								ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)),
							})
							IndicatorFrameGradient.Rotation = 90

							local ClickTextButton = Instance.new("TextButton")

							ClickTextButton.Name = "Click"
							ClickTextButton.Parent = ItemFrame
							ClickTextButton.BackgroundTransparency = 1
							ClickTextButton.BorderSizePixel = 0
							ClickTextButton.Size = UDim2.new(1, 0, 1, 0)
							ClickTextButton.Position = UDim2.new(0, 0, 0, 0)
							ClickTextButton.ZIndex = 120
							ClickTextButton.AutoButtonColor = false
							ClickTextButton.Font = Enum.Font.SourceSans
							ClickTextButton.Text = ""
							ClickTextButton.MouseEnter:Connect(function()
								tw({
									v = ItemFrame,
									t = 0.2,
									s = "Quad",
									d = "Out",
									g = {
										BackgroundTransparency = 0.2,
									},
								}):Play()
							end)
							ClickTextButton.MouseLeave:Connect(function()
								tw({
									v = ItemFrame,
									t = 0.2,
									s = "Quad",
									d = "Out",
									g = {
										BackgroundTransparency = 0.4,
									},
								}):Play()
							end)
							ClickTextButton.MouseButton1Click:Connect(function()
								EffectClick2(ClickTextButton, ItemFrame)

								if Multi then
									selectedValues[text] = not selectedValues[text]

									local items, task_

									if selectedValues[text] then
										tw({
											v = ItemTitleTextLabel,
											t = 0.2,
											s = "Quad",
											d = "Out",
											g = {
												TextTransparency = 0,
											},
										}):Play()
										tw({
											v = IndicatorFrame,
											t = 0.2,
											s = "Back",
											d = "Out",
											g = {
												Size = UDim2.new(0, 4, 0, 32),
												BackgroundTransparency = 0,
											},
										}):Play()
										items = {}

										for k, v in pairs(selectedValues) do
											if v then
												table.insert(items, k)
											end
										end

										updateDisplayText()
										task_ = task
									else
										tw({
											v = ItemTitleTextLabel,
											t = 0.2,
											s = "Quad",
											d = "Out",
											g = {
												TextTransparency = 0.5,
											},
										}):Play()
										tw({
											v = IndicatorFrame,
											t = 0.2,
											s = "Back",
											d = "Out",
											g = {
												Size = UDim2.new(0, 0, 0, 32),
												BackgroundTransparency = 1,
											},
										}):Play()
										items = {}

										for k, v in pairs(selectedValues) do
											if v then
												table.insert(items, k)
											end
										end

										updateDisplayText()
										task_ = task
									end

									task_.spawn(function()
										pcall(Callback, items)
									end)
								else
									for k in pairs(selectedValues) do
										selectedValues[k] = false
									end

									selectedValues[text] = true

									for _, child in pairs(MenuScrollScrollingFrame:GetChildren()) do
										if child:IsA("Frame") and child.Name == "Item" then
											local ItemTitle = child:FindFirstChild("ItemTitle")
											local Indicator = child:FindFirstChild("Indicator")

											if ItemTitle and Indicator then
												tw({
													v = ItemTitle,
													t = 0.2,
													s = "Quad",
													d = "Out",
													g = {
														TextTransparency = 0.5,
													},
												}):Play()
												tw({
													v = Indicator,
													t = 0.2,
													s = "Back",
													d = "Out",
													g = {
														Size = UDim2.new(0, 0, 0, 32),
														BackgroundTransparency = 1,
													},
												}):Play()
											end
										end
									end

									tw({
										v = ItemTitleTextLabel,
										t = 0.2,
										s = "Quad",
										d = "Out",
										g = {
											TextTransparency = 0,
										},
									}):Play()
									tw({
										v = IndicatorFrame,
										t = 0.2,
										s = "Back",
										d = "Out",
										g = {
											Size = UDim2.new(0, 4, 0, 32),
											BackgroundTransparency = 0,
										},
									}):Play()
									updateDisplayText()
									task.spawn(function()
										pcall(Callback, text)
									end)
									task.wait(0.15)
									closeDropdown()
								end
							end)
						end

						for _, v in pairs(List) do
							addItem(v)
						end

						updateDisplayText()
						listenForOutsideClick()
						table.insert(SearchItems, {
							Frame = DropdownFrame,
							SearchName = TitleB,
							HighlightFrame = HighlightFrameB,
						})
						DropdownFrame.Destroying:Connect(function()
							if connection then
								connection:Disconnect()
								connection = nil
							end

							if DropdownMenuFrame then
								DropdownMenuFrame:Destroy()
							end
						end)
						dropdownApi = {
							Add = function(self, item)
								if not table.find(List, item) then
									table.insert(List, item)
									addItem(item)
								end
							end,
							Remove = function(self, item)
								for k, v in pairs(List) do
									if v == item then
										table.remove(List, k)

										break
									end
								end

								for _, child in pairs(MenuScrollScrollingFrame:GetChildren()) do
									if child:IsA("Frame") and child.Name == "Item" then
										local ItemTitle = child:FindFirstChild("ItemTitle")

										if ItemTitle and ItemTitle.Text == item then
											child:Destroy()

											break
										end
									end
								end

								selectedValues[item] = nil
								updateDisplayText()
							end,
							Clear = function()
								for _, child in pairs(MenuScrollScrollingFrame:GetChildren()) do
									if child:IsA("Frame") and child.Name == "Item" then
										child:Destroy()
									end
								end

								List = {}
								selectedValues = {}
								updateDisplayText()
							end,
							SetValue = function(self, value)
								selectedValues = {}

								local valueB, valueC, valueD, ItemTitle, Indicator, tween, tweenB, tweenC, tweenD

								if type(value) == "table" then
									local iterator, iterTable, iterKey = pairs(value)
									local iteratorB = geniter(iterator, iterTable, iterKey)

									for _, v in iterator, iterTable, iterKey do
										while true do
											selectedValues[v] = true

											local packed = table.pack(iteratorB())

											if not packed[1] then
												break
											end

											v = packed[3]
										end

										local iterator, iterTable, iterKey = pairs(MenuScrollScrollingFrame:GetChildren())

										for _, entry in iterator, iterTable, iterKey do
											if entry:IsA("Frame") and entry.Name == "Item" then
												local child = entry:FindFirstChild("ItemTitle")
												local childB = entry:FindFirstChild("Indicator")

												if child and childB then
													if selectedValues[child.Text] then
														tw({
															v = child,
															t = 0.2,
															s = "Quad",
															d = "Out",
															g = {
																TextTransparency = 0,
															},
														}):Play()
														tw({
															v = childB,
															t = 0.2,
															s = "Back",
															d = "Out",
															g = {
																Size = UDim2.new(0, 4, 0, 32),
																BackgroundTransparency = 0,
															},
														}):Play()
													else
														tw({
															v = child,
															t = 0.2,
															s = "Quad",
															d = "Out",
															g = {
																TextTransparency = 0.5,
															},
														}):Play()
														tw({
															v = childB,
															t = 0.2,
															s = "Back",
															d = "Out",
															g = {
																Size = UDim2.new(0, 0, 0, 32),
																BackgroundTransparency = 1,
															},
														}):Play()
													end
												end
											end
										end

										updateDisplayText()

										return
									end

									valueB, valueC, valueD = pairs(MenuScrollScrollingFrame:GetChildren())

									for _, v in valueB, valueC, valueD do
										if v:IsA("Frame") and v.Name == "Item" then
											ItemTitle = v:FindFirstChild("ItemTitle")
											Indicator = v:FindFirstChild("Indicator")

											if ItemTitle and Indicator then
												if selectedValues[ItemTitle.Text] then
													tween = tw({
														v = ItemTitle,
														t = 0.2,
														s = "Quad",
														d = "Out",
														g = {
															TextTransparency = 0,
														},
													})
													tween:Play()
													tweenB = tw({
														v = Indicator,
														t = 0.2,
														s = "Back",
														d = "Out",
														g = {
															Size = UDim2.new(0, 4, 0, 32),
															BackgroundTransparency = 0,
														},
													})
													tweenB:Play()
												else
													tweenC = tw({
														v = ItemTitle,
														t = 0.2,
														s = "Quad",
														d = "Out",
														g = {
															TextTransparency = 0.5,
														},
													})
													tweenC:Play()
													tweenD = tw({
														v = Indicator,
														t = 0.2,
														s = "Back",
														d = "Out",
														g = {
															Size = UDim2.new(0, 0, 0, 32),
															BackgroundTransparency = 1,
														},
													})
													tweenD:Play()
												end
											end
										end
									end
								elseif type(value) == "string" and value ~= "" then
									selectedValues[value] = true
									valueB, valueC, valueD = pairs(MenuScrollScrollingFrame:GetChildren())

									for _, v in valueB, valueC, valueD do
										if v:IsA("Frame") and v.Name == "Item" then
											ItemTitle = v:FindFirstChild("ItemTitle")
											Indicator = v:FindFirstChild("Indicator")

											if ItemTitle and Indicator then
												if selectedValues[ItemTitle.Text] then
													tween = tw({
														v = ItemTitle,
														t = 0.2,
														s = "Quad",
														d = "Out",
														g = {
															TextTransparency = 0,
														},
													})
													tween:Play()
													tweenB = tw({
														v = Indicator,
														t = 0.2,
														s = "Back",
														d = "Out",
														g = {
															Size = UDim2.new(0, 4, 0, 32),
															BackgroundTransparency = 0,
														},
													})
													tweenB:Play()
												else
													tweenC = tw({
														v = ItemTitle,
														t = 0.2,
														s = "Quad",
														d = "Out",
														g = {
															TextTransparency = 0.5,
														},
													})
													tweenC:Play()
													tweenD = tw({
														v = Indicator,
														t = 0.2,
														s = "Back",
														d = "Out",
														g = {
															Size = UDim2.new(0, 0, 0, 32),
															BackgroundTransparency = 1,
														},
													})
													tweenD:Play()
												end
											end
										end
									end
								else
									valueB, valueC, valueD = pairs(MenuScrollScrollingFrame:GetChildren())

									for _, v in valueB, valueC, valueD do
										if v:IsA("Frame") and v.Name == "Item" then
											ItemTitle = v:FindFirstChild("ItemTitle")
											Indicator = v:FindFirstChild("Indicator")

											if ItemTitle and Indicator then
												if selectedValues[ItemTitle.Text] then
													tw({
														v = ItemTitle,
														t = 0.2,
														s = "Quad",
														d = "Out",
														g = {
															TextTransparency = 0,
														},
													}):Play()
													tw({
														v = Indicator,
														t = 0.2,
														s = "Back",
														d = "Out",
														g = {
															Size = UDim2.new(0, 4, 0, 32),
															BackgroundTransparency = 0,
														},
													}):Play()
												else
													tw({
														v = ItemTitle,
														t = 0.2,
														s = "Quad",
														d = "Out",
														g = {
															TextTransparency = 0.5,
														},
													}):Play()
													tw({
														v = Indicator,
														t = 0.2,
														s = "Back",
														d = "Out",
														g = {
															Size = UDim2.new(0, 0, 0, 32),
															BackgroundTransparency = 1,
														},
													}):Play()
												end
											end
										end
									end
								end

								updateDisplayText()
							end,
							GetValue = function()
								if not Multi then
									for k, v in pairs(selectedValues) do
										if v then
											return k
										end
									end

									return nil
								end

								local items = {}

								for k, v in pairs(selectedValues) do
									if v then
										table.insert(items, k)
									end
								end

								return items
							end,
							SetTitle = function(self, text)
								TitleTextLabel.Text = text
								TitleTextLabelB.Text = text

								for _, v in pairs(SearchItems) do
									if v.Frame == DropdownFrame then
										v.SearchName = text

										break
									end
								end
							end,
							SetDesc = function(self, text)
								if DescTextLabel then
									DescTextLabel.Text = text
								end
							end,
							Visible = function(self, visible)
								DropdownFrame.Visible = visible

								if not visible and isOpen then
									closeDropdown()
								end
							end,
						}
					end
				end
			else
				local text = "l"

				Callback = options.Callback or function() end
				number += 1
				BadgeLabelTextLabel.Text = tostring(number)
				tw({
					v = BadgeFrame,
					t = 0.3,
					s = "Back",
					d = "Out",
					g = {
						Size = UDim2.new(0, math.max(32, #tostring(number) * 10 + 12), 0, 18),
					},
				}):Play()
				DropdownFrame = Instance.new("Frame")

				local DropdownFrameCorner = Instance.new("UICorner")

				DropdownFrameStroke = Instance.new("UIStroke")

				local DropdownFrameImage = Instance.new("ImageLabel")
				local DropdownFrameImageGradient = Instance.new("UIGradient")

				TitleTextLabel = Instance.new("TextLabel")
				DescTextLabel = Instance.new("TextLabel")
				ValueDisplayTextLabel = Instance.new("TextLabel")

				local ValueDisplayTextLabelGradient = Instance.new("UIGradient")

				ArrowIconImageLabel = Instance.new("ImageLabel")
				ArrowIconImageLabelGradient = Instance.new("UIGradient")
				HighlightFrameB = Instance.new("Frame")

				local HighlightFrameBCorner = Instance.new("UICorner")

				ClickDropdownTextButton = Instance.new("TextButton")
				DropdownFrame.Name = "Dropdown"
				DropdownFrame.Parent = GetColumn(text)
				DropdownFrame.AnchorPoint = Vector2.new(0.5, 0.5)
				DropdownFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
				DropdownFrame.BackgroundTransparency = 0.35
				DropdownFrame.BorderSizePixel = 0

				local uDim2New = UDim2.new
				local value = 0.97
				local number = 0
				local numberB = 0

				DropdownFrame.Size = uDim2New(value, number, numberB, DescB ~= "" and 65 or 50)
				DropdownFrame.ClipsDescendants = true
				DropdownFrameCorner.Parent = DropdownFrame
				DropdownFrameCorner.CornerRadius = UDim.new(0, 12)
				DropdownFrameStroke.Parent = DropdownFrame
				DropdownFrameStroke.Color = Color3.fromRGB(110, 110, 140)
				DropdownFrameStroke.Thickness = 2
				DropdownFrameStroke.Transparency = 0.75
				HighlightFrameB.Name = "HighlightFrame"
				HighlightFrameB.Parent = DropdownFrame
				HighlightFrameB.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				HighlightFrameB.BackgroundTransparency = 1
				HighlightFrameB.Size = UDim2.new(1, 0, 1, 0)
				HighlightFrameB.ZIndex = 2
				HighlightFrameBCorner.CornerRadius = UDim.new(0, 12)
				HighlightFrameBCorner.Parent = HighlightFrameB
				DropdownFrameImage.Parent = DropdownFrame
				DropdownFrameImage.AnchorPoint = Vector2.new(0.5, 0.5)
				DropdownFrameImage.BackgroundTransparency = 1
				DropdownFrameImage.Position = UDim2.new(0.5, 0, 0.5, 0)
				DropdownFrameImage.Size = UDim2.new(1, 50, 1, 0)
				DropdownFrameImage.Image = "rbxassetid://72380279434385"
				DropdownFrameImage.ImageTransparency = 0.85
				DropdownFrameImage.ScaleType = Enum.ScaleType.Crop
				DropdownFrameImageGradient.Parent = DropdownFrameImage
				DropdownFrameImageGradient.Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
					ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 170, 255)),
					ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)),
				})
				TitleTextLabel.Name = "Title"
				TitleTextLabel.Parent = DropdownFrame
				TitleTextLabel.BackgroundTransparency = 1
				TitleTextLabel.Position = UDim2.new(0.04, 0, 0, 6)
				TitleTextLabel.Size = UDim2.new(0.75, 0, 0, 16)
				TitleTextLabel.Font = Enum.Font.GothamBold
				TitleTextLabel.Text = TitleB
				TitleTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
				TitleTextLabel.TextSize = 14
				TitleTextLabel.TextXAlignment = Enum.TextXAlignment.Left
				TitleTextLabel.TextScaled = true
				TitleTextLabel.TextWrapped = true

				local TitleTextLabelTextConstraint = Instance.new("UITextSizeConstraint")

				TitleTextLabelTextConstraint.Parent = TitleTextLabel
				TitleTextLabelTextConstraint.MaxTextSize = 14
				TitleTextLabelTextConstraint.MinTextSize = 10
				ValueDisplayTextLabel.Name = "ValueDisplay"
				ValueDisplayTextLabel.Parent = DropdownFrame
				ValueDisplayTextLabel.BackgroundTransparency = 1
				ValueDisplayTextLabel.Position = UDim2.new(0.04, numberB, 0, DescB ~= "" and 28 or 24)
				ValueDisplayTextLabel.Size = UDim2.new(0.85, 0, 0, 16)
				ValueDisplayTextLabel.Font = Enum.Font.GothamBold
				ValueDisplayTextLabel.Text = type(Value) == "table" and "Multiple Selected"
					or Value ~= "" and tostring(Value)
					or "Select..."
				ValueDisplayTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
				ValueDisplayTextLabel.TextSize = 12
				ValueDisplayTextLabel.TextXAlignment = Enum.TextXAlignment.Left
				ValueDisplayTextLabel.TextScaled = true
				ValueDisplayTextLabel.TextWrapped = true

				local ValueDisplayTextLabelTextConstraint = Instance.new("UITextSizeConstraint")

				ValueDisplayTextLabelTextConstraint.Parent = ValueDisplayTextLabel
				ValueDisplayTextLabelTextConstraint.MaxTextSize = 12
				ValueDisplayTextLabelTextConstraint.MinTextSize = 8
				ValueDisplayTextLabelGradient.Parent = ValueDisplayTextLabel
				ValueDisplayTextLabelGradient.Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
					ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 170, 255)),
					ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)),
				})
				ValueDisplayTextLabelGradient.Rotation = 90

				if DescB == "" then
					ArrowIconImageLabel.Name = "ArrowIcon"
					ArrowIconImageLabel.Parent = DropdownFrame
					ArrowIconImageLabel.AnchorPoint = Vector2.new(1, 0.5)
					ArrowIconImageLabel.BackgroundTransparency = 1
					ArrowIconImageLabel.Position = UDim2.new(0.96, 0, 0.5, 0)
					ArrowIconImageLabel.Size = UDim2.new(0, 24, 0, 24)
					ArrowIconImageLabel.Image = "rbxassetid://129573215183311"
					ArrowIconImageLabel.ScaleType = Enum.ScaleType.Fit
					ArrowIconImageLabelGradient.Parent = ArrowIconImageLabel
					ArrowIconImageLabelGradient.Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
						ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 170, 255)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)),
					})
					DropdownMenuFrame = Instance.new("Frame")
					DropdownMenuFrameCorner = Instance.new("UICorner")
					DropdownMenuFrameStroke = Instance.new("UIStroke")
					EffectImageLabel = Instance.new("ImageLabel")
					HeaderFrameB = Instance.new("Frame")
					TitleTextLabelB = Instance.new("TextLabel")
					LineFrameB = Instance.new("Frame")
					LineFrameBGradient = Instance.new("UIGradient")
					SearchBoxTextBox = Instance.new("TextBox")
					SearchBoxTextBoxCorner = Instance.new("UICorner")
					SearchBoxTextBoxStroke = Instance.new("UIStroke")
					SearchBoxTextBoxStrokeGradient = Instance.new("UIGradient")
					MenuScrollScrollingFrame = Instance.new("ScrollingFrame")
					MenuScrollScrollingFrameListLayout = Instance.new("UIListLayout")
					DropdownMenuFrame.Name = "DropdownMenu"
					DropdownMenuFrame.Parent = BackgroundFrame
					DropdownMenuFrame.AnchorPoint = Vector2.new(1, 0.5)
					DropdownMenuFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
					DropdownMenuFrame.BackgroundTransparency = 0.05
					DropdownMenuFrame.Position = UDim2.new(1, 0, 0.5, 0)
					DropdownMenuFrame.Size = UDim2.new(0, 0, 1, 0)
					DropdownMenuFrame.ClipsDescendants = true
					DropdownMenuFrame.Visible = false
					DropdownMenuFrame.ZIndex = 100
					DropdownMenuFrameCorner.Parent = DropdownMenuFrame
					DropdownMenuFrameCorner.CornerRadius = UDim.new(0, 16)
					DropdownMenuFrameStroke.Parent = DropdownMenuFrame
					DropdownMenuFrameStroke.Color = Color3.fromRGB(110, 110, 140)
					DropdownMenuFrameStroke.Thickness = 2
					DropdownMenuFrameStroke.Transparency = 0.6
					EffectImageLabel.Name = "Effect"
					EffectImageLabel.Parent = DropdownMenuFrame
					EffectImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
					EffectImageLabel.BackgroundTransparency = 1
					EffectImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
					EffectImageLabel.Size = UDim2.new(1, 0, 1, 0)
					EffectImageLabel.Image = "rbxassetid://132687652275989"
					EffectImageLabel.ImageColor3 = Color3.fromRGB(0, 255, 127)
					EffectImageLabel.ImageTransparency = 0.5
					EffectImageLabel.ScaleType = Enum.ScaleType.Crop
					EffectImageLabel.ZIndex = 100
					HeaderFrameB.Name = "Header"
					HeaderFrameB.Parent = DropdownMenuFrame
					HeaderFrameB.BackgroundTransparency = 1
					HeaderFrameB.Size = UDim2.new(1, 0, 0, 70)
					HeaderFrameB.ZIndex = 101
					TitleTextLabelB.Name = "Title"
					TitleTextLabelB.Parent = HeaderFrameB
					TitleTextLabelB.BackgroundTransparency = 1
					TitleTextLabelB.Position = UDim2.new(0, 16, 0, 12)
					TitleTextLabelB.Size = UDim2.new(1, -32, 0, 24)
					TitleTextLabelB.Font = Enum.Font.GothamBold
					TitleTextLabelB.Text = TitleB
					TitleTextLabelB.TextColor3 = Color3.fromRGB(255, 255, 255)
					TitleTextLabelB.TextSize = 18
					TitleTextLabelB.TextXAlignment = Enum.TextXAlignment.Left
					TitleTextLabelB.ZIndex = 101
					LineFrameB.Name = "Line"
					LineFrameB.Parent = HeaderFrameB
					LineFrameB.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					LineFrameB.BorderSizePixel = 0
					LineFrameB.Position = UDim2.new(0, 16, 0, 42)
					LineFrameB.Size = UDim2.new(0, 60, 0, 2)
					LineFrameB.ZIndex = 101
					LineFrameBGradient.Parent = LineFrameB
					LineFrameBGradient.Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
						ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 170, 255)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)),
					})
					SearchBoxTextBox.Name = "SearchBox"
					SearchBoxTextBox.Parent = HeaderFrameB
					SearchBoxTextBox.AnchorPoint = Vector2.new(0.5, 1)
					SearchBoxTextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					SearchBoxTextBox.BackgroundTransparency = 0.92
					SearchBoxTextBox.Position = UDim2.new(0.5, 0, 1, -4)
					SearchBoxTextBox.Size = UDim2.new(0, 0, 0, 28)
					SearchBoxTextBox.Font = Enum.Font.GothamBold
					SearchBoxTextBox.PlaceholderColor3 = Color3.fromRGB(140, 140, 140)
					SearchBoxTextBox.PlaceholderText = "Search..."
					SearchBoxTextBox.Text = ""
					SearchBoxTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
					SearchBoxTextBox.TextSize = 12
					SearchBoxTextBox.ClearTextOnFocus = false
					SearchBoxTextBox.ZIndex = 102
					SearchBoxTextBoxCorner.Parent = SearchBoxTextBox
					SearchBoxTextBoxCorner.CornerRadius = UDim.new(0, 8)
					SearchBoxTextBoxStroke.Parent = SearchBoxTextBox
					SearchBoxTextBoxStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
					SearchBoxTextBoxStroke.Color = Color3.fromRGB(255, 255, 255)
					SearchBoxTextBoxStroke.Thickness = 1.5
					SearchBoxTextBoxStroke.Transparency = 0.7
					SearchBoxTextBoxStrokeGradient.Parent = SearchBoxTextBoxStroke
					SearchBoxTextBoxStrokeGradient.Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
						ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 170, 255)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)),
					})
					MenuScrollScrollingFrame.Name = "MenuScroll"
					MenuScrollScrollingFrame.Parent = DropdownMenuFrame
					MenuScrollScrollingFrame.Active = true
					MenuScrollScrollingFrame.BackgroundTransparency = 1
					MenuScrollScrollingFrame.BorderSizePixel = 0
					MenuScrollScrollingFrame.Position = UDim2.new(0, 8, 0, 78)
					MenuScrollScrollingFrame.Size = UDim2.new(1, -16, 1, -86)
					MenuScrollScrollingFrame.ClipsDescendants = true
					MenuScrollScrollingFrame.ScrollBarThickness = 4
					MenuScrollScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(0, 170, 255)
					MenuScrollScrollingFrame.ScrollBarImageTransparency = 0.7
					MenuScrollScrollingFrame.ZIndex = 101
					MenuScrollScrollingFrameListLayout.Parent = MenuScrollScrollingFrame
					MenuScrollScrollingFrameListLayout.Padding = UDim.new(0, 4)
					MenuScrollScrollingFrameListLayout.SortOrder = Enum.SortOrder.LayoutOrder
					MenuScrollScrollingFrameListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
						MenuScrollScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, MenuScrollScrollingFrameListLayout.AbsoluteContentSize.Y + 8)
					end)
					isAnimating = false
					isOpen = false
					selectedValues = {}

					if type(Value) == "table" then
						for _, v in pairs(Value) do
							selectedValues[v] = true
						end

						updateDisplayText = function()
							if Multi then
								local items = {}

								for k, v in pairs(selectedValues) do
									if v then
										table.insert(items, k)
									end
								end

								if #items > 0 then
									ValueDisplayTextLabel.Text = #items .. " Selected"
								else
									ValueDisplayTextLabel.Text = "Select..."
								end
							else
								local flag = false

								for k, v in pairs(selectedValues) do
									if v then
										ValueDisplayTextLabel.Text = k
										flag = true

										break
									end
								end

								if not flag then
									ValueDisplayTextLabel.Text = "Select..."
								end
							end
						end
						closeDropdown = function()
							if isAnimating or not isOpen then
								return
							end

							isAnimating = true
							isOpen = false
							tw({
								v = DropdownMenuFrame,
								t = 0.25,
								s = "Quad",
								d = "Out",
								g = {
									Size = UDim2.new(0, 0, 1, 0),
								},
							}):Play()
							tw({
								v = SearchBoxTextBox,
								t = 0.2,
								s = "Quad",
								d = "Out",
								g = {
									Size = UDim2.new(0, 0, 0, 28),
								},
							}):Play()
							tw({
								v = ArrowIconImageLabel,
								t = 0.25,
								s = "Quad",
								d = "Out",
								g = {
									Rotation = 0,
								},
							}):Play()
							tw({
								v = DropdownFrameStroke,
								t = 0.25,
								s = "Quad",
								d = "Out",
								g = {
									Transparency = 0.75,
								},
							}):Play()
							task.spawn(function()
								task.wait(0.25)

								if not isOpen then
									DropdownMenuFrame.Visible = false
								end

								isAnimating = false
							end)
						end
						openDropdown = function()
							if isAnimating or isOpen then
								return
							end

							isAnimating = true
							isOpen = true
							DropdownMenuFrame.Visible = true
							SearchBoxTextBox.Text = ""
							tw({
								v = DropdownMenuFrame,
								t = 0.3,
								s = "Back",
								d = "Out",
								g = {
									Size = UDim2.new(0, 240, 1, 0),
								},
							}):Play()
							tw({
								v = SearchBoxTextBox,
								t = 0.25,
								s = "Back",
								d = "Out",
								g = {
									Size = UDim2.new(0.9, 0, 0, 28),
								},
							}):Play()
							tw({
								v = ArrowIconImageLabel,
								t = 0.3,
								s = "Back",
								d = "Out",
								g = {
									Rotation = 180,
								},
							}):Play()
							tw({
								v = DropdownFrameStroke,
								t = 0.3,
								s = "Quad",
								d = "Out",
								g = {
									Transparency = 0.4,
								},
							}):Play()
							task.spawn(function()
								task.wait(0.3)
								isAnimating = false
							end)
						end
						ClickDropdownTextButton.Name = "ClickDropdown"
						ClickDropdownTextButton.Parent = DropdownFrame
						ClickDropdownTextButton.BackgroundTransparency = 1
						ClickDropdownTextButton.Size = UDim2.new(1, 0, 1, 0)
						ClickDropdownTextButton.Position = UDim2.new(0, 0, 0, 0)
						ClickDropdownTextButton.BorderSizePixel = 0
						ClickDropdownTextButton.AutoButtonColor = false
						ClickDropdownTextButton.ZIndex = 10
						ClickDropdownTextButton.Text = ""
						ClickDropdownTextButton.MouseButton1Click:Connect(function()
							if isAnimating then
								return
							end

							if isOpen then
								closeDropdown()
							else
								openDropdown()
							end

							EffectClick2(ClickDropdownTextButton, DropdownFrame)
						end)
						connection = nil
						listenForOutsideClick = function()
							if connection then
								connection:Disconnect()
								connection = nil
							end

							connection = UserInputService.InputBegan:Connect(function(input)
								if not isOpen or isAnimating then
									return
								end

								if
									input.UserInputType == Enum.UserInputType.MouseButton1
									or input.UserInputType == Enum.UserInputType.Touch
								then
									local mouseLocation = UserInputService:GetMouseLocation()
									local AbsolutePosition = DropdownMenuFrame.AbsolutePosition
									local AbsoluteSize = DropdownMenuFrame.AbsoluteSize
									local absolutePosition = DropdownFrame.AbsolutePosition
									local absoluteSize = DropdownFrame.AbsoluteSize

									if
										not (
											mouseLocation.X >= AbsolutePosition.X
												and mouseLocation.X <= AbsolutePosition.X + AbsoluteSize.X
												and mouseLocation.Y >= AbsolutePosition.Y
												and mouseLocation.Y <= AbsolutePosition.Y + AbsoluteSize.Y
											or mouseLocation.X >= absolutePosition.X
												and mouseLocation.X <= absolutePosition.X + absoluteSize.X
												and mouseLocation.Y >= absolutePosition.Y
												and mouseLocation.Y <= absolutePosition.Y + absoluteSize.Y
										)
									then
										closeDropdown()
									end
								end
							end)
						end
						SearchBoxTextBox:GetPropertyChangedSignal("Text"):Connect(function()
							local lowered = string.lower(SearchBoxTextBox.Text)

							for _, child in pairs(MenuScrollScrollingFrame:GetChildren()) do
								if child:IsA("Frame") and child.Name == "Item" then
									local ItemTitle = child:FindFirstChild("ItemTitle")

									if ItemTitle then
										local loweredB = string.lower(ItemTitle.Text)

										child.Visible = lowered == "" or string.find(loweredB, lowered, 1, true) ~= nil
									end
								end
							end
						end)
						SearchBoxTextBox.Focused:Connect(function()
							tw({
								v = SearchBoxTextBoxStroke,
								t = 0.3,
								s = "Quad",
								d = "Out",
								g = {
									Transparency = 0.3,
								},
							}):Play()
						end)
						SearchBoxTextBox.FocusLost:Connect(function()
							tw({
								v = SearchBoxTextBoxStroke,
								t = 0.3,
								s = "Quad",
								d = "Out",
								g = {
									Transparency = 0.7,
								},
							}):Play()
						end)
						addItem = function(text)
							local ItemFrame = Instance.new("Frame")
							local ItemFrameCorner = Instance.new("UICorner")
							local ItemTitleTextLabel = Instance.new("TextLabel")
							local IndicatorFrame = Instance.new("Frame")
							local IndicatorFrameCorner = Instance.new("UICorner")
							local IndicatorFrameGradient = Instance.new("UIGradient")

							ItemFrame.Name = "Item"
							ItemFrame.Parent = MenuScrollScrollingFrame
							ItemFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
							ItemFrame.BackgroundTransparency = 0.4
							ItemFrame.Size = UDim2.new(1, 0, 0, 32)
							ItemFrame.ZIndex = 102
							ItemFrameCorner.Parent = ItemFrame
							ItemFrameCorner.CornerRadius = UDim.new(0, 8)
							ItemTitleTextLabel.Name = "ItemTitle"
							ItemTitleTextLabel.Parent = ItemFrame
							ItemTitleTextLabel.BackgroundTransparency = 1
							ItemTitleTextLabel.Position = UDim2.new(0, 12, 0, 0)
							ItemTitleTextLabel.Size = UDim2.new(1, -44, 1, 0)
							ItemTitleTextLabel.Font = Enum.Font.GothamBold
							ItemTitleTextLabel.Text = text
							ItemTitleTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
							ItemTitleTextLabel.TextSize = 13
							ItemTitleTextLabel.TextTransparency = selectedValues[text] and 0 or 0.5
							ItemTitleTextLabel.TextXAlignment = Enum.TextXAlignment.Left
							ItemTitleTextLabel.TextScaled = true
							ItemTitleTextLabel.TextWrapped = true
							ItemTitleTextLabel.ZIndex = 103

							local ItemTitleTextLabelTextConstraint = Instance.new("UITextSizeConstraint")

							ItemTitleTextLabelTextConstraint.Parent = ItemTitleTextLabel
							ItemTitleTextLabelTextConstraint.MaxTextSize = 13
							ItemTitleTextLabelTextConstraint.MinTextSize = 9
							IndicatorFrame.Name = "Indicator"
							IndicatorFrame.Parent = ItemFrame
							IndicatorFrame.AnchorPoint = Vector2.new(0, 0.5)
							IndicatorFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
							IndicatorFrame.Position = UDim2.new(0, 0, 0.5, 0)
							IndicatorFrame.Size = UDim2.new(0, selectedValues[text] and 4 or 0, 0, 32)
							IndicatorFrame.BackgroundTransparency = selectedValues[text] and 0 or 1
							IndicatorFrame.ZIndex = 102
							IndicatorFrameCorner.Parent = IndicatorFrame
							IndicatorFrameCorner.CornerRadius = UDim.new(1, 0)
							IndicatorFrameGradient.Parent = IndicatorFrame
							IndicatorFrameGradient.Color = ColorSequence.new({
								ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
								ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 170, 255)),
								ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)),
							})
							IndicatorFrameGradient.Rotation = 90

							local ClickTextButton = Instance.new("TextButton")

							ClickTextButton.Name = "Click"
							ClickTextButton.Parent = ItemFrame
							ClickTextButton.BackgroundTransparency = 1
							ClickTextButton.BorderSizePixel = 0
							ClickTextButton.Size = UDim2.new(1, 0, 1, 0)
							ClickTextButton.Position = UDim2.new(0, 0, 0, 0)
							ClickTextButton.ZIndex = 120
							ClickTextButton.AutoButtonColor = false
							ClickTextButton.Font = Enum.Font.SourceSans
							ClickTextButton.Text = ""
							ClickTextButton.MouseEnter:Connect(function()
								tw({
									v = ItemFrame,
									t = 0.2,
									s = "Quad",
									d = "Out",
									g = {
										BackgroundTransparency = 0.2,
									},
								}):Play()
							end)
							ClickTextButton.MouseLeave:Connect(function()
								tw({
									v = ItemFrame,
									t = 0.2,
									s = "Quad",
									d = "Out",
									g = {
										BackgroundTransparency = 0.4,
									},
								}):Play()
							end)
							ClickTextButton.MouseButton1Click:Connect(function()
								EffectClick2(ClickTextButton, ItemFrame)

								if Multi then
									selectedValues[text] = not selectedValues[text]

									local items, task_

									if selectedValues[text] then
										tw({
											v = ItemTitleTextLabel,
											t = 0.2,
											s = "Quad",
											d = "Out",
											g = {
												TextTransparency = 0,
											},
										}):Play()
										tw({
											v = IndicatorFrame,
											t = 0.2,
											s = "Back",
											d = "Out",
											g = {
												Size = UDim2.new(0, 4, 0, 32),
												BackgroundTransparency = 0,
											},
										}):Play()
										items = {}

										for k, v in pairs(selectedValues) do
											if v then
												table.insert(items, k)
											end
										end

										updateDisplayText()
										task_ = task
									else
										tw({
											v = ItemTitleTextLabel,
											t = 0.2,
											s = "Quad",
											d = "Out",
											g = {
												TextTransparency = 0.5,
											},
										}):Play()
										tw({
											v = IndicatorFrame,
											t = 0.2,
											s = "Back",
											d = "Out",
											g = {
												Size = UDim2.new(0, 0, 0, 32),
												BackgroundTransparency = 1,
											},
										}):Play()
										items = {}

										for k, v in pairs(selectedValues) do
											if v then
												table.insert(items, k)
											end
										end

										updateDisplayText()
										task_ = task
									end

									task_.spawn(function()
										pcall(Callback, items)
									end)
								else
									for k in pairs(selectedValues) do
										selectedValues[k] = false
									end

									selectedValues[text] = true

									for _, child in pairs(MenuScrollScrollingFrame:GetChildren()) do
										if child:IsA("Frame") and child.Name == "Item" then
											local ItemTitle = child:FindFirstChild("ItemTitle")
											local Indicator = child:FindFirstChild("Indicator")

											if ItemTitle and Indicator then
												tw({
													v = ItemTitle,
													t = 0.2,
													s = "Quad",
													d = "Out",
													g = {
														TextTransparency = 0.5,
													},
												}):Play()
												tw({
													v = Indicator,
													t = 0.2,
													s = "Back",
													d = "Out",
													g = {
														Size = UDim2.new(0, 0, 0, 32),
														BackgroundTransparency = 1,
													},
												}):Play()
											end
										end
									end

									tw({
										v = ItemTitleTextLabel,
										t = 0.2,
										s = "Quad",
										d = "Out",
										g = {
											TextTransparency = 0,
										},
									}):Play()
									tw({
										v = IndicatorFrame,
										t = 0.2,
										s = "Back",
										d = "Out",
										g = {
											Size = UDim2.new(0, 4, 0, 32),
											BackgroundTransparency = 0,
										},
									}):Play()
									updateDisplayText()
									task.spawn(function()
										pcall(Callback, text)
									end)
									task.wait(0.15)
									closeDropdown()
								end
							end)
						end

						for _, v in pairs(List) do
							addItem(v)
						end

						updateDisplayText()
						listenForOutsideClick()
						table.insert(SearchItems, {
							Frame = DropdownFrame,
							SearchName = TitleB,
							HighlightFrame = HighlightFrameB,
						})
						DropdownFrame.Destroying:Connect(function()
							if connection then
								connection:Disconnect()
								connection = nil
							end

							if DropdownMenuFrame then
								DropdownMenuFrame:Destroy()
							end
						end)
						dropdownApi = {
							Add = function(self, item)
								if not table.find(List, item) then
									table.insert(List, item)
									addItem(item)
								end
							end,
							Remove = function(self, item)
								for k, v in pairs(List) do
									if v == item then
										table.remove(List, k)

										break
									end
								end

								for _, child in pairs(MenuScrollScrollingFrame:GetChildren()) do
									if child:IsA("Frame") and child.Name == "Item" then
										local ItemTitle = child:FindFirstChild("ItemTitle")

										if ItemTitle and ItemTitle.Text == item then
											child:Destroy()

											break
										end
									end
								end

								selectedValues[item] = nil
								updateDisplayText()
							end,
							Clear = function()
								for _, child in pairs(MenuScrollScrollingFrame:GetChildren()) do
									if child:IsA("Frame") and child.Name == "Item" then
										child:Destroy()
									end
								end

								List = {}
								selectedValues = {}
								updateDisplayText()
							end,
							SetValue = function(self, value)
								selectedValues = {}

								local valueB, valueC, valueD, ItemTitle, Indicator, tween, tweenB, tweenC, tweenD

								if type(value) == "table" then
									local iterator, iterTable, iterKey = pairs(value)
									local iteratorB = geniter(iterator, iterTable, iterKey)

									for _, v in iterator, iterTable, iterKey do
										while true do
											selectedValues[v] = true

											local packed = table.pack(iteratorB())

											if not packed[1] then
												break
											end

											v = packed[3]
										end

										local iterator, iterTable, iterKey = pairs(MenuScrollScrollingFrame:GetChildren())

										for _, entry in iterator, iterTable, iterKey do
											if entry:IsA("Frame") and entry.Name == "Item" then
												local child = entry:FindFirstChild("ItemTitle")
												local childB = entry:FindFirstChild("Indicator")

												if child and childB then
													if selectedValues[child.Text] then
														tw({
															v = child,
															t = 0.2,
															s = "Quad",
															d = "Out",
															g = {
																TextTransparency = 0,
															},
														}):Play()
														tw({
															v = childB,
															t = 0.2,
															s = "Back",
															d = "Out",
															g = {
																Size = UDim2.new(0, 4, 0, 32),
																BackgroundTransparency = 0,
															},
														}):Play()
													else
														tw({
															v = child,
															t = 0.2,
															s = "Quad",
															d = "Out",
															g = {
																TextTransparency = 0.5,
															},
														}):Play()
														tw({
															v = childB,
															t = 0.2,
															s = "Back",
															d = "Out",
															g = {
																Size = UDim2.new(0, 0, 0, 32),
																BackgroundTransparency = 1,
															},
														}):Play()
													end
												end
											end
										end

										updateDisplayText()

										return
									end

									valueB, valueC, valueD = pairs(MenuScrollScrollingFrame:GetChildren())

									for _, v in valueB, valueC, valueD do
										if v:IsA("Frame") and v.Name == "Item" then
											ItemTitle = v:FindFirstChild("ItemTitle")
											Indicator = v:FindFirstChild("Indicator")

											if ItemTitle and Indicator then
												if selectedValues[ItemTitle.Text] then
													tween = tw({
														v = ItemTitle,
														t = 0.2,
														s = "Quad",
														d = "Out",
														g = {
															TextTransparency = 0,
														},
													})
													tween:Play()
													tweenB = tw({
														v = Indicator,
														t = 0.2,
														s = "Back",
														d = "Out",
														g = {
															Size = UDim2.new(0, 4, 0, 32),
															BackgroundTransparency = 0,
														},
													})
													tweenB:Play()
												else
													tweenC = tw({
														v = ItemTitle,
														t = 0.2,
														s = "Quad",
														d = "Out",
														g = {
															TextTransparency = 0.5,
														},
													})
													tweenC:Play()
													tweenD = tw({
														v = Indicator,
														t = 0.2,
														s = "Back",
														d = "Out",
														g = {
															Size = UDim2.new(0, 0, 0, 32),
															BackgroundTransparency = 1,
														},
													})
													tweenD:Play()
												end
											end
										end
									end
								elseif type(value) == "string" and value ~= "" then
									selectedValues[value] = true
									valueB, valueC, valueD = pairs(MenuScrollScrollingFrame:GetChildren())

									for _, v in valueB, valueC, valueD do
										if v:IsA("Frame") and v.Name == "Item" then
											ItemTitle = v:FindFirstChild("ItemTitle")
											Indicator = v:FindFirstChild("Indicator")

											if ItemTitle and Indicator then
												if selectedValues[ItemTitle.Text] then
													tween = tw({
														v = ItemTitle,
														t = 0.2,
														s = "Quad",
														d = "Out",
														g = {
															TextTransparency = 0,
														},
													})
													tween:Play()
													tweenB = tw({
														v = Indicator,
														t = 0.2,
														s = "Back",
														d = "Out",
														g = {
															Size = UDim2.new(0, 4, 0, 32),
															BackgroundTransparency = 0,
														},
													})
													tweenB:Play()
												else
													tweenC = tw({
														v = ItemTitle,
														t = 0.2,
														s = "Quad",
														d = "Out",
														g = {
															TextTransparency = 0.5,
														},
													})
													tweenC:Play()
													tweenD = tw({
														v = Indicator,
														t = 0.2,
														s = "Back",
														d = "Out",
														g = {
															Size = UDim2.new(0, 0, 0, 32),
															BackgroundTransparency = 1,
														},
													})
													tweenD:Play()
												end
											end
										end
									end
								else
									valueB, valueC, valueD = pairs(MenuScrollScrollingFrame:GetChildren())

									for _, v in valueB, valueC, valueD do
										if v:IsA("Frame") and v.Name == "Item" then
											ItemTitle = v:FindFirstChild("ItemTitle")
											Indicator = v:FindFirstChild("Indicator")

											if ItemTitle and Indicator then
												if selectedValues[ItemTitle.Text] then
													tw({
														v = ItemTitle,
														t = 0.2,
														s = "Quad",
														d = "Out",
														g = {
															TextTransparency = 0,
														},
													}):Play()
													tw({
														v = Indicator,
														t = 0.2,
														s = "Back",
														d = "Out",
														g = {
															Size = UDim2.new(0, 4, 0, 32),
															BackgroundTransparency = 0,
														},
													}):Play()
												else
													tw({
														v = ItemTitle,
														t = 0.2,
														s = "Quad",
														d = "Out",
														g = {
															TextTransparency = 0.5,
														},
													}):Play()
													tw({
														v = Indicator,
														t = 0.2,
														s = "Back",
														d = "Out",
														g = {
															Size = UDim2.new(0, 0, 0, 32),
															BackgroundTransparency = 1,
														},
													}):Play()
												end
											end
										end
									end
								end

								updateDisplayText()
							end,
							GetValue = function()
								if not Multi then
									for k, v in pairs(selectedValues) do
										if v then
											return k
										end
									end

									return nil
								end

								local items = {}

								for k, v in pairs(selectedValues) do
									if v then
										table.insert(items, k)
									end
								end

								return items
							end,
							SetTitle = function(self, text)
								TitleTextLabel.Text = text
								TitleTextLabelB.Text = text

								for _, v in pairs(SearchItems) do
									if v.Frame == DropdownFrame then
										v.SearchName = text

										break
									end
								end
							end,
							SetDesc = function(self, text)
								if DescTextLabel then
									DescTextLabel.Text = text
								end
							end,
							Visible = function(self, visible)
								DropdownFrame.Visible = visible

								if not visible and isOpen then
									closeDropdown()
								end
							end,
						}
					elseif Value == "" then
						updateDisplayText = function()
							if Multi then
								local items = {}

								for k, v in pairs(selectedValues) do
									if v then
										table.insert(items, k)
									end
								end

								if #items > 0 then
									ValueDisplayTextLabel.Text = #items .. " Selected"
								else
									ValueDisplayTextLabel.Text = "Select..."
								end
							else
								local flag = false

								for k, v in pairs(selectedValues) do
									if v then
										ValueDisplayTextLabel.Text = k
										flag = true

										break
									end
								end

								if not flag then
									ValueDisplayTextLabel.Text = "Select..."
								end
							end
						end
						closeDropdown = function()
							if isAnimating or not isOpen then
								return
							end

							isAnimating = true
							isOpen = false
							tw({
								v = DropdownMenuFrame,
								t = 0.25,
								s = "Quad",
								d = "Out",
								g = {
									Size = UDim2.new(0, 0, 1, 0),
								},
							}):Play()
							tw({
								v = SearchBoxTextBox,
								t = 0.2,
								s = "Quad",
								d = "Out",
								g = {
									Size = UDim2.new(0, 0, 0, 28),
								},
							}):Play()
							tw({
								v = ArrowIconImageLabel,
								t = 0.25,
								s = "Quad",
								d = "Out",
								g = {
									Rotation = 0,
								},
							}):Play()
							tw({
								v = DropdownFrameStroke,
								t = 0.25,
								s = "Quad",
								d = "Out",
								g = {
									Transparency = 0.75,
								},
							}):Play()
							task.spawn(function()
								task.wait(0.25)

								if not isOpen then
									DropdownMenuFrame.Visible = false
								end

								isAnimating = false
							end)
						end
						openDropdown = function()
							if isAnimating or isOpen then
								return
							end

							isAnimating = true
							isOpen = true
							DropdownMenuFrame.Visible = true
							SearchBoxTextBox.Text = ""
							tw({
								v = DropdownMenuFrame,
								t = 0.3,
								s = "Back",
								d = "Out",
								g = {
									Size = UDim2.new(0, 240, 1, 0),
								},
							}):Play()
							tw({
								v = SearchBoxTextBox,
								t = 0.25,
								s = "Back",
								d = "Out",
								g = {
									Size = UDim2.new(0.9, 0, 0, 28),
								},
							}):Play()
							tw({
								v = ArrowIconImageLabel,
								t = 0.3,
								s = "Back",
								d = "Out",
								g = {
									Rotation = 180,
								},
							}):Play()
							tw({
								v = DropdownFrameStroke,
								t = 0.3,
								s = "Quad",
								d = "Out",
								g = {
									Transparency = 0.4,
								},
							}):Play()
							task.spawn(function()
								task.wait(0.3)
								isAnimating = false
							end)
						end
						ClickDropdownTextButton.Name = "ClickDropdown"
						ClickDropdownTextButton.Parent = DropdownFrame
						ClickDropdownTextButton.BackgroundTransparency = 1
						ClickDropdownTextButton.Size = UDim2.new(1, 0, 1, 0)
						ClickDropdownTextButton.Position = UDim2.new(0, 0, 0, 0)
						ClickDropdownTextButton.BorderSizePixel = 0
						ClickDropdownTextButton.AutoButtonColor = false
						ClickDropdownTextButton.ZIndex = 10
						ClickDropdownTextButton.Text = ""
						ClickDropdownTextButton.MouseButton1Click:Connect(function()
							if isAnimating then
								return
							end

							if isOpen then
								closeDropdown()
							else
								openDropdown()
							end

							EffectClick2(ClickDropdownTextButton, DropdownFrame)
						end)
						connection = nil
						listenForOutsideClick = function()
							if connection then
								connection:Disconnect()
								connection = nil
							end

							connection = UserInputService.InputBegan:Connect(function(input)
								if not isOpen or isAnimating then
									return
								end

								if
									input.UserInputType == Enum.UserInputType.MouseButton1
									or input.UserInputType == Enum.UserInputType.Touch
								then
									local mouseLocation = UserInputService:GetMouseLocation()
									local AbsolutePosition = DropdownMenuFrame.AbsolutePosition
									local AbsoluteSize = DropdownMenuFrame.AbsoluteSize
									local absolutePosition = DropdownFrame.AbsolutePosition
									local absoluteSize = DropdownFrame.AbsoluteSize

									if
										not (
											mouseLocation.X >= AbsolutePosition.X
												and mouseLocation.X <= AbsolutePosition.X + AbsoluteSize.X
												and mouseLocation.Y >= AbsolutePosition.Y
												and mouseLocation.Y <= AbsolutePosition.Y + AbsoluteSize.Y
											or mouseLocation.X >= absolutePosition.X
												and mouseLocation.X <= absolutePosition.X + absoluteSize.X
												and mouseLocation.Y >= absolutePosition.Y
												and mouseLocation.Y <= absolutePosition.Y + absoluteSize.Y
										)
									then
										closeDropdown()
									end
								end
							end)
						end
						SearchBoxTextBox:GetPropertyChangedSignal("Text"):Connect(function()
							local lowered = string.lower(SearchBoxTextBox.Text)

							for _, child in pairs(MenuScrollScrollingFrame:GetChildren()) do
								if child:IsA("Frame") and child.Name == "Item" then
									local ItemTitle = child:FindFirstChild("ItemTitle")

									if ItemTitle then
										local loweredB = string.lower(ItemTitle.Text)

										child.Visible = lowered == "" or string.find(loweredB, lowered, 1, true) ~= nil
									end
								end
							end
						end)
						SearchBoxTextBox.Focused:Connect(function()
							tw({
								v = SearchBoxTextBoxStroke,
								t = 0.3,
								s = "Quad",
								d = "Out",
								g = {
									Transparency = 0.3,
								},
							}):Play()
						end)
						SearchBoxTextBox.FocusLost:Connect(function()
							tw({
								v = SearchBoxTextBoxStroke,
								t = 0.3,
								s = "Quad",
								d = "Out",
								g = {
									Transparency = 0.7,
								},
							}):Play()
						end)
						addItem = function(text)
							local ItemFrame = Instance.new("Frame")
							local ItemFrameCorner = Instance.new("UICorner")
							local ItemTitleTextLabel = Instance.new("TextLabel")
							local IndicatorFrame = Instance.new("Frame")
							local IndicatorFrameCorner = Instance.new("UICorner")
							local IndicatorFrameGradient = Instance.new("UIGradient")

							ItemFrame.Name = "Item"
							ItemFrame.Parent = MenuScrollScrollingFrame
							ItemFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
							ItemFrame.BackgroundTransparency = 0.4
							ItemFrame.Size = UDim2.new(1, 0, 0, 32)
							ItemFrame.ZIndex = 102
							ItemFrameCorner.Parent = ItemFrame
							ItemFrameCorner.CornerRadius = UDim.new(0, 8)
							ItemTitleTextLabel.Name = "ItemTitle"
							ItemTitleTextLabel.Parent = ItemFrame
							ItemTitleTextLabel.BackgroundTransparency = 1
							ItemTitleTextLabel.Position = UDim2.new(0, 12, 0, 0)
							ItemTitleTextLabel.Size = UDim2.new(1, -44, 1, 0)
							ItemTitleTextLabel.Font = Enum.Font.GothamBold
							ItemTitleTextLabel.Text = text
							ItemTitleTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
							ItemTitleTextLabel.TextSize = 13
							ItemTitleTextLabel.TextTransparency = selectedValues[text] and 0 or 0.5
							ItemTitleTextLabel.TextXAlignment = Enum.TextXAlignment.Left
							ItemTitleTextLabel.TextScaled = true
							ItemTitleTextLabel.TextWrapped = true
							ItemTitleTextLabel.ZIndex = 103

							local ItemTitleTextLabelTextConstraint = Instance.new("UITextSizeConstraint")

							ItemTitleTextLabelTextConstraint.Parent = ItemTitleTextLabel
							ItemTitleTextLabelTextConstraint.MaxTextSize = 13
							ItemTitleTextLabelTextConstraint.MinTextSize = 9
							IndicatorFrame.Name = "Indicator"
							IndicatorFrame.Parent = ItemFrame
							IndicatorFrame.AnchorPoint = Vector2.new(0, 0.5)
							IndicatorFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
							IndicatorFrame.Position = UDim2.new(0, 0, 0.5, 0)
							IndicatorFrame.Size = UDim2.new(0, selectedValues[text] and 4 or 0, 0, 32)
							IndicatorFrame.BackgroundTransparency = selectedValues[text] and 0 or 1
							IndicatorFrame.ZIndex = 102
							IndicatorFrameCorner.Parent = IndicatorFrame
							IndicatorFrameCorner.CornerRadius = UDim.new(1, 0)
							IndicatorFrameGradient.Parent = IndicatorFrame
							IndicatorFrameGradient.Color = ColorSequence.new({
								ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
								ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 170, 255)),
								ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)),
							})
							IndicatorFrameGradient.Rotation = 90

							local ClickTextButton = Instance.new("TextButton")

							ClickTextButton.Name = "Click"
							ClickTextButton.Parent = ItemFrame
							ClickTextButton.BackgroundTransparency = 1
							ClickTextButton.BorderSizePixel = 0
							ClickTextButton.Size = UDim2.new(1, 0, 1, 0)
							ClickTextButton.Position = UDim2.new(0, 0, 0, 0)
							ClickTextButton.ZIndex = 120
							ClickTextButton.AutoButtonColor = false
							ClickTextButton.Font = Enum.Font.SourceSans
							ClickTextButton.Text = ""
							ClickTextButton.MouseEnter:Connect(function()
								tw({
									v = ItemFrame,
									t = 0.2,
									s = "Quad",
									d = "Out",
									g = {
										BackgroundTransparency = 0.2,
									},
								}):Play()
							end)
							ClickTextButton.MouseLeave:Connect(function()
								tw({
									v = ItemFrame,
									t = 0.2,
									s = "Quad",
									d = "Out",
									g = {
										BackgroundTransparency = 0.4,
									},
								}):Play()
							end)
							ClickTextButton.MouseButton1Click:Connect(function()
								EffectClick2(ClickTextButton, ItemFrame)

								if Multi then
									selectedValues[text] = not selectedValues[text]

									local items, task_

									if selectedValues[text] then
										tw({
											v = ItemTitleTextLabel,
											t = 0.2,
											s = "Quad",
											d = "Out",
											g = {
												TextTransparency = 0,
											},
										}):Play()
										tw({
											v = IndicatorFrame,
											t = 0.2,
											s = "Back",
											d = "Out",
											g = {
												Size = UDim2.new(0, 4, 0, 32),
												BackgroundTransparency = 0,
											},
										}):Play()
										items = {}

										for k, v in pairs(selectedValues) do
											if v then
												table.insert(items, k)
											end
										end

										updateDisplayText()
										task_ = task
									else
										tw({
											v = ItemTitleTextLabel,
											t = 0.2,
											s = "Quad",
											d = "Out",
											g = {
												TextTransparency = 0.5,
											},
										}):Play()
										tw({
											v = IndicatorFrame,
											t = 0.2,
											s = "Back",
											d = "Out",
											g = {
												Size = UDim2.new(0, 0, 0, 32),
												BackgroundTransparency = 1,
											},
										}):Play()
										items = {}

										for k, v in pairs(selectedValues) do
											if v then
												table.insert(items, k)
											end
										end

										updateDisplayText()
										task_ = task
									end

									task_.spawn(function()
										pcall(Callback, items)
									end)
								else
									for k in pairs(selectedValues) do
										selectedValues[k] = false
									end

									selectedValues[text] = true

									for _, child in pairs(MenuScrollScrollingFrame:GetChildren()) do
										if child:IsA("Frame") and child.Name == "Item" then
											local ItemTitle = child:FindFirstChild("ItemTitle")
											local Indicator = child:FindFirstChild("Indicator")

											if ItemTitle and Indicator then
												tw({
													v = ItemTitle,
													t = 0.2,
													s = "Quad",
													d = "Out",
													g = {
														TextTransparency = 0.5,
													},
												}):Play()
												tw({
													v = Indicator,
													t = 0.2,
													s = "Back",
													d = "Out",
													g = {
														Size = UDim2.new(0, 0, 0, 32),
														BackgroundTransparency = 1,
													},
												}):Play()
											end
										end
									end

									tw({
										v = ItemTitleTextLabel,
										t = 0.2,
										s = "Quad",
										d = "Out",
										g = {
											TextTransparency = 0,
										},
									}):Play()
									tw({
										v = IndicatorFrame,
										t = 0.2,
										s = "Back",
										d = "Out",
										g = {
											Size = UDim2.new(0, 4, 0, 32),
											BackgroundTransparency = 0,
										},
									}):Play()
									updateDisplayText()
									task.spawn(function()
										pcall(Callback, text)
									end)
									task.wait(0.15)
									closeDropdown()
								end
							end)
						end

						for _, v in pairs(List) do
							addItem(v)
						end

						updateDisplayText()
						listenForOutsideClick()
						table.insert(SearchItems, {
							Frame = DropdownFrame,
							SearchName = TitleB,
							HighlightFrame = HighlightFrameB,
						})
						DropdownFrame.Destroying:Connect(function()
							if connection then
								connection:Disconnect()
								connection = nil
							end

							if DropdownMenuFrame then
								DropdownMenuFrame:Destroy()
							end
						end)
						dropdownApi = {
							Add = function(self, item)
								if not table.find(List, item) then
									table.insert(List, item)
									addItem(item)
								end
							end,
							Remove = function(self, item)
								for k, v in pairs(List) do
									if v == item then
										table.remove(List, k)

										break
									end
								end

								for _, child in pairs(MenuScrollScrollingFrame:GetChildren()) do
									if child:IsA("Frame") and child.Name == "Item" then
										local ItemTitle = child:FindFirstChild("ItemTitle")

										if ItemTitle and ItemTitle.Text == item then
											child:Destroy()

											break
										end
									end
								end

								selectedValues[item] = nil
								updateDisplayText()
							end,
							Clear = function()
								for _, child in pairs(MenuScrollScrollingFrame:GetChildren()) do
									if child:IsA("Frame") and child.Name == "Item" then
										child:Destroy()
									end
								end

								List = {}
								selectedValues = {}
								updateDisplayText()
							end,
							SetValue = function(self, value)
								selectedValues = {}

								local valueB, valueC, valueD, ItemTitle, Indicator, tween, tweenB, tweenC, tweenD

								if type(value) == "table" then
									local iterator, iterTable, iterKey = pairs(value)
									local iteratorB = geniter(iterator, iterTable, iterKey)

									for _, v in iterator, iterTable, iterKey do
										while true do
											selectedValues[v] = true

											local packed = table.pack(iteratorB())

											if not packed[1] then
												break
											end

											v = packed[3]
										end

										local iterator, iterTable, iterKey = pairs(MenuScrollScrollingFrame:GetChildren())

										for _, entry in iterator, iterTable, iterKey do
											if entry:IsA("Frame") and entry.Name == "Item" then
												local child = entry:FindFirstChild("ItemTitle")
												local childB = entry:FindFirstChild("Indicator")

												if child and childB then
													if selectedValues[child.Text] then
														tw({
															v = child,
															t = 0.2,
															s = "Quad",
															d = "Out",
															g = {
																TextTransparency = 0,
															},
														}):Play()
														tw({
															v = childB,
															t = 0.2,
															s = "Back",
															d = "Out",
															g = {
																Size = UDim2.new(0, 4, 0, 32),
																BackgroundTransparency = 0,
															},
														}):Play()
													else
														tw({
															v = child,
															t = 0.2,
															s = "Quad",
															d = "Out",
															g = {
																TextTransparency = 0.5,
															},
														}):Play()
														tw({
															v = childB,
															t = 0.2,
															s = "Back",
															d = "Out",
															g = {
																Size = UDim2.new(0, 0, 0, 32),
																BackgroundTransparency = 1,
															},
														}):Play()
													end
												end
											end
										end

										updateDisplayText()

										return
									end

									valueB, valueC, valueD = pairs(MenuScrollScrollingFrame:GetChildren())

									for _, v in valueB, valueC, valueD do
										if v:IsA("Frame") and v.Name == "Item" then
											ItemTitle = v:FindFirstChild("ItemTitle")
											Indicator = v:FindFirstChild("Indicator")

											if ItemTitle and Indicator then
												if selectedValues[ItemTitle.Text] then
													tween = tw({
														v = ItemTitle,
														t = 0.2,
														s = "Quad",
														d = "Out",
														g = {
															TextTransparency = 0,
														},
													})
													tween:Play()
													tweenB = tw({
														v = Indicator,
														t = 0.2,
														s = "Back",
														d = "Out",
														g = {
															Size = UDim2.new(0, 4, 0, 32),
															BackgroundTransparency = 0,
														},
													})
													tweenB:Play()
												else
													tweenC = tw({
														v = ItemTitle,
														t = 0.2,
														s = "Quad",
														d = "Out",
														g = {
															TextTransparency = 0.5,
														},
													})
													tweenC:Play()
													tweenD = tw({
														v = Indicator,
														t = 0.2,
														s = "Back",
														d = "Out",
														g = {
															Size = UDim2.new(0, 0, 0, 32),
															BackgroundTransparency = 1,
														},
													})
													tweenD:Play()
												end
											end
										end
									end
								elseif type(value) == "string" and value ~= "" then
									selectedValues[value] = true
									valueB, valueC, valueD = pairs(MenuScrollScrollingFrame:GetChildren())

									for _, v in valueB, valueC, valueD do
										if v:IsA("Frame") and v.Name == "Item" then
											ItemTitle = v:FindFirstChild("ItemTitle")
											Indicator = v:FindFirstChild("Indicator")

											if ItemTitle and Indicator then
												if selectedValues[ItemTitle.Text] then
													tween = tw({
														v = ItemTitle,
														t = 0.2,
														s = "Quad",
														d = "Out",
														g = {
															TextTransparency = 0,
														},
													})
													tween:Play()
													tweenB = tw({
														v = Indicator,
														t = 0.2,
														s = "Back",
														d = "Out",
														g = {
															Size = UDim2.new(0, 4, 0, 32),
															BackgroundTransparency = 0,
														},
													})
													tweenB:Play()
												else
													tweenC = tw({
														v = ItemTitle,
														t = 0.2,
														s = "Quad",
														d = "Out",
														g = {
															TextTransparency = 0.5,
														},
													})
													tweenC:Play()
													tweenD = tw({
														v = Indicator,
														t = 0.2,
														s = "Back",
														d = "Out",
														g = {
															Size = UDim2.new(0, 0, 0, 32),
															BackgroundTransparency = 1,
														},
													})
													tweenD:Play()
												end
											end
										end
									end
								else
									valueB, valueC, valueD = pairs(MenuScrollScrollingFrame:GetChildren())

									for _, v in valueB, valueC, valueD do
										if v:IsA("Frame") and v.Name == "Item" then
											ItemTitle = v:FindFirstChild("ItemTitle")
											Indicator = v:FindFirstChild("Indicator")

											if ItemTitle and Indicator then
												if selectedValues[ItemTitle.Text] then
													tw({
														v = ItemTitle,
														t = 0.2,
														s = "Quad",
														d = "Out",
														g = {
															TextTransparency = 0,
														},
													}):Play()
													tw({
														v = Indicator,
														t = 0.2,
														s = "Back",
														d = "Out",
														g = {
															Size = UDim2.new(0, 4, 0, 32),
															BackgroundTransparency = 0,
														},
													}):Play()
												else
													tw({
														v = ItemTitle,
														t = 0.2,
														s = "Quad",
														d = "Out",
														g = {
															TextTransparency = 0.5,
														},
													}):Play()
													tw({
														v = Indicator,
														t = 0.2,
														s = "Back",
														d = "Out",
														g = {
															Size = UDim2.new(0, 0, 0, 32),
															BackgroundTransparency = 1,
														},
													}):Play()
												end
											end
										end
									end
								end

								updateDisplayText()
							end,
							GetValue = function()
								if not Multi then
									for k, v in pairs(selectedValues) do
										if v then
											return k
										end
									end

									return nil
								end

								local items = {}

								for k, v in pairs(selectedValues) do
									if v then
										table.insert(items, k)
									end
								end

								return items
							end,
							SetTitle = function(self, text)
								TitleTextLabel.Text = text
								TitleTextLabelB.Text = text

								for _, v in pairs(SearchItems) do
									if v.Frame == DropdownFrame then
										v.SearchName = text

										break
									end
								end
							end,
							SetDesc = function(self, text)
								if DescTextLabel then
									DescTextLabel.Text = text
								end
							end,
							Visible = function(self, visible)
								DropdownFrame.Visible = visible

								if not visible and isOpen then
									closeDropdown()
								end
							end,
						}
					else
						selectedValues[Value] = true
						updateDisplayText = function()
							if Multi then
								local items = {}

								for k, v in pairs(selectedValues) do
									if v then
										table.insert(items, k)
									end
								end

								if #items > 0 then
									ValueDisplayTextLabel.Text = #items .. " Selected"
								else
									ValueDisplayTextLabel.Text = "Select..."
								end
							else
								local flag = false

								for k, v in pairs(selectedValues) do
									if v then
										ValueDisplayTextLabel.Text = k
										flag = true

										break
									end
								end

								if not flag then
									ValueDisplayTextLabel.Text = "Select..."
								end
							end
						end
						closeDropdown = function()
							if isAnimating or not isOpen then
								return
							end

							isAnimating = true
							isOpen = false
							tw({
								v = DropdownMenuFrame,
								t = 0.25,
								s = "Quad",
								d = "Out",
								g = {
									Size = UDim2.new(0, 0, 1, 0),
								},
							}):Play()
							tw({
								v = SearchBoxTextBox,
								t = 0.2,
								s = "Quad",
								d = "Out",
								g = {
									Size = UDim2.new(0, 0, 0, 28),
								},
							}):Play()
							tw({
								v = ArrowIconImageLabel,
								t = 0.25,
								s = "Quad",
								d = "Out",
								g = {
									Rotation = 0,
								},
							}):Play()
							tw({
								v = DropdownFrameStroke,
								t = 0.25,
								s = "Quad",
								d = "Out",
								g = {
									Transparency = 0.75,
								},
							}):Play()
							task.spawn(function()
								task.wait(0.25)

								if not isOpen then
									DropdownMenuFrame.Visible = false
								end

								isAnimating = false
							end)
						end
						openDropdown = function()
							if isAnimating or isOpen then
								return
							end

							isAnimating = true
							isOpen = true
							DropdownMenuFrame.Visible = true
							SearchBoxTextBox.Text = ""
							tw({
								v = DropdownMenuFrame,
								t = 0.3,
								s = "Back",
								d = "Out",
								g = {
									Size = UDim2.new(0, 240, 1, 0),
								},
							}):Play()
							tw({
								v = SearchBoxTextBox,
								t = 0.25,
								s = "Back",
								d = "Out",
								g = {
									Size = UDim2.new(0.9, 0, 0, 28),
								},
							}):Play()
							tw({
								v = ArrowIconImageLabel,
								t = 0.3,
								s = "Back",
								d = "Out",
								g = {
									Rotation = 180,
								},
							}):Play()
							tw({
								v = DropdownFrameStroke,
								t = 0.3,
								s = "Quad",
								d = "Out",
								g = {
									Transparency = 0.4,
								},
							}):Play()
							task.spawn(function()
								task.wait(0.3)
								isAnimating = false
							end)
						end
						ClickDropdownTextButton.Name = "ClickDropdown"
						ClickDropdownTextButton.Parent = DropdownFrame
						ClickDropdownTextButton.BackgroundTransparency = 1
						ClickDropdownTextButton.Size = UDim2.new(1, 0, 1, 0)
						ClickDropdownTextButton.Position = UDim2.new(0, 0, 0, 0)
						ClickDropdownTextButton.BorderSizePixel = 0
						ClickDropdownTextButton.AutoButtonColor = false
						ClickDropdownTextButton.ZIndex = 10
						ClickDropdownTextButton.Text = ""
						ClickDropdownTextButton.MouseButton1Click:Connect(function()
							if isAnimating then
								return
							end

							if isOpen then
								closeDropdown()
							else
								openDropdown()
							end

							EffectClick2(ClickDropdownTextButton, DropdownFrame)
						end)
						connection = nil
						listenForOutsideClick = function()
							if connection then
								connection:Disconnect()
								connection = nil
							end

							connection = UserInputService.InputBegan:Connect(function(input)
								if not isOpen or isAnimating then
									return
								end

								if
									input.UserInputType == Enum.UserInputType.MouseButton1
									or input.UserInputType == Enum.UserInputType.Touch
								then
									local mouseLocation = UserInputService:GetMouseLocation()
									local AbsolutePosition = DropdownMenuFrame.AbsolutePosition
									local AbsoluteSize = DropdownMenuFrame.AbsoluteSize
									local absolutePosition = DropdownFrame.AbsolutePosition
									local absoluteSize = DropdownFrame.AbsoluteSize

									if
										not (
											mouseLocation.X >= AbsolutePosition.X
												and mouseLocation.X <= AbsolutePosition.X + AbsoluteSize.X
												and mouseLocation.Y >= AbsolutePosition.Y
												and mouseLocation.Y <= AbsolutePosition.Y + AbsoluteSize.Y
											or mouseLocation.X >= absolutePosition.X
												and mouseLocation.X <= absolutePosition.X + absoluteSize.X
												and mouseLocation.Y >= absolutePosition.Y
												and mouseLocation.Y <= absolutePosition.Y + absoluteSize.Y
										)
									then
										closeDropdown()
									end
								end
							end)
						end
						SearchBoxTextBox:GetPropertyChangedSignal("Text"):Connect(function()
							local lowered = string.lower(SearchBoxTextBox.Text)

							for _, child in pairs(MenuScrollScrollingFrame:GetChildren()) do
								if child:IsA("Frame") and child.Name == "Item" then
									local ItemTitle = child:FindFirstChild("ItemTitle")

									if ItemTitle then
										local loweredB = string.lower(ItemTitle.Text)

										child.Visible = lowered == "" or string.find(loweredB, lowered, 1, true) ~= nil
									end
								end
							end
						end)
						SearchBoxTextBox.Focused:Connect(function()
							tw({
								v = SearchBoxTextBoxStroke,
								t = 0.3,
								s = "Quad",
								d = "Out",
								g = {
									Transparency = 0.3,
								},
							}):Play()
						end)
						SearchBoxTextBox.FocusLost:Connect(function()
							tw({
								v = SearchBoxTextBoxStroke,
								t = 0.3,
								s = "Quad",
								d = "Out",
								g = {
									Transparency = 0.7,
								},
							}):Play()
						end)
						addItem = function(text)
							local ItemFrame = Instance.new("Frame")
							local ItemFrameCorner = Instance.new("UICorner")
							local ItemTitleTextLabel = Instance.new("TextLabel")
							local IndicatorFrame = Instance.new("Frame")
							local IndicatorFrameCorner = Instance.new("UICorner")
							local IndicatorFrameGradient = Instance.new("UIGradient")

							ItemFrame.Name = "Item"
							ItemFrame.Parent = MenuScrollScrollingFrame
							ItemFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
							ItemFrame.BackgroundTransparency = 0.4
							ItemFrame.Size = UDim2.new(1, 0, 0, 32)
							ItemFrame.ZIndex = 102
							ItemFrameCorner.Parent = ItemFrame
							ItemFrameCorner.CornerRadius = UDim.new(0, 8)
							ItemTitleTextLabel.Name = "ItemTitle"
							ItemTitleTextLabel.Parent = ItemFrame
							ItemTitleTextLabel.BackgroundTransparency = 1
							ItemTitleTextLabel.Position = UDim2.new(0, 12, 0, 0)
							ItemTitleTextLabel.Size = UDim2.new(1, -44, 1, 0)
							ItemTitleTextLabel.Font = Enum.Font.GothamBold
							ItemTitleTextLabel.Text = text
							ItemTitleTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
							ItemTitleTextLabel.TextSize = 13
							ItemTitleTextLabel.TextTransparency = selectedValues[text] and 0 or 0.5
							ItemTitleTextLabel.TextXAlignment = Enum.TextXAlignment.Left
							ItemTitleTextLabel.TextScaled = true
							ItemTitleTextLabel.TextWrapped = true
							ItemTitleTextLabel.ZIndex = 103

							local ItemTitleTextLabelTextConstraint = Instance.new("UITextSizeConstraint")

							ItemTitleTextLabelTextConstraint.Parent = ItemTitleTextLabel
							ItemTitleTextLabelTextConstraint.MaxTextSize = 13
							ItemTitleTextLabelTextConstraint.MinTextSize = 9
							IndicatorFrame.Name = "Indicator"
							IndicatorFrame.Parent = ItemFrame
							IndicatorFrame.AnchorPoint = Vector2.new(0, 0.5)
							IndicatorFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
							IndicatorFrame.Position = UDim2.new(0, 0, 0.5, 0)
							IndicatorFrame.Size = UDim2.new(0, selectedValues[text] and 4 or 0, 0, 32)
							IndicatorFrame.BackgroundTransparency = selectedValues[text] and 0 or 1
							IndicatorFrame.ZIndex = 102
							IndicatorFrameCorner.Parent = IndicatorFrame
							IndicatorFrameCorner.CornerRadius = UDim.new(1, 0)
							IndicatorFrameGradient.Parent = IndicatorFrame
							IndicatorFrameGradient.Color = ColorSequence.new({
								ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
								ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 170, 255)),
								ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)),
							})
							IndicatorFrameGradient.Rotation = 90

							local ClickTextButton = Instance.new("TextButton")

							ClickTextButton.Name = "Click"
							ClickTextButton.Parent = ItemFrame
							ClickTextButton.BackgroundTransparency = 1
							ClickTextButton.BorderSizePixel = 0
							ClickTextButton.Size = UDim2.new(1, 0, 1, 0)
							ClickTextButton.Position = UDim2.new(0, 0, 0, 0)
							ClickTextButton.ZIndex = 120
							ClickTextButton.AutoButtonColor = false
							ClickTextButton.Font = Enum.Font.SourceSans
							ClickTextButton.Text = ""
							ClickTextButton.MouseEnter:Connect(function()
								tw({
									v = ItemFrame,
									t = 0.2,
									s = "Quad",
									d = "Out",
									g = {
										BackgroundTransparency = 0.2,
									},
								}):Play()
							end)
							ClickTextButton.MouseLeave:Connect(function()
								tw({
									v = ItemFrame,
									t = 0.2,
									s = "Quad",
									d = "Out",
									g = {
										BackgroundTransparency = 0.4,
									},
								}):Play()
							end)
							ClickTextButton.MouseButton1Click:Connect(function()
								EffectClick2(ClickTextButton, ItemFrame)

								if Multi then
									selectedValues[text] = not selectedValues[text]

									local items, task_

									if selectedValues[text] then
										tw({
											v = ItemTitleTextLabel,
											t = 0.2,
											s = "Quad",
											d = "Out",
											g = {
												TextTransparency = 0,
											},
										}):Play()
										tw({
											v = IndicatorFrame,
											t = 0.2,
											s = "Back",
											d = "Out",
											g = {
												Size = UDim2.new(0, 4, 0, 32),
												BackgroundTransparency = 0,
											},
										}):Play()
										items = {}

										for k, v in pairs(selectedValues) do
											if v then
												table.insert(items, k)
											end
										end

										updateDisplayText()
										task_ = task
									else
										tw({
											v = ItemTitleTextLabel,
											t = 0.2,
											s = "Quad",
											d = "Out",
											g = {
												TextTransparency = 0.5,
											},
										}):Play()
										tw({
											v = IndicatorFrame,
											t = 0.2,
											s = "Back",
											d = "Out",
											g = {
												Size = UDim2.new(0, 0, 0, 32),
												BackgroundTransparency = 1,
											},
										}):Play()
										items = {}

										for k, v in pairs(selectedValues) do
											if v then
												table.insert(items, k)
											end
										end

										updateDisplayText()
										task_ = task
									end

									task_.spawn(function()
										pcall(Callback, items)
									end)
								else
									for k in pairs(selectedValues) do
										selectedValues[k] = false
									end

									selectedValues[text] = true

									for _, child in pairs(MenuScrollScrollingFrame:GetChildren()) do
										if child:IsA("Frame") and child.Name == "Item" then
											local ItemTitle = child:FindFirstChild("ItemTitle")
											local Indicator = child:FindFirstChild("Indicator")

											if ItemTitle and Indicator then
												tw({
													v = ItemTitle,
													t = 0.2,
													s = "Quad",
													d = "Out",
													g = {
														TextTransparency = 0.5,
													},
												}):Play()
												tw({
													v = Indicator,
													t = 0.2,
													s = "Back",
													d = "Out",
													g = {
														Size = UDim2.new(0, 0, 0, 32),
														BackgroundTransparency = 1,
													},
												}):Play()
											end
										end
									end

									tw({
										v = ItemTitleTextLabel,
										t = 0.2,
										s = "Quad",
										d = "Out",
										g = {
											TextTransparency = 0,
										},
									}):Play()
									tw({
										v = IndicatorFrame,
										t = 0.2,
										s = "Back",
										d = "Out",
										g = {
											Size = UDim2.new(0, 4, 0, 32),
											BackgroundTransparency = 0,
										},
									}):Play()
									updateDisplayText()
									task.spawn(function()
										pcall(Callback, text)
									end)
									task.wait(0.15)
									closeDropdown()
								end
							end)
						end

						for _, v in pairs(List) do
							addItem(v)
						end

						updateDisplayText()
						listenForOutsideClick()
						table.insert(SearchItems, {
							Frame = DropdownFrame,
							SearchName = TitleB,
							HighlightFrame = HighlightFrameB,
						})
						DropdownFrame.Destroying:Connect(function()
							if connection then
								connection:Disconnect()
								connection = nil
							end

							if DropdownMenuFrame then
								DropdownMenuFrame:Destroy()
							end
						end)
						dropdownApi = {
							Add = function(self, item)
								if not table.find(List, item) then
									table.insert(List, item)
									addItem(item)
								end
							end,
							Remove = function(self, item)
								for k, v in pairs(List) do
									if v == item then
										table.remove(List, k)

										break
									end
								end

								for _, child in pairs(MenuScrollScrollingFrame:GetChildren()) do
									if child:IsA("Frame") and child.Name == "Item" then
										local ItemTitle = child:FindFirstChild("ItemTitle")

										if ItemTitle and ItemTitle.Text == item then
											child:Destroy()

											break
										end
									end
								end

								selectedValues[item] = nil
								updateDisplayText()
							end,
							Clear = function()
								for _, child in pairs(MenuScrollScrollingFrame:GetChildren()) do
									if child:IsA("Frame") and child.Name == "Item" then
										child:Destroy()
									end
								end

								List = {}
								selectedValues = {}
								updateDisplayText()
							end,
							SetValue = function(self, value)
								selectedValues = {}

								local valueB, valueC, valueD, ItemTitle, Indicator, tween, tweenB, tweenC, tweenD

								if type(value) == "table" then
									local iterator, iterTable, iterKey = pairs(value)
									local iteratorB = geniter(iterator, iterTable, iterKey)

									for _, v in iterator, iterTable, iterKey do
										while true do
											selectedValues[v] = true

											local packed = table.pack(iteratorB())

											if not packed[1] then
												break
											end

											v = packed[3]
										end

										local iterator, iterTable, iterKey = pairs(MenuScrollScrollingFrame:GetChildren())

										for _, entry in iterator, iterTable, iterKey do
											if entry:IsA("Frame") and entry.Name == "Item" then
												local child = entry:FindFirstChild("ItemTitle")
												local childB = entry:FindFirstChild("Indicator")

												if child and childB then
													if selectedValues[child.Text] then
														tw({
															v = child,
															t = 0.2,
															s = "Quad",
															d = "Out",
															g = {
																TextTransparency = 0,
															},
														}):Play()
														tw({
															v = childB,
															t = 0.2,
															s = "Back",
															d = "Out",
															g = {
																Size = UDim2.new(0, 4, 0, 32),
																BackgroundTransparency = 0,
															},
														}):Play()
													else
														tw({
															v = child,
															t = 0.2,
															s = "Quad",
															d = "Out",
															g = {
																TextTransparency = 0.5,
															},
														}):Play()
														tw({
															v = childB,
															t = 0.2,
															s = "Back",
															d = "Out",
															g = {
																Size = UDim2.new(0, 0, 0, 32),
																BackgroundTransparency = 1,
															},
														}):Play()
													end
												end
											end
										end

										updateDisplayText()

										return
									end

									valueB, valueC, valueD = pairs(MenuScrollScrollingFrame:GetChildren())

									for _, v in valueB, valueC, valueD do
										if v:IsA("Frame") and v.Name == "Item" then
											ItemTitle = v:FindFirstChild("ItemTitle")
											Indicator = v:FindFirstChild("Indicator")

											if ItemTitle and Indicator then
												if selectedValues[ItemTitle.Text] then
													tween = tw({
														v = ItemTitle,
														t = 0.2,
														s = "Quad",
														d = "Out",
														g = {
															TextTransparency = 0,
														},
													})
													tween:Play()
													tweenB = tw({
														v = Indicator,
														t = 0.2,
														s = "Back",
														d = "Out",
														g = {
															Size = UDim2.new(0, 4, 0, 32),
															BackgroundTransparency = 0,
														},
													})
													tweenB:Play()
												else
													tweenC = tw({
														v = ItemTitle,
														t = 0.2,
														s = "Quad",
														d = "Out",
														g = {
															TextTransparency = 0.5,
														},
													})
													tweenC:Play()
													tweenD = tw({
														v = Indicator,
														t = 0.2,
														s = "Back",
														d = "Out",
														g = {
															Size = UDim2.new(0, 0, 0, 32),
															BackgroundTransparency = 1,
														},
													})
													tweenD:Play()
												end
											end
										end
									end
								elseif type(value) == "string" and value ~= "" then
									selectedValues[value] = true
									valueB, valueC, valueD = pairs(MenuScrollScrollingFrame:GetChildren())

									for _, v in valueB, valueC, valueD do
										if v:IsA("Frame") and v.Name == "Item" then
											ItemTitle = v:FindFirstChild("ItemTitle")
											Indicator = v:FindFirstChild("Indicator")

											if ItemTitle and Indicator then
												if selectedValues[ItemTitle.Text] then
													tween = tw({
														v = ItemTitle,
														t = 0.2,
														s = "Quad",
														d = "Out",
														g = {
															TextTransparency = 0,
														},
													})
													tween:Play()
													tweenB = tw({
														v = Indicator,
														t = 0.2,
														s = "Back",
														d = "Out",
														g = {
															Size = UDim2.new(0, 4, 0, 32),
															BackgroundTransparency = 0,
														},
													})
													tweenB:Play()
												else
													tweenC = tw({
														v = ItemTitle,
														t = 0.2,
														s = "Quad",
														d = "Out",
														g = {
															TextTransparency = 0.5,
														},
													})
													tweenC:Play()
													tweenD = tw({
														v = Indicator,
														t = 0.2,
														s = "Back",
														d = "Out",
														g = {
															Size = UDim2.new(0, 0, 0, 32),
															BackgroundTransparency = 1,
														},
													})
													tweenD:Play()
												end
											end
										end
									end
								else
									valueB, valueC, valueD = pairs(MenuScrollScrollingFrame:GetChildren())

									for _, v in valueB, valueC, valueD do
										if v:IsA("Frame") and v.Name == "Item" then
											ItemTitle = v:FindFirstChild("ItemTitle")
											Indicator = v:FindFirstChild("Indicator")

											if ItemTitle and Indicator then
												if selectedValues[ItemTitle.Text] then
													tw({
														v = ItemTitle,
														t = 0.2,
														s = "Quad",
														d = "Out",
														g = {
															TextTransparency = 0,
														},
													}):Play()
													tw({
														v = Indicator,
														t = 0.2,
														s = "Back",
														d = "Out",
														g = {
															Size = UDim2.new(0, 4, 0, 32),
															BackgroundTransparency = 0,
														},
													}):Play()
												else
													tw({
														v = ItemTitle,
														t = 0.2,
														s = "Quad",
														d = "Out",
														g = {
															TextTransparency = 0.5,
														},
													}):Play()
													tw({
														v = Indicator,
														t = 0.2,
														s = "Back",
														d = "Out",
														g = {
															Size = UDim2.new(0, 0, 0, 32),
															BackgroundTransparency = 1,
														},
													}):Play()
												end
											end
										end
									end
								end

								updateDisplayText()
							end,
							GetValue = function()
								if not Multi then
									for k, v in pairs(selectedValues) do
										if v then
											return k
										end
									end

									return nil
								end

								local items = {}

								for k, v in pairs(selectedValues) do
									if v then
										table.insert(items, k)
									end
								end

								return items
							end,
							SetTitle = function(self, text)
								TitleTextLabel.Text = text
								TitleTextLabelB.Text = text

								for _, v in pairs(SearchItems) do
									if v.Frame == DropdownFrame then
										v.SearchName = text

										break
									end
								end
							end,
							SetDesc = function(self, text)
								if DescTextLabel then
									DescTextLabel.Text = text
								end
							end,
							Visible = function(self, visible)
								DropdownFrame.Visible = visible

								if not visible and isOpen then
									closeDropdown()
								end
							end,
						}
					end
				else
					DescTextLabel.Name = "Desc"
					DescTextLabel.Parent = DropdownFrame
					DescTextLabel.BackgroundTransparency = 1
					DescTextLabel.Position = UDim2.new(0.04, 0, 0, 22)
					DescTextLabel.Size = UDim2.new(0.75, 0, 0, 12)
					DescTextLabel.Font = Enum.Font.Gotham
					DescTextLabel.Text = DescB
					DescTextLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
					DescTextLabel.TextSize = 10
					DescTextLabel.TextTransparency = 0.4
					DescTextLabel.TextXAlignment = Enum.TextXAlignment.Left
					DescTextLabel.TextScaled = true
					DescTextLabel.TextWrapped = true

					local DescTextLabelTextConstraint = Instance.new("UITextSizeConstraint")

					DescTextLabelTextConstraint.Parent = DescTextLabel
					DescTextLabelTextConstraint.MaxTextSize = 10
					DescTextLabelTextConstraint.MinTextSize = 7
					ArrowIconImageLabel.Name = "ArrowIcon"
					ArrowIconImageLabel.Parent = DropdownFrame
					ArrowIconImageLabel.AnchorPoint = Vector2.new(1, 0.5)
					ArrowIconImageLabel.BackgroundTransparency = 1
					ArrowIconImageLabel.Position = UDim2.new(0.96, 0, 0.5, 0)
					ArrowIconImageLabel.Size = UDim2.new(0, 24, 0, 24)
					ArrowIconImageLabel.Image = "rbxassetid://129573215183311"
					ArrowIconImageLabel.ScaleType = Enum.ScaleType.Fit
					ArrowIconImageLabelGradient.Parent = ArrowIconImageLabel
					ArrowIconImageLabelGradient.Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
						ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 170, 255)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)),
					})
					DropdownMenuFrame = Instance.new("Frame")
					DropdownMenuFrameCorner = Instance.new("UICorner")
					DropdownMenuFrameStroke = Instance.new("UIStroke")
					EffectImageLabel = Instance.new("ImageLabel")
					HeaderFrameB = Instance.new("Frame")
					TitleTextLabelB = Instance.new("TextLabel")
					LineFrameB = Instance.new("Frame")
					LineFrameBGradient = Instance.new("UIGradient")
					SearchBoxTextBox = Instance.new("TextBox")
					SearchBoxTextBoxCorner = Instance.new("UICorner")
					SearchBoxTextBoxStroke = Instance.new("UIStroke")
					SearchBoxTextBoxStrokeGradient = Instance.new("UIGradient")
					MenuScrollScrollingFrame = Instance.new("ScrollingFrame")
					MenuScrollScrollingFrameListLayout = Instance.new("UIListLayout")
					DropdownMenuFrame.Name = "DropdownMenu"
					DropdownMenuFrame.Parent = BackgroundFrame
					DropdownMenuFrame.AnchorPoint = Vector2.new(1, 0.5)
					DropdownMenuFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
					DropdownMenuFrame.BackgroundTransparency = 0.05
					DropdownMenuFrame.Position = UDim2.new(1, 0, 0.5, 0)
					DropdownMenuFrame.Size = UDim2.new(0, 0, 1, 0)
					DropdownMenuFrame.ClipsDescendants = true
					DropdownMenuFrame.Visible = false
					DropdownMenuFrame.ZIndex = 100
					DropdownMenuFrameCorner.Parent = DropdownMenuFrame
					DropdownMenuFrameCorner.CornerRadius = UDim.new(0, 16)
					DropdownMenuFrameStroke.Parent = DropdownMenuFrame
					DropdownMenuFrameStroke.Color = Color3.fromRGB(110, 110, 140)
					DropdownMenuFrameStroke.Thickness = 2
					DropdownMenuFrameStroke.Transparency = 0.6
					EffectImageLabel.Name = "Effect"
					EffectImageLabel.Parent = DropdownMenuFrame
					EffectImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
					EffectImageLabel.BackgroundTransparency = 1
					EffectImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
					EffectImageLabel.Size = UDim2.new(1, 0, 1, 0)
					EffectImageLabel.Image = "rbxassetid://132687652275989"
					EffectImageLabel.ImageColor3 = Color3.fromRGB(0, 255, 127)
					EffectImageLabel.ImageTransparency = 0.5
					EffectImageLabel.ScaleType = Enum.ScaleType.Crop
					EffectImageLabel.ZIndex = 100
					HeaderFrameB.Name = "Header"
					HeaderFrameB.Parent = DropdownMenuFrame
					HeaderFrameB.BackgroundTransparency = 1
					HeaderFrameB.Size = UDim2.new(1, 0, 0, 70)
					HeaderFrameB.ZIndex = 101
					TitleTextLabelB.Name = "Title"
					TitleTextLabelB.Parent = HeaderFrameB
					TitleTextLabelB.BackgroundTransparency = 1
					TitleTextLabelB.Position = UDim2.new(0, 16, 0, 12)
					TitleTextLabelB.Size = UDim2.new(1, -32, 0, 24)
					TitleTextLabelB.Font = Enum.Font.GothamBold
					TitleTextLabelB.Text = TitleB
					TitleTextLabelB.TextColor3 = Color3.fromRGB(255, 255, 255)
					TitleTextLabelB.TextSize = 18
					TitleTextLabelB.TextXAlignment = Enum.TextXAlignment.Left
					TitleTextLabelB.ZIndex = 101
					LineFrameB.Name = "Line"
					LineFrameB.Parent = HeaderFrameB
					LineFrameB.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					LineFrameB.BorderSizePixel = 0
					LineFrameB.Position = UDim2.new(0, 16, 0, 42)
					LineFrameB.Size = UDim2.new(0, 60, 0, 2)
					LineFrameB.ZIndex = 101
					LineFrameBGradient.Parent = LineFrameB
					LineFrameBGradient.Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
						ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 170, 255)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)),
					})
					SearchBoxTextBox.Name = "SearchBox"
					SearchBoxTextBox.Parent = HeaderFrameB
					SearchBoxTextBox.AnchorPoint = Vector2.new(0.5, 1)
					SearchBoxTextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					SearchBoxTextBox.BackgroundTransparency = 0.92
					SearchBoxTextBox.Position = UDim2.new(0.5, 0, 1, -4)
					SearchBoxTextBox.Size = UDim2.new(0, 0, 0, 28)
					SearchBoxTextBox.Font = Enum.Font.GothamBold
					SearchBoxTextBox.PlaceholderColor3 = Color3.fromRGB(140, 140, 140)
					SearchBoxTextBox.PlaceholderText = "Search..."
					SearchBoxTextBox.Text = ""
					SearchBoxTextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
					SearchBoxTextBox.TextSize = 12
					SearchBoxTextBox.ClearTextOnFocus = false
					SearchBoxTextBox.ZIndex = 102
					SearchBoxTextBoxCorner.Parent = SearchBoxTextBox
					SearchBoxTextBoxCorner.CornerRadius = UDim.new(0, 8)
					SearchBoxTextBoxStroke.Parent = SearchBoxTextBox
					SearchBoxTextBoxStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
					SearchBoxTextBoxStroke.Color = Color3.fromRGB(255, 255, 255)
					SearchBoxTextBoxStroke.Thickness = 1.5
					SearchBoxTextBoxStroke.Transparency = 0.7
					SearchBoxTextBoxStrokeGradient.Parent = SearchBoxTextBoxStroke
					SearchBoxTextBoxStrokeGradient.Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
						ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 170, 255)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)),
					})
					MenuScrollScrollingFrame.Name = "MenuScroll"
					MenuScrollScrollingFrame.Parent = DropdownMenuFrame
					MenuScrollScrollingFrame.Active = true
					MenuScrollScrollingFrame.BackgroundTransparency = 1
					MenuScrollScrollingFrame.BorderSizePixel = 0
					MenuScrollScrollingFrame.Position = UDim2.new(0, 8, 0, 78)
					MenuScrollScrollingFrame.Size = UDim2.new(1, -16, 1, -86)
					MenuScrollScrollingFrame.ClipsDescendants = true
					MenuScrollScrollingFrame.ScrollBarThickness = 4
					MenuScrollScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(0, 170, 255)
					MenuScrollScrollingFrame.ScrollBarImageTransparency = 0.7
					MenuScrollScrollingFrame.ZIndex = 101
					MenuScrollScrollingFrameListLayout.Parent = MenuScrollScrollingFrame
					MenuScrollScrollingFrameListLayout.Padding = UDim.new(0, 4)
					MenuScrollScrollingFrameListLayout.SortOrder = Enum.SortOrder.LayoutOrder
					MenuScrollScrollingFrameListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
						MenuScrollScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, MenuScrollScrollingFrameListLayout.AbsoluteContentSize.Y + 8)
					end)
					isAnimating = false
					isOpen = false
					selectedValues = {}

					if type(Value) == "table" then
						for _, v in pairs(Value) do
							selectedValues[v] = true
						end

						updateDisplayText = function()
							if Multi then
								local items = {}

								for k, v in pairs(selectedValues) do
									if v then
										table.insert(items, k)
									end
								end

								if #items > 0 then
									ValueDisplayTextLabel.Text = #items .. " Selected"
								else
									ValueDisplayTextLabel.Text = "Select..."
								end
							else
								local flag = false

								for k, v in pairs(selectedValues) do
									if v then
										ValueDisplayTextLabel.Text = k
										flag = true

										break
									end
								end

								if not flag then
									ValueDisplayTextLabel.Text = "Select..."
								end
							end
						end
						closeDropdown = function()
							if isAnimating or not isOpen then
								return
							end

							isAnimating = true
							isOpen = false
							tw({
								v = DropdownMenuFrame,
								t = 0.25,
								s = "Quad",
								d = "Out",
								g = {
									Size = UDim2.new(0, 0, 1, 0),
								},
							}):Play()
							tw({
								v = SearchBoxTextBox,
								t = 0.2,
								s = "Quad",
								d = "Out",
								g = {
									Size = UDim2.new(0, 0, 0, 28),
								},
							}):Play()
							tw({
								v = ArrowIconImageLabel,
								t = 0.25,
								s = "Quad",
								d = "Out",
								g = {
									Rotation = 0,
								},
							}):Play()
							tw({
								v = DropdownFrameStroke,
								t = 0.25,
								s = "Quad",
								d = "Out",
								g = {
									Transparency = 0.75,
								},
							}):Play()
							task.spawn(function()
								task.wait(0.25)

								if not isOpen then
									DropdownMenuFrame.Visible = false
								end

								isAnimating = false
							end)
						end
						openDropdown = function()
							if isAnimating or isOpen then
								return
							end

							isAnimating = true
							isOpen = true
							DropdownMenuFrame.Visible = true
							SearchBoxTextBox.Text = ""
							tw({
								v = DropdownMenuFrame,
								t = 0.3,
								s = "Back",
								d = "Out",
								g = {
									Size = UDim2.new(0, 240, 1, 0),
								},
							}):Play()
							tw({
								v = SearchBoxTextBox,
								t = 0.25,
								s = "Back",
								d = "Out",
								g = {
									Size = UDim2.new(0.9, 0, 0, 28),
								},
							}):Play()
							tw({
								v = ArrowIconImageLabel,
								t = 0.3,
								s = "Back",
								d = "Out",
								g = {
									Rotation = 180,
								},
							}):Play()
							tw({
								v = DropdownFrameStroke,
								t = 0.3,
								s = "Quad",
								d = "Out",
								g = {
									Transparency = 0.4,
								},
							}):Play()
							task.spawn(function()
								task.wait(0.3)
								isAnimating = false
							end)
						end
						ClickDropdownTextButton.Name = "ClickDropdown"
						ClickDropdownTextButton.Parent = DropdownFrame
						ClickDropdownTextButton.BackgroundTransparency = 1
						ClickDropdownTextButton.Size = UDim2.new(1, 0, 1, 0)
						ClickDropdownTextButton.Position = UDim2.new(0, 0, 0, 0)
						ClickDropdownTextButton.BorderSizePixel = 0
						ClickDropdownTextButton.AutoButtonColor = false
						ClickDropdownTextButton.ZIndex = 10
						ClickDropdownTextButton.Text = ""
						ClickDropdownTextButton.MouseButton1Click:Connect(function()
							if isAnimating then
								return
							end

							if isOpen then
								closeDropdown()
							else
								openDropdown()
							end

							EffectClick2(ClickDropdownTextButton, DropdownFrame)
						end)
						connection = nil
						listenForOutsideClick = function()
							if connection then
								connection:Disconnect()
								connection = nil
							end

							connection = UserInputService.InputBegan:Connect(function(input)
								if not isOpen or isAnimating then
									return
								end

								if
									input.UserInputType == Enum.UserInputType.MouseButton1
									or input.UserInputType == Enum.UserInputType.Touch
								then
									local mouseLocation = UserInputService:GetMouseLocation()
									local AbsolutePosition = DropdownMenuFrame.AbsolutePosition
									local AbsoluteSize = DropdownMenuFrame.AbsoluteSize
									local absolutePosition = DropdownFrame.AbsolutePosition
									local absoluteSize = DropdownFrame.AbsoluteSize

									if
										not (
											mouseLocation.X >= AbsolutePosition.X
												and mouseLocation.X <= AbsolutePosition.X + AbsoluteSize.X
												and mouseLocation.Y >= AbsolutePosition.Y
												and mouseLocation.Y <= AbsolutePosition.Y + AbsoluteSize.Y
											or mouseLocation.X >= absolutePosition.X
												and mouseLocation.X <= absolutePosition.X + absoluteSize.X
												and mouseLocation.Y >= absolutePosition.Y
												and mouseLocation.Y <= absolutePosition.Y + absoluteSize.Y
										)
									then
										closeDropdown()
									end
								end
							end)
						end
						SearchBoxTextBox:GetPropertyChangedSignal("Text"):Connect(function()
							local lowered = string.lower(SearchBoxTextBox.Text)

							for _, child in pairs(MenuScrollScrollingFrame:GetChildren()) do
								if child:IsA("Frame") and child.Name == "Item" then
									local ItemTitle = child:FindFirstChild("ItemTitle")

									if ItemTitle then
										local loweredB = string.lower(ItemTitle.Text)

										child.Visible = lowered == "" or string.find(loweredB, lowered, 1, true) ~= nil
									end
								end
							end
						end)
						SearchBoxTextBox.Focused:Connect(function()
							tw({
								v = SearchBoxTextBoxStroke,
								t = 0.3,
								s = "Quad",
								d = "Out",
								g = {
									Transparency = 0.3,
								},
							}):Play()
						end)
						SearchBoxTextBox.FocusLost:Connect(function()
							tw({
								v = SearchBoxTextBoxStroke,
								t = 0.3,
								s = "Quad",
								d = "Out",
								g = {
									Transparency = 0.7,
								},
							}):Play()
						end)
						addItem = function(text)
							local ItemFrame = Instance.new("Frame")
							local ItemFrameCorner = Instance.new("UICorner")
							local ItemTitleTextLabel = Instance.new("TextLabel")
							local IndicatorFrame = Instance.new("Frame")
							local IndicatorFrameCorner = Instance.new("UICorner")
							local IndicatorFrameGradient = Instance.new("UIGradient")

							ItemFrame.Name = "Item"
							ItemFrame.Parent = MenuScrollScrollingFrame
							ItemFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
							ItemFrame.BackgroundTransparency = 0.4
							ItemFrame.Size = UDim2.new(1, 0, 0, 32)
							ItemFrame.ZIndex = 102
							ItemFrameCorner.Parent = ItemFrame
							ItemFrameCorner.CornerRadius = UDim.new(0, 8)
							ItemTitleTextLabel.Name = "ItemTitle"
							ItemTitleTextLabel.Parent = ItemFrame
							ItemTitleTextLabel.BackgroundTransparency = 1
							ItemTitleTextLabel.Position = UDim2.new(0, 12, 0, 0)
							ItemTitleTextLabel.Size = UDim2.new(1, -44, 1, 0)
							ItemTitleTextLabel.Font = Enum.Font.GothamBold
							ItemTitleTextLabel.Text = text
							ItemTitleTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
							ItemTitleTextLabel.TextSize = 13
							ItemTitleTextLabel.TextTransparency = selectedValues[text] and 0 or 0.5
							ItemTitleTextLabel.TextXAlignment = Enum.TextXAlignment.Left
							ItemTitleTextLabel.TextScaled = true
							ItemTitleTextLabel.TextWrapped = true
							ItemTitleTextLabel.ZIndex = 103

							local ItemTitleTextLabelTextConstraint = Instance.new("UITextSizeConstraint")

							ItemTitleTextLabelTextConstraint.Parent = ItemTitleTextLabel
							ItemTitleTextLabelTextConstraint.MaxTextSize = 13
							ItemTitleTextLabelTextConstraint.MinTextSize = 9
							IndicatorFrame.Name = "Indicator"
							IndicatorFrame.Parent = ItemFrame
							IndicatorFrame.AnchorPoint = Vector2.new(0, 0.5)
							IndicatorFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
							IndicatorFrame.Position = UDim2.new(0, 0, 0.5, 0)
							IndicatorFrame.Size = UDim2.new(0, selectedValues[text] and 4 or 0, 0, 32)
							IndicatorFrame.BackgroundTransparency = selectedValues[text] and 0 or 1
							IndicatorFrame.ZIndex = 102
							IndicatorFrameCorner.Parent = IndicatorFrame
							IndicatorFrameCorner.CornerRadius = UDim.new(1, 0)
							IndicatorFrameGradient.Parent = IndicatorFrame
							IndicatorFrameGradient.Color = ColorSequence.new({
								ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
								ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 170, 255)),
								ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)),
							})
							IndicatorFrameGradient.Rotation = 90

							local ClickTextButton = Instance.new("TextButton")

							ClickTextButton.Name = "Click"
							ClickTextButton.Parent = ItemFrame
							ClickTextButton.BackgroundTransparency = 1
							ClickTextButton.BorderSizePixel = 0
							ClickTextButton.Size = UDim2.new(1, 0, 1, 0)
							ClickTextButton.Position = UDim2.new(0, 0, 0, 0)
							ClickTextButton.ZIndex = 120
							ClickTextButton.AutoButtonColor = false
							ClickTextButton.Font = Enum.Font.SourceSans
							ClickTextButton.Text = ""
							ClickTextButton.MouseEnter:Connect(function()
								tw({
									v = ItemFrame,
									t = 0.2,
									s = "Quad",
									d = "Out",
									g = {
										BackgroundTransparency = 0.2,
									},
								}):Play()
							end)
							ClickTextButton.MouseLeave:Connect(function()
								tw({
									v = ItemFrame,
									t = 0.2,
									s = "Quad",
									d = "Out",
									g = {
										BackgroundTransparency = 0.4,
									},
								}):Play()
							end)
							ClickTextButton.MouseButton1Click:Connect(function()
								EffectClick2(ClickTextButton, ItemFrame)

								if Multi then
									selectedValues[text] = not selectedValues[text]

									local items, task_

									if selectedValues[text] then
										tw({
											v = ItemTitleTextLabel,
											t = 0.2,
											s = "Quad",
											d = "Out",
											g = {
												TextTransparency = 0,
											},
										}):Play()
										tw({
											v = IndicatorFrame,
											t = 0.2,
											s = "Back",
											d = "Out",
											g = {
												Size = UDim2.new(0, 4, 0, 32),
												BackgroundTransparency = 0,
											},
										}):Play()
										items = {}

										for k, v in pairs(selectedValues) do
											if v then
												table.insert(items, k)
											end
										end

										updateDisplayText()
										task_ = task
									else
										tw({
											v = ItemTitleTextLabel,
											t = 0.2,
											s = "Quad",
											d = "Out",
											g = {
												TextTransparency = 0.5,
											},
										}):Play()
										tw({
											v = IndicatorFrame,
											t = 0.2,
											s = "Back",
											d = "Out",
											g = {
												Size = UDim2.new(0, 0, 0, 32),
												BackgroundTransparency = 1,
											},
										}):Play()
										items = {}

										for k, v in pairs(selectedValues) do
											if v then
												table.insert(items, k)
											end
										end

										updateDisplayText()
										task_ = task
									end

									task_.spawn(function()
										pcall(Callback, items)
									end)
								else
									for k in pairs(selectedValues) do
										selectedValues[k] = false
									end

									selectedValues[text] = true

									for _, child in pairs(MenuScrollScrollingFrame:GetChildren()) do
										if child:IsA("Frame") and child.Name == "Item" then
											local ItemTitle = child:FindFirstChild("ItemTitle")
											local Indicator = child:FindFirstChild("Indicator")

											if ItemTitle and Indicator then
												tw({
													v = ItemTitle,
													t = 0.2,
													s = "Quad",
													d = "Out",
													g = {
														TextTransparency = 0.5,
													},
												}):Play()
												tw({
													v = Indicator,
													t = 0.2,
													s = "Back",
													d = "Out",
													g = {
														Size = UDim2.new(0, 0, 0, 32),
														BackgroundTransparency = 1,
													},
												}):Play()
											end
										end
									end

									tw({
										v = ItemTitleTextLabel,
										t = 0.2,
										s = "Quad",
										d = "Out",
										g = {
											TextTransparency = 0,
										},
									}):Play()
									tw({
										v = IndicatorFrame,
										t = 0.2,
										s = "Back",
										d = "Out",
										g = {
											Size = UDim2.new(0, 4, 0, 32),
											BackgroundTransparency = 0,
										},
									}):Play()
									updateDisplayText()
									task.spawn(function()
										pcall(Callback, text)
									end)
									task.wait(0.15)
									closeDropdown()
								end
							end)
						end

						for _, v in pairs(List) do
							addItem(v)
						end

						updateDisplayText()
						listenForOutsideClick()
						table.insert(SearchItems, {
							Frame = DropdownFrame,
							SearchName = TitleB,
							HighlightFrame = HighlightFrameB,
						})
						DropdownFrame.Destroying:Connect(function()
							if connection then
								connection:Disconnect()
								connection = nil
							end

							if DropdownMenuFrame then
								DropdownMenuFrame:Destroy()
							end
						end)
						dropdownApi = {
							Add = function(self, item)
								if not table.find(List, item) then
									table.insert(List, item)
									addItem(item)
								end
							end,
							Remove = function(self, item)
								for k, v in pairs(List) do
									if v == item then
										table.remove(List, k)

										break
									end
								end

								for _, child in pairs(MenuScrollScrollingFrame:GetChildren()) do
									if child:IsA("Frame") and child.Name == "Item" then
										local ItemTitle = child:FindFirstChild("ItemTitle")

										if ItemTitle and ItemTitle.Text == item then
											child:Destroy()

											break
										end
									end
								end

								selectedValues[item] = nil
								updateDisplayText()
							end,
							Clear = function()
								for _, child in pairs(MenuScrollScrollingFrame:GetChildren()) do
									if child:IsA("Frame") and child.Name == "Item" then
										child:Destroy()
									end
								end

								List = {}
								selectedValues = {}
								updateDisplayText()
							end,
							SetValue = function(self, value)
								selectedValues = {}

								local valueB, valueC, valueD, ItemTitle, Indicator, tween, tweenB, tweenC, tweenD

								if type(value) == "table" then
									local iterator, iterTable, iterKey = pairs(value)
									local iteratorB = geniter(iterator, iterTable, iterKey)

									for _, v in iterator, iterTable, iterKey do
										while true do
											selectedValues[v] = true

											local packed = table.pack(iteratorB())

											if not packed[1] then
												break
											end

											v = packed[3]
										end

										local iterator, iterTable, iterKey = pairs(MenuScrollScrollingFrame:GetChildren())

										for _, entry in iterator, iterTable, iterKey do
											if entry:IsA("Frame") and entry.Name == "Item" then
												local child = entry:FindFirstChild("ItemTitle")
												local childB = entry:FindFirstChild("Indicator")

												if child and childB then
													if selectedValues[child.Text] then
														tw({
															v = child,
															t = 0.2,
															s = "Quad",
															d = "Out",
															g = {
																TextTransparency = 0,
															},
														}):Play()
														tw({
															v = childB,
															t = 0.2,
															s = "Back",
															d = "Out",
															g = {
																Size = UDim2.new(0, 4, 0, 32),
																BackgroundTransparency = 0,
															},
														}):Play()
													else
														tw({
															v = child,
															t = 0.2,
															s = "Quad",
															d = "Out",
															g = {
																TextTransparency = 0.5,
															},
														}):Play()
														tw({
															v = childB,
															t = 0.2,
															s = "Back",
															d = "Out",
															g = {
																Size = UDim2.new(0, 0, 0, 32),
																BackgroundTransparency = 1,
															},
														}):Play()
													end
												end
											end
										end

										updateDisplayText()

										return
									end

									valueB, valueC, valueD = pairs(MenuScrollScrollingFrame:GetChildren())

									for _, v in valueB, valueC, valueD do
										if v:IsA("Frame") and v.Name == "Item" then
											ItemTitle = v:FindFirstChild("ItemTitle")
											Indicator = v:FindFirstChild("Indicator")

											if ItemTitle and Indicator then
												if selectedValues[ItemTitle.Text] then
													tween = tw({
														v = ItemTitle,
														t = 0.2,
														s = "Quad",
														d = "Out",
														g = {
															TextTransparency = 0,
														},
													})
													tween:Play()
													tweenB = tw({
														v = Indicator,
														t = 0.2,
														s = "Back",
														d = "Out",
														g = {
															Size = UDim2.new(0, 4, 0, 32),
															BackgroundTransparency = 0,
														},
													})
													tweenB:Play()
												else
													tweenC = tw({
														v = ItemTitle,
														t = 0.2,
														s = "Quad",
														d = "Out",
														g = {
															TextTransparency = 0.5,
														},
													})
													tweenC:Play()
													tweenD = tw({
														v = Indicator,
														t = 0.2,
														s = "Back",
														d = "Out",
														g = {
															Size = UDim2.new(0, 0, 0, 32),
															BackgroundTransparency = 1,
														},
													})
													tweenD:Play()
												end
											end
										end
									end
								elseif type(value) == "string" and value ~= "" then
									selectedValues[value] = true
									valueB, valueC, valueD = pairs(MenuScrollScrollingFrame:GetChildren())

									for _, v in valueB, valueC, valueD do
										if v:IsA("Frame") and v.Name == "Item" then
											ItemTitle = v:FindFirstChild("ItemTitle")
											Indicator = v:FindFirstChild("Indicator")

											if ItemTitle and Indicator then
												if selectedValues[ItemTitle.Text] then
													tween = tw({
														v = ItemTitle,
														t = 0.2,
														s = "Quad",
														d = "Out",
														g = {
															TextTransparency = 0,
														},
													})
													tween:Play()
													tweenB = tw({
														v = Indicator,
														t = 0.2,
														s = "Back",
														d = "Out",
														g = {
															Size = UDim2.new(0, 4, 0, 32),
															BackgroundTransparency = 0,
														},
													})
													tweenB:Play()
												else
													tweenC = tw({
														v = ItemTitle,
														t = 0.2,
														s = "Quad",
														d = "Out",
														g = {
															TextTransparency = 0.5,
														},
													})
													tweenC:Play()
													tweenD = tw({
														v = Indicator,
														t = 0.2,
														s = "Back",
														d = "Out",
														g = {
															Size = UDim2.new(0, 0, 0, 32),
															BackgroundTransparency = 1,
														},
													})
													tweenD:Play()
												end
											end
										end
									end
								else
									valueB, valueC, valueD = pairs(MenuScrollScrollingFrame:GetChildren())

									for _, v in valueB, valueC, valueD do
										if v:IsA("Frame") and v.Name == "Item" then
											ItemTitle = v:FindFirstChild("ItemTitle")
											Indicator = v:FindFirstChild("Indicator")

											if ItemTitle and Indicator then
												if selectedValues[ItemTitle.Text] then
													tw({
														v = ItemTitle,
														t = 0.2,
														s = "Quad",
														d = "Out",
														g = {
															TextTransparency = 0,
														},
													}):Play()
													tw({
														v = Indicator,
														t = 0.2,
														s = "Back",
														d = "Out",
														g = {
															Size = UDim2.new(0, 4, 0, 32),
															BackgroundTransparency = 0,
														},
													}):Play()
												else
													tw({
														v = ItemTitle,
														t = 0.2,
														s = "Quad",
														d = "Out",
														g = {
															TextTransparency = 0.5,
														},
													}):Play()
													tw({
														v = Indicator,
														t = 0.2,
														s = "Back",
														d = "Out",
														g = {
															Size = UDim2.new(0, 0, 0, 32),
															BackgroundTransparency = 1,
														},
													}):Play()
												end
											end
										end
									end
								end

								updateDisplayText()
							end,
							GetValue = function()
								if not Multi then
									for k, v in pairs(selectedValues) do
										if v then
											return k
										end
									end

									return nil
								end

								local items = {}

								for k, v in pairs(selectedValues) do
									if v then
										table.insert(items, k)
									end
								end

								return items
							end,
							SetTitle = function(self, text)
								TitleTextLabel.Text = text
								TitleTextLabelB.Text = text

								for _, v in pairs(SearchItems) do
									if v.Frame == DropdownFrame then
										v.SearchName = text

										break
									end
								end
							end,
							SetDesc = function(self, text)
								if DescTextLabel then
									DescTextLabel.Text = text
								end
							end,
							Visible = function(self, visible)
								DropdownFrame.Visible = visible

								if not visible and isOpen then
									closeDropdown()
								end
							end,
						}
					elseif Value == "" then
						updateDisplayText = function()
							if Multi then
								local items = {}

								for k, v in pairs(selectedValues) do
									if v then
										table.insert(items, k)
									end
								end

								if #items > 0 then
									ValueDisplayTextLabel.Text = #items .. " Selected"
								else
									ValueDisplayTextLabel.Text = "Select..."
								end
							else
								local flag = false

								for k, v in pairs(selectedValues) do
									if v then
										ValueDisplayTextLabel.Text = k
										flag = true

										break
									end
								end

								if not flag then
									ValueDisplayTextLabel.Text = "Select..."
								end
							end
						end
						closeDropdown = function()
							if isAnimating or not isOpen then
								return
							end

							isAnimating = true
							isOpen = false
							tw({
								v = DropdownMenuFrame,
								t = 0.25,
								s = "Quad",
								d = "Out",
								g = {
									Size = UDim2.new(0, 0, 1, 0),
								},
							}):Play()
							tw({
								v = SearchBoxTextBox,
								t = 0.2,
								s = "Quad",
								d = "Out",
								g = {
									Size = UDim2.new(0, 0, 0, 28),
								},
							}):Play()
							tw({
								v = ArrowIconImageLabel,
								t = 0.25,
								s = "Quad",
								d = "Out",
								g = {
									Rotation = 0,
								},
							}):Play()
							tw({
								v = DropdownFrameStroke,
								t = 0.25,
								s = "Quad",
								d = "Out",
								g = {
									Transparency = 0.75,
								},
							}):Play()
							task.spawn(function()
								task.wait(0.25)

								if not isOpen then
									DropdownMenuFrame.Visible = false
								end

								isAnimating = false
							end)
						end
						openDropdown = function()
							if isAnimating or isOpen then
								return
							end

							isAnimating = true
							isOpen = true
							DropdownMenuFrame.Visible = true
							SearchBoxTextBox.Text = ""
							tw({
								v = DropdownMenuFrame,
								t = 0.3,
								s = "Back",
								d = "Out",
								g = {
									Size = UDim2.new(0, 240, 1, 0),
								},
							}):Play()
							tw({
								v = SearchBoxTextBox,
								t = 0.25,
								s = "Back",
								d = "Out",
								g = {
									Size = UDim2.new(0.9, 0, 0, 28),
								},
							}):Play()
							tw({
								v = ArrowIconImageLabel,
								t = 0.3,
								s = "Back",
								d = "Out",
								g = {
									Rotation = 180,
								},
							}):Play()
							tw({
								v = DropdownFrameStroke,
								t = 0.3,
								s = "Quad",
								d = "Out",
								g = {
									Transparency = 0.4,
								},
							}):Play()
							task.spawn(function()
								task.wait(0.3)
								isAnimating = false
							end)
						end
						ClickDropdownTextButton.Name = "ClickDropdown"
						ClickDropdownTextButton.Parent = DropdownFrame
						ClickDropdownTextButton.BackgroundTransparency = 1
						ClickDropdownTextButton.Size = UDim2.new(1, 0, 1, 0)
						ClickDropdownTextButton.Position = UDim2.new(0, 0, 0, 0)
						ClickDropdownTextButton.BorderSizePixel = 0
						ClickDropdownTextButton.AutoButtonColor = false
						ClickDropdownTextButton.ZIndex = 10
						ClickDropdownTextButton.Text = ""
						ClickDropdownTextButton.MouseButton1Click:Connect(function()
							if isAnimating then
								return
							end

							if isOpen then
								closeDropdown()
							else
								openDropdown()
							end

							EffectClick2(ClickDropdownTextButton, DropdownFrame)
						end)
						connection = nil
						listenForOutsideClick = function()
							if connection then
								connection:Disconnect()
								connection = nil
							end

							connection = UserInputService.InputBegan:Connect(function(input)
								if not isOpen or isAnimating then
									return
								end

								if
									input.UserInputType == Enum.UserInputType.MouseButton1
									or input.UserInputType == Enum.UserInputType.Touch
								then
									local mouseLocation = UserInputService:GetMouseLocation()
									local AbsolutePosition = DropdownMenuFrame.AbsolutePosition
									local AbsoluteSize = DropdownMenuFrame.AbsoluteSize
									local absolutePosition = DropdownFrame.AbsolutePosition
									local absoluteSize = DropdownFrame.AbsoluteSize

									if
										not (
											mouseLocation.X >= AbsolutePosition.X
												and mouseLocation.X <= AbsolutePosition.X + AbsoluteSize.X
												and mouseLocation.Y >= AbsolutePosition.Y
												and mouseLocation.Y <= AbsolutePosition.Y + AbsoluteSize.Y
											or mouseLocation.X >= absolutePosition.X
												and mouseLocation.X <= absolutePosition.X + absoluteSize.X
												and mouseLocation.Y >= absolutePosition.Y
												and mouseLocation.Y <= absolutePosition.Y + absoluteSize.Y
										)
									then
										closeDropdown()
									end
								end
							end)
						end
						SearchBoxTextBox:GetPropertyChangedSignal("Text"):Connect(function()
							local lowered = string.lower(SearchBoxTextBox.Text)

							for _, child in pairs(MenuScrollScrollingFrame:GetChildren()) do
								if child:IsA("Frame") and child.Name == "Item" then
									local ItemTitle = child:FindFirstChild("ItemTitle")

									if ItemTitle then
										local loweredB = string.lower(ItemTitle.Text)

										child.Visible = lowered == "" or string.find(loweredB, lowered, 1, true) ~= nil
									end
								end
							end
						end)
						SearchBoxTextBox.Focused:Connect(function()
							tw({
								v = SearchBoxTextBoxStroke,
								t = 0.3,
								s = "Quad",
								d = "Out",
								g = {
									Transparency = 0.3,
								},
							}):Play()
						end)
						SearchBoxTextBox.FocusLost:Connect(function()
							tw({
								v = SearchBoxTextBoxStroke,
								t = 0.3,
								s = "Quad",
								d = "Out",
								g = {
									Transparency = 0.7,
								},
							}):Play()
						end)
						addItem = function(text)
							local ItemFrame = Instance.new("Frame")
							local ItemFrameCorner = Instance.new("UICorner")
							local ItemTitleTextLabel = Instance.new("TextLabel")
							local IndicatorFrame = Instance.new("Frame")
							local IndicatorFrameCorner = Instance.new("UICorner")
							local IndicatorFrameGradient = Instance.new("UIGradient")

							ItemFrame.Name = "Item"
							ItemFrame.Parent = MenuScrollScrollingFrame
							ItemFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
							ItemFrame.BackgroundTransparency = 0.4
							ItemFrame.Size = UDim2.new(1, 0, 0, 32)
							ItemFrame.ZIndex = 102
							ItemFrameCorner.Parent = ItemFrame
							ItemFrameCorner.CornerRadius = UDim.new(0, 8)
							ItemTitleTextLabel.Name = "ItemTitle"
							ItemTitleTextLabel.Parent = ItemFrame
							ItemTitleTextLabel.BackgroundTransparency = 1
							ItemTitleTextLabel.Position = UDim2.new(0, 12, 0, 0)
							ItemTitleTextLabel.Size = UDim2.new(1, -44, 1, 0)
							ItemTitleTextLabel.Font = Enum.Font.GothamBold
							ItemTitleTextLabel.Text = text
							ItemTitleTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
							ItemTitleTextLabel.TextSize = 13
							ItemTitleTextLabel.TextTransparency = selectedValues[text] and 0 or 0.5
							ItemTitleTextLabel.TextXAlignment = Enum.TextXAlignment.Left
							ItemTitleTextLabel.TextScaled = true
							ItemTitleTextLabel.TextWrapped = true
							ItemTitleTextLabel.ZIndex = 103

							local ItemTitleTextLabelTextConstraint = Instance.new("UITextSizeConstraint")

							ItemTitleTextLabelTextConstraint.Parent = ItemTitleTextLabel
							ItemTitleTextLabelTextConstraint.MaxTextSize = 13
							ItemTitleTextLabelTextConstraint.MinTextSize = 9
							IndicatorFrame.Name = "Indicator"
							IndicatorFrame.Parent = ItemFrame
							IndicatorFrame.AnchorPoint = Vector2.new(0, 0.5)
							IndicatorFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
							IndicatorFrame.Position = UDim2.new(0, 0, 0.5, 0)
							IndicatorFrame.Size = UDim2.new(0, selectedValues[text] and 4 or 0, 0, 32)
							IndicatorFrame.BackgroundTransparency = selectedValues[text] and 0 or 1
							IndicatorFrame.ZIndex = 102
							IndicatorFrameCorner.Parent = IndicatorFrame
							IndicatorFrameCorner.CornerRadius = UDim.new(1, 0)
							IndicatorFrameGradient.Parent = IndicatorFrame
							IndicatorFrameGradient.Color = ColorSequence.new({
								ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
								ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 170, 255)),
								ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)),
							})
							IndicatorFrameGradient.Rotation = 90

							local ClickTextButton = Instance.new("TextButton")

							ClickTextButton.Name = "Click"
							ClickTextButton.Parent = ItemFrame
							ClickTextButton.BackgroundTransparency = 1
							ClickTextButton.BorderSizePixel = 0
							ClickTextButton.Size = UDim2.new(1, 0, 1, 0)
							ClickTextButton.Position = UDim2.new(0, 0, 0, 0)
							ClickTextButton.ZIndex = 120
							ClickTextButton.AutoButtonColor = false
							ClickTextButton.Font = Enum.Font.SourceSans
							ClickTextButton.Text = ""
							ClickTextButton.MouseEnter:Connect(function()
								tw({
									v = ItemFrame,
									t = 0.2,
									s = "Quad",
									d = "Out",
									g = {
										BackgroundTransparency = 0.2,
									},
								}):Play()
							end)
							ClickTextButton.MouseLeave:Connect(function()
								tw({
									v = ItemFrame,
									t = 0.2,
									s = "Quad",
									d = "Out",
									g = {
										BackgroundTransparency = 0.4,
									},
								}):Play()
							end)
							ClickTextButton.MouseButton1Click:Connect(function()
								EffectClick2(ClickTextButton, ItemFrame)

								if Multi then
									selectedValues[text] = not selectedValues[text]

									local items, task_

									if selectedValues[text] then
										tw({
											v = ItemTitleTextLabel,
											t = 0.2,
											s = "Quad",
											d = "Out",
											g = {
												TextTransparency = 0,
											},
										}):Play()
										tw({
											v = IndicatorFrame,
											t = 0.2,
											s = "Back",
											d = "Out",
											g = {
												Size = UDim2.new(0, 4, 0, 32),
												BackgroundTransparency = 0,
											},
										}):Play()
										items = {}

										for k, v in pairs(selectedValues) do
											if v then
												table.insert(items, k)
											end
										end

										updateDisplayText()
										task_ = task
									else
										tw({
											v = ItemTitleTextLabel,
											t = 0.2,
											s = "Quad",
											d = "Out",
											g = {
												TextTransparency = 0.5,
											},
										}):Play()
										tw({
											v = IndicatorFrame,
											t = 0.2,
											s = "Back",
											d = "Out",
											g = {
												Size = UDim2.new(0, 0, 0, 32),
												BackgroundTransparency = 1,
											},
										}):Play()
										items = {}

										for k, v in pairs(selectedValues) do
											if v then
												table.insert(items, k)
											end
										end

										updateDisplayText()
										task_ = task
									end

									task_.spawn(function()
										pcall(Callback, items)
									end)
								else
									for k in pairs(selectedValues) do
										selectedValues[k] = false
									end

									selectedValues[text] = true

									for _, child in pairs(MenuScrollScrollingFrame:GetChildren()) do
										if child:IsA("Frame") and child.Name == "Item" then
											local ItemTitle = child:FindFirstChild("ItemTitle")
											local Indicator = child:FindFirstChild("Indicator")

											if ItemTitle and Indicator then
												tw({
													v = ItemTitle,
													t = 0.2,
													s = "Quad",
													d = "Out",
													g = {
														TextTransparency = 0.5,
													},
												}):Play()
												tw({
													v = Indicator,
													t = 0.2,
													s = "Back",
													d = "Out",
													g = {
														Size = UDim2.new(0, 0, 0, 32),
														BackgroundTransparency = 1,
													},
												}):Play()
											end
										end
									end

									tw({
										v = ItemTitleTextLabel,
										t = 0.2,
										s = "Quad",
										d = "Out",
										g = {
											TextTransparency = 0,
										},
									}):Play()
									tw({
										v = IndicatorFrame,
										t = 0.2,
										s = "Back",
										d = "Out",
										g = {
											Size = UDim2.new(0, 4, 0, 32),
											BackgroundTransparency = 0,
										},
									}):Play()
									updateDisplayText()
									task.spawn(function()
										pcall(Callback, text)
									end)
									task.wait(0.15)
									closeDropdown()
								end
							end)
						end

						for _, v in pairs(List) do
							addItem(v)
						end

						updateDisplayText()
						listenForOutsideClick()
						table.insert(SearchItems, {
							Frame = DropdownFrame,
							SearchName = TitleB,
							HighlightFrame = HighlightFrameB,
						})
						DropdownFrame.Destroying:Connect(function()
							if connection then
								connection:Disconnect()
								connection = nil
							end

							if DropdownMenuFrame then
								DropdownMenuFrame:Destroy()
							end
						end)
						dropdownApi = {
							Add = function(self, item)
								if not table.find(List, item) then
									table.insert(List, item)
									addItem(item)
								end
							end,
							Remove = function(self, item)
								for k, v in pairs(List) do
									if v == item then
										table.remove(List, k)

										break
									end
								end

								for _, child in pairs(MenuScrollScrollingFrame:GetChildren()) do
									if child:IsA("Frame") and child.Name == "Item" then
										local ItemTitle = child:FindFirstChild("ItemTitle")

										if ItemTitle and ItemTitle.Text == item then
											child:Destroy()

											break
										end
									end
								end

								selectedValues[item] = nil
								updateDisplayText()
							end,
							Clear = function()
								for _, child in pairs(MenuScrollScrollingFrame:GetChildren()) do
									if child:IsA("Frame") and child.Name == "Item" then
										child:Destroy()
									end
								end

								List = {}
								selectedValues = {}
								updateDisplayText()
							end,
							SetValue = function(self, value)
								selectedValues = {}

								local valueB, valueC, valueD, ItemTitle, Indicator, tween, tweenB, tweenC, tweenD

								if type(value) == "table" then
									local iterator, iterTable, iterKey = pairs(value)
									local iteratorB = geniter(iterator, iterTable, iterKey)

									for _, v in iterator, iterTable, iterKey do
										while true do
											selectedValues[v] = true

											local packed = table.pack(iteratorB())

											if not packed[1] then
												break
											end

											v = packed[3]
										end

										local iterator, iterTable, iterKey = pairs(MenuScrollScrollingFrame:GetChildren())

										for _, entry in iterator, iterTable, iterKey do
											if entry:IsA("Frame") and entry.Name == "Item" then
												local child = entry:FindFirstChild("ItemTitle")
												local childB = entry:FindFirstChild("Indicator")

												if child and childB then
													if selectedValues[child.Text] then
														tw({
															v = child,
															t = 0.2,
															s = "Quad",
															d = "Out",
															g = {
																TextTransparency = 0,
															},
														}):Play()
														tw({
															v = childB,
															t = 0.2,
															s = "Back",
															d = "Out",
															g = {
																Size = UDim2.new(0, 4, 0, 32),
																BackgroundTransparency = 0,
															},
														}):Play()
													else
														tw({
															v = child,
															t = 0.2,
															s = "Quad",
															d = "Out",
															g = {
																TextTransparency = 0.5,
															},
														}):Play()
														tw({
															v = childB,
															t = 0.2,
															s = "Back",
															d = "Out",
															g = {
																Size = UDim2.new(0, 0, 0, 32),
																BackgroundTransparency = 1,
															},
														}):Play()
													end
												end
											end
										end

										updateDisplayText()

										return
									end

									valueB, valueC, valueD = pairs(MenuScrollScrollingFrame:GetChildren())

									for _, v in valueB, valueC, valueD do
										if v:IsA("Frame") and v.Name == "Item" then
											ItemTitle = v:FindFirstChild("ItemTitle")
											Indicator = v:FindFirstChild("Indicator")

											if ItemTitle and Indicator then
												if selectedValues[ItemTitle.Text] then
													tween = tw({
														v = ItemTitle,
														t = 0.2,
														s = "Quad",
														d = "Out",
														g = {
															TextTransparency = 0,
														},
													})
													tween:Play()
													tweenB = tw({
														v = Indicator,
														t = 0.2,
														s = "Back",
														d = "Out",
														g = {
															Size = UDim2.new(0, 4, 0, 32),
															BackgroundTransparency = 0,
														},
													})
													tweenB:Play()
												else
													tweenC = tw({
														v = ItemTitle,
														t = 0.2,
														s = "Quad",
														d = "Out",
														g = {
															TextTransparency = 0.5,
														},
													})
													tweenC:Play()
													tweenD = tw({
														v = Indicator,
														t = 0.2,
														s = "Back",
														d = "Out",
														g = {
															Size = UDim2.new(0, 0, 0, 32),
															BackgroundTransparency = 1,
														},
													})
													tweenD:Play()
												end
											end
										end
									end
								elseif type(value) == "string" and value ~= "" then
									selectedValues[value] = true
									valueB, valueC, valueD = pairs(MenuScrollScrollingFrame:GetChildren())

									for _, v in valueB, valueC, valueD do
										if v:IsA("Frame") and v.Name == "Item" then
											ItemTitle = v:FindFirstChild("ItemTitle")
											Indicator = v:FindFirstChild("Indicator")

											if ItemTitle and Indicator then
												if selectedValues[ItemTitle.Text] then
													tween = tw({
														v = ItemTitle,
														t = 0.2,
														s = "Quad",
														d = "Out",
														g = {
															TextTransparency = 0,
														},
													})
													tween:Play()
													tweenB = tw({
														v = Indicator,
														t = 0.2,
														s = "Back",
														d = "Out",
														g = {
															Size = UDim2.new(0, 4, 0, 32),
															BackgroundTransparency = 0,
														},
													})
													tweenB:Play()
												else
													tweenC = tw({
														v = ItemTitle,
														t = 0.2,
														s = "Quad",
														d = "Out",
														g = {
															TextTransparency = 0.5,
														},
													})
													tweenC:Play()
													tweenD = tw({
														v = Indicator,
														t = 0.2,
														s = "Back",
														d = "Out",
														g = {
															Size = UDim2.new(0, 0, 0, 32),
															BackgroundTransparency = 1,
														},
													})
													tweenD:Play()
												end
											end
										end
									end
								else
									valueB, valueC, valueD = pairs(MenuScrollScrollingFrame:GetChildren())

									for _, v in valueB, valueC, valueD do
										if v:IsA("Frame") and v.Name == "Item" then
											ItemTitle = v:FindFirstChild("ItemTitle")
											Indicator = v:FindFirstChild("Indicator")

											if ItemTitle and Indicator then
												if selectedValues[ItemTitle.Text] then
													tw({
														v = ItemTitle,
														t = 0.2,
														s = "Quad",
														d = "Out",
														g = {
															TextTransparency = 0,
														},
													}):Play()
													tw({
														v = Indicator,
														t = 0.2,
														s = "Back",
														d = "Out",
														g = {
															Size = UDim2.new(0, 4, 0, 32),
															BackgroundTransparency = 0,
														},
													}):Play()
												else
													tw({
														v = ItemTitle,
														t = 0.2,
														s = "Quad",
														d = "Out",
														g = {
															TextTransparency = 0.5,
														},
													}):Play()
													tw({
														v = Indicator,
														t = 0.2,
														s = "Back",
														d = "Out",
														g = {
															Size = UDim2.new(0, 0, 0, 32),
															BackgroundTransparency = 1,
														},
													}):Play()
												end
											end
										end
									end
								end

								updateDisplayText()
							end,
							GetValue = function()
								if not Multi then
									for k, v in pairs(selectedValues) do
										if v then
											return k
										end
									end

									return nil
								end

								local items = {}

								for k, v in pairs(selectedValues) do
									if v then
										table.insert(items, k)
									end
								end

								return items
							end,
							SetTitle = function(self, text)
								TitleTextLabel.Text = text
								TitleTextLabelB.Text = text

								for _, v in pairs(SearchItems) do
									if v.Frame == DropdownFrame then
										v.SearchName = text

										break
									end
								end
							end,
							SetDesc = function(self, text)
								if DescTextLabel then
									DescTextLabel.Text = text
								end
							end,
							Visible = function(self, visible)
								DropdownFrame.Visible = visible

								if not visible and isOpen then
									closeDropdown()
								end
							end,
						}
					else
						selectedValues[Value] = true
						updateDisplayText = function()
							if Multi then
								local items = {}

								for k, v in pairs(selectedValues) do
									if v then
										table.insert(items, k)
									end
								end

								if #items > 0 then
									ValueDisplayTextLabel.Text = #items .. " Selected"
								else
									ValueDisplayTextLabel.Text = "Select..."
								end
							else
								local flag = false

								for k, v in pairs(selectedValues) do
									if v then
										ValueDisplayTextLabel.Text = k
										flag = true

										break
									end
								end

								if not flag then
									ValueDisplayTextLabel.Text = "Select..."
								end
							end
						end
						closeDropdown = function()
							if isAnimating or not isOpen then
								return
							end

							isAnimating = true
							isOpen = false
							tw({
								v = DropdownMenuFrame,
								t = 0.25,
								s = "Quad",
								d = "Out",
								g = {
									Size = UDim2.new(0, 0, 1, 0),
								},
							}):Play()
							tw({
								v = SearchBoxTextBox,
								t = 0.2,
								s = "Quad",
								d = "Out",
								g = {
									Size = UDim2.new(0, 0, 0, 28),
								},
							}):Play()
							tw({
								v = ArrowIconImageLabel,
								t = 0.25,
								s = "Quad",
								d = "Out",
								g = {
									Rotation = 0,
								},
							}):Play()
							tw({
								v = DropdownFrameStroke,
								t = 0.25,
								s = "Quad",
								d = "Out",
								g = {
									Transparency = 0.75,
								},
							}):Play()
							task.spawn(function()
								task.wait(0.25)

								if not isOpen then
									DropdownMenuFrame.Visible = false
								end

								isAnimating = false
							end)
						end
						openDropdown = function()
							if isAnimating or isOpen then
								return
							end

							isAnimating = true
							isOpen = true
							DropdownMenuFrame.Visible = true
							SearchBoxTextBox.Text = ""
							tw({
								v = DropdownMenuFrame,
								t = 0.3,
								s = "Back",
								d = "Out",
								g = {
									Size = UDim2.new(0, 240, 1, 0),
								},
							}):Play()
							tw({
								v = SearchBoxTextBox,
								t = 0.25,
								s = "Back",
								d = "Out",
								g = {
									Size = UDim2.new(0.9, 0, 0, 28),
								},
							}):Play()
							tw({
								v = ArrowIconImageLabel,
								t = 0.3,
								s = "Back",
								d = "Out",
								g = {
									Rotation = 180,
								},
							}):Play()
							tw({
								v = DropdownFrameStroke,
								t = 0.3,
								s = "Quad",
								d = "Out",
								g = {
									Transparency = 0.4,
								},
							}):Play()
							task.spawn(function()
								task.wait(0.3)
								isAnimating = false
							end)
						end
						ClickDropdownTextButton.Name = "ClickDropdown"
						ClickDropdownTextButton.Parent = DropdownFrame
						ClickDropdownTextButton.BackgroundTransparency = 1
						ClickDropdownTextButton.Size = UDim2.new(1, 0, 1, 0)
						ClickDropdownTextButton.Position = UDim2.new(0, 0, 0, 0)
						ClickDropdownTextButton.BorderSizePixel = 0
						ClickDropdownTextButton.AutoButtonColor = false
						ClickDropdownTextButton.ZIndex = 10
						ClickDropdownTextButton.Text = ""
						ClickDropdownTextButton.MouseButton1Click:Connect(function()
							if isAnimating then
								return
							end

							if isOpen then
								closeDropdown()
							else
								openDropdown()
							end

							EffectClick2(ClickDropdownTextButton, DropdownFrame)
						end)
						connection = nil
						listenForOutsideClick = function()
							if connection then
								connection:Disconnect()
								connection = nil
							end

							connection = UserInputService.InputBegan:Connect(function(input)
								if not isOpen or isAnimating then
									return
								end

								if
									input.UserInputType == Enum.UserInputType.MouseButton1
									or input.UserInputType == Enum.UserInputType.Touch
								then
									local mouseLocation = UserInputService:GetMouseLocation()
									local AbsolutePosition = DropdownMenuFrame.AbsolutePosition
									local AbsoluteSize = DropdownMenuFrame.AbsoluteSize
									local absolutePosition = DropdownFrame.AbsolutePosition
									local absoluteSize = DropdownFrame.AbsoluteSize

									if
										not (
											mouseLocation.X >= AbsolutePosition.X
												and mouseLocation.X <= AbsolutePosition.X + AbsoluteSize.X
												and mouseLocation.Y >= AbsolutePosition.Y
												and mouseLocation.Y <= AbsolutePosition.Y + AbsoluteSize.Y
											or mouseLocation.X >= absolutePosition.X
												and mouseLocation.X <= absolutePosition.X + absoluteSize.X
												and mouseLocation.Y >= absolutePosition.Y
												and mouseLocation.Y <= absolutePosition.Y + absoluteSize.Y
										)
									then
										closeDropdown()
									end
								end
							end)
						end
						SearchBoxTextBox:GetPropertyChangedSignal("Text"):Connect(function()
							local lowered = string.lower(SearchBoxTextBox.Text)

							for _, child in pairs(MenuScrollScrollingFrame:GetChildren()) do
								if child:IsA("Frame") and child.Name == "Item" then
									local ItemTitle = child:FindFirstChild("ItemTitle")

									if ItemTitle then
										local loweredB = string.lower(ItemTitle.Text)

										child.Visible = lowered == "" or string.find(loweredB, lowered, 1, true) ~= nil
									end
								end
							end
						end)
						SearchBoxTextBox.Focused:Connect(function()
							tw({
								v = SearchBoxTextBoxStroke,
								t = 0.3,
								s = "Quad",
								d = "Out",
								g = {
									Transparency = 0.3,
								},
							}):Play()
						end)
						SearchBoxTextBox.FocusLost:Connect(function()
							tw({
								v = SearchBoxTextBoxStroke,
								t = 0.3,
								s = "Quad",
								d = "Out",
								g = {
									Transparency = 0.7,
								},
							}):Play()
						end)
						addItem = function(text)
							local ItemFrame = Instance.new("Frame")
							local ItemFrameCorner = Instance.new("UICorner")
							local ItemTitleTextLabel = Instance.new("TextLabel")
							local IndicatorFrame = Instance.new("Frame")
							local IndicatorFrameCorner = Instance.new("UICorner")
							local IndicatorFrameGradient = Instance.new("UIGradient")

							ItemFrame.Name = "Item"
							ItemFrame.Parent = MenuScrollScrollingFrame
							ItemFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
							ItemFrame.BackgroundTransparency = 0.4
							ItemFrame.Size = UDim2.new(1, 0, 0, 32)
							ItemFrame.ZIndex = 102
							ItemFrameCorner.Parent = ItemFrame
							ItemFrameCorner.CornerRadius = UDim.new(0, 8)
							ItemTitleTextLabel.Name = "ItemTitle"
							ItemTitleTextLabel.Parent = ItemFrame
							ItemTitleTextLabel.BackgroundTransparency = 1
							ItemTitleTextLabel.Position = UDim2.new(0, 12, 0, 0)
							ItemTitleTextLabel.Size = UDim2.new(1, -44, 1, 0)
							ItemTitleTextLabel.Font = Enum.Font.GothamBold
							ItemTitleTextLabel.Text = text
							ItemTitleTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
							ItemTitleTextLabel.TextSize = 13
							ItemTitleTextLabel.TextTransparency = selectedValues[text] and 0 or 0.5
							ItemTitleTextLabel.TextXAlignment = Enum.TextXAlignment.Left
							ItemTitleTextLabel.TextScaled = true
							ItemTitleTextLabel.TextWrapped = true
							ItemTitleTextLabel.ZIndex = 103

							local ItemTitleTextLabelTextConstraint = Instance.new("UITextSizeConstraint")

							ItemTitleTextLabelTextConstraint.Parent = ItemTitleTextLabel
							ItemTitleTextLabelTextConstraint.MaxTextSize = 13
							ItemTitleTextLabelTextConstraint.MinTextSize = 9
							IndicatorFrame.Name = "Indicator"
							IndicatorFrame.Parent = ItemFrame
							IndicatorFrame.AnchorPoint = Vector2.new(0, 0.5)
							IndicatorFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
							IndicatorFrame.Position = UDim2.new(0, 0, 0.5, 0)
							IndicatorFrame.Size = UDim2.new(0, selectedValues[text] and 4 or 0, 0, 32)
							IndicatorFrame.BackgroundTransparency = selectedValues[text] and 0 or 1
							IndicatorFrame.ZIndex = 102
							IndicatorFrameCorner.Parent = IndicatorFrame
							IndicatorFrameCorner.CornerRadius = UDim.new(1, 0)
							IndicatorFrameGradient.Parent = IndicatorFrame
							IndicatorFrameGradient.Color = ColorSequence.new({
								ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
								ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 170, 255)),
								ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)),
							})
							IndicatorFrameGradient.Rotation = 90

							local ClickTextButton = Instance.new("TextButton")

							ClickTextButton.Name = "Click"
							ClickTextButton.Parent = ItemFrame
							ClickTextButton.BackgroundTransparency = 1
							ClickTextButton.BorderSizePixel = 0
							ClickTextButton.Size = UDim2.new(1, 0, 1, 0)
							ClickTextButton.Position = UDim2.new(0, 0, 0, 0)
							ClickTextButton.ZIndex = 120
							ClickTextButton.AutoButtonColor = false
							ClickTextButton.Font = Enum.Font.SourceSans
							ClickTextButton.Text = ""
							ClickTextButton.MouseEnter:Connect(function()
								tw({
									v = ItemFrame,
									t = 0.2,
									s = "Quad",
									d = "Out",
									g = {
										BackgroundTransparency = 0.2,
									},
								}):Play()
							end)
							ClickTextButton.MouseLeave:Connect(function()
								tw({
									v = ItemFrame,
									t = 0.2,
									s = "Quad",
									d = "Out",
									g = {
										BackgroundTransparency = 0.4,
									},
								}):Play()
							end)
							ClickTextButton.MouseButton1Click:Connect(function()
								EffectClick2(ClickTextButton, ItemFrame)

								if Multi then
									selectedValues[text] = not selectedValues[text]

									local items, task_

									if selectedValues[text] then
										tw({
											v = ItemTitleTextLabel,
											t = 0.2,
											s = "Quad",
											d = "Out",
											g = {
												TextTransparency = 0,
											},
										}):Play()
										tw({
											v = IndicatorFrame,
											t = 0.2,
											s = "Back",
											d = "Out",
											g = {
												Size = UDim2.new(0, 4, 0, 32),
												BackgroundTransparency = 0,
											},
										}):Play()
										items = {}

										for k, v in pairs(selectedValues) do
											if v then
												table.insert(items, k)
											end
										end

										updateDisplayText()
										task_ = task
									else
										tw({
											v = ItemTitleTextLabel,
											t = 0.2,
											s = "Quad",
											d = "Out",
											g = {
												TextTransparency = 0.5,
											},
										}):Play()
										tw({
											v = IndicatorFrame,
											t = 0.2,
											s = "Back",
											d = "Out",
											g = {
												Size = UDim2.new(0, 0, 0, 32),
												BackgroundTransparency = 1,
											},
										}):Play()
										items = {}

										for k, v in pairs(selectedValues) do
											if v then
												table.insert(items, k)
											end
										end

										updateDisplayText()
										task_ = task
									end

									task_.spawn(function()
										pcall(Callback, items)
									end)
								else
									for k in pairs(selectedValues) do
										selectedValues[k] = false
									end

									selectedValues[text] = true

									for _, child in pairs(MenuScrollScrollingFrame:GetChildren()) do
										if child:IsA("Frame") and child.Name == "Item" then
											local ItemTitle = child:FindFirstChild("ItemTitle")
											local Indicator = child:FindFirstChild("Indicator")

											if ItemTitle and Indicator then
												tw({
													v = ItemTitle,
													t = 0.2,
													s = "Quad",
													d = "Out",
													g = {
														TextTransparency = 0.5,
													},
												}):Play()
												tw({
													v = Indicator,
													t = 0.2,
													s = "Back",
													d = "Out",
													g = {
														Size = UDim2.new(0, 0, 0, 32),
														BackgroundTransparency = 1,
													},
												}):Play()
											end
										end
									end

									tw({
										v = ItemTitleTextLabel,
										t = 0.2,
										s = "Quad",
										d = "Out",
										g = {
											TextTransparency = 0,
										},
									}):Play()
									tw({
										v = IndicatorFrame,
										t = 0.2,
										s = "Back",
										d = "Out",
										g = {
											Size = UDim2.new(0, 4, 0, 32),
											BackgroundTransparency = 0,
										},
									}):Play()
									updateDisplayText()
									task.spawn(function()
										pcall(Callback, text)
									end)
									task.wait(0.15)
									closeDropdown()
								end
							end)
						end

						for _, v in pairs(List) do
							addItem(v)
						end

						updateDisplayText()
						listenForOutsideClick()
						table.insert(SearchItems, {
							Frame = DropdownFrame,
							SearchName = TitleB,
							HighlightFrame = HighlightFrameB,
						})
						DropdownFrame.Destroying:Connect(function()
							if connection then
								connection:Disconnect()
								connection = nil
							end

							if DropdownMenuFrame then
								DropdownMenuFrame:Destroy()
							end
						end)
						dropdownApi = {
							Add = function(self, item)
								if not table.find(List, item) then
									table.insert(List, item)
									addItem(item)
								end
							end,
							Remove = function(self, item)
								for k, v in pairs(List) do
									if v == item then
										table.remove(List, k)

										break
									end
								end

								for _, child in pairs(MenuScrollScrollingFrame:GetChildren()) do
									if child:IsA("Frame") and child.Name == "Item" then
										local ItemTitle = child:FindFirstChild("ItemTitle")

										if ItemTitle and ItemTitle.Text == item then
											child:Destroy()

											break
										end
									end
								end

								selectedValues[item] = nil
								updateDisplayText()
							end,
							Clear = function()
								for _, child in pairs(MenuScrollScrollingFrame:GetChildren()) do
									if child:IsA("Frame") and child.Name == "Item" then
										child:Destroy()
									end
								end

								List = {}
								selectedValues = {}
								updateDisplayText()
							end,
							SetValue = function(self, value)
								selectedValues = {}

								local valueB, valueC, valueD, ItemTitle, Indicator, tween, tweenB, tweenC, tweenD

								if type(value) == "table" then
									local iterator, iterTable, iterKey = pairs(value)
									local iteratorB = geniter(iterator, iterTable, iterKey)

									for _, v in iterator, iterTable, iterKey do
										while true do
											selectedValues[v] = true

											local packed = table.pack(iteratorB())

											if not packed[1] then
												break
											end

											v = packed[3]
										end

										local iterator, iterTable, iterKey = pairs(MenuScrollScrollingFrame:GetChildren())

										for _, entry in iterator, iterTable, iterKey do
											if entry:IsA("Frame") and entry.Name == "Item" then
												local child = entry:FindFirstChild("ItemTitle")
												local childB = entry:FindFirstChild("Indicator")

												if child and childB then
													if selectedValues[child.Text] then
														tw({
															v = child,
															t = 0.2,
															s = "Quad",
															d = "Out",
															g = {
																TextTransparency = 0,
															},
														}):Play()
														tw({
															v = childB,
															t = 0.2,
															s = "Back",
															d = "Out",
															g = {
																Size = UDim2.new(0, 4, 0, 32),
																BackgroundTransparency = 0,
															},
														}):Play()
													else
														tw({
															v = child,
															t = 0.2,
															s = "Quad",
															d = "Out",
															g = {
																TextTransparency = 0.5,
															},
														}):Play()
														tw({
															v = childB,
															t = 0.2,
															s = "Back",
															d = "Out",
															g = {
																Size = UDim2.new(0, 0, 0, 32),
																BackgroundTransparency = 1,
															},
														}):Play()
													end
												end
											end
										end

										updateDisplayText()

										return
									end

									valueB, valueC, valueD = pairs(MenuScrollScrollingFrame:GetChildren())

									for _, v in valueB, valueC, valueD do
										if v:IsA("Frame") and v.Name == "Item" then
											ItemTitle = v:FindFirstChild("ItemTitle")
											Indicator = v:FindFirstChild("Indicator")

											if ItemTitle and Indicator then
												if selectedValues[ItemTitle.Text] then
													tween = tw({
														v = ItemTitle,
														t = 0.2,
														s = "Quad",
														d = "Out",
														g = {
															TextTransparency = 0,
														},
													})
													tween:Play()
													tweenB = tw({
														v = Indicator,
														t = 0.2,
														s = "Back",
														d = "Out",
														g = {
															Size = UDim2.new(0, 4, 0, 32),
															BackgroundTransparency = 0,
														},
													})
													tweenB:Play()
												else
													tweenC = tw({
														v = ItemTitle,
														t = 0.2,
														s = "Quad",
														d = "Out",
														g = {
															TextTransparency = 0.5,
														},
													})
													tweenC:Play()
													tweenD = tw({
														v = Indicator,
														t = 0.2,
														s = "Back",
														d = "Out",
														g = {
															Size = UDim2.new(0, 0, 0, 32),
															BackgroundTransparency = 1,
														},
													})
													tweenD:Play()
												end
											end
										end
									end
								elseif type(value) == "string" and value ~= "" then
									selectedValues[value] = true
									valueB, valueC, valueD = pairs(MenuScrollScrollingFrame:GetChildren())

									for _, v in valueB, valueC, valueD do
										if v:IsA("Frame") and v.Name == "Item" then
											ItemTitle = v:FindFirstChild("ItemTitle")
											Indicator = v:FindFirstChild("Indicator")

											if ItemTitle and Indicator then
												if selectedValues[ItemTitle.Text] then
													tween = tw({
														v = ItemTitle,
														t = 0.2,
														s = "Quad",
														d = "Out",
														g = {
															TextTransparency = 0,
														},
													})
													tween:Play()
													tweenB = tw({
														v = Indicator,
														t = 0.2,
														s = "Back",
														d = "Out",
														g = {
															Size = UDim2.new(0, 4, 0, 32),
															BackgroundTransparency = 0,
														},
													})
													tweenB:Play()
												else
													tweenC = tw({
														v = ItemTitle,
														t = 0.2,
														s = "Quad",
														d = "Out",
														g = {
															TextTransparency = 0.5,
														},
													})
													tweenC:Play()
													tweenD = tw({
														v = Indicator,
														t = 0.2,
														s = "Back",
														d = "Out",
														g = {
															Size = UDim2.new(0, 0, 0, 32),
															BackgroundTransparency = 1,
														},
													})
													tweenD:Play()
												end
											end
										end
									end
								else
									valueB, valueC, valueD = pairs(MenuScrollScrollingFrame:GetChildren())

									for _, v in valueB, valueC, valueD do
										if v:IsA("Frame") and v.Name == "Item" then
											ItemTitle = v:FindFirstChild("ItemTitle")
											Indicator = v:FindFirstChild("Indicator")

											if ItemTitle and Indicator then
												if selectedValues[ItemTitle.Text] then
													tw({
														v = ItemTitle,
														t = 0.2,
														s = "Quad",
														d = "Out",
														g = {
															TextTransparency = 0,
														},
													}):Play()
													tw({
														v = Indicator,
														t = 0.2,
														s = "Back",
														d = "Out",
														g = {
															Size = UDim2.new(0, 4, 0, 32),
															BackgroundTransparency = 0,
														},
													}):Play()
												else
													tw({
														v = ItemTitle,
														t = 0.2,
														s = "Quad",
														d = "Out",
														g = {
															TextTransparency = 0.5,
														},
													}):Play()
													tw({
														v = Indicator,
														t = 0.2,
														s = "Back",
														d = "Out",
														g = {
															Size = UDim2.new(0, 0, 0, 32),
															BackgroundTransparency = 1,
														},
													}):Play()
												end
											end
										end
									end
								end

								updateDisplayText()
							end,
							GetValue = function()
								if not Multi then
									for k, v in pairs(selectedValues) do
										if v then
											return k
										end
									end

									return nil
								end

								local items = {}

								for k, v in pairs(selectedValues) do
									if v then
										table.insert(items, k)
									end
								end

								return items
							end,
							SetTitle = function(self, text)
								TitleTextLabel.Text = text
								TitleTextLabelB.Text = text

								for _, v in pairs(SearchItems) do
									if v.Frame == DropdownFrame then
										v.SearchName = text

										break
									end
								end
							end,
							SetDesc = function(self, text)
								if DescTextLabel then
									DescTextLabel.Text = text
								end
							end,
							Visible = function(self, visible)
								DropdownFrame.Visible = visible

								if not visible and isOpen then
									closeDropdown()
								end
							end,
						}
					end
				end
			end

			dropdownApi.SetList = function(self, list)
				for _, child in pairs(MenuScrollScrollingFrame:GetChildren()) do
					if child:IsA("Frame") and child.Name == "Item" then
						child:Destroy()
					end
				end

				List = list or {}

				for _, v in pairs(List) do
					addItem(v)
				end

				updateDisplayText()
			end
			dropdownApi.Refresh = function()
				for _, child in pairs(MenuScrollScrollingFrame:GetChildren()) do
					if child:IsA("Frame") and child.Name == "Item" then
						local ItemTitle = child:FindFirstChild("ItemTitle")
						local Indicator = child:FindFirstChild("Indicator")

						if ItemTitle and Indicator then
							if selectedValues[ItemTitle.Text] then
								ItemTitle.TextTransparency = 0
								Indicator.Size = UDim2.new(0, 4, 0, 32)
								Indicator.BackgroundTransparency = 0
							else
								ItemTitle.TextTransparency = 0.5
								Indicator.Size = UDim2.new(0, 0, 0, 32)
								Indicator.BackgroundTransparency = 1
							end
						end
					end
				end

				updateDisplayText()
			end

			return dropdownApi
		end
		Library.Elements.Dialog = function(self, options)
			local TitleB = options.Title or "Dialog"
			local DescB = options.Desc or nil
			local Side = options.Side or "l"
			local IconB = options.Icon or nil
			local DialogTitle = options.DialogTitle or "Confirmation"
			local DialogContent = options.DialogContent or "Are you sure?"
			local Buttons = options.Buttons
				or {
					{
						Title = "Cancel",
						Callback = function() end,
					},
					{
						Title = "Confirm",
						Callback = function() end,
					},
				}

			number += 1
			BadgeLabelTextLabel.Text = tostring(number)
			tw({
				v = BadgeFrame,
				t = 0.3,
				s = "Back",
				d = "Out",
				g = {
					Size = UDim2.new(0, math.max(32, #tostring(number) * 10 + 12), 0, 18),
				},
			}):Play()

			local DialogOverlayFrame = Instance.new("Frame")
			local DialogBoxFrame = Instance.new("Frame")
			local DialogBoxFrameCorner = Instance.new("UICorner")
			local DialogBoxFrameStroke = Instance.new("UIStroke")
			local ShadowImageLabel = Instance.new("ImageLabel")
			local BackgroundFrame = Instance.new("Frame")
			local BackgroundFrameCorner = Instance.new("UICorner")
			local BackgroundFrameGradient = Instance.new("UIGradient")
			local DialogTitleTextLabel = Instance.new("TextLabel")
			local DialogContentTextLabel = Instance.new("TextLabel")
			local ButtonContainerFrame = Instance.new("Frame")
			local ButtonContainerFrameListLayout = Instance.new("UIListLayout")

			DialogOverlayFrame.Name = "DialogOverlay"
			DialogOverlayFrame.Parent = ScreenGui
			DialogOverlayFrame.AnchorPoint = Vector2.new(0.5, 0.5)
			DialogOverlayFrame.BackgroundTransparency = 1
			DialogOverlayFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
			DialogOverlayFrame.Size = UDim2.new(1, 0, 1, 0)
			DialogOverlayFrame.Visible = false
			DialogOverlayFrame.ZIndex = 2000
			DialogBoxFrame.Name = "DialogBox"
			DialogBoxFrame.Parent = DialogOverlayFrame
			DialogBoxFrame.AnchorPoint = Vector2.new(0.5, 0.5)
			DialogBoxFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
			DialogBoxFrame.BackgroundTransparency = 0.05
			DialogBoxFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
			DialogBoxFrame.Size = UDim2.new(0, 0, 0, 0)
			DialogBoxFrame.ClipsDescendants = true
			DialogBoxFrame.ZIndex = 2001
			DialogBoxFrameCorner.Parent = DialogBoxFrame
			DialogBoxFrameCorner.CornerRadius = UDim.new(0, 16)
			DialogBoxFrameStroke.Parent = DialogBoxFrame
			DialogBoxFrameStroke.Color = Color3.fromRGB(100, 100, 130)
			DialogBoxFrameStroke.Thickness = 2.5
			DialogBoxFrameStroke.Transparency = 0.5
			ShadowImageLabel.Name = "Shadow"
			ShadowImageLabel.Parent = DialogBoxFrame
			ShadowImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
			ShadowImageLabel.BackgroundTransparency = 1
			ShadowImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
			ShadowImageLabel.Size = UDim2.new(1, 60, 1, 60)
			ShadowImageLabel.ZIndex = 2000
			ShadowImageLabel.Image = "rbxassetid://8992230677"
			ShadowImageLabel.ImageColor3 = Color3.fromRGB(0, 0, 0)
			ShadowImageLabel.ImageTransparency = 0.2
			ShadowImageLabel.ScaleType = Enum.ScaleType.Slice
			ShadowImageLabel.SliceCenter = Rect.new(99, 99, 99, 99)
			BackgroundFrame.Name = "Background"
			BackgroundFrame.Parent = DialogBoxFrame
			BackgroundFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			BackgroundFrame.BackgroundTransparency = 0.95
			BackgroundFrame.BorderSizePixel = 0
			BackgroundFrame.Size = UDim2.new(1, 0, 1, 0)
			BackgroundFrame.ZIndex = 2001
			BackgroundFrameCorner.Parent = BackgroundFrame
			BackgroundFrameCorner.CornerRadius = UDim.new(0, 16)
			BackgroundFrameGradient.Parent = BackgroundFrame
			BackgroundFrameGradient.Rotation = 45
			BackgroundFrameGradient.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
				ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 170, 255)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)),
			})
			DialogTitleTextLabel.Name = "DialogTitle"
			DialogTitleTextLabel.Parent = DialogBoxFrame
			DialogTitleTextLabel.BackgroundTransparency = 1
			DialogTitleTextLabel.Position = UDim2.new(0, 20, 0, 18)
			DialogTitleTextLabel.Size = UDim2.new(1, -40, 0, 28)
			DialogTitleTextLabel.Font = Enum.Font.GothamBold
			DialogTitleTextLabel.Text = DialogTitle
			DialogTitleTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			DialogTitleTextLabel.TextSize = 18
			DialogTitleTextLabel.TextXAlignment = Enum.TextXAlignment.Left
			DialogTitleTextLabel.ZIndex = 2002
			DialogContentTextLabel.Name = "DialogContent"
			DialogContentTextLabel.Parent = DialogBoxFrame
			DialogContentTextLabel.BackgroundTransparency = 1
			DialogContentTextLabel.Position = UDim2.new(0, 20, 0, 55)
			DialogContentTextLabel.Size = UDim2.new(1, -40, 0, 60)
			DialogContentTextLabel.Font = Enum.Font.Gotham
			DialogContentTextLabel.Text = DialogContent
			DialogContentTextLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
			DialogContentTextLabel.TextSize = 14
			DialogContentTextLabel.TextTransparency = 0.3
			DialogContentTextLabel.TextWrapped = true
			DialogContentTextLabel.TextXAlignment = Enum.TextXAlignment.Left
			DialogContentTextLabel.TextYAlignment = Enum.TextYAlignment.Top
			DialogContentTextLabel.ZIndex = 2002
			ButtonContainerFrame.Name = "ButtonContainer"
			ButtonContainerFrame.Parent = DialogBoxFrame
			ButtonContainerFrame.AnchorPoint = Vector2.new(0.5, 1)
			ButtonContainerFrame.BackgroundTransparency = 1
			ButtonContainerFrame.Position = UDim2.new(0.5, 0, 1, -15)
			ButtonContainerFrame.Size = UDim2.new(0.92, 0, 0, 40)
			ButtonContainerFrame.ZIndex = 2002
			ButtonContainerFrameListLayout.Parent = ButtonContainerFrame
			ButtonContainerFrameListLayout.FillDirection = Enum.FillDirection.Horizontal
			ButtonContainerFrameListLayout.Padding = UDim.new(0, 8)
			ButtonContainerFrameListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			ButtonContainerFrameListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
			ButtonContainerFrameListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

			local function CloseDialog()
				tw({
					v = DialogBoxFrame,
					t = 0.3,
					s = "Back",
					d = "In",
					g = {
						Size = UDim2.new(0, 0, 0, 0),
					},
				}):Play()
				task.wait(0.3)
				DialogOverlayFrame.Visible = false
			end
			local function FireDialog()
				DialogOverlayFrame.Visible = true
				tw({
					v = DialogBoxFrame,
					t = 0.4,
					s = "Back",
					d = "Out",
					g = {
						Size = UDim2.new(0, 350, 0, 180),
					},
				}):Play()
			end

			local ButtonFrame, TitleTextLabelB, HighlightFrameB, buttonFrameClick

			for k, v in ipairs(Buttons) do
				local DialogButtonTextButton = Instance.new("TextButton")
				local DialogButtonTextButtonCorner = Instance.new("UICorner")
				local DialogButtonTextButtonGradient = Instance.new("UIGradient")
				local amount = 1 / #Buttons - 8 * (#Buttons - 1) / #Buttons / 350
				DialogButtonTextButton.Name = "DialogButton" .. k
				DialogButtonTextButton.Parent = ButtonContainerFrame
				DialogButtonTextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				DialogButtonTextButton.BackgroundTransparency = 0.88
				DialogButtonTextButton.BorderSizePixel = 0
				DialogButtonTextButton.Size = UDim2.new(amount, 0, 1, 0)
				DialogButtonTextButton.Font = Enum.Font.GothamBold
				DialogButtonTextButton.Text = v.Title or "Button"
				DialogButtonTextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
				DialogButtonTextButton.TextSize = 14
				DialogButtonTextButton.TextScaled = true
				DialogButtonTextButton.TextWrapped = true
				DialogButtonTextButton.AutoButtonColor = false
				DialogButtonTextButton.ZIndex = 2003
				local DialogButtonTextButtonTextConstraint = Instance.new("UITextSizeConstraint")
				DialogButtonTextButtonTextConstraint.Parent = DialogButtonTextButton
				DialogButtonTextButtonTextConstraint.MaxTextSize = 14
				DialogButtonTextButtonTextConstraint.MinTextSize = 10
				DialogButtonTextButtonCorner.Parent = DialogButtonTextButton
				DialogButtonTextButtonCorner.CornerRadius = UDim.new(0, 8)
				DialogButtonTextButtonGradient.Parent = DialogButtonTextButton
				DialogButtonTextButtonGradient.Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
					ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 170, 255)),
					ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)),
				})
				DialogButtonTextButton.MouseEnter:Connect(function()
					tw({v = DialogButtonTextButton, t = 0.2, s = "Quad", d = "Out", g = {BackgroundTransparency = 0.8}}):Play()
				end)
				DialogButtonTextButton.MouseLeave:Connect(function()
					tw({v = DialogButtonTextButton, t = 0.2, s = "Quad", d = "Out", g = {BackgroundTransparency = 0.88}}):Play()
				end)
				DialogButtonTextButton.MouseButton1Click:Connect(function()
					EffectClick2(DialogButtonTextButton, DialogButtonTextButton)
					if v.Callback then
						pcall(v.Callback)
					end
					task.wait(0.15)
					CloseDialog()
				end)
			end

			do

				if not (IconB or DescB) then
					ButtonFrame = Instance.new("Frame")

					local ButtonFrameGradient = Instance.new("UIGradient")

					TitleTextLabelB = Instance.new("TextLabel")

					local ButtonFrameCorner = Instance.new("UICorner")
					local ButtonFrameImage = Instance.new("ImageLabel")
					local ButtonFrameStroke = Instance.new("UIStroke")

					HighlightFrameB = Instance.new("Frame")

					local HighlightFrameBCorner = Instance.new("UICorner")

					buttonFrameClick = click(ButtonFrame)
					ButtonFrame.Name = "Button"
					ButtonFrame.Parent = GetColumn(Side)
					ButtonFrame.AnchorPoint = Vector2.new(0.5, 0.5)
					ButtonFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					ButtonFrame.BorderSizePixel = 0
					ButtonFrame.Size = UDim2.new(0.97, 0, 0, 35)
					ButtonFrame.ClipsDescendants = true
					ButtonFrameGradient.Parent = ButtonFrame
					ButtonFrameGradient.Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
						ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 170, 255)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)),
					})
					ButtonFrameStroke.Parent = ButtonFrame
					ButtonFrameStroke.Color = Color3.fromRGB(255, 255, 255)
					ButtonFrameStroke.Thickness = 2
					ButtonFrameStroke.Transparency = 0.65
					HighlightFrameB.Name = "HighlightFrame"
					HighlightFrameB.Parent = ButtonFrame
					HighlightFrameB.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					HighlightFrameB.BackgroundTransparency = 1
					HighlightFrameB.Size = UDim2.new(1, 0, 1, 0)
					HighlightFrameB.ZIndex = 2
					HighlightFrameBCorner.CornerRadius = UDim.new(0, 10)
					HighlightFrameBCorner.Parent = HighlightFrameB
					TitleTextLabelB.Name = "Title"
					TitleTextLabelB.Parent = ButtonFrame
					TitleTextLabelB.AnchorPoint = Vector2.new(0.5, 0.5)
					TitleTextLabelB.BackgroundTransparency = 1
					TitleTextLabelB.Position = UDim2.new(0.5, 0, 0.5, 0)
					TitleTextLabelB.Size = UDim2.new(0.95, 0, 0.8, 0)
					TitleTextLabelB.Font = Enum.Font.GothamBold
					TitleTextLabelB.Text = TitleB
					TitleTextLabelB.TextColor3 = Color3.fromRGB(255, 255, 255)
					TitleTextLabelB.TextSize = 14
					TitleTextLabelB.TextScaled = true
					TitleTextLabelB.TextWrapped = true

					local TitleTextLabelBTextConstraint = Instance.new("UITextSizeConstraint")

					TitleTextLabelBTextConstraint.Parent = TitleTextLabelB
					TitleTextLabelBTextConstraint.MaxTextSize = 14
					TitleTextLabelBTextConstraint.MinTextSize = 10
					ButtonFrameCorner.Parent = ButtonFrame
					ButtonFrameCorner.CornerRadius = UDim.new(0, 10)
					ButtonFrameImage.Parent = ButtonFrame
					ButtonFrameImage.AnchorPoint = Vector2.new(0.5, 0.5)
					ButtonFrameImage.BackgroundTransparency = 1
					ButtonFrameImage.Position = UDim2.new(0.5, 0, 0.5, 0)
					ButtonFrameImage.Size = UDim2.new(1, 50, 1, 0)
					ButtonFrameImage.Image = "rbxassetid://72380279434385"
					ButtonFrameImage.ImageTransparency = 0.7
					ButtonFrameImage.ScaleType = Enum.ScaleType.Crop

					local MouseButton1Click = buttonFrameClick.MouseButton1Click

					MouseButton1Click:Connect(function()
						FireDialog()
						tw({
							v = ButtonFrame,
							t = 0.2,
							s = "Bounce",
							d = "Out",
							g = {
								Size = UDim2.new(0.9, 0, 0, 35),
							},
						}):Play()
						delay(0.08, function()
							tw({
								v = ButtonFrame,
								t = 0.2,
								s = "Bounce",
								d = "Out",
								g = {
									Size = UDim2.new(0.97, 0, 0, 35),
								},
							}):Play()
						end)
						EffectClick(buttonFrameClick, ButtonFrame)
					end)
					table.insert(SearchItems, {
						Frame = ButtonFrame,
						SearchName = TitleB,
						HighlightFrame = HighlightFrameB,
					})

					return {
						Fire = function()
							FireDialog()
						end,
						UpdateTitle = function(self, text)
							TitleTextLabelB.Text = text

							for _, entry in pairs(SearchItems) do
								if entry.Frame == ButtonFrame then
									entry.SearchName = text

									break
								end
							end
						end,
						UpdateDialogTitle = function(self, text)
							DialogTitleTextLabel.Text = text
						end,
						UpdateDialogContent = function(self, text)
							DialogContentTextLabel.Text = text
						end,
						Visible = function(self, visible)
							ButtonFrame.Visible = visible
						end,
						Close = function()
							CloseDialog()
						end,
					}
				end

				local ButtonImageFrame = Instance.new("Frame")
				local TitleTextLabel = Instance.new("TextLabel")
				local ButtonImageFrameCorner = Instance.new("UICorner")
				local ButtonImageFrameImage = Instance.new("ImageLabel")
				local ButtonImageFrameImageGradient = Instance.new("UIGradient")
				local iconImageLabel = Instance.new("ImageLabel")
				local DescTextLabel = Instance.new("TextLabel")
				local nextImageLabel = Instance.new("ImageLabel")
				local ButtonImageFrameStroke = Instance.new("UIStroke")
				local HighlightFrameB = Instance.new("Frame")
				local HighlightFrameBCorner = Instance.new("UICorner")
				local buttonImageFrameClick = click(ButtonImageFrame)

				ButtonImageFrame.Name = "ButtonImage"
				ButtonImageFrame.Parent = GetColumn(Side)
				ButtonImageFrame.AnchorPoint = Vector2.new(0.5, 0.5)
				ButtonImageFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
				ButtonImageFrame.BackgroundTransparency = 0.35
				ButtonImageFrame.BorderSizePixel = 0
				ButtonImageFrame.Size = UDim2.new(0.97, 0, 0, 55)
				ButtonImageFrame.ClipsDescendants = true
				ButtonImageFrameStroke.Parent = ButtonImageFrame
				ButtonImageFrameStroke.Color = Color3.fromRGB(110, 110, 140)
				ButtonImageFrameStroke.Thickness = 2
				ButtonImageFrameStroke.Transparency = 0.75
				HighlightFrameB.Name = "HighlightFrame"
				HighlightFrameB.Parent = ButtonImageFrame
				HighlightFrameB.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				HighlightFrameB.BackgroundTransparency = 1
				HighlightFrameB.Size = UDim2.new(1, 0, 1, 0)
				HighlightFrameB.ZIndex = 2
				HighlightFrameBCorner.CornerRadius = UDim.new(0, 12)
				HighlightFrameBCorner.Parent = HighlightFrameB
				TitleTextLabel.Name = "Title"
				TitleTextLabel.Parent = ButtonImageFrame
				TitleTextLabel.AnchorPoint = Vector2.new(0, 0.5)
				TitleTextLabel.BackgroundTransparency = 1
				TitleTextLabel.Position = UDim2.new(0, 55, 0.35, 0)
				TitleTextLabel.Size = UDim2.new(0.65, 0, 0, 18)
				TitleTextLabel.Font = Enum.Font.GothamBold
				TitleTextLabel.RichText = true
				TitleTextLabel.Text = TitleB
				TitleTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
				TitleTextLabel.TextSize = 14
				TitleTextLabel.TextXAlignment = Enum.TextXAlignment.Left
				TitleTextLabel.TextScaled = true
				TitleTextLabel.TextWrapped = true

				local TitleTextLabelTextConstraint = Instance.new("UITextSizeConstraint")

				TitleTextLabelTextConstraint.Parent = TitleTextLabel
				TitleTextLabelTextConstraint.MaxTextSize = 14
				TitleTextLabelTextConstraint.MinTextSize = 10
				ButtonImageFrameCorner.Parent = ButtonImageFrame
				ButtonImageFrameCorner.CornerRadius = UDim.new(0, 12)
				ButtonImageFrameImage.Parent = ButtonImageFrame
				ButtonImageFrameImage.AnchorPoint = Vector2.new(0.5, 0.5)
				ButtonImageFrameImage.BackgroundTransparency = 1
				ButtonImageFrameImage.Position = UDim2.new(0.5, 0, 0.5, 0)
				ButtonImageFrameImage.Size = UDim2.new(1, 50, 1, 0)
				ButtonImageFrameImage.Image = "rbxassetid://72380279434385"
				ButtonImageFrameImage.ImageTransparency = 0.85
				ButtonImageFrameImage.ScaleType = Enum.ScaleType.Crop
				ButtonImageFrameImageGradient.Parent = ButtonImageFrameImage
				ButtonImageFrameImageGradient.Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
					ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 170, 255)),
					ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)),
				})
				iconImageLabel.Name = "icon"
				iconImageLabel.Parent = ButtonImageFrame
				iconImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
				iconImageLabel.BackgroundTransparency = 1
				iconImageLabel.Position = UDim2.new(0, 27, 0.5, 0)
				iconImageLabel.Size = UDim2.new(0, 38, 0, 38)
				iconImageLabel.Image = GetIcon(IconB)
				iconImageLabel.ScaleType = Enum.ScaleType.Fit
				DescTextLabel.Name = "Desc"
				DescTextLabel.Parent = ButtonImageFrame
				DescTextLabel.AnchorPoint = Vector2.new(0, 0.5)
				DescTextLabel.BackgroundTransparency = 1
				DescTextLabel.Position = UDim2.new(0, 55, 0.68, 0)
				DescTextLabel.Size = UDim2.new(0.65, 0, 0, 15)
				DescTextLabel.Font = Enum.Font.GothamBold
				DescTextLabel.RichText = true
				DescTextLabel.Text = DescB
				DescTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
				DescTextLabel.TextSize = 11
				DescTextLabel.TextTransparency = 0.4
				DescTextLabel.TextXAlignment = Enum.TextXAlignment.Left
				DescTextLabel.TextScaled = true
				DescTextLabel.TextWrapped = true

				local DescTextLabelTextConstraint = Instance.new("UITextSizeConstraint")

				DescTextLabelTextConstraint.Parent = DescTextLabel
				DescTextLabelTextConstraint.MaxTextSize = 11
				DescTextLabelTextConstraint.MinTextSize = 8
				nextImageLabel.Name = "next"
				nextImageLabel.Parent = ButtonImageFrame
				nextImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
				nextImageLabel.BackgroundTransparency = 1
				nextImageLabel.Position = UDim2.new(1, -16, 0.5, 0)
				nextImageLabel.Size = UDim2.new(0, 20, 0, 20)
				nextImageLabel.Image = "rbxassetid://108028847031522"
				nextImageLabel.ScaleType = Enum.ScaleType.Fit
				buttonImageFrameClick.MouseButton1Click:Connect(function()
					FireDialog()
					tw({
						v = nextImageLabel,
						t = 0.2,
						s = "Bounce",
						d = "Out",
						g = {
							Position = UDim2.new(1, -12, 0.5, 0),
						},
					}):Play()
					delay(0.08, function()
						tw({
							v = nextImageLabel,
							t = 0.2,
							s = "Bounce",
							d = "Out",
							g = {
								Position = UDim2.new(1, -16, 0.5, 0),
							},
						}):Play()
					end)
					EffectClick2(buttonImageFrameClick, ButtonImageFrame)
				end)
				table.insert(SearchItems, {
					Frame = ButtonImageFrame,
					SearchName = TitleB,
					HighlightFrame = HighlightFrameB,
				})

				local items = {
					Fire = function()
						FireDialog()
					end,
					Title = function(self, text)
						TitleTextLabel.Text = text

						for _, entry in pairs(SearchItems) do
							if entry.Frame == ButtonImageFrame then
								entry.SearchName = text

								break
							end
						end
					end,
					Desc = function(self, text)
						DescTextLabel.Text = text
					end,
					Icon = function(self, arg)
						iconImageLabel.Image = GetIcon(arg)
					end,
					UpdateDialogTitle = function(self, text)
						DialogTitleTextLabel.Text = text
					end,
					UpdateDialogContent = function(self, text)
						DialogContentTextLabel.Text = text
					end,
					Visible = function(self, visible)
						ButtonImageFrame.Visible = visible
					end,
				}
				local text = "Close"

				items[text] = function()
					CloseDialog()
				end

				return items
			end

			if not (IconB or DescB) then
				ButtonFrame = Instance.new("Frame")

				local ButtonFrameGradient = Instance.new("UIGradient")

				TitleTextLabelB = Instance.new("TextLabel")

				local ButtonFrameCorner = Instance.new("UICorner")
				local ButtonFrameImage = Instance.new("ImageLabel")
				local ButtonFrameStroke = Instance.new("UIStroke")

				HighlightFrameB = Instance.new("Frame")

				local HighlightFrameBCorner = Instance.new("UICorner")

				buttonFrameClick = click(ButtonFrame)
				ButtonFrame.Name = "Button"
				ButtonFrame.Parent = GetColumn(Side)
				ButtonFrame.AnchorPoint = Vector2.new(0.5, 0.5)
				ButtonFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ButtonFrame.BorderSizePixel = 0
				ButtonFrame.Size = UDim2.new(0.97, 0, 0, 35)
				ButtonFrame.ClipsDescendants = true
				ButtonFrameGradient.Parent = ButtonFrame
				ButtonFrameGradient.Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
					ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 170, 255)),
					ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)),
				})
				ButtonFrameStroke.Parent = ButtonFrame
				ButtonFrameStroke.Color = Color3.fromRGB(255, 255, 255)
				ButtonFrameStroke.Thickness = 2
				ButtonFrameStroke.Transparency = 0.65
				HighlightFrameB.Name = "HighlightFrame"
				HighlightFrameB.Parent = ButtonFrame
				HighlightFrameB.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				HighlightFrameB.BackgroundTransparency = 1
				HighlightFrameB.Size = UDim2.new(1, 0, 1, 0)
				HighlightFrameB.ZIndex = 2
				HighlightFrameBCorner.CornerRadius = UDim.new(0, 10)
				HighlightFrameBCorner.Parent = HighlightFrameB
				TitleTextLabelB.Name = "Title"
				TitleTextLabelB.Parent = ButtonFrame
				TitleTextLabelB.AnchorPoint = Vector2.new(0.5, 0.5)
				TitleTextLabelB.BackgroundTransparency = 1
				TitleTextLabelB.Position = UDim2.new(0.5, 0, 0.5, 0)
				TitleTextLabelB.Size = UDim2.new(0.95, 0, 0.8, 0)
				TitleTextLabelB.Font = Enum.Font.GothamBold
				TitleTextLabelB.Text = TitleB
				TitleTextLabelB.TextColor3 = Color3.fromRGB(255, 255, 255)
				TitleTextLabelB.TextSize = 14
				TitleTextLabelB.TextScaled = true
				TitleTextLabelB.TextWrapped = true

				local TitleTextLabelBTextConstraint = Instance.new("UITextSizeConstraint")

				TitleTextLabelBTextConstraint.Parent = TitleTextLabelB
				TitleTextLabelBTextConstraint.MaxTextSize = 14
				TitleTextLabelBTextConstraint.MinTextSize = 10
				ButtonFrameCorner.Parent = ButtonFrame
				ButtonFrameCorner.CornerRadius = UDim.new(0, 10)
				ButtonFrameImage.Parent = ButtonFrame
				ButtonFrameImage.AnchorPoint = Vector2.new(0.5, 0.5)
				ButtonFrameImage.BackgroundTransparency = 1
				ButtonFrameImage.Position = UDim2.new(0.5, 0, 0.5, 0)
				ButtonFrameImage.Size = UDim2.new(1, 50, 1, 0)
				ButtonFrameImage.Image = "rbxassetid://72380279434385"
				ButtonFrameImage.ImageTransparency = 0.7
				ButtonFrameImage.ScaleType = Enum.ScaleType.Crop
				buttonFrameClick.MouseButton1Click:Connect(function()
					FireDialog()
					tw({
						v = ButtonFrame,
						t = 0.2,
						s = "Bounce",
						d = "Out",
						g = {
							Size = UDim2.new(0.9, 0, 0, 35),
						},
					}):Play()
					delay(0.08, function()
						tw({
							v = ButtonFrame,
							t = 0.2,
							s = "Bounce",
							d = "Out",
							g = {
								Size = UDim2.new(0.97, 0, 0, 35),
							},
						}):Play()
					end)
					EffectClick(buttonFrameClick, ButtonFrame)
				end)
				table.insert(SearchItems, {
					Frame = ButtonFrame,
					SearchName = TitleB,
					HighlightFrame = HighlightFrameB,
				})

				return {
					Fire = function()
						FireDialog()
					end,
					UpdateTitle = function(self, text)
						TitleTextLabelB.Text = text

						for _, v in pairs(SearchItems) do
							if v.Frame == ButtonFrame then
								v.SearchName = text

								break
							end
						end
					end,
					UpdateDialogTitle = function(self, text)
						DialogTitleTextLabel.Text = text
					end,
					UpdateDialogContent = function(self, text)
						DialogContentTextLabel.Text = text
					end,
					Visible = function(self, visible)
						ButtonFrame.Visible = visible
					end,
					Close = function()
						CloseDialog()
					end,
				}
			end

			local ButtonImageFrame = Instance.new("Frame")
			local TitleTextLabel = Instance.new("TextLabel")
			local ButtonImageFrameCorner = Instance.new("UICorner")
			local ButtonImageFrameImage = Instance.new("ImageLabel")
			local ButtonImageFrameImageGradient = Instance.new("UIGradient")
			local iconImageLabel = Instance.new("ImageLabel")
			local DescTextLabel = Instance.new("TextLabel")
			local nextImageLabel = Instance.new("ImageLabel")
			local ButtonImageFrameStroke = Instance.new("UIStroke")
			local HighlightFrameB = Instance.new("Frame")
			local HighlightFrameBCorner = Instance.new("UICorner")
			local buttonImageFrameClick = click(ButtonImageFrame)

			ButtonImageFrame.Name = "ButtonImage"
			ButtonImageFrame.Parent = GetColumn(Side)
			ButtonImageFrame.AnchorPoint = Vector2.new(0.5, 0.5)
			ButtonImageFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
			ButtonImageFrame.BackgroundTransparency = 0.35
			ButtonImageFrame.BorderSizePixel = 0
			ButtonImageFrame.Size = UDim2.new(0.97, 0, 0, 55)
			ButtonImageFrame.ClipsDescendants = true
			ButtonImageFrameStroke.Parent = ButtonImageFrame
			ButtonImageFrameStroke.Color = Color3.fromRGB(110, 110, 140)
			ButtonImageFrameStroke.Thickness = 2
			ButtonImageFrameStroke.Transparency = 0.75
			HighlightFrameB.Name = "HighlightFrame"
			HighlightFrameB.Parent = ButtonImageFrame
			HighlightFrameB.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			HighlightFrameB.BackgroundTransparency = 1
			HighlightFrameB.Size = UDim2.new(1, 0, 1, 0)
			HighlightFrameB.ZIndex = 2
			HighlightFrameBCorner.CornerRadius = UDim.new(0, 12)
			HighlightFrameBCorner.Parent = HighlightFrameB
			TitleTextLabel.Name = "Title"
			TitleTextLabel.Parent = ButtonImageFrame
			TitleTextLabel.AnchorPoint = Vector2.new(0, 0.5)
			TitleTextLabel.BackgroundTransparency = 1
			TitleTextLabel.Position = UDim2.new(0, 55, 0.35, 0)
			TitleTextLabel.Size = UDim2.new(0.65, 0, 0, 18)
			TitleTextLabel.Font = Enum.Font.GothamBold
			TitleTextLabel.RichText = true
			TitleTextLabel.Text = TitleB
			TitleTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			TitleTextLabel.TextSize = 14
			TitleTextLabel.TextXAlignment = Enum.TextXAlignment.Left
			TitleTextLabel.TextScaled = true
			TitleTextLabel.TextWrapped = true

			local TitleTextLabelTextConstraint = Instance.new("UITextSizeConstraint")

			TitleTextLabelTextConstraint.Parent = TitleTextLabel
			TitleTextLabelTextConstraint.MaxTextSize = 14
			TitleTextLabelTextConstraint.MinTextSize = 10
			ButtonImageFrameCorner.Parent = ButtonImageFrame
			ButtonImageFrameCorner.CornerRadius = UDim.new(0, 12)
			ButtonImageFrameImage.Parent = ButtonImageFrame
			ButtonImageFrameImage.AnchorPoint = Vector2.new(0.5, 0.5)
			ButtonImageFrameImage.BackgroundTransparency = 1
			ButtonImageFrameImage.Position = UDim2.new(0.5, 0, 0.5, 0)
			ButtonImageFrameImage.Size = UDim2.new(1, 50, 1, 0)
			ButtonImageFrameImage.Image = "rbxassetid://72380279434385"
			ButtonImageFrameImage.ImageTransparency = 0.85
			ButtonImageFrameImage.ScaleType = Enum.ScaleType.Crop
			ButtonImageFrameImageGradient.Parent = ButtonImageFrameImage
			ButtonImageFrameImageGradient.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 255, 127)),
				ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 170, 255)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(85, 85, 255)),
			})
			iconImageLabel.Name = "icon"
			iconImageLabel.Parent = ButtonImageFrame
			iconImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
			iconImageLabel.BackgroundTransparency = 1
			iconImageLabel.Position = UDim2.new(0, 27, 0.5, 0)
			iconImageLabel.Size = UDim2.new(0, 38, 0, 38)
			iconImageLabel.Image = GetIcon(IconB)
			iconImageLabel.ScaleType = Enum.ScaleType.Fit
			DescTextLabel.Name = "Desc"
			DescTextLabel.Parent = ButtonImageFrame
			DescTextLabel.AnchorPoint = Vector2.new(0, 0.5)
			DescTextLabel.BackgroundTransparency = 1
			DescTextLabel.Position = UDim2.new(0, 55, 0.68, 0)
			DescTextLabel.Size = UDim2.new(0.65, 0, 0, 15)
			DescTextLabel.Font = Enum.Font.GothamBold
			DescTextLabel.RichText = true
			DescTextLabel.Text = DescB
			DescTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			DescTextLabel.TextSize = 11
			DescTextLabel.TextTransparency = 0.4
			DescTextLabel.TextXAlignment = Enum.TextXAlignment.Left
			DescTextLabel.TextScaled = true
			DescTextLabel.TextWrapped = true

			local DescTextLabelTextConstraint = Instance.new("UITextSizeConstraint")

			DescTextLabelTextConstraint.Parent = DescTextLabel
			DescTextLabelTextConstraint.MaxTextSize = 11
			DescTextLabelTextConstraint.MinTextSize = 8
			nextImageLabel.Name = "next"
			nextImageLabel.Parent = ButtonImageFrame
			nextImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
			nextImageLabel.BackgroundTransparency = 1
			nextImageLabel.Position = UDim2.new(1, -16, 0.5, 0)
			nextImageLabel.Size = UDim2.new(0, 20, 0, 20)
			nextImageLabel.Image = "rbxassetid://108028847031522"
			nextImageLabel.ScaleType = Enum.ScaleType.Fit
			buttonImageFrameClick.MouseButton1Click:Connect(function()
				FireDialog()
				tw({
					v = nextImageLabel,
					t = 0.2,
					s = "Bounce",
					d = "Out",
					g = {
						Position = UDim2.new(1, -12, 0.5, 0),
					},
				}):Play()
				delay(0.08, function()
					tw({
						v = nextImageLabel,
						t = 0.2,
						s = "Bounce",
						d = "Out",
						g = {
							Position = UDim2.new(1, -16, 0.5, 0),
						},
					}):Play()
				end)
				EffectClick2(buttonImageFrameClick, ButtonImageFrame)
			end)
			table.insert(SearchItems, {
				Frame = ButtonImageFrame,
				SearchName = TitleB,
				HighlightFrame = HighlightFrameB,
			})

			return {
				Fire = function()
					FireDialog()
				end,
				Title = function(self, text)
					TitleTextLabel.Text = text

					for _, v in pairs(SearchItems) do
						if v.Frame == ButtonImageFrame then
							v.SearchName = text

							break
						end
					end
				end,
				Desc = function(self, text)
					DescTextLabel.Text = text
				end,
				Icon = function(self, arg)
					iconImageLabel.Image = GetIcon(arg)
				end,
				UpdateDialogTitle = function(self, text)
					DialogTitleTextLabel.Text = text
				end,
				UpdateDialogContent = function(self, text)
					DialogContentTextLabel.Text = text
				end,
				Visible = function(self, visible)
					ButtonImageFrame.Visible = visible
				end,
				Close = function()
					CloseDialog()
				end,
			}
		end

		return Library.Elements
	end

	return Library.Tabs
end

return Library
