local Library = {}

-- Services
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Variables
Library.Theme = {
    Accent = Color3.fromRGB(170, 0, 255),
    WindowBackground = Color3.fromRGB(20, 20, 20),
    WindowBorder = Color3.fromRGB(50, 50, 50),
    TabBackground = Color3.fromRGB(30, 30, 30),
    TabBorder = Color3.fromRGB(50, 50, 50),
    SectionBackground = Color3.fromRGB(25, 25, 25),
    SectionBorder = Color3.fromRGB(40, 40, 40),
    Text = Color3.fromRGB(200, 200, 200),
    DisabledText = Color3.fromRGB(120, 120, 120),
    ObjectBackground = Color3.fromRGB(35, 35, 35),
    ObjectBorder = Color3.fromRGB(50, 50, 50),
    DropdownOptionBackground = Color3.fromRGB(40, 40, 40)
}

function Library:CreateWindow(title)
    local ScreenGui = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local TabHolder = Instance.new("Frame")
    local Title = Instance.new("TextLabel")

    ScreenGui.Parent = game:GetService("CoreGui")
    ScreenGui.Name = "CustomUILibrary"

    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.Size = UDim2.new(0, 600, 0, 400)
    MainFrame.BackgroundColor3 = Library.Theme.WindowBackground
    MainFrame.BorderColor3 = Library.Theme.WindowBorder

    Title.Name = "Title"
    Title.Parent = MainFrame
    Title.Size = UDim2.new(1, 0, 0, 30)
    Title.BackgroundColor3 = Library.Theme.TabBackground
    Title.BorderColor3 = Library.Theme.TabBorder
    Title.Text = title or "UI Library"
    Title.TextColor3 = Library.Theme.Text
    Title.Font = Enum.Font.SourceSansBold
    Title.TextSize = 18

    TabHolder.Name = "TabHolder"
    TabHolder.Parent = MainFrame
    TabHolder.Position = UDim2.new(0, 0, 0, 30)
    TabHolder.Size = UDim2.new(0, 120, 1, -30)
    TabHolder.BackgroundColor3 = Library.Theme.TabBackground
    TabHolder.BorderColor3 = Library.Theme.TabBorder

    local Tabs = {}

    function Tabs:CreateTab(tabName)
        local TabButton = Instance.new("TextButton")
        local TabFrame = Instance.new("Frame")

        TabButton.Name = tabName .. "Button"
        TabButton.Parent = TabHolder
        TabButton.Size = UDim2.new(1, -10, 0, 30)
        TabButton.Position = UDim2.new(0, 5, 0, #TabHolder:GetChildren() * 35 - 35)
        TabButton.Text = tabName
        TabButton.TextColor3 = Library.Theme.Text
        TabButton.BackgroundColor3 = Library.Theme.ObjectBackground
        TabButton.BorderColor3 = Library.Theme.ObjectBorder

        TabFrame.Name = tabName .. "Frame"
        TabFrame.Parent = MainFrame
        TabFrame.Size = UDim2.new(1, -130, 1, -40)
        TabFrame.Position = UDim2.new(0, 130, 0, 30)
        TabFrame.BackgroundColor3 = Library.Theme.SectionBackground
        TabFrame.BorderColor3 = Library.Theme.SectionBorder
        TabFrame.Visible = false

        TabButton.MouseButton1Click:Connect(function()
            for _, frame in ipairs(MainFrame:GetChildren()) do
                if frame:IsA("Frame") and frame.Name:match("Frame") then
                    frame.Visible = false
                end
            end
            TabFrame.Visible = true
        end)

        local Sections = {}

        function Sections:Section(options)
            local SectionFrame = Instance.new("Frame")
            local SectionTitle = Instance.new("TextLabel")

            SectionFrame.Name = options.Name .. "Section"
            SectionFrame.Parent = TabFrame
            SectionFrame.Size = UDim2.new(0.5, -10, 0, 200)
            SectionFrame.Position = options.Side == "Right" and UDim2.new(0.5, 5, 0, 10) or UDim2.new(0, 5, 0, 10)
            SectionFrame.BackgroundColor3 = Library.Theme.SectionBackground
            SectionFrame.BorderColor3 = Library.Theme.SectionBorder

            SectionTitle.Name = "SectionTitle"
            SectionTitle.Parent = SectionFrame
            SectionTitle.Size = UDim2.new(1, 0, 0, 20)
            SectionTitle.BackgroundColor3 = Library.Theme.ObjectBackground
            SectionTitle.BorderColor3 = Library.Theme.ObjectBorder
            SectionTitle.Text = options.Name
            SectionTitle.TextColor3 = Library.Theme.Text
            SectionTitle.Font = Enum.Font.SourceSans
            SectionTitle.TextSize = 14

            return SectionFrame
        end

        return Sections
    end

    return Tabs
end

function Library:Toggle(parent, options)
    local ToggleFrame = Instance.new("Frame")
    local ToggleButton = Instance.new("TextButton")
    local ToggleLabel = Instance.new("TextLabel")

    ToggleFrame.Name = options.Name .. "Toggle"
    ToggleFrame.Parent = parent
    ToggleFrame.Size = UDim2.new(1, -10, 0, 30)
    ToggleFrame.Position = UDim2.new(0, 5, 0, #parent:GetChildren() * 35 - 35)
    ToggleFrame.BackgroundColor3 = Library.Theme.ObjectBackground
    ToggleFrame.BorderColor3 = Library.Theme.ObjectBorder

    ToggleButton.Name = "ToggleButton"
    ToggleButton.Parent = ToggleFrame
    ToggleButton.Size = UDim2.new(0, 20, 0, 20)
    ToggleButton.Position = UDim2.new(1, -25, 0.5, -10)
    ToggleButton.BackgroundColor3 = Library.Theme.ObjectBackground
    ToggleButton.BorderColor3 = Library.Theme.ObjectBorder
    ToggleButton.Text = ""

    ToggleLabel.Name = "ToggleLabel"
    ToggleLabel.Parent = ToggleFrame
    ToggleLabel.Size = UDim2.new(1, -30, 1, 0)
    ToggleLabel.Position = UDim2.new(0, 5, 0, 0)
    ToggleLabel.BackgroundTransparency = 1
    ToggleLabel.Text = options.Name
    ToggleLabel.TextColor3 = Library.Theme.Text
    ToggleLabel.Font = Enum.Font.SourceSans
    ToggleLabel.TextSize = 14
    ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left

    local toggled = false

    ToggleButton.MouseButton1Click:Connect(function()
        toggled = not toggled
        options.Callback(toggled)
        ToggleButton.BackgroundColor3 = toggled and Library.Theme.Accent or Library.Theme.ObjectBackground
    end)

    return ToggleFrame
end

return Library
