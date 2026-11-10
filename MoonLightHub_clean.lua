-- discord.gg/syncrypt

local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

if CoreGui:FindFirstChild("MoonLightHub_UI_V9") then
	CoreGui.MoonLightHub_UI_V9:Destroy()
end

local function createWindow(_, title, version)
	local ScreenGui = Instance.new("ScreenGui")

	ScreenGui.Name = "MoonLightHub_UI_V9"
	ScreenGui.Parent = CoreGui
	ScreenGui.ResetOnSpawn = false
	game:GetService("GuiService")

	local function isMobile()
		UserInputService:GetConnectedGamepads()

		return UserInputService.TouchEnabled and not UserInputService.MouseEnabled
	end
	local function getViewportSize()
		return workspace.CurrentCamera.ViewportSize
	end
	local function computeLayout()
		local viewport = getViewportSize()
		local X = viewport.X
		local Y = viewport.Y
		local mobile = isMobile()
		local value = mobile and 12 or 20
		local valueB = mobile and 14 or 24
		local maxWidth = X - value * 2
		local maxHeight = Y - valueB * 2
		local width, height, sidebarWidth, topBarHeight, textScale

		if mobile then
			width = math.clamp(X * 0.88, 280, math.min(540, maxWidth))
			height = math.clamp(Y * 0.76, 340, math.min(580, maxHeight))
			sidebarWidth = 58
			topBarHeight = 40
			textScale = math.clamp(width / 480, 0.72, 0.92)
		elseif X >= 1440 then
			width = math.clamp(X * 0.52, 720, math.min(960, maxWidth))
			height = math.clamp(Y * 0.62, 480, math.min(680, maxHeight))
			sidebarWidth = 180
			topBarHeight = 50
			textScale = math.clamp(width / 720, 1, 1.3)
		elseif X >= 1024 then
			width = math.clamp(X * 0.58, 620, math.min(800, maxWidth))
			height = math.clamp(Y * 0.64, 440, math.min(560, maxHeight))
			sidebarWidth = 175
			topBarHeight = 50
			textScale = 1
		else
			width = math.clamp(X * 0.78, 460, math.min(680, maxWidth))
			height = math.clamp(Y * 0.7, 360, math.min(520, maxHeight))
			sidebarWidth = 155
			topBarHeight = 50
			textScale = math.clamp(width / 520, 0.85, 1)
		end

		return math.floor(width), math.floor(height), math.floor(sidebarWidth), topBarHeight, textScale
	end

	local textScale = 1

	local function scaleText(self)
		return math.floor(self * textScale)
	end

	local textRegistry = {}

	local function registerText(self, baseB)
		table.insert(textRegistry, {
			obj = self,
			base = baseB
		})
		self.TextSize = scaleText(baseB)
	end
	local function applyTextScale(self)
		textScale = self

		for _, v in ipairs(textRegistry) do
			pcall(function()
				v.obj.TextSize = math.floor(v.base * self)
			end)
		end
	end

	local windowWidth, windowHeight, initialSidebarWidth, topBarHeight

	windowWidth, windowHeight, initialSidebarWidth, topBarHeight, textScale = computeLayout()

	local MainFrame = Instance.new("Frame")

	MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	MainFrame.Size = UDim2.new(0, windowWidth, 0, windowHeight)
	MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
	MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 20)
	MainFrame.BorderSizePixel = 0
	MainFrame.Parent = ScreenGui
	Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)
	Instance.new("UIStroke", MainFrame).Color = Color3.fromRGB(40, 40, 45)

	local sidebarWidth = initialSidebarWidth

	local function clampWindowToScreen()
		local value = getViewportSize()
		local valueB = isMobile()
		local valueC = valueB and 14 or 20
		local valueD = valueB and 16 or 24
		local amount = MainFrame.AbsoluteSize.X / 2
		local amountB = MainFrame.AbsoluteSize.Y / 2
		local amountC = value.X / 2
		local amountD = value.Y / 2
		local Offset = MainFrame.Position.Y.Offset
		local clamped = math.clamp(MainFrame.Position.X.Offset, -amountC + amount + valueC, amountC - amount - valueC)
		local clampedB = math.clamp(Offset, -amountD + amountB + valueD, amountD - amountB - valueD)

		MainFrame.Position = UDim2.new(0.5, clamped, 0.5, clampedB)
	end

	local ResizeHandle = Instance.new("TextButton")

	ResizeHandle.Size = UDim2.new(0, 20, 0, 20)
	ResizeHandle.Position = UDim2.new(1, -20, 1, -20)
	ResizeHandle.BackgroundTransparency = 1
	ResizeHandle.Text = ""
	ResizeHandle.TextColor3 = Color3.fromRGB(100, 100, 100)
	ResizeHandle.Font = Enum.Font.Gotham
	ResizeHandle.ZIndex = 100
	ResizeHandle.Visible = not isMobile()
	ResizeHandle.Parent = MainFrame

	local isResizing = false
	local Position
	local AbsoluteSize

	ResizeHandle.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			isResizing = true
			Position = input.Position
			AbsoluteSize = MainFrame.AbsoluteSize
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					isResizing = false
				end
			end)
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) and isResizing then
			local amount = input.Position - Position
			local value = isMobile()
			local valueB = getViewportSize()
			local valueC = value and 14 or 20
			local valueD = value and 16 or 24
			local valueE = value and 300 or 480
			local minimum = math.min(value and 560 or 1400, valueB.X - valueC * 2)
			local valueC = value and 320 or 320
			local min = math.min
			local valueF = value and 600
			local amountB = min(valueF or 950, valueB.Y - valueD * 2)
			local clamped = math.clamp(AbsoluteSize.X + amount.X, valueE, minimum)
			local clampedB = math.clamp(AbsoluteSize.Y + amount.Y, valueC, amountB)

			MainFrame.Size = UDim2.new(0, clamped, 0, clampedB)
			clampWindowToScreen()
		end
	end)

	local TopBar = Instance.new("Frame")

	TopBar.Size = UDim2.new(1, 0, 0, topBarHeight)
	TopBar.BackgroundTransparency = 1
	TopBar.Active = true
	TopBar.ZIndex = 5
	TopBar.Parent = MainFrame

	local mobile = isMobile()
	local buttonSize = mobile and 28 or 30
	local buttonOffset = -(buttonSize / 2)
	local TitleLabel = Instance.new("TextLabel")
	local number = 0

	TitleLabel.Size = UDim2.new(number, mobile and 100 or 120, 1, 0)
	TitleLabel.Position = UDim2.new(number, mobile and 12 or 20, 0, 0)
	TitleLabel.BackgroundTransparency = 1
	TitleLabel.Text = title or "Moon Light Hub"
	TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	TitleLabel.Font = Enum.Font.GothamBold
	TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
	TitleLabel.Parent = TopBar
	registerText(TitleLabel, mobile and 13 or 16)

	local VersionBadge = Instance.new("Frame")
	local number = 0

	VersionBadge.Size = UDim2.new(number, mobile and 70 or 90, 0, mobile and 18 or 22)
	VersionBadge.Position = UDim2.new(number, mobile and 110 or 130, 0.5, mobile and -9 or -11)
	VersionBadge.BackgroundColor3 = Color3.fromRGB(20, 35, 55)
	VersionBadge.Parent = TopBar
	Instance.new("UICorner", VersionBadge).CornerRadius = UDim.new(0, 4)
	Instance.new("UIStroke", VersionBadge).Color = Color3.fromRGB(0, 100, 200)

	local VersionLabel = Instance.new("TextLabel")

	VersionLabel.Size = UDim2.new(1, 0, 1, 0)
	VersionLabel.BackgroundTransparency = 1
	VersionLabel.Text = version or "v1.0.1"
	VersionLabel.TextColor3 = Color3.fromRGB(80, 170, 255)
	VersionLabel.Font = Enum.Font.GothamBold
	VersionLabel.Parent = VersionBadge
	registerText(VersionLabel, mobile and 9 or 11)

	local ArrowsLabel = Instance.new("TextLabel")

	ArrowsLabel.Size = UDim2.new(0, 200, 1, 0)
	ArrowsLabel.Position = UDim2.new(0, 230, 0, 0)
	ArrowsLabel.BackgroundTransparency = 1
	ArrowsLabel.RichText = true
	ArrowsLabel.Text = "<font color=\"#3282F6\">>></font> <font color=\"#3282F6\">>></font> <font color=\"#3282F6\">>></font> >> >> >>"
	ArrowsLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
	ArrowsLabel.Font = Enum.Font.GothamBold
	ArrowsLabel.TextXAlignment = Enum.TextXAlignment.Left
	ArrowsLabel.Visible = not mobile
	ArrowsLabel.Parent = TopBar
	registerText(ArrowsLabel, 14)

	local MinimizeButton = Instance.new("TextButton")

	MinimizeButton.Size = UDim2.new(0, buttonSize, 0, buttonSize)
	MinimizeButton.Position = UDim2.new(1, -(buttonSize * 2 + 14), 0.5, buttonOffset)
	MinimizeButton.BackgroundTransparency = 1
	MinimizeButton.Text = "—"
	MinimizeButton.TextColor3 = Color3.fromRGB(150, 150, 150)
	MinimizeButton.Font = Enum.Font.GothamBold
	MinimizeButton.Parent = TopBar
	registerText(MinimizeButton, mobile and 12 or 14)
	MinimizeButton.MouseEnter:Connect(function()
		TweenService:Create(MinimizeButton, TweenInfo.new(0.2), {
			TextColor3 = Color3.fromRGB(255, 255, 255)
		}):Play()
	end)
	MinimizeButton.MouseLeave:Connect(function()
		TweenService:Create(MinimizeButton, TweenInfo.new(0.2), {
			TextColor3 = Color3.fromRGB(150, 150, 150)
		}):Play()
	end)

	local CloseButton = Instance.new("TextButton")

	CloseButton.Size = UDim2.new(0, buttonSize, 0, buttonSize)
	CloseButton.Position = UDim2.new(1, -(buttonSize + 8), 0.5, buttonOffset)
	CloseButton.BackgroundTransparency = 1
	CloseButton.Text = "✕"
	CloseButton.TextColor3 = Color3.fromRGB(150, 150, 150)
	CloseButton.Font = Enum.Font.GothamBold
	CloseButton.Parent = TopBar
	registerText(CloseButton, mobile and 12 or 14)
	CloseButton.MouseEnter:Connect(function()
		TweenService:Create(CloseButton, TweenInfo.new(0.2), {
			TextColor3 = Color3.fromRGB(255, 60, 60)
		}):Play()
	end)
	CloseButton.MouseLeave:Connect(function()
		TweenService:Create(CloseButton, TweenInfo.new(0.2), {
			TextColor3 = Color3.fromRGB(150, 150, 150)
		}):Play()
	end)
	CloseButton.MouseButton1Click:Connect(function()
		ScreenGui:Destroy()
	end)

	local isWindowVisible = true
	local ToggleButton = Instance.new("ImageButton")
	local buttonDiameter = isMobile() and 42 or 46

	ToggleButton.Size = UDim2.new(0, buttonDiameter, 0, buttonDiameter)

	if isMobile() then
		ToggleButton.Position = UDim2.new(1, -(buttonDiameter + 12), 0, 12)
		ToggleButton.AnchorPoint = Vector2.new(0, 0)
	else
		ToggleButton.Position = UDim2.new(0, 14, 0.5, -23)
		ToggleButton.AnchorPoint = Vector2.new(0, 0.5)
	end

	ToggleButton.BackgroundColor3 = Color3.fromRGB(18, 18, 20)
	ToggleButton.BorderSizePixel = 0
	ToggleButton.Image = "rbxassetid://10734950309"
	ToggleButton.ImageColor3 = Color3.fromRGB(80, 160, 255)
	ToggleButton.ZIndex = 200
	ToggleButton.Parent = ScreenGui
	Instance.new("UICorner", ToggleButton).CornerRadius = UDim.new(1, 0)

	local ToggleButtonStroke = Instance.new("UIStroke")

	ToggleButtonStroke.Color = Color3.fromRGB(50, 130, 246)
	ToggleButtonStroke.Thickness = 1.5
	ToggleButtonStroke.Parent = ToggleButton
	ToggleButton.MouseEnter:Connect(function()
		TweenService:Create(ToggleButton, TweenInfo.new(0.2), {
			ImageColor3 = Color3.fromRGB(120, 200, 255),
			BackgroundColor3 = Color3.fromRGB(20, 80, 160)
		}):Play()
	end)
	ToggleButton.MouseLeave:Connect(function()
		TweenService:Create(ToggleButton, TweenInfo.new(0.2), {
			ImageColor3 = Color3.fromRGB(80, 160, 255),
			BackgroundColor3 = Color3.fromRGB(18, 18, 20)
		}):Play()
	end)

	local isToggling = false

	local function toggleWindow()
		if isToggling then
			return
		end

		isToggling = true
		isWindowVisible = not isWindowVisible

		if isWindowVisible then
			MainFrame.Visible = true
			MainFrame.Size = UDim2.new(0, 1, 0, 1)

			local value, valueB = computeLayout()
			local tween = TweenService:Create(MainFrame, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
				Size = UDim2.new(0, value, 0, valueB)
			})

			tween:Play()
			TweenService:Create(ToggleButton, TweenInfo.new(0.35, Enum.EasingStyle.Quint), {
				Rotation = 0,
				ImageColor3 = Color3.fromRGB(80, 160, 255)
			}):Play()
			tween.Completed:Connect(function()
				isToggling = false
			end)
		else
			local tween = TweenService:Create(MainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
				Size = UDim2.new(0, 1, 0, 1)
			})

			TweenService:Create(ToggleButton, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {
				Rotation = 90,
				ImageColor3 = Color3.fromRGB(200, 200, 200)
			}):Play()
			tween:Play()
			tween.Completed:Connect(function()
				MainFrame.Visible = false

				local value, valueB = computeLayout()

				MainFrame.Size = UDim2.new(0, value, 0, valueB)
				isToggling = false
			end)
		end
	end

	ToggleButton.MouseButton1Click:Connect(toggleWindow)
	MinimizeButton.MouseButton1Click:Connect(toggleWindow)
	UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if not gameProcessed then
			if input.KeyCode == Enum.KeyCode.RightControl then
				toggleWindow()
			end
		end
	end)

	local isDraggingToggle = false
	local position
	local positionB

	ToggleButton.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			isDraggingToggle = true
			position = input.Position
			positionB = ToggleButton.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					isDraggingToggle = false
				end
			end)
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if isDraggingToggle then
			if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
				local amount = input.Position - position
				local value = getViewportSize()
				local valueB = isMobile() and 42 or 46

				if isMobile() then
					local clamped = math.clamp(positionB.X.Offset + amount.X, 10, value.X - valueB - 10)
					local clampedB = math.clamp(positionB.Y.Offset + amount.Y, 10, value.Y - valueB - 10)

					ToggleButton.Position = UDim2.new(1, -(clamped + valueB), 0, clampedB)
				else
					local clamped = math.clamp(positionB.X.Offset + amount.X, 10, value.X - valueB - 10)
					local clampedB = math.clamp(positionB.Y.Offset + amount.Y, -value.Y / 2 + valueB, value.Y / 2 - valueB)

					ToggleButton.Position = UDim2.new(0, clamped, 0.5, clampedB)
				end
			end
		end
	end)

	local isDraggingWindow = false
	local vector = Vector2.zero
	local vectorB = Vector2.zero

	local function dragWindowTo(self)
		local amount = self - vector
		local value = getViewportSize()
		local valueB = isMobile()
		local valueC = valueB and 14 or 20
		local valueD = valueB and 16 or 24
		local amountB = MainFrame.AbsoluteSize.X / 2
		local amountC = MainFrame.AbsoluteSize.Y / 2
		local amountD = value.X / 2
		local amountE = value.Y / 2
		local clamped = math.clamp(vectorB.X + amount.X, -amountD + amountB + valueC, amountD - amountB - valueC)
		local clampedB = math.clamp(vectorB.Y + amount.Y, -amountE + amountC + valueD, amountE - amountC - valueD)

		MainFrame.Position = UDim2.new(0.5, clamped, 0.5, clampedB)
	end

	TopBar.InputBegan:Connect(function(input)
		local UserInputType = input.UserInputType

		if UserInputType == Enum.UserInputType.MouseButton1 or UserInputType == Enum.UserInputType.Touch then
			isDraggingWindow = true
			vector = Vector2.new(input.Position.X, input.Position.Y)
			vectorB = Vector2.new(MainFrame.Position.X.Offset, MainFrame.Position.Y.Offset)
		end
	end)
	TopBar.InputEnded:Connect(function(input)
		local UserInputType = input.UserInputType

		if UserInputType == Enum.UserInputType.MouseButton1 or UserInputType == Enum.UserInputType.Touch then
			isDraggingWindow = false
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		local UserInputType = input.UserInputType

		if isDraggingWindow then
			if UserInputType == Enum.UserInputType.MouseMovement or UserInputType == Enum.UserInputType.Touch then
				dragWindowTo(Vector2.new(input.Position.X, input.Position.Y))
			end
		end
	end)

	local TopLine = Instance.new("Frame")

	TopLine.Size = UDim2.new(1, 0, 0, 1)
	TopLine.Position = UDim2.new(0, 0, 0, topBarHeight)
	TopLine.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
	TopLine.BorderSizePixel = 0
	TopLine.Parent = MainFrame

	local SidebarDivider = Instance.new("Frame")

	SidebarDivider.Size = UDim2.new(0, 1, 1, -topBarHeight)
	SidebarDivider.Position = UDim2.new(0, sidebarWidth + 5, 0, topBarHeight)
	SidebarDivider.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
	SidebarDivider.BorderSizePixel = 0
	SidebarDivider.Parent = MainFrame

	local Sidebar = Instance.new("ScrollingFrame")

	Sidebar.Size = UDim2.new(0, sidebarWidth, 1, -topBarHeight)
	Sidebar.Position = UDim2.new(0, 0, 0, topBarHeight)
	Sidebar.BackgroundTransparency = 1
	Sidebar.BorderSizePixel = 0
	Sidebar.ScrollBarThickness = 0
	Sidebar.Parent = MainFrame

	local SidebarLayout = Instance.new("UIListLayout")

	SidebarLayout.Padding = UDim.new(0, 4)
	SidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
	SidebarLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	SidebarLayout.Parent = Sidebar

	local SidebarPadding = Instance.new("UIPadding")

	SidebarPadding.PaddingTop = UDim.new(0, isMobile() and 6 or 15)
	SidebarPadding.Parent = Sidebar

	local number = 0

	local function nextLayoutOrder()
		number += 1

		return number
	end

	local ContentContainer = Instance.new("Frame")

	ContentContainer.Size = UDim2.new(1, -(sidebarWidth + 6), 1, -topBarHeight)
	ContentContainer.Position = UDim2.new(0, sidebarWidth + 6, 0, topBarHeight)
	ContentContainer.BackgroundTransparency = 1
	ContentContainer.Parent = MainFrame

	workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
		local value, valueB, valueC, valueD, valueE = computeLayout()

		TweenService:Create(MainFrame, TweenInfo.new(0.35, Enum.EasingStyle.Quint), {
			Size = UDim2.new(0, value, 0, valueB)
		}):Play()
		clampWindowToScreen()
		sidebarWidth = valueC
		topBarHeight = valueD
		TopBar.Size = UDim2.new(1, 0, 0, valueD)
		TopLine.Position = UDim2.new(0, 0, 0, valueD)
		SidebarDivider.Size = UDim2.new(0, 1, 1, -valueD)
		SidebarDivider.Position = UDim2.new(0, valueC + 5, 0, valueD)
		Sidebar.Size = UDim2.new(0, valueC, 1, -valueD)
		Sidebar.Position = UDim2.new(0, 0, 0, valueD)
		ContentContainer.Size = UDim2.new(1, -(valueC + 6), 1, -valueD)
		ContentContainer.Position = UDim2.new(0, valueC + 6, 0, valueD)
		applyTextScale(valueE)
	end)

	local Window

	Window = {
		CurrentTab = nil,
		AllTabs = {},
		MakeTabSection = function(self, title)
			if isMobile() then
				return
			end

			local SidebarLabel = Instance.new("TextLabel")

			SidebarLabel.Size = UDim2.new(1, -30, 0, 20)
			SidebarLabel.BackgroundTransparency = 1
			SidebarLabel.Text = string.upper(title)
			SidebarLabel.TextColor3 = Color3.fromRGB(120, 120, 120)
			SidebarLabel.Font = Enum.Font.GothamBold
			SidebarLabel.TextXAlignment = Enum.TextXAlignment.Left
			SidebarLabel.LayoutOrder = nextLayoutOrder()
			SidebarLabel.Parent = Sidebar
			Instance.new("UIPadding", SidebarLabel).PaddingLeft = UDim.new(0, 5)
			registerText(SidebarLabel, 10)
		end,
		MakeTab = function(self, title, icon)
			local value = isMobile()
			local TabButton = Instance.new("TextButton")

			TabButton.Size = value and UDim2.new(1, -8, 0, 46) or UDim2.new(1, -20, 0, 40)
			TabButton.BackgroundTransparency = 1
			TabButton.Text = ""
			TabButton.LayoutOrder = nextLayoutOrder()
			TabButton.Parent = Sidebar

			local TabBackground = Instance.new("Frame")

			TabBackground.Size = UDim2.new(1, 0, 1, 0)
			TabBackground.BackgroundColor3 = Color3.fromRGB(25, 25, 28)
			TabBackground.Parent = TabButton
			Instance.new("UICorner", TabBackground).CornerRadius = UDim.new(0, value and 10 or 8)

			local TabGradient = Instance.new("UIGradient")

			TabGradient.Transparency = NumberSequence.new({
				NumberSequenceKeypoint.new(0, 0),
				NumberSequenceKeypoint.new(0.4, 1),
				NumberSequenceKeypoint.new(1, 1)
			})
			TabGradient.Parent = TabBackground
			TabGradient.Enabled = false

			local TabIndicator = Instance.new("Frame")

			TabIndicator.Size = UDim2.new(0, 3, 0.5, 0)
			TabIndicator.Position = UDim2.new(0, 0, 0.25, 0)
			TabIndicator.BackgroundColor3 = Color3.fromRGB(50, 130, 246)
			TabIndicator.Parent = TabBackground
			TabIndicator.Visible = false
			Instance.new("UICorner", TabIndicator).CornerRadius = UDim.new(1, 0)

			local valueB = 15

			if icon then
				local ImageLabel = Instance.new("ImageLabel")
				local valueC = value and 22 or 18

				ImageLabel.Size = UDim2.new(0, valueC, 0, valueC)
				ImageLabel.Position = value and UDim2.new(0.5, -math.floor(valueC / 2), 0.5, -math.floor(valueC / 2)) or UDim2.new(0, 11, 0.5, -9)
				ImageLabel.BackgroundTransparency = 1
				ImageLabel.Image = icon
				ImageLabel.ImageColor3 = Color3.fromRGB(150, 150, 150)
				ImageLabel.Parent = TabBackground
				valueB = value and 0 or 40
			end

			local TabBackgroundLabel = Instance.new("TextLabel")

			TabBackgroundLabel.Size = UDim2.new(1, -valueB, 1, 0)
			TabBackgroundLabel.Position = UDim2.new(0, valueB, 0, 0)
			TabBackgroundLabel.BackgroundTransparency = 1
			TabBackgroundLabel.Text = title
			TabBackgroundLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
			TabBackgroundLabel.Font = Enum.Font.GothamSemibold
			TabBackgroundLabel.TextXAlignment = Enum.TextXAlignment.Left
			TabBackgroundLabel.Visible = not value
			TabBackgroundLabel.Parent = TabBackground
			registerText(TabBackgroundLabel, 13)

			local TabContent = Instance.new("ScrollingFrame")

			TabContent.Size = UDim2.new(1, 0, 1, 0)
			TabContent.BackgroundTransparency = 1
			TabContent.ScrollBarThickness = 3
			TabContent.ScrollBarImageColor3 = Color3.fromRGB(50, 130, 246)
			TabContent.Visible = false
			TabContent.Parent = ContentContainer

			local TabContentLayout = Instance.new("UIListLayout")

			TabContentLayout.Padding = UDim.new(0, isMobile() and 6 or 10)
			TabContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
			TabContentLayout.Parent = TabContent

			local TabContentPadding = Instance.new("UIPadding")
			local value = isMobile() and 10 or 20

			TabContentPadding.PaddingLeft = UDim.new(0, value)
			TabContentPadding.PaddingRight = UDim.new(0, value)

			local number = 0

			TabContentPadding.PaddingTop = UDim.new(number, isMobile() and 8 or 15)
			TabContentPadding.PaddingBottom = UDim.new(number, isMobile() and 10 or 20)
			TabContentPadding.Parent = TabContent
			TabContentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
				TabContent.CanvasSize = UDim2.new(0, 0, 0, TabContentLayout.AbsoluteContentSize.Y + 30)
			end)
			table.insert(Window.AllTabs, {
				Btn = TabButton,
				Bg = TabBackground,
				Text = TabBackgroundLabel,
				Grad = TabGradient,
				Content = TabContent,
				Indicator = TabIndicator
			})

			local function selectTab()
				for _, allTab in ipairs(Window.AllTabs) do
					allTab.Content.Visible = false
					allTab.Grad.Enabled = false
					allTab.Indicator.Visible = false
					TweenService:Create(allTab.Bg, TweenInfo.new(0.2), {
						BackgroundColor3 = Color3.fromRGB(25, 25, 28)
					}):Play()
					TweenService:Create(allTab.Text, TweenInfo.new(0.2), {
						TextColor3 = Color3.fromRGB(150, 150, 150)
					}):Play()

					if allTab.Bg:FindFirstChildOfClass("ImageLabel") then
						TweenService:Create(allTab.Bg:FindFirstChildOfClass("ImageLabel"), TweenInfo.new(0.2), {
							ImageColor3 = Color3.fromRGB(150, 150, 150)
						}):Play()
					end
				end

				TabContent.Visible = true
				TabGradient.Enabled = true
				TabIndicator.Visible = true
				TweenService:Create(TabBackground, TweenInfo.new(0.2), {
					BackgroundColor3 = Color3.fromRGB(20, 80, 160)
				}):Play()
				TweenService:Create(TabBackgroundLabel, TweenInfo.new(0.2), {
					TextColor3 = Color3.fromRGB(255, 255, 255)
				}):Play()

				if TabBackground:FindFirstChildOfClass("ImageLabel") then
					TweenService:Create(TabBackground:FindFirstChildOfClass("ImageLabel"), TweenInfo.new(0.2), {
						ImageColor3 = Color3.fromRGB(255, 255, 255)
					}):Play()
				end
			end

			TabButton.MouseButton1Click:Connect(selectTab)

			if not Window.CurrentTab then
				Window.CurrentTab = TabContent
				selectTab()
			end

			local Frame
			local number = 0

			local function getRow(self)
				if not self then
					Frame = nil
					number = 0

					return TabContent
				end

				if not Frame or number >= 2 then
					Frame = Instance.new("Frame")
					Frame.Size = UDim2.new(1, 0, 0, 65)
					Frame.BackgroundTransparency = 1
					Frame.Parent = TabContent

					local FrameListLayout = Instance.new("UIListLayout")

					FrameListLayout.FillDirection = Enum.FillDirection.Horizontal
					FrameListLayout.Padding = UDim.new(0, 15)
					FrameListLayout.SortOrder = Enum.SortOrder.LayoutOrder
					FrameListLayout.Parent = Frame
					number = 0
				end

				number += 1

				return Frame
			end
			local function createIconBox(self, image)
				local SelfFrame = Instance.new("Frame")

				SelfFrame.Size = UDim2.new(0, 36, 0, 36)
				SelfFrame.Position = UDim2.new(0, 15, 0.5, -18)
				SelfFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
				SelfFrame.Parent = self
				Instance.new("UICorner", SelfFrame).CornerRadius = UDim.new(0, 8)
				Instance.new("UIStroke", SelfFrame).Color = Color3.fromRGB(65, 65, 70)

				local ImageLabel = Instance.new("ImageLabel")

				ImageLabel.Size = UDim2.new(0, 22, 0, 22)
				ImageLabel.Position = UDim2.new(0.5, -11, 0.5, -11)
				ImageLabel.BackgroundTransparency = 1
				ImageLabel.Image = image
				ImageLabel.Parent = SelfFrame

				return 65
			end

			return {
				AddContentSection = function(self, title)
					getRow(false)

					local TabContentLabel = Instance.new("TextLabel")

					TabContentLabel.Size = UDim2.new(1, 0, 0, 35)
					TabContentLabel.BackgroundTransparency = 1
					TabContentLabel.Text = title
					TabContentLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
					TabContentLabel.Font = Enum.Font.GothamBold
					TabContentLabel.TextXAlignment = Enum.TextXAlignment.Left
					TabContentLabel.Parent = TabContent
					registerText(TabContentLabel, 16)

					local TabContentLabelFrame = Instance.new("Frame")

					TabContentLabelFrame.Size = UDim2.new(1, 0, 0, 1)
					TabContentLabelFrame.Position = UDim2.new(0, 0, 1, -5)
					TabContentLabelFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
					TabContentLabelFrame.BorderSizePixel = 0
					TabContentLabelFrame.Parent = TabContentLabel
				end,
				AddBanner = function(self, title, description, image, inviteLink)
					getRow(false)

					local TabContentFrame = Instance.new("Frame")

					TabContentFrame.Size = UDim2.new(1, -5, 0, 140)
					TabContentFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
					TabContentFrame.ClipsDescendants = true
					TabContentFrame.Parent = TabContent
					Instance.new("UICorner", TabContentFrame).CornerRadius = UDim.new(0, 8)
					Instance.new("UIStroke", TabContentFrame).Color = Color3.fromRGB(50, 50, 55)

					local ImageLabel = Instance.new("ImageLabel")

					ImageLabel.Size = UDim2.new(1, 0, 0, 80)
					ImageLabel.Position = UDim2.new(0, 0, 0, 0)
					ImageLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
					ImageLabel.Image = image
					ImageLabel.ScaleType = Enum.ScaleType.Crop
					ImageLabel.Parent = TabContentFrame

					local TabContentFrameB = Instance.new("Frame")

					TabContentFrameB.Size = UDim2.new(1, 0, 0, 60)
					TabContentFrameB.Position = UDim2.new(0, 0, 0, 80)
					TabContentFrameB.BackgroundTransparency = 1
					TabContentFrameB.Parent = TabContentFrame

					local TabContentFrameBLabel = Instance.new("TextLabel")

					TabContentFrameBLabel.Size = UDim2.new(1, -120, 0, 20)
					TabContentFrameBLabel.Position = UDim2.new(0, 15, 0, 10)
					TabContentFrameBLabel.BackgroundTransparency = 1
					TabContentFrameBLabel.Text = title
					TabContentFrameBLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
					TabContentFrameBLabel.Font = Enum.Font.GothamBold
					TabContentFrameBLabel.TextXAlignment = Enum.TextXAlignment.Left
					TabContentFrameBLabel.Parent = TabContentFrameB
					registerText(TabContentFrameBLabel, 14)

					local TabContentFrameBLabel = Instance.new("TextLabel")

					TabContentFrameBLabel.Size = UDim2.new(1, -120, 0, 15)
					TabContentFrameBLabel.Position = UDim2.new(0, 15, 0, 30)
					TabContentFrameBLabel.BackgroundTransparency = 1
					TabContentFrameBLabel.Text = description
					TabContentFrameBLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
					TabContentFrameBLabel.Font = Enum.Font.Gotham
					TabContentFrameBLabel.TextXAlignment = Enum.TextXAlignment.Left
					TabContentFrameBLabel.Parent = TabContentFrameB
					registerText(TabContentFrameBLabel, 11)

					local TabContentFrameBButton = Instance.new("TextButton")

					TabContentFrameBButton.Size = UDim2.new(0, 90, 0, 32)
					TabContentFrameBButton.Position = UDim2.new(1, -105, 0.5, -16)
					TabContentFrameBButton.BackgroundColor3 = Color3.fromRGB(10, 190, 60)
					TabContentFrameBButton.Text = "Join"
					TabContentFrameBButton.TextColor3 = Color3.fromRGB(255, 255, 255)
					TabContentFrameBButton.Font = Enum.Font.GothamBold
					TabContentFrameBButton.Parent = TabContentFrameB
					registerText(TabContentFrameBButton, 13)
					Instance.new("UICorner", TabContentFrameBButton).CornerRadius = UDim.new(0, 6)
					TabContentFrameBButton.MouseButton1Click:Connect(function()
						if setclipboard then
							setclipboard(inviteLink)
							TabContentFrameBButton.Text = "Copied!"
							TabContentFrameBButton.BackgroundColor3 = Color3.fromRGB(0, 140, 40)
							task.wait(1.5)
							TabContentFrameBButton.Text = "Join"
							TabContentFrameBButton.BackgroundColor3 = Color3.fromRGB(10, 190, 60)
						else
							warn("Executor không hỗ trợ setclipboard!")
						end
					end)
				end,
				AddToggle = function(self, title, icon, default, halfWidth, callback)
					local enabled = default or false
					local row = getRow(halfWidth)
					local color = Color3.fromRGB(13, 30, 60)
					local colorB = Color3.fromRGB(24, 24, 28)
					local colorC = Color3.fromRGB(50, 130, 246)
					local colorD = Color3.fromRGB(45, 45, 50)
					local colorE = Color3.fromRGB(20, 60, 130)
					local colorF = Color3.fromRGB(35, 35, 40)
					local colorG = Color3.fromRGB(50, 130, 246)
					local colorH = Color3.fromRGB(50, 50, 55)
					local value = isMobile() and 55 or 65
					local RowButton = Instance.new("TextButton")

					RowButton.Size = halfWidth and UDim2.new(0.5, -7, 0, value) or UDim2.new(1, 0, 0, value)
					RowButton.BackgroundColor3 = enabled and color or colorB
					RowButton.Text = ""
					RowButton.AutoButtonColor = false
					RowButton.Parent = row
					Instance.new("UICorner", RowButton).CornerRadius = UDim.new(0, 8)

					local RowButtonStroke = Instance.new("UIStroke")

					RowButtonStroke.Color = enabled and colorC or colorD
					RowButtonStroke.Thickness = enabled and 1.5 or 1
					RowButtonStroke.Parent = RowButton

					local RowButtonFrame
					local ImageLabel
					local RowButtonFrameStroke
					local value = 15

					if icon and icon ~= "" then
						RowButtonFrame = Instance.new("Frame")
						RowButtonFrame.Size = UDim2.new(0, 36, 0, 36)
						RowButtonFrame.Position = UDim2.new(0, 15, 0.5, -18)
						RowButtonFrame.BackgroundColor3 = enabled and colorE or colorF
						RowButtonFrame.Parent = RowButton
						Instance.new("UICorner", RowButtonFrame).CornerRadius = UDim.new(0, 8)
						RowButtonFrameStroke = Instance.new("UIStroke")
						RowButtonFrameStroke.Color = enabled and colorC or Color3.fromRGB(65, 65, 70)
						RowButtonFrameStroke.Parent = RowButtonFrame
						ImageLabel = Instance.new("ImageLabel")
						ImageLabel.Size = UDim2.new(0, 22, 0, 22)
						ImageLabel.Position = UDim2.new(0.5, -11, 0.5, -11)
						ImageLabel.BackgroundTransparency = 1
						ImageLabel.Image = icon
						ImageLabel.ImageColor3 = enabled and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(180, 180, 180)
						ImageLabel.Parent = RowButtonFrame
						value = 65
					end

					local RowButtonLabel = Instance.new("TextLabel")

					RowButtonLabel.Size = UDim2.new(1, -value - 60, 0, 20)
					RowButtonLabel.Position = UDim2.new(0, value, 0.5, -15)
					RowButtonLabel.BackgroundTransparency = 1
					RowButtonLabel.Text = title
					RowButtonLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
					RowButtonLabel.Font = Enum.Font.GothamSemibold
					RowButtonLabel.TextXAlignment = Enum.TextXAlignment.Left
					RowButtonLabel.Parent = RowButton
					registerText(RowButtonLabel, 13)

					local RowButtonLabel = Instance.new("TextLabel")

					RowButtonLabel.Size = UDim2.new(1, -value - 60, 0, 15)
					RowButtonLabel.Position = UDim2.new(0, value, 0.5, 5)
					RowButtonLabel.BackgroundTransparency = 1
					RowButtonLabel.Text = enabled and "ACTIVE" or "DISABLE"
					RowButtonLabel.TextColor3 = enabled and colorC or Color3.fromRGB(100, 100, 100)
					RowButtonLabel.Font = Enum.Font.GothamBold
					RowButtonLabel.TextXAlignment = Enum.TextXAlignment.Left
					RowButtonLabel.Parent = RowButton
					registerText(RowButtonLabel, 11)

					local RowButtonFrameB = Instance.new("Frame")

					RowButtonFrameB.Size = UDim2.new(0, 44, 0, 22)
					RowButtonFrameB.Position = UDim2.new(1, -55, 0.5, -11)
					RowButtonFrameB.BackgroundColor3 = enabled and colorG or colorH
					RowButtonFrameB.Parent = RowButton
					Instance.new("UICorner", RowButtonFrameB).CornerRadius = UDim.new(1, 0)

					local RowButtonFrameBFrame = Instance.new("Frame")

					RowButtonFrameBFrame.Size = UDim2.new(0, 18, 0, 18)
					RowButtonFrameBFrame.Position = enabled and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9)
					RowButtonFrameBFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					RowButtonFrameBFrame.Parent = RowButtonFrameB
					Instance.new("UICorner", RowButtonFrameBFrame).CornerRadius = UDim.new(1, 0)

					local function setToggleState(self, arg)
						local tweenInfo = TweenInfo.new(arg or 0.3, Enum.EasingStyle.Quint)

						TweenService:Create(RowButton, tweenInfo, {
							BackgroundColor3 = self and color or colorB
						}):Play()
						TweenService:Create(RowButtonStroke, tweenInfo, {
							Color = self and colorC or colorD,
							Thickness = self and 1.5 or 1
						}):Play()
						TweenService:Create(RowButtonFrameB, tweenInfo, {
							BackgroundColor3 = self and colorG or colorH
						}):Play()
						TweenService:Create(RowButtonFrameBFrame, tweenInfo, {
							Position = self and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9)
						}):Play()
						RowButtonLabel.Text = self and "ACTIVE" or "DISABLE"
						TweenService:Create(RowButtonLabel, tweenInfo, {
							TextColor3 = self and colorC or Color3.fromRGB(100, 100, 100)
						}):Play()

						if RowButtonFrame then
							TweenService:Create(RowButtonFrame, tweenInfo, {
								BackgroundColor3 = self and colorE or colorF
							}):Play()
						end

						if RowButtonFrameStroke then
							TweenService:Create(RowButtonFrameStroke, tweenInfo, {
								Color = self and colorC or Color3.fromRGB(65, 65, 70)
							}):Play()
						end

						if ImageLabel then
							TweenService:Create(ImageLabel, tweenInfo, {
								ImageColor3 = self and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(180, 180, 180)
							}):Play()
						end
					end

					RowButton.MouseButton1Click:Connect(function()
						enabled = not enabled
						setToggleState(enabled, 0.3)
						callback(enabled)
					end)
				end,
				AddButton = function(self, title, icon, halfWidth, callback, description)
					local row = getRow(halfWidth)
					local value = isMobile() and 55 or 65
					local RowButton = Instance.new("TextButton")

					RowButton.Size = halfWidth and UDim2.new(0.5, -7, 0, value) or UDim2.new(1, 0, 0, value)
					RowButton.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
					RowButton.Text = ""
					RowButton.AutoButtonColor = false
					RowButton.Parent = row
					Instance.new("UICorner", RowButton).CornerRadius = UDim.new(0, 8)

					local RowButtonStroke = Instance.new("UIStroke")

					RowButtonStroke.Color = Color3.fromRGB(45, 45, 50)
					RowButtonStroke.Parent = RowButton

					local RowButtonFrame
					local ImageLabel
					local value = 15

					if icon and icon ~= "" then
						RowButtonFrame = Instance.new("Frame")
						RowButtonFrame.Size = UDim2.new(0, 36, 0, 36)
						RowButtonFrame.Position = UDim2.new(0, 15, 0.5, -18)
						RowButtonFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
						RowButtonFrame.Parent = RowButton
						Instance.new("UICorner", RowButtonFrame).CornerRadius = UDim.new(0, 8)
						Instance.new("UIStroke", RowButtonFrame).Color = Color3.fromRGB(65, 65, 70)
						ImageLabel = Instance.new("ImageLabel")
						ImageLabel.Size = UDim2.new(0, 22, 0, 22)
						ImageLabel.Position = UDim2.new(0.5, -11, 0.5, -11)
						ImageLabel.BackgroundTransparency = 1
						ImageLabel.Image = icon
						ImageLabel.ImageColor3 = Color3.fromRGB(180, 180, 180)
						ImageLabel.Parent = RowButtonFrame
						value = 65
					end

					local RowButtonImage = Instance.new("ImageLabel")

					RowButtonImage.Size = UDim2.new(0, 18, 0, 18)
					RowButtonImage.Position = UDim2.new(1, -32, 0.5, -9)
					RowButtonImage.BackgroundTransparency = 1
					RowButtonImage.Image = "rbxassetid://11293977931"
					RowButtonImage.ImageColor3 = Color3.fromRGB(90, 90, 95)
					RowButtonImage.Parent = RowButton

					local RowButtonLabel = Instance.new("TextLabel")

					RowButtonLabel.BackgroundTransparency = 1
					RowButtonLabel.Text = title
					RowButtonLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
					RowButtonLabel.Font = Enum.Font.GothamSemibold
					RowButtonLabel.TextXAlignment = Enum.TextXAlignment.Left

					if description and description ~= "" then
						RowButtonLabel.Size = UDim2.new(1, -value - 44, 0, 20)
						RowButtonLabel.Position = UDim2.new(0, value, 0.5, -15)
						RowButtonLabel.Parent = RowButton
						registerText(RowButtonLabel, 13)

						local RowButtonLabelB = Instance.new("TextLabel")

						RowButtonLabelB.Size = UDim2.new(1, -value - 44, 0, 15)
						RowButtonLabelB.Position = UDim2.new(0, value, 0.5, 5)
						RowButtonLabelB.BackgroundTransparency = 1
						RowButtonLabelB.Text = description
						RowButtonLabelB.TextColor3 = Color3.fromRGB(110, 110, 115)
						RowButtonLabelB.Font = Enum.Font.GothamMedium
						RowButtonLabelB.TextXAlignment = Enum.TextXAlignment.Left
						RowButtonLabelB.Parent = RowButton
						registerText(RowButtonLabelB, 11)
					else
						RowButtonLabel.Size = UDim2.new(1, -value - 44, 1, 0)
						RowButtonLabel.Position = UDim2.new(0, value, 0, 0)
						RowButtonLabel.Parent = RowButton
						registerText(RowButtonLabel, 13)
					end

					local tweenInfo = TweenInfo.new(0.12, Enum.EasingStyle.Quint)
					local tweenInfoB = TweenInfo.new(0.2, Enum.EasingStyle.Quint)

					RowButton.MouseEnter:Connect(function()
						TweenService:Create(RowButton, tweenInfoB, {
							BackgroundColor3 = Color3.fromRGB(30, 30, 36)
						}):Play()
						TweenService:Create(RowButtonStroke, tweenInfoB, {
							Color = Color3.fromRGB(65, 65, 75)
						}):Play()
						TweenService:Create(RowButtonImage, tweenInfoB, {
							ImageColor3 = Color3.fromRGB(50, 130, 246)
						}):Play()

						if RowButtonFrame then
							TweenService:Create(RowButtonFrame, tweenInfoB, {
								BackgroundColor3 = Color3.fromRGB(28, 50, 90)
							}):Play()
						end

						if ImageLabel then
							TweenService:Create(ImageLabel, tweenInfoB, {
								ImageColor3 = Color3.fromRGB(255, 255, 255)
							}):Play()
						end
					end)
					RowButton.MouseLeave:Connect(function()
						TweenService:Create(RowButton, tweenInfoB, {
							BackgroundColor3 = Color3.fromRGB(24, 24, 28)
						}):Play()
						TweenService:Create(RowButtonStroke, tweenInfoB, {
							Color = Color3.fromRGB(45, 45, 50)
						}):Play()
						TweenService:Create(RowButtonImage, tweenInfoB, {
							ImageColor3 = Color3.fromRGB(90, 90, 95)
						}):Play()

						if RowButtonFrame then
							TweenService:Create(RowButtonFrame, tweenInfoB, {
								BackgroundColor3 = Color3.fromRGB(35, 35, 40)
							}):Play()
						end

						if ImageLabel then
							TweenService:Create(ImageLabel, tweenInfoB, {
								ImageColor3 = Color3.fromRGB(180, 180, 180)
							}):Play()
						end
					end)
					RowButton.MouseButton1Down:Connect(function()
						TweenService:Create(RowButton, tweenInfo, {
							BackgroundColor3 = Color3.fromRGB(18, 40, 80)
						}):Play()
						TweenService:Create(RowButtonStroke, tweenInfo, {
							Color = Color3.fromRGB(50, 130, 246)
						}):Play()
					end)
					RowButton.MouseButton1Up:Connect(function()
						TweenService:Create(RowButton, tweenInfo, {
							BackgroundColor3 = Color3.fromRGB(30, 30, 36)
						}):Play()
						TweenService:Create(RowButtonStroke, tweenInfo, {
							Color = Color3.fromRGB(65, 65, 75)
						}):Play()
					end)
					RowButton.MouseButton1Click:Connect(callback)
				end,
				AddDropdown = function(self, title, options, halfWidth, callback)
					local isOpen = false
					local row = getRow(halfWidth)
					local select = options and options[1] or "Trống"
					local RowButton = Instance.new("TextButton")

					RowButton.Size = halfWidth and UDim2.new(0.5, -7, 0, 65) or UDim2.new(1, 0, 0, 65)
					RowButton.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
					RowButton.Text = ""
					RowButton.Parent = row
					Instance.new("UICorner", RowButton).CornerRadius = UDim.new(0, 8)
					Instance.new("UIStroke", RowButton).Color = Color3.fromRGB(45, 45, 50)

					local value = createIconBox(RowButton, "rbxassetid://10881958866")
					local RowButtonLabel = Instance.new("TextLabel")

					RowButtonLabel.Size = UDim2.new(0.5, -value, 0, 20)
					RowButtonLabel.Position = UDim2.new(0, value, 0.5, -15)
					RowButtonLabel.BackgroundTransparency = 1
					RowButtonLabel.Text = title
					RowButtonLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
					RowButtonLabel.Font = Enum.Font.GothamSemibold
					RowButtonLabel.TextXAlignment = Enum.TextXAlignment.Left
					RowButtonLabel.Parent = RowButton
					registerText(RowButtonLabel, 13)

					local RowButtonLabel = Instance.new("TextLabel")

					RowButtonLabel.Size = UDim2.new(0.5, -value, 0, 15)
					RowButtonLabel.Position = UDim2.new(0, value, 0.5, 5)
					RowButtonLabel.BackgroundTransparency = 1
					RowButtonLabel.Text = "Select: " .. select
					RowButtonLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
					RowButtonLabel.Font = Enum.Font.GothamMedium
					RowButtonLabel.TextXAlignment = Enum.TextXAlignment.Left
					RowButtonLabel.Parent = RowButton
					registerText(RowButtonLabel, 11)

					local RowButtonLabelB = Instance.new("TextLabel")

					RowButtonLabelB.Size = UDim2.new(0, 20, 0, 20)
					RowButtonLabelB.Position = UDim2.new(1, -30, 0.5, -10)
					RowButtonLabelB.BackgroundTransparency = 1
					RowButtonLabelB.Text = "▼"
					RowButtonLabelB.TextColor3 = Color3.fromRGB(150, 150, 150)
					RowButtonLabelB.Font = Enum.Font.GothamBold
					RowButtonLabelB.Parent = RowButton
					registerText(RowButtonLabelB, 12)

					local MainFrameB = Instance.new("Frame")

					MainFrameB.BackgroundColor3 = Color3.fromRGB(32, 32, 36)
					MainFrameB.Size = UDim2.new(0, 0, 0, 0)
					MainFrameB.Visible = false
					MainFrameB.ZIndex = 100
					MainFrameB.ClipsDescendants = true
					MainFrameB.Parent = MainFrame
					Instance.new("UICorner", MainFrameB).CornerRadius = UDim.new(0, 8)
					Instance.new("UIStroke", MainFrameB).Color = Color3.fromRGB(60, 60, 65)

					local MainFrameBScroller = Instance.new("ScrollingFrame")

					MainFrameBScroller.Size = UDim2.new(1, 0, 1, -10)
					MainFrameBScroller.Position = UDim2.new(0, 0, 0, 5)
					MainFrameBScroller.BackgroundTransparency = 1
					MainFrameBScroller.ScrollBarThickness = 2
					MainFrameBScroller.ScrollBarImageColor3 = Color3.fromRGB(50, 130, 246)
					MainFrameBScroller.ZIndex = 101
					MainFrameBScroller.Parent = MainFrameB

					local MainFrameBScrollerListLayout = Instance.new("UIListLayout")

					MainFrameBScrollerListLayout.SortOrder = Enum.SortOrder.LayoutOrder
					MainFrameBScrollerListLayout.Padding = UDim.new(0, 4)
					MainFrameBScrollerListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
					MainFrameBScrollerListLayout.Parent = MainFrameBScroller
					TabContent:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
						if isOpen then
							isOpen = false
							TweenService:Create(MainFrameB, TweenInfo.new(0.2), {
								Size = UDim2.new(0, RowButton.AbsoluteSize.X, 0, 0)
							}):Play()
							TweenService:Create(RowButtonLabelB, TweenInfo.new(0.2), {
								Rotation = 0
							}):Play()
							task.delay(0.2, function()
								if not isOpen then
									MainFrameB.Visible = false
								end
							end)
						end
					end)
					RowButton.MouseButton1Click:Connect(function()
						isOpen = not isOpen

						if isOpen then
							MainFrameB.Position = UDim2.new(0, RowButton.AbsolutePosition.X - MainFrame.AbsolutePosition.X, 0, RowButton.AbsolutePosition.Y - MainFrame.AbsolutePosition.Y + RowButton.AbsoluteSize.Y + 5)
							MainFrameB.Size = UDim2.new(0, RowButton.AbsoluteSize.X, 0, 0)
							MainFrameB.Visible = true

							local clamped = math.clamp(#options * 32, 0, 150) + 10

							TweenService:Create(MainFrameB, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {
								Size = UDim2.new(0, RowButton.AbsoluteSize.X, 0, clamped)
							}):Play()
							TweenService:Create(RowButtonLabelB, TweenInfo.new(0.3), {
								Rotation = 180
							}):Play()
						else
							TweenService:Create(MainFrameB, TweenInfo.new(0.2), {
								Size = UDim2.new(0, RowButton.AbsoluteSize.X, 0, 0)
							}):Play()
							TweenService:Create(RowButtonLabelB, TweenInfo.new(0.3), {
								Rotation = 0
							}):Play()
							task.delay(0.2, function()
								if not isOpen then
									MainFrameB.Visible = false
								end
							end)
						end
					end)

					local dropdown = {
						Refresh = function(self, newOptions)
							options = newOptions

							for _, child in pairs(MainFrameBScroller:GetChildren()) do
								if child:IsA("TextButton") then
									child:Destroy()
								end
							end

							for _, v in ipairs(options) do
								local MainFrameBScrollerButton = Instance.new("TextButton")

								MainFrameBScrollerButton.Size = UDim2.new(1, -12, 0, 28)
								MainFrameBScrollerButton.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
								MainFrameBScrollerButton.Text = "   " .. v
								MainFrameBScrollerButton.TextColor3 = Color3.fromRGB(200, 200, 200)
								MainFrameBScrollerButton.Font = Enum.Font.GothamMedium
								MainFrameBScrollerButton.TextXAlignment = Enum.TextXAlignment.Left
								MainFrameBScrollerButton.AutoButtonColor = false
								MainFrameBScrollerButton.ZIndex = 102
								MainFrameBScrollerButton.Parent = MainFrameBScroller
								registerText(MainFrameBScrollerButton, 12)
								Instance.new("UICorner", MainFrameBScrollerButton).CornerRadius = UDim.new(0, 6)
								MainFrameBScrollerButton.MouseEnter:Connect(function()
									TweenService:Create(MainFrameBScrollerButton, TweenInfo.new(0.15), {
										BackgroundColor3 = Color3.fromRGB(50, 50, 55),
										TextColor3 = Color3.fromRGB(50, 130, 246)
									}):Play()
								end)
								MainFrameBScrollerButton.MouseLeave:Connect(function()
									TweenService:Create(MainFrameBScrollerButton, TweenInfo.new(0.15), {
										BackgroundColor3 = Color3.fromRGB(40, 40, 45),
										TextColor3 = Color3.fromRGB(200, 200, 200)
									}):Play()
								end)
								MainFrameBScrollerButton.MouseButton1Click:Connect(function()
									RowButtonLabel.Text = "Select: " .. v
									isOpen = false
									TweenService:Create(MainFrameB, TweenInfo.new(0.2), {
										Size = UDim2.new(0, RowButton.AbsoluteSize.X, 0, 0)
									}):Play()
									TweenService:Create(RowButtonLabelB, TweenInfo.new(0.3), {
										Rotation = 0
									}):Play()
									task.delay(0.2, function()
										if not isOpen then
											MainFrameB.Visible = false
										end
									end)
									callback(v)
								end)
							end

							MainFrameBScroller.CanvasSize = UDim2.new(0, 0, 0, MainFrameBScrollerListLayout.AbsoluteContentSize.Y + 5)
						end
					}

					dropdown:Refresh(options)

					return dropdown
				end,
				AddSlider = function(self, title, icon, min, maxB, default, callback)
					local currentValue = math.clamp(default or min, min, maxB)
					local isDragging = false

					getRow(false)

					local value = isMobile() and 65 or 75
					local TabContentFrame = Instance.new("Frame")

					TabContentFrame.Size = UDim2.new(1, 0, 0, value)
					TabContentFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 28)
					TabContentFrame.Parent = TabContent
					Instance.new("UICorner", TabContentFrame).CornerRadius = UDim.new(0, 8)

					local TabContentFrameStroke = Instance.new("UIStroke")

					TabContentFrameStroke.Color = Color3.fromRGB(45, 45, 50)
					TabContentFrameStroke.Parent = TabContentFrame

					local TabContentFrameB
					local ImageLabel
					local value = 15

					if icon and icon ~= "" then
						TabContentFrameB = Instance.new("Frame")
						TabContentFrameB.Size = UDim2.new(0, 36, 0, 36)
						TabContentFrameB.Position = UDim2.new(0, 15, 0.5, -18)
						TabContentFrameB.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
						TabContentFrameB.Parent = TabContentFrame
						Instance.new("UICorner", TabContentFrameB).CornerRadius = UDim.new(0, 8)
						Instance.new("UIStroke", TabContentFrameB).Color = Color3.fromRGB(65, 65, 70)
						ImageLabel = Instance.new("ImageLabel")
						ImageLabel.Size = UDim2.new(0, 22, 0, 22)
						ImageLabel.Position = UDim2.new(0.5, -11, 0.5, -11)
						ImageLabel.BackgroundTransparency = 1
						ImageLabel.Image = icon
						ImageLabel.ImageColor3 = Color3.fromRGB(180, 180, 180)
						ImageLabel.Parent = TabContentFrameB
						value = 65
					end

					local TabContentFrameLabel = Instance.new("TextLabel")

					TabContentFrameLabel.Size = UDim2.new(1, -value - 65, 0, 18)
					TabContentFrameLabel.Position = UDim2.new(0, value, 0, isMobile() and 10 or 12)
					TabContentFrameLabel.BackgroundTransparency = 1
					TabContentFrameLabel.Text = title
					TabContentFrameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
					TabContentFrameLabel.Font = Enum.Font.GothamSemibold
					TabContentFrameLabel.TextXAlignment = Enum.TextXAlignment.Left
					TabContentFrameLabel.Parent = TabContentFrame
					registerText(TabContentFrameLabel, 13)

					local TabContentFrameLabel = Instance.new("TextLabel")

					TabContentFrameLabel.Size = UDim2.new(0, 55, 0, 18)

					local number = 1
					local amount = -60
					local numberB = 0

					TabContentFrameLabel.Position = UDim2.new(number, amount, numberB, isMobile() and 10 or 12)
					TabContentFrameLabel.BackgroundTransparency = 1
					TabContentFrameLabel.Text = tostring(currentValue)
					TabContentFrameLabel.TextColor3 = Color3.fromRGB(50, 130, 246)
					TabContentFrameLabel.Font = Enum.Font.GothamBold
					TabContentFrameLabel.TextXAlignment = Enum.TextXAlignment.Right
					TabContentFrameLabel.Parent = TabContentFrame
					registerText(TabContentFrameLabel, 13)

					local TabContentFrameC = Instance.new("Frame")

					TabContentFrameC.Size = UDim2.new(1, -(value + 20), 0, 6)
					TabContentFrameC.Position = UDim2.new(numberB, value, 0, isMobile() and 44 or 50)
					TabContentFrameC.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
					TabContentFrameC.Parent = TabContentFrame
					Instance.new("UICorner", TabContentFrameC).CornerRadius = UDim.new(1, 0)

					local amount = (currentValue - min) / math.max(maxB - min, 1)
					local TabContentFrameCFrame = Instance.new("Frame")

					TabContentFrameCFrame.Size = UDim2.new(amount, 0, 1, 0)
					TabContentFrameCFrame.BackgroundColor3 = Color3.fromRGB(50, 130, 246)
					TabContentFrameCFrame.Parent = TabContentFrameC
					Instance.new("UICorner", TabContentFrameCFrame).CornerRadius = UDim.new(1, 0)

					local TabContentFrameCFrameB = Instance.new("Frame")

					TabContentFrameCFrameB.Size = UDim2.new(0, 14, 0, 14)
					TabContentFrameCFrameB.Position = UDim2.new(amount, -7, 0.5, -7)
					TabContentFrameCFrameB.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					TabContentFrameCFrameB.ZIndex = 5
					TabContentFrameCFrameB.Parent = TabContentFrameC
					Instance.new("UICorner", TabContentFrameCFrameB).CornerRadius = UDim.new(1, 0)

					local TabContentFrameCFrameBStroke = Instance.new("UIStroke")

					TabContentFrameCFrameBStroke.Color = Color3.fromRGB(50, 130, 246)
					TabContentFrameCFrameBStroke.Thickness = 2
					TabContentFrameCFrameBStroke.Parent = TabContentFrameCFrameB

					local function updateSliderFromX(self)
						currentValue = math.floor(min + (maxB - min) * math.clamp((self - TabContentFrameC.AbsolutePosition.X) / TabContentFrameC.AbsoluteSize.X, 0, 1))

						local amount = (currentValue - min) / math.max(maxB - min, 1)

						TweenService:Create(TabContentFrameCFrame, TweenInfo.new(0.05), {
							Size = UDim2.new(amount, 0, 1, 0)
						}):Play()
						TweenService:Create(TabContentFrameCFrameB, TweenInfo.new(0.05), {
							Position = UDim2.new(amount, -7, 0.5, -7)
						}):Play()
						TabContentFrameLabel.Text = tostring(currentValue)
						callback(currentValue)
					end

					TabContentFrameC.InputBegan:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
							isDragging = true
							updateSliderFromX(input.Position.X)
						end
					end)
					TabContentFrameCFrameB.InputBegan:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							isDragging = true

							return
						elseif input.UserInputType == Enum.UserInputType.Touch then
							isDragging = true
						end
					end)
					UserInputService.InputChanged:Connect(function(input)
						if isDragging then
							if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
								updateSliderFromX(input.Position.X)
							end
						end
					end)
					UserInputService.InputEnded:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
							isDragging = false
						end
					end)
					TabContentFrame.MouseEnter:Connect(function()
						TweenService:Create(TabContentFrameStroke, TweenInfo.new(0.2), {
							Color = Color3.fromRGB(65, 65, 75)
						}):Play()
						TweenService:Create(TabContentFrameCFrame, TweenInfo.new(0.2), {
							BackgroundColor3 = Color3.fromRGB(80, 160, 255)
						}):Play()

						if TabContentFrameB then
							TweenService:Create(TabContentFrameB, TweenInfo.new(0.2), {
								BackgroundColor3 = Color3.fromRGB(28, 50, 90)
							}):Play()
						end

						if ImageLabel then
							TweenService:Create(ImageLabel, TweenInfo.new(0.2), {
								ImageColor3 = Color3.fromRGB(255, 255, 255)
							}):Play()
						end
					end)
					TabContentFrame.MouseLeave:Connect(function()
						TweenService:Create(TabContentFrameStroke, TweenInfo.new(0.2), {
							Color = Color3.fromRGB(45, 45, 50)
						}):Play()
						TweenService:Create(TabContentFrameCFrame, TweenInfo.new(0.2), {
							BackgroundColor3 = Color3.fromRGB(50, 130, 246)
						}):Play()

						if TabContentFrameB then
							TweenService:Create(TabContentFrameB, TweenInfo.new(0.2), {
								BackgroundColor3 = Color3.fromRGB(35, 35, 40)
							}):Play()
						end

						if ImageLabel then
							TweenService:Create(ImageLabel, TweenInfo.new(0.2), {
								ImageColor3 = Color3.fromRGB(180, 180, 180)
							}):Play()
						end
					end)

					return {
						SetValue = function(self, value)
							currentValue = math.clamp(value, min, maxB)

							local amount = (currentValue - min) / math.max(maxB - min, 1)

							TabContentFrameCFrame.Size = UDim2.new(amount, 0, 1, 0)
							TabContentFrameCFrameB.Position = UDim2.new(amount, -7, 0.5, -7)
							TabContentFrameLabel.Text = tostring(currentValue)
						end
					}
				end
			}
		end
	}

	return Window
end

local items = {
	CreateWindow = createWindow
}

return items
