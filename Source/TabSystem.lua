local Tabs = {}

function CreateTabContainer(Main)
	local TabBar = Instance.new("Frame")
	TabBar.Size = UDim2.new(1, 0, 0, 40)
	TabBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	TabBar.BorderSizePixel = 0
	TabBar.Parent = Main

	local UIListLayout = Instance.new("UIListLayout", TabBar)
	UIListLayout.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout.Padding = UDim.new(0, 4)
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

	local TabContentFrame = Instance.new("Frame")
	TabContentFrame.Size = UDim2.new(1, 0, 1, -40)
	TabContentFrame.Position = UDim2.new(0, 0, 0, 40)
	TabContentFrame.BackgroundTransparency = 1
	TabContentFrame.Name = "TabContent"
	TabContentFrame.Parent = Main

	return TabBar, TabContentFrame
end

function CreateTab(Main, TabBar, TabContentFrame, name)
	local Button = Instance.new("TextButton")
	Button.Size = UDim2.new(0, 120, 1, 0)
	Button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	Button.TextColor3 = Color3.fromRGB(255, 255, 255)
	Button.Font = Enum.Font.GothamBold
	Button.TextSize = 14
	Button.Text = name
	Button.BorderSizePixel = 0
	Button.Parent = TabBar

	local Corner = Instance.new("UICorner", Button)
	Corner.CornerRadius = UDim.new(0, 8)

	local Content = Instance.new("Frame")
	Content.Size = UDim2.new(1, 0, 1, 0)
	Content.BackgroundTransparency = 1
	Content.Visible = false
	Content.Parent = TabContentFrame

	local function ActivateTab()
		for _, tab in pairs(TabContentFrame:GetChildren()) do
			if tab:IsA("Frame") then
				tab.Visible = false
			end
		end
		for _, btn in pairs(TabBar:GetChildren()) do
			if btn:IsA("TextButton") then
				btn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
			end
		end

		Content.Visible = true
		Button.BackgroundColor3 = Color3.fromRGB(60, 90, 150)
	end

	Button.MouseButton1Click:Connect(ActivateTab)

	if #TabContentFrame:GetChildren() == 1 then
		ActivateTab()
	end

	return Content
end
