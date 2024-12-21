local Library = {}

function Library:Create(config)
    local ui = {}
    ui.Name = config.Name or "UI"
    ui.Size = config.Size or UDim2.new(0, 500, 0, 300)
    ui.Theme = config.Theme or {}

    -- Create ScreenGui
    ui.ScreenGui = Instance.new("ScreenGui")
    ui.ScreenGui.Name = ui.Name
    ui.ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    -- Create Main Frame
    ui.MainFrame = Instance.new("Frame")
    ui.MainFrame.Size = ui.Size
    ui.MainFrame.Position = UDim2.new(0.5, -ui.Size.X.Offset / 2, 0.5, -ui.Size.Y.Offset / 2)
    ui.MainFrame.BackgroundColor3 = ui.Theme.Background or Color3.fromRGB(30, 30, 30)
    ui.MainFrame.BorderColor3 = ui.Theme.Border or Color3.fromRGB(50, 50, 50)
    ui.MainFrame.Parent = ui.ScreenGui

    -- Add tabs, sections, and other functionality
    ui.Tabs = {}

    function ui:Tab(config)
        local tab = {}
        tab.Name = config.Name or "Tab"

        -- Create Tab Button
        tab.Button = Instance.new("TextButton")
        tab.Button.Text = tab.Name
        tab.Button.Size = UDim2.new(0, 100, 0, 30)
        tab.Button.Parent = ui.MainFrame

        -- Add Sections and other functionalities
        tab.Sections = {}

        function tab:Section(config)
            local section = {}
            section.Name = config.Name or "Section"
            section.Side = config.Side or "Left"

            -- Create Section Frame
            section.Frame = Instance.new("Frame")
            section.Frame.Size = UDim2.new(0.5, -5, 0, 100)
            section.Frame.Position = section.Side == "Left" and UDim2.new(0, 5, 0, 40) or UDim2.new(0.5, 5, 0, 40)
            section.Frame.BackgroundColor3 = ui.Theme.Background
            section.Frame.BorderColor3 = ui.Theme.Border
            section.Frame.Parent = ui.MainFrame

            function section:Toggle(config)
                local toggle = {}
                toggle.Name = config.Name or "Toggle"
                toggle.Default = config.Default or false
                toggle.Callback = config.Callback or function() end

                -- Create Toggle Button
                toggle.Button = Instance.new("TextButton")
                toggle.Button.Text = toggle.Name
                toggle.Button.Size = UDim2.new(0, 100, 0, 30)
                toggle.Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                toggle.Button.Parent = section.Frame

                -- Handle Toggle Click
                toggle.State = toggle.Default
                toggle.Button.MouseButton1Click:Connect(function()
                    toggle.State = not toggle.State
                    toggle.Callback(toggle.State)
                end)

                return toggle
            end

            table.insert(tab.Sections, section)
            return section
        end

        table.insert(ui.Tabs, tab)
        return tab
    end

    return ui
end

return Library
