local Library = {}

function Library:Window(Settings)
    local TitleText = Settings.Title or "Menu"

    local Player = game.Players.LocalPlayer
    local PlayerGui = Player:WaitForChild("PlayerGui")

    if PlayerGui:FindFirstChild("CustomMenu_Lib") then
        PlayerGui.CustomMenu_Lib:Destroy()
    end

    -- خط Silkscreen
    local FontFace = Font.new(
        "rbxassetid://12187371840",
        Enum.FontWeight.Regular,
        Enum.FontStyle.Normal
    )

    -- GUI الأساسي
    local Gui = Instance.new("ScreenGui")
    Gui.Name = "CustomMenu_Lib"
    Gui.IgnoreGuiInset = true
    Gui.ResetOnSpawn = false
    Gui.Parent = PlayerGui

    -- الواجهة
    local Main = Instance.new("Frame")
    Main.Parent = Gui
    Main.Size = UDim2.new(0, 190, 0, 260)
    Main.Position = UDim2.new(0.5, -95, 0.5, -130)
    Main.BackgroundColor3 = Color3.fromRGB(255,255,255)
    Main.BackgroundTransparency = 0.1

    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)

    local stroke = Instance.new("UIStroke", Main)
    stroke.Thickness = 2
    stroke.Color = Color3.fromRGB(0,0,0)

    ---------------------------------------------------
    -- Header
    ---------------------------------------------------

    local Header = Instance.new("Frame")
    Header.Parent = Main
    Header.Size = UDim2.new(1, 0, 0, 40)
    Header.BackgroundTransparency = 1

    local Icon = Instance.new("ImageLabel")
    Icon.Parent = Header
    Icon.Size = UDim2.new(0, 22, 0, 22)
    Icon.Position = UDim2.new(0, 6, 0.5, -11)
    Icon.BackgroundTransparency = 1
    Icon.Image = "rbxassetid://15195559870" -- شعار ديسكورد

    local Title = Instance.new("TextLabel")
    Title.Parent = Header
    Title.Size = UDim2.new(1, -60, 0, 22)
    Title.Position = UDim2.new(0, 34, 0.5, -11)
    Title.BackgroundTransparency = 1
    Title.Text = TitleText
    Title.FontFace = FontFace
    Title.TextScaled = true
    Title.TextColor3 = Color3.fromRGB(0,0,0)

    -- زر X
    local Close = Instance.new("TextButton")
    Close.Parent = Header
    Close.Size = UDim2.new(0, 22, 0, 22)
    Close.Position = UDim2.new(1, -30, 0.5, -11)
    Close.BackgroundColor3 = Color3.fromRGB(255,255,255)
    Close.Text = "X"
    Close.FontFace = FontFace
    Close.TextScaled = true
    Close.TextColor3 = Color3.fromRGB(0,0,0)

    Instance.new("UICorner", Close).CornerRadius = UDim.new(0, 6)
    Instance.new("UIStroke", Close).Thickness = 2

    Close.MouseButton1Click:Connect(function()
        Gui:Destroy()
    end)

    ---------------------------------------------------
    -- سحب الواجهة
    ---------------------------------------------------

    local UIS = game:GetService("UserInputService")
    local dragging, dragStart, startPos

    Main.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or 
           input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = Main.Position
        end
    end)

    Main.InputEnded:Connect(function()
        dragging = false
    end)

    UIS.InputChanged:Connect(function(input)
        if dragging and 
           (input.UserInputType == Enum.UserInputType.Touch 
            or input.UserInputType == Enum.UserInputType.MouseMovement) then

            local delta = input.Position - dragStart

            Main.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)

    ---------------------------------------------------
    -- Buttons Holder
    ---------------------------------------------------

    local ButtonsFrame = Instance.new("Frame")
    ButtonsFrame.Parent = Main
    ButtonsFrame.Position = UDim2.new(0, 0, 0, 45)
    ButtonsFrame.Size = UDim2.new(1, 0, 1, -50)
    ButtonsFrame.BackgroundTransparency = 1

    local Layout = Instance.new("UIListLayout", ButtonsFrame)
    Layout.Padding = UDim.new(0, 6)
    Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    Layout.VerticalAlignment = Enum.VerticalAlignment.Top

    ---------------------------------------------------
    -- دالة إضافة زر
    ---------------------------------------------------

    local WindowObject = {}

    function WindowObject:Button(text, callback)
        callback = callback or function() end

        local Btn = Instance.new("TextButton")
        Btn.Parent = ButtonsFrame
        Btn.Size = UDim2.new(0, 150, 0, 28)
        Btn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        Btn.Text = text
        Btn.FontFace = FontFace
        Btn.TextScaled = true
        Btn.TextColor3 = Color3.fromRGB(255,255,255)

        Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 8)
        Instance.new("UIStroke", Btn).Thickness = 2

        Btn.MouseButton1Click:Connect(function()
            -- تأثير الضغط
            Btn.BackgroundColor3 = Color3.fromRGB(255,255,255)
            Btn.TextColor3 = Color3.fromRGB(0,0,0)
            task.wait(0.12)
            Btn.BackgroundColor3 = Color3.fromRGB(0,0,0)
            Btn.TextColor3 = Color3.fromRGB(255,255,255)

            callback()
        end)

        return Btn
    end

    return WindowObject
end

return Library
