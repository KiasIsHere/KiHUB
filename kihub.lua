-- [[ KIHUB - INDEX LOADER V.1.0 (DELTA COMPATIBLE) ]] --
-- Redesigned for Delta Roblox Executor with Enhanced UI

getgenv().HubVersion = "v1.0"
getgenv().HubName = "KiHub"

-- Security check for Delta compatibility
local IS_DELTA = pcall(function()
    if syn and syn.protect_gui then
        return true
    end
    if get_hidden_ui or gethui then
        return true
    end
    return false
end) or (syn and syn.protect_gui) or (getgenv and getgenv().gethui) or (getgenv and getgenv().get_hidden_ui)

local CoreGui = game:GetService("CoreGui")
local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local TweenService = game:GetService("TweenService")

-- Cleanup existing UI
pcall(function()
    if getgenv().KiHubUI then
        getgenv().KiHubUI:Destroy()
    end
    if getgenv().KiHubButton then
        getgenv().KiHubButton:Destroy()
    end
end)

-- Enhanced Color Theme
local Theme = {
    Bg = Color3.fromRGB(18, 20, 22),
    Header = Color3.fromRGB(25, 28, 32),
    Item = Color3.fromRGB(40, 45, 52),
    ItemHover = Color3.fromRGB(55, 62, 72),
    Text = Color3.fromRGB(235, 235, 235),
    TextMuted = Color3.fromRGB(150, 155, 165),
    Accent = Color3.fromRGB(255, 85, 85),
    AccentLight = Color3.fromRGB(255, 120, 120),
    Success = Color3.fromRGB(85, 255, 127),
    Warning = Color3.fromRGB(255, 200, 85),
    Error = Color3.fromRGB(255, 85, 85),
    TabBg = Color3.fromRGB(22, 25, 30),
    Border = Color3.fromRGB(60, 65, 75),
    Shadow = Color3.fromRGB(0, 0, 0)
}

-- Create Main GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KiHubInterface"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 99999

-- Delta compatibility: Protect GUI
if syn and syn.protect_gui then
    syn.protect_gui(ScreenGui)
end

pcall(function()
    ScreenGui.Parent = CoreGui
end)
if not ScreenGui.Parent then
    ScreenGui.Parent = LP:FindFirstChildOfClass("PlayerGui")
end

getgenv().KiHubUI = ScreenGui

-- Create Toggle Button
local HubButton = Instance.new("ImageButton")
HubButton.Name = "KiHubButton"
HubButton.Size = UDim2.new(0, 55, 0, 55)
HubButton.Position = UDim2.new(0.1, 0, 0.85, 0)
HubButton.BackgroundColor3 = Theme.Accent
HubButton.AutoButtonColor = false
HubButton.Image = ""
HubButton.Parent = ScreenGui

-- Button styling
local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0.5, 0)
btnCorner.Parent = HubButton

local btnStroke = Instance.new("UIStroke")
btnStroke.Color = Color3.fromRGB(255, 150, 150)
btnStroke.Thickness = 2
btnStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
btnStroke.Parent = HubButton

local btnGlow = Instance.new("ImageLabel")
btnGlow.Size = UDim2.new(1.5, 0, 1.5, 0)
btnGlow.Position = UDim2.new(-0.25, 0, -0.25, 0)
btnGlow.BackgroundTransparency = 1
btnGlow.Image = "rbxassetid://4996896225"
btnGlow.ImageColor3 = Theme.Accent
btnGlow.ImageTransparency = 0.7
btnGlow.ZIndex = 0
btnGlow.Parent = HubButton

local btnIcon = Instance.new("TextLabel")
btnIcon.Size = UDim2.new(1, 0, 1, 0)
btnIcon.BackgroundTransparency = 1
btnIcon.Text = "K"
btnIcon.TextColor3 = Color3.new(1, 1, 1)
btnIcon.Font = Enum.Font.GothamBlack
btnIcon.TextSize = 24
btnIcon.Parent = HubButton

getgenv().KiHubButton = HubButton

-- Create Main Window
local Main = Instance.new("Frame")
Main.Name = "KiHubMain"
Main.Size = UDim2.new(0, 520, 0, 380)
Main.Position = UDim2.new(0.5, -260, 0.5, -190)
Main.BackgroundColor3 = Theme.Bg
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.Parent = ScreenGui

-- Window shadow effect
local shadow = Instance.new("ImageLabel")
shadow.Size = UDim2.new(1.1, 0, 1.1, 0)
shadow.Position = UDim2.new(-0.05, 0, -0.05, 0)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://6026562261"
shadow.ImageColor3 = Theme.Shadow
shadow.ImageTransparency = 0.5
shadow.ZIndex = -1
shadow.Parent = Main

-- Main corner
local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = Main

-- Main border
local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Theme.Border
mainStroke.Thickness = 1
mainStroke.Parent = Main

-- Header Section
local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Size = UDim2.new(1, 0, 0, 50)
Header.BackgroundColor3 = Theme.Header
Header.BorderSizePixel = 0
Header.Parent = Main

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 12)
headerCorner.Parent = Header

local headerStroke = Instance.new("UIStroke")
headerStroke.Color = Theme.Border
headerStroke.Thickness = 1
headerStroke.Parent = Header

-- Logo Section
local LogoContainer = Instance.new("Frame")
LogoContainer.Size = UDim2.new(0, 40, 0, 40)
LogoContainer.Position = UDim2.new(0, 12, 0.5, -20)
LogoContainer.BackgroundColor3 = Theme.Accent
LogoContainer.BorderSizePixel = 0
LogoContainer.Parent = Header

local logoCorner = Instance.new("UICorner")
logoCorner.CornerRadius = UDim.new(0.3, 0)
logoCorner.Parent = LogoContainer

local LogoText = Instance.new("TextLabel")
LogoText.Size = UDim2.new(1, 0, 1, 0)
LogoText.BackgroundTransparency = 1
LogoText.Text = "K"
LogoText.TextColor3 = Color3.new(1, 1, 1)
LogoText.Font = Enum.Font.GothamBlack
LogoText.TextSize = 20
LogoText.Parent = LogoContainer

-- Title Section
local TitleContainer = Instance.new("Frame")
TitleContainer.Size = UDim2.new(0, 150, 0, 30)
TitleContainer.Position = UDim2.new(0, 60, 0, 10)
TitleContainer.BackgroundTransparency = 1
TitleContainer.Parent = Header

local HubTitle = Instance.new("TextLabel")
HubTitle.Size = UDim2.new(1, 0, 0, 20)
HubTitle.Position = UDim2.new(0, 0, 0, 0)
HubTitle.BackgroundTransparency = 1
HubTitle.Text = getgenv().HubName
HubTitle.TextColor3 = Theme.Text
HubTitle.Font = Enum.Font.GothamBlack
HubTitle.TextSize = 18
HubTitle.TextXAlignment = Enum.TextXAlignment.Left
HubTitle.Parent = TitleContainer

local VersionLabel = Instance.new("TextLabel")
VersionLabel.Size = UDim2.new(1, 0, 0, 15)
VersionLabel.Position = UDim2.new(0, 0, 0, 15)
VersionLabel.BackgroundTransparency = 1
VersionLabel.Text = getgenv().HubVersion .. " • Delta Compatible"
VersionLabel.TextColor3 = Theme.TextMuted
VersionLabel.Font = Enum.Font.GothamSemibold
VersionLabel.TextSize = 11
VersionLabel.TextXAlignment = Enum.TextXAlignment.Left
VersionLabel.Parent = TitleContainer

-- Control Buttons
local ButtonContainer = Instance.new("Frame")
ButtonContainer.Size = UDim2.new(0, 120, 0, 30)
ButtonButtonContainer.Position = UDim2.new(1, -130, 0.5, -15)
ButtonContainer.BackgroundTransparency = 1
ButtonContainer.Parent = Header

-- Discord Button
local DiscordBtn = Instance.new("TextButton")
DiscordBtn.Name = "DiscordBtn"
DiscordBtn.Size = UDim2.new(0, 85, 0, 28)
DiscordBtn.Position = UDim2.new(0, 0, 0, 1)
DiscordBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
DiscordBtn.Text = "Discord"
DiscordBtn.TextColor3 = Color3.new(1, 1, 1)
DiscordBtn.Font = Enum.Font.GothamBold
DiscordBtn.TextSize = 11
DiscordBtn.AutoButtonColor = false
DiscordBtn.Parent = ButtonContainer

local discordCorner = Instance.new("UICorner")
discordCorner.CornerRadius = UDim.new(0, 6)
discordCorner.Parent = DiscordBtn

DiscordBtn.MouseEnter:Connect(function()
    TweenService:Create(DiscordBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(100, 115, 255)}):Play()
end)

DiscordBtn.MouseLeave:Connect(function()
    TweenService:Create(DiscordBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(88, 101, 242)}):Play()
end)

DiscordBtn.MouseButton1Click:Connect(function()
    pcall(function()
        if setclipboard then
            setclipboard("https://discord.gg/your-invite-code")
        end
    end)
end)

-- Minimize Button
local MinBtn = Instance.new("TextButton")
MinBtn.Name = "MinBtn"
MinBtn.Size = UDim2.new(0, 28, 0, 28)
MinBtn.Position = UDim2.new(0, 92, 0, 1)
MinBtn.BackgroundColor3 = Theme.Item
MinBtn.Text = "−"
MinBtn.TextColor3 = Theme.Text
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 16
MinBtn.AutoButtonColor = false
MinBtn.Parent = ButtonContainer

local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(0, 6)
minCorner.Parent = MinBtn

MinBtn.MouseEnter:Connect(function()
    TweenService:Create(MinBtn, TweenInfo.new(0.2), {BackgroundColor3 = Theme.ItemHover}):Play()
end)

MinBtn.MouseLeave:Connect(function()
    TweenService:Create(MinBtn, TweenInfo.new(0.2), {BackgroundColor3 = Theme.Item}):Play()
end)

-- Tab System
local TabSection = Instance.new("Frame")
TabSection.Name = "TabSection"
TabSection.Size = UDim2.new(0, 140, 1, -50)
TabSection.Position = UDim2.new(0, 0, 0, 50)
TabSection.BackgroundColor3 = Theme.TabBg
TabSection.BorderSizePixel = 0
TabSection.Parent = Main

local tabCorner = Instance.new("UICorner")
tabCorner.CornerRadius = UDim.new(0, 0)
tabCorner.Parent = TabSection

local TabList = Instance.new("UIListLayout")
TabList.Padding = UDim.new(0, 6)
TabList.HorizontalAlignment = Enum.HorizontalAlignment.Center
TabList.SortOrder = Enum.SortOrder.LayoutOrder
TabList.Parent = TabSection

local TabPadding = Instance.new("UIPadding")
TabPadding.PaddingTop = UDim.new(0, 8)
TabPadding.PaddingBottom = UDim.new(0, 8)
TabPadding.PaddingLeft = UDim.new(0, 6)
TabPadding.PaddingRight = UDim.new(0, 6)
TabPadding.Parent = TabSection

-- Content Area
local ContentArea = Instance.new("Frame")
ContentArea.Name = "ContentArea"
ContentArea.Size = UDim2.new(1, -150, 1, -60)
ContentArea.Position = UDim2.new(0, 145, 0, 55)
ContentArea.BackgroundTransparency = 1
ContentArea.BorderSizePixel = 0
ContentArea.Parent = Main

-- Page Container
local PageContainer = Instance.new("Frame")
PageContainer.Size = UDim2.new(1, 0, 1, 0)
PageContainer.BackgroundTransparency = 1
PageContainer.BorderSizePixel = 0
PageContainer.Parent = ContentArea

-- Tab and Page Management
local Tabs = {}
local Pages = {}
local CurrentPage = nil

local function CreateTabButton(name, icon, page)
    local TabBtn = Instance.new("TextButton")
    TabBtn.Name = name .. "Tab"
    TabBtn.Size = UDim2.new(1, -12, 0, 42)
    TabBtn.BackgroundColor3 = Theme.Item
    TabBtn.Text = "  " .. name
    TabBtn.TextColor3 = Theme.TextMuted
    TabBtn.Font = Enum.Font.GothamBold
    TabBtn.TextSize = 12
    TabBtn.AutoButtonColor = false
    TabBtn.TextXAlignment = Enum.TextXAlignment.Left
    TabBtn.Parent = TabSection

    local tabCorner = Instance.new("UICorner")
    tabCorner.CornerRadius = UDim.new(0, 8)
    tabCorner.Parent = TabBtn

    local tabStroke = Instance.new("UIStroke")
    tabStroke.Color = Theme.Border
    tabStroke.Thickness = 1
    tabStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    tabStroke.Parent = TabBtn

    -- Hover effects
    TabBtn.MouseEnter:Connect(function()
        if CurrentPage ~= page then
            TweenService:Create(TabBtn, TweenInfo.new(0.2), {BackgroundColor3 = Theme.ItemHover}):Play()
        end
    end)

    TabBtn.MouseLeave:Connect(function()
        if CurrentPage ~= page then
            TweenService:Create(TabBtn, TweenInfo.new(0.2), {BackgroundColor3 = Theme.Item}):Play()
        end
    end)

    -- Click handler
    TabBtn.MouseButton1Click:Connect(function()
        -- Update all tabs
        for _, tab in pairs(Tabs) do
            TweenService:Create(tab.Button, TweenInfo.new(0.2), {
                BackgroundColor3 = Theme.Item,
                TextColor3 = Theme.TextMuted
            }):Play()
            tab.Button.UIStroke.Color = Theme.Border
        end

        -- Update all pages
        for _, pg in pairs(Pages) do
            pg.Visible = false
        end

        -- Activate current
        CurrentPage = page
        page.Visible = true
        
        TweenService:Create(TabBtn, TweenInfo.new(0.2), {
            BackgroundColor3 = Theme.Accent,
            TextColor3 = Color3.new(1, 1, 1)
        }):Play()
        TabBtn.UIStroke.Color = Theme.AccentLight
    end)

    table.insert(Tabs, {Button = TabBtn, Page = page})
    return TabBtn
end

local function CreatePage()
    local Page = Instance.new("ScrollingFrame")
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.BorderSizePixel = 0
    Page.Visible = false
    Page.ScrollBarThickness = 3
    Page.ScrollBarImageColor3 = Theme.Accent
    Page.ScrollBarImageTransparency = 0.3
    Page.Parent = PageContainer

    local pageLayout = Instance.new("UIListLayout")
    pageLayout.Padding = UDim.new(0, 8)
    pageLayout.SortOrder = Enum.SortOrder.LayoutOrder
    pageLayout.Parent = Page

    local pagePadding = Instance.new("UIPadding")
    pagePadding.PaddingTop = UDim.new(0, 5)
    pagePadding.PaddingBottom = UDim.new(0, 10)
    pagePadding.PaddingLeft = UDim.new(0, 5)
    pagePadding.PaddingRight = UDim.new(0, 5)
    pagePadding.Parent = Page

    table.insert(Pages, Page)
    return Page
end

-- Create default pages
local HomePage = CreatePage()
local ScriptsPage = CreatePage()
local SettingsPage = CreatePage()

-- Create tab buttons
CreateTabButton("Home", "🏠", HomePage)
CreateTabButton("Scripts", "📜", ScriptsPage)
CreateTabButton("Settings", "⚙️", SettingsPage)

-- Home Page Content
local function CreateHomeContent()
    local welcomeCard = Instance.new("Frame")
    welcomeCard.Size = UDim2.new(1, 0, 0, 80)
    welcomeCard.BackgroundColor3 = Theme.Item
    welcomeCard.BorderSizePixel = 0
    welcomeCard.Parent = HomePage

    local cardCorner = Instance.new("UICorner")
    cardCorner.CornerRadius = UDim.new(0, 8)
    cardCorner.Parent = welcomeCard

    local cardStroke = Instance.new("UIStroke")
    cardStroke.Color = Theme.Border
    cardStroke.Thickness = 1
    cardStroke.Parent = welcomeCard

    local welcomeTitle = Instance.new("TextLabel")
    welcomeTitle.Size = UDim2.new(1, -20, 0, 30)
    welcomeTitle.Position = UDim2.new(0, 10, 0, 10)
    welcomeTitle.BackgroundTransparency = 1
    welcomeTitle.Text = "Welcome to " .. getgenv().HubName
    welcomeTitle.TextColor3 = Theme.Text
    welcomeTitle.Font = Enum.Font.GothamBlack
    welcomeTitle.TextSize = 18
    welcomeTitle.TextXAlignment = Enum.TextXAlignment.Left
    welcomeTitle.Parent = welcomeCard

    local welcomeDesc = Instance.new("TextLabel")
    welcomeDesc.Size = UDim2.new(1, -20, 0, 35)
    welcomeDesc.Position = UDim2.new(0, 10, 0, 40)
    welcomeDesc.BackgroundTransparency = 1
    welcomeDesc.Text = "Premium Roblox scripting hub optimized for Delta Executor. Enjoy seamless automation and farming features."
    welcomeDesc.TextColor3 = Theme.TextMuted
    welcomeDesc.Font = Enum.Font.GothamSemibold
    welcomeDesc.TextSize = 11
    welcomeDesc.TextWrapped = true
    welcomeDesc.TextXAlignment = Enum.TextXAlignment.Left
    welcomeDesc.Parent = welcomeCard

    -- Status Card
    local statusCard = Instance.new("Frame")
    statusCard.Size = UDim2.new(1, 0, 0, 60)
    statusCard.BackgroundColor3 = Theme.Item
    statusCard.BorderSizePixel = 0
    statusCard.Parent = HomePage

    local statusCorner = Instance.new("UICorner")
    statusCorner.CornerRadius = UDim.new(0, 8)
    statusCorner.Parent = statusCard

    local statusStroke = Instance.new("UIStroke")
    statusStroke.Color = Theme.Border
    statusStroke.Thickness = 1
    statusStroke.Parent = statusCard

    local statusTitle = Instance.new("TextLabel")
    statusTitle.Size = UDim2.new(1, -20, 0, 25)
    statusTitle.Position = UDim2.new(0, 10, 0, 8)
    statusTitle.BackgroundTransparency = 1
    statusTitle.Text = "System Status"
    statusTitle.TextColor3 = Theme.Text
    statusTitle.Font = Enum.Font.GothamBold
    statusTitle.TextSize = 13
    statusTitle.TextXAlignment = Enum.TextXAlignment.Left
    statusTitle.Parent = statusCard

    local statusIndicator = Instance.new("Frame")
    statusIndicator.Size = UDim2.new(0, 12, 0, 12)
    statusIndicator.Position = UDim2.new(0, 10, 0, 38)
    statusIndicator.BackgroundColor3 = Theme.Success
    statusIndicator.BorderSizePixel = 0
    statusIndicator.Parent = statusCard

    local indicatorCorner = Instance.new("UICorner")
    indicatorCorner.CornerRadius = UDim.new(0.5, 0)
    indicatorCorner.Parent = statusIndicator

    local statusText = Instance.new("TextLabel")
    statusText.Size = UDim2.new(1, -30, 0, 20)
    statusText.Position = UDim2.new(0, 28, 0, 34)
    statusText.BackgroundTransparency = 1
    statusText.Text = "Delta Executor Compatible • All Systems Ready"
    statusText.TextColor3 = Theme.Success
    statusText.Font = Enum.Font.GothamSemibold
    statusText.TextSize = 11
    statusText.TextXAlignment = Enum.TextXAlignment.Left
    statusText.Parent = statusCard

    -- Quick Actions
    local quickTitle = Instance.new("TextLabel")
    quickTitle.Size = UDim2.new(1, 0, 0, 25)
    quickTitle.BackgroundTransparency = 1
    quickTitle.Text = "Quick Actions"
    quickTitle.TextColor3 = Theme.Text
    quickTitle.Font = Enum.Font.GothamBold
    quickTitle.TextSize = 14
    quickTitle.TextXAlignment = Enum.TextXAlignment.Left
    quickTitle.Parent = HomePage

    local actionGrid = Instance.new("Frame")
    actionGrid.Size = UDim2.new(1, 0, 0, 100)
    actionGrid.BackgroundTransparency = 1
    actionGrid.Parent = HomePage

    local gridLayout = Instance.new("UIGridLayout")
    gridLayout.CellSize = UDim2.new(0, 105, 0, 45)
    gridLayout.CellPadding = UDim.new(0, 8)
    gridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
    gridLayout.SortOrder = Enum.SortOrder.LayoutOrder
    gridLayout.Parent = actionGrid

    local function CreateActionButton(text, color)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 105, 0, 45)
        btn.BackgroundColor3 = Theme.Item
        btn.Text = text
        btn.TextColor3 = Theme.Text
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 11
        btn.AutoButtonColor = false
        btn.Parent = actionGrid

        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 6)
        btnCorner.Parent = btn

        local btnStroke = Instance.new("UIStroke")
        btnStroke.Color = Theme.Border
        btnStroke.Thickness = 1
        btnStroke.Parent = btn

        btn.MouseEnter:Connect(function()
            TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = color or Theme.ItemHover}):Play()
        end)

        btn.MouseLeave:Connect(function()
            TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Theme.Item}):Play()
        end)

        return btn
    end

    CreateActionButton("Execute All", Theme.Accent)
    CreateActionButton("Refresh UI", Color3.fromRGB(85, 170, 255))
    CreateActionButton("Clear Logs", Color3.fromRGB(255, 170, 85))
    CreateActionButton("Rejoin Game", Color3.fromRGB(170, 85, 255))
end

CreateHomeContent()

-- Scripts Page with Auto-Load functionality
local function CreateScriptLoader(name, description, loadLink)
    local scriptCard = Instance.new("Frame")
    scriptCard.Size = UDim2.new(1, 0, 0, 90)
    scriptCard.BackgroundColor3 = Theme.Item
    scriptCard.BorderSizePixel = 0
    scriptCard.Parent = ScriptsPage

    local cardCorner = Instance.new("UICorner")
    cardCorner.CornerRadius = UDim.new(0, 8)
    cardCorner.Parent = scriptCard

    local cardStroke = Instance.new("UIStroke")
    cardStroke.Color = Theme.Border
    cardStroke.Thickness = 1
    cardStroke.Parent = scriptCard

    local scriptTitle = Instance.new("TextLabel")
    scriptTitle.Size = UDim2.new(1, -20, 0, 25)
    scriptTitle.Position = UDim2.new(0, 12, 0, 8)
    scriptTitle.BackgroundTransparency = 1
    scriptTitle.Text = name
    scriptTitle.TextColor3 = Theme.Text
    scriptTitle.Font = Enum.Font.GothamBold
    scriptTitle.TextSize = 14
    scriptTitle.TextXAlignment = Enum.TextXAlignment.Left
    scriptTitle.Parent = scriptCard

    local scriptDesc = Instance.new("TextLabel")
    scriptDesc.Size = UDim2.new(1, -140, 0, 35)
    scriptDesc.Position = UDim2.new(0, 12, 0, 32)
    scriptDesc.BackgroundTransparency = 1
    scriptDesc.Text = description
    scriptDesc.TextColor3 = Theme.TextMuted
    scriptDesc.Font = Enum.Font.GothamSemibold
    scriptDesc.TextSize = 11
    scriptDesc.TextWrapped = true
    scriptDesc.TextXAlignment = Enum.TextXAlignment.Left
    scriptDesc.Parent = scriptCard

    local loadBtn = Instance.new("TextButton")
    loadBtn.Size = UDim2.new(0, 100, 0, 32)
    loadBtn.Position = UDim2.new(1, -112, 0, 45)
    loadBtn.BackgroundColor3 = Theme.Accent
    loadBtn.Text = "Load Script"
    loadBtn.TextColor3 = Color3.new(1, 1, 1)
    loadBtn.Font = Enum.Font.GothamBold
    loadBtn.TextSize = 11
    loadBtn.AutoButtonColor = false
    loadBtn.Parent = scriptCard

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = loadBtn

    local statusLabel = Instance.new("TextLabel")
    statusLabel.Size = UDim2.new(0, 100, 0, 20)
    statusLabel.Position = UDim2.new(1, -112, 0, 8)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Text = "Ready"
    statusLabel.TextColor3 = Theme.Success
    statusLabel.Font = Enum.Font.GothamSemibold
    statusLabel.TextSize = 10
    statusLabel.TextXAlignment = Enum.TextXAlignment.Right
    statusLabel.Parent = scriptCard

    local isLoaded = false

    loadBtn.MouseEnter:Connect(function()
        TweenService:Create(loadBtn, TweenInfo.new(0.2), {BackgroundColor3 = Theme.AccentLight}):Play()
    end)

    loadBtn.MouseLeave:Connect(function()
        TweenService:Create(loadBtn, TweenInfo.new(0.2), {BackgroundColor3 = Theme.Accent}):Play()
    end)

    loadBtn.MouseButton1Click:Connect(function()
        if isLoaded then
            statusLabel.Text = "Already Loaded"
            statusLabel.TextColor3 = Theme.Warning
            return
        end

        statusLabel.Text = "Loading..."
        statusLabel.TextColor3 = Theme.Warning
        loadBtn.Text = "..."

        task.spawn(function()
            local success, result = pcall(function()
                if loadLink and loadLink ~= "" then
                    local scriptCode = game:HttpGet(loadLink)
                    local func, err = loadstring(scriptCode)
                    
                    if func then
                        func()
                        return true
                    else
                        return false, "Compile Error: " .. tostring(err)
                    end
                else
                    return false, "Invalid link"
                end
            end)

            if success then
                isLoaded = true
                statusLabel.Text = "Loaded ✓"
                statusLabel.TextColor3 = Theme.Success
                loadBtn.Text = "Loaded"
                TweenService:Create(loadBtn, TweenInfo.new(0.2), {BackgroundColor3 = Theme.Success}):Play()
            else
                statusLabel.Text = "Failed"
                statusLabel.TextColor3 = Theme.Error
                loadBtn.Text = "Retry"
                warn(name .. " failed to load: " .. tostring(result))
            end
        end)
    end)
end

-- Create script loaders
CreateScriptLoader("Pabrik System", "Automated factory management and production system.", "https://raw.githubusercontent.com/Koziz/CAW-SCRIPT/refs/heads/main/Pabrik.lua")
CreateScriptLoader("Auto Farm", "Resource farming automation for wood, stone, and more.", "https://raw.githubusercontent.com/Koziz/CAW-SCRIPT/refs/heads/main/Autofarm.lua")
CreateScriptLoader("Manager", "Inventory management and item sorting system.", "https://raw.githubusercontent.com/ZonHUBs/ZONHUB/refs/heads/main/manager.lua")
CreateScriptLoader("Teleport Hub", "Quick teleportation to various locations.", "")
CreateScriptLoader("ESP System", "Enhanced player visualization and tracking.", "")

-- Settings Page
local function CreateSettingsContent()
    local settingsTitle = Instance.new("TextLabel")
    settingsTitle.Size = UDim2.new(1, 0, 0, 30)
    settingsTitle.BackgroundTransparency = 1
    settingsTitle.Text = "Configuration"
    settingsTitle.TextColor3 = Theme.Text
    settingsTitle.Font = Enum.Font.GothamBlack
    settingsTitle.TextSize = 16
    settingsTitle.TextXAlignment = Enum.TextXAlignment.Left
    settingsTitle.Parent = SettingsPage

    local function CreateSettingToggle(name, description, default)
        local toggleCard = Instance.new("Frame")
        toggleCard.Size = UDim2.new(1, 0, 0, 55)
        toggleCard.BackgroundColor3 = Theme.Item
        toggleCard.BorderSizePixel = 0
        toggleCard.Parent = SettingsPage

        local cardCorner = Instance.new("UICorner")
        cardCorner.CornerRadius = UDim.new(0, 8)
        cardCorner.Parent = toggleCard

        local toggleTitle = Instance.new("TextLabel")
        toggleTitle.Size = UDim2.new(1, -60, 0, 22)
        toggleTitle.Position = UDim2.new(0, 12, 0, 8)
        toggleTitle.BackgroundTransparency = 1
        toggleTitle.Text = name
        toggleTitle.TextColor3 = Theme.Text
        toggleTitle.Font = Enum.Font.GothamBold
        toggleTitle.TextSize = 12
        toggleTitle.TextXAlignment = Enum.TextXAlignment.Left
        toggleTitle.Parent = toggleCard

        local toggleDesc = Instance.new("TextLabel")
        toggleDesc.Size = UDim2.new(1, -60, 0, 18)
        toggleDesc.Position = UDim2.new(0, 12, 0, 28)
        toggleDesc.BackgroundTransparency = 1
        toggleDesc.Text = description
        toggleDesc.TextColor3 = Theme.TextMuted
        toggleDesc.Font = Enum.Font.GothamSemibold
        toggleDesc.TextSize = 10
        toggleDesc.TextXAlignment = Enum.TextXAlignment.Left
        toggleDesc.Parent = toggleCard

        local toggleSwitch = Instance.new("TextButton")
        toggleSwitch.Size = UDim2.new(0, 44, 0, 24)
        toggleSwitch.Position = UDim2.new(1, -56, 0, 16)
        toggleSwitch.BackgroundColor3 = default and Theme.Accent or Theme.Border
        toggleSwitch.Text = ""
        toggleSwitch.AutoButtonColor = false
        toggleSwitch.Parent = toggleCard

        local switchCorner = Instance.new("UICorner")
        switchCorner.CornerRadius = UDim.new(0.5, 0)
        switchCorner.Parent = toggleSwitch

        local switchKnob = Instance.new("Frame")
        switchKnob.Size = UDim2.new(0, 18, 0, 18)
        switchKnob.Position = UDim2.new(0, default and 22 or 4, 0, 3)
        switchKnob.BackgroundColor3 = Color3.new(1, 1, 1)
        switchKnob.BorderSizePixel = 0
        switchKnob.Parent = toggleSwitch

        local knobCorner = Instance.new("UICorner")
        knobCorner.CornerRadius = UDim.new(0.5, 0)
        knobCorner.Parent = switchKnob

        local isOn = default
        toggleSwitch.MouseButton1Click:Connect(function()
            isOn = not isOn
            TweenService:Create(toggleSwitch, TweenInfo.new(0.2), {
                BackgroundColor3 = isOn and Theme.Accent or Theme.Border
            }):Play()
            TweenService:Create(switchKnob, TweenInfo.new(0.2), {
                Position = UDim2.new(0, isOn and 22 or 4, 0, 3)
            }):Play()
        end)
    end

    CreateSettingToggle("Auto Execute", "Automatically load scripts on game join", true)
    CreateSettingToggle("Silent Aim", "Enable silent aiming features", false)
    CreateSettingToggle("ESP Visible", "Show ESP for all players", true)
    CreateSettingToggle("Notifications", "Show script notifications", true)
end

CreateSettingsContent()

-- UI Toggle Functionality
local isMinimized = false
local isVisible = true

local function ToggleUI()
    isVisible = not isVisible
    
    if isVisible then
        Main.Visible = true
        HubButton.Visible = false
        
        -- Animate in
        Main.Size = UDim2.new(0, 520, 0, 380)
        Main.Position = UDim2.new(0.5, -260, 0.5, -190)
    else
        Main.Visible = false
        HubButton.Visible = true
        
        -- Position button where window was
        HubButton.Position = Main.Position
    end
end

-- Button animations
HubButton.MouseEnter:Connect(function()
    TweenService:Create(HubButton, TweenInfo.new(0.2), {
        Size = UDim2.new(0, 60, 0, 60),
        BackgroundColor3 = Theme.AccentLight
    }):Play()
    TweenService:Create(btnGlow, TweenInfo.new(0.2), {ImageTransparency = 0.4}):Play()
end)

HubButton.MouseLeave:Connect(function()
    TweenService:Create(HubButton, TweenInfo.new(0.2), {
        Size = UDim2.new(0, 55, 0, 55),
        BackgroundColor3 = Theme.Accent
    }):Play()
    TweenService:Create(btnGlow, TweenInfo.new(0.2), {ImageTransparency = 0.7}):Play()
end)

HubButton.MouseButton1Click:Connect(ToggleUI)
MinBtn.MouseButton1Click:Connect(ToggleUI)

-- Draggable functionality
local dragging = false
local dragStart = nil
local startPos = nil

local function MakeDraggable(frame, trigger)
    trigger.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            
            local connection
            connection = input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                    connection:Disconnect()
                end
            end)
        end
    end)
    
    trigger.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    UIS.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(
                startPos.X.Scale, 
                startPos.X.Offset + delta.X,
                startPos.Y.Scale, 
                startPos.Y.Offset + delta.Y
            )
        end
    end)
end

MakeDraggable(Main, Header)
MakeDraggable(HubButton, HubButton)

-- Initialize - Show button first
Main.Visible = false
HubButton.Visible = true

-- Select first tab by default
if #Tabs > 0 then
    Tabs[1].Button.BackgroundColor3 = Theme.Accent
    Tabs[1].Button.TextColor3 = Color3.new(1, 1, 1)
    Tabs[1].Button.UIStroke.Color = Theme.AccentLight
    Pages[1].Visible = true
    CurrentPage = Pages[1]
end

-- Notification system
local function ShowNotification(title, message, duration)
    duration = duration or 3
    
    local notifContainer = Instance.new("Frame")
    notifContainer.Size = UDim2.new(0, 280, 0, 70)
    notifContainer.Position = UDim2.new(1, -300, 0.85, 0)
    notifContainer.BackgroundColor3 = Theme.Item
    notifContainer.BorderSizePixel = 0
    notifContainer.Parent = ScreenGui
    
    local notifCorner = Instance.new("UICorner")
    notifCorner.CornerRadius = UDim.new(0, 8)
    notifCorner.Parent = notifContainer
    
    local notifStroke = Instance.new("UIStroke")
    notifStroke.Color = Theme.Border
    notifStroke.Thickness = 1
    notifStroke.Parent = notifContainer
    
    local notifTitle = Instance.new("TextLabel")
    notifTitle.Size = UDim2.new(1, -20, 0, 25)
    notifTitle.Position = UDim2.new(0, 10, 0, 8)
    notifTitle.BackgroundTransparency = 1
    notifTitle.Text = title
    notifTitle.TextColor3 = Theme.Accent
    notifTitle.Font = Enum.Font.GothamBold
    notifTitle.TextSize = 13
    notifTitle.TextXAlignment = Enum.TextXAlignment.Left
    notifTitle.Parent = notifContainer
    
    local notifDesc = Instance.new("TextLabel")
    notifDesc.Size = UDim2.new(1, -20, 0, 30)
    notifDesc.Position = UDim2.new(0, 10, 0, 32)
    notifDesc.BackgroundTransparency = 1
    notifDesc.Text = message
    notifDesc.TextColor3 = Theme.TextMuted
    notifDesc.Font = Enum.Font.GothamSemibold
    notifDesc.TextSize = 11
    notifDesc.TextWrapped = true
    notifDesc.TextXAlignment = Enum.TextXAlignment.Left
    notifDesc.Parent = notifContainer
    
    -- Animate in
    notifContainer.Position = UDim2.new(1, -280, 0.85, 0)
    TweenService:Create(notifContainer, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(1, -300, 0.85, 0)
    }):Play()
    
    -- Auto remove
    task.delay(duration, function()
        TweenService:Create(notifContainer, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Position = UDim2.new(1, -280, 0.85, 0),
            ImageTransparency = 1
        }):Play()
        
        task.delay(0.3, function()
            notifContainer:Destroy()
        end)
    end)
end

-- Show welcome notification
task.delay(0.5, function()
    ShowNotification(getgenv().HubName .. " Loaded", "Version " .. getgenv().HubVersion .. " ready for Delta Executor", 4)
end)

-- Console output for debugging
print("[" .. getgenv().HubName .. "] UI Loaded Successfully")
print("[" .. getgenv().HubName .. "] Version: " .. getgenv().HubVersion)
print("[" .. getgenv().HubName .. "] Delta Compatible: " .. tostring(IS_DELTA)
CreateAutoLoadTab("Pabrik", "Memuat otomatis sistem Pabrik.", "https://raw.githubusercontent.com/Koziz/CAW-SCRIPT/refs/heads/main/Pabrik.lua")
CreateAutoLoadTab("Auto Farm", "Sistem farming resource (Kayu, Batu).", "https://raw.githubusercontent.com/Koziz/CAW-SCRIPT/refs/heads/main/Autofarm.lua")
CreateAutoLoadTab("Manager", "Sistem Inventory & Sortir Barang.", "https://raw.githubusercontent.com/ZonHUBs/ZONHUB/refs/heads/main/manager.lua")
