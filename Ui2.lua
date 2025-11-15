local Library = {}

local TweenService = game:GetService("TweenService")
local Silkscreen = Enum.Font.SciFi
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

function Library:Window(config)
    if PlayerGui:FindFirstChild("ProGUI") then
        PlayerGui.ProGUI:Destroy()
    end

    local ScreenGui = Instance.new("ScreenGui", PlayerGui)
    ScreenGui.Name = "ProGUI"
    ScreenGui.ResetOnSpawn = false

    local ShowBtn = Instance.new("TextButton", ScreenGui)
    ShowBtn.Size = UDim2.new(0,60,0,30)
    ShowBtn.Position = UDim2.new(0,20,0.5,-15)
    ShowBtn.BackgroundColor3 = Color3.fromRGB(255,255,255)
    ShowBtn.Text = "Show"
    ShowBtn.Font = Silkscreen
    ShowBtn.TextSize = 20
    ShowBtn.TextColor3 = Color3.fromRGB(0,0,0)
    Instance.new("UICorner", ShowBtn).CornerRadius = UDim.new(1,0)
    ShowBtn.Visible = false

    --== Window ==--
    local Main = Instance.new("Frame", ScreenGui)
    Main.Size = UDim2.new(0,440,0,300)
    Main.Position = UDim2.new(0.5,-220,0.5,-150)
    Main.BackgroundColor3 = Color3.fromRGB(0,0,0)
    Main.BackgroundTransparency = 0.25
    Main.Active = true
    Main.Draggable = true
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0,10)

    local MainStroke = Instance.new("UIStroke", Main)
    MainStroke.Color = Color3.fromRGB(255,255,255)
    MainStroke.Thickness = 2

    --== Header ==--
    local Header = Instance.new("Frame", Main)
    Header.Size = UDim2.new(1,0,0,40)
    Header.BackgroundColor3 = Color3.fromRGB(20,20,20)
    Header.BackgroundTransparency = 0.35
    Instance.new("UICorner", Header).CornerRadius = UDim.new(0,10)

    local Title = Instance.new("TextLabel", Header)
    Title.Text = config.Title or "My GUI"
    Title.Size = UDim2.new(0,200,1,0)
    Title.Position = UDim2.new(0,15,0,0)
    Title.Font = Silkscreen
    Title.TextSize = 22
    Title.BackgroundTransparency = 1
    Title.TextColor3 = Color3.fromRGB(255,255,255)

    local Hide = Instance.new("TextButton", Header)
    Hide.Size = UDim2.new(0,30,0,30)
    Hide.Position = UDim2.new(1,-70,0,5)
    Hide.BackgroundColor3 = Color3.fromRGB(255,200,50)
    Hide.Text = "-"
    Hide.Font = Silkscreen
    Hide.TextSize = 20
    Hide.TextColor3 = Color3.fromRGB(0,0,0)
    Instance.new("UICorner", Hide).CornerRadius = UDim.new(1,0)

    local Close = Instance.new("TextButton", Header)
    Close.Size = UDim2.new(0,30,0,30)
    Close.Position = UDim2.new(1,-35,0,5)
    Close.BackgroundColor3 = Color3.fromRGB(255,60,60)
    Close.Text = "X"
    Close.Font = Silkscreen
    Close.TextSize = 20
    Close.TextColor3 = Color3.fromRGB(255,255,255)
    Instance.new("UICorner", Close).CornerRadius = UDim.new(1,0)

    --== Tabs ==--
    local Tabs = Instance.new("Frame", Main)
    Tabs.Size = UDim2.new(0,120,1,-45)
    Tabs.Position = UDim2.new(0,0,0,45)
    Tabs.BackgroundColor3 = Color3.fromRGB(20,20,20)
    Instance.new("UICorner", Tabs).CornerRadius = UDim.new(0,10)

    local TabList = Instance.new("UIListLayout", Tabs)
    TabList.Padding = UDim.new(0,10)
    TabList.SortOrder = Enum.SortOrder.LayoutOrder

    --== Content ==--
    local Content = Instance.new("Frame", Main)
    Content.Size = UDim2.new(1,-140,1,-45)
    Content.Position = UDim2.new(0,130,0,45)
    Content.BackgroundColor3 = Color3.fromRGB(10,10,10)
    Instance.new("UICorner", Content).CornerRadius = UDim.new(0,10)

    local Scroll = Instance.new("ScrollingFrame", Content)
    Scroll.Size = UDim2.new(1,0,1,0)
    Scroll.CanvasSize = UDim2.new(0,0,0,0)
    Scroll.ScrollBarThickness = 6
    Scroll.ScrollBarImageColor3 = Color3.fromRGB(120,180,255)
    Scroll.BackgroundTransparency = 1

    local UIList = Instance.new("UIListLayout", Scroll)
    UIList.Padding = UDim.new(0,10)
    UIList.SortOrder = Enum.SortOrder.LayoutOrder

    UIList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        Scroll.CanvasSize = UDim2.new(0,0,0,UIList.AbsoluteContentSize.Y + 10)
    end)

    local function ClearContent()
        for _, child in ipairs(Scroll:GetChildren()) do
            if child:IsA("Frame") or child:IsA("TextButton") then
                child:Destroy()
            end
        end
    end

    local WindowTable = {}

    --------------------------------------------------------------------
    --                        🔥 نظام تبويبات شغال                       --
    --------------------------------------------------------------------
    function WindowTable:Tab(name)
        local TabBtn = Instance.new("TextButton", Tabs)
        TabBtn.Size = UDim2.new(1,-20,0,35)
        TabBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
        TabBtn.Font = Silkscreen
        TabBtn.TextSize = 18
        TabBtn.TextColor3 = Color3.fromRGB(255,255,255)
        TabBtn.Text = name
        Instance.new("UICorner", TabBtn).CornerRadius = UDim.new(0,8)

        local TabTable = {}
        TabTable.Elements = {} -- ⭐ يخزن عناصر التاب

        -- عند الضغط يظهر محتوى التاب
        TabBtn.MouseButton1Click:Connect(function()
            ClearContent()
            for _, element in ipairs(TabTable.Elements) do
                element.Parent = Scroll
            end
        end)

        ---------------------------------------------------------
        --                      Button                         --
        ---------------------------------------------------------
        function TabTable:Button(text, callback)
            local Btn = Instance.new("TextButton")
            Btn.Size = UDim2.new(1,-20,0,40)
            Btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
            Btn.Font = Silkscreen
            Btn.TextSize = 18
            Btn.TextColor3 = Color3.fromRGB(255,255,255)
            Btn.Text = text
            Instance.new("UICorner", Btn).CornerRadius = UDim.new(0,10)
            Btn.MouseButton1Click:Connect(callback)

            table.insert(self.Elements, Btn)
            return Btn
        end

        ---------------------------------------------------------
        --                      Toggle                         --
        ---------------------------------------------------------
        function TabTable:Toggle(info)
            local Frame = Instance.new("Frame")
            Frame.Size = UDim2.new(1,-20,0,45)
            Frame.BackgroundColor3 = Color3.fromRGB(40,40,40)
            Instance.new("UICorner", Frame).CornerRadius = UDim.new(0,10)

            local Label = Instance.new("TextLabel", Frame)
            Label.Text = info.Title
            Label.Font = Silkscreen
            Label.TextSize = 18
            Label.TextColor3 = Color3.fromRGB(255,255,255)
            Label.Size = UDim2.new(1,-50,1,0)
            Label.Position = UDim2.new(0,10,0,0)
            Label.BackgroundTransparency = 1

            local Btn = Instance.new("TextButton", Frame)
            Btn.Size = UDim2.new(0,35,0,20)
            Btn.Position = UDim2.new(1,-45,0.5,-10)
            Btn.BackgroundColor3 = Color3.fromRGB(80,80,80)
            Btn.Text = ""
            Instance.new("UICorner", Btn).CornerRadius = UDim.new(1,0)

            local state = info.Value or false

            Btn.MouseButton1Click:Connect(function()
                state = not state
                TweenService:Create(
                    Btn,
                    TweenInfo.new(0.25),
                    {BackgroundColor3 = state and Color3.fromRGB(255,255,255) or Color3.fromRGB(80,80,80)}
                ):Play()
                info.Callback(state)
            end)

            table.insert(self.Elements, Frame)
            return Frame
        end

        return TabTable
    end

    --------------------------------------------------------------------

    ShowBtn.MouseButton1Click:Connect(function()
        Main.Visible = true
        ShowBtn.Visible = false
    end)

    Hide.MouseButton1Click:Connect(function()
        Main.Visible = false
        ShowBtn.Visible = true
    end)

    Close.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    return WindowTable
end

return Library
