-- 1. GitHub Bağlantılı Özel Key Ekranı
local CoreGui = game:GetService("CoreGui")

if CoreGui:FindFirstChild("KlakzKeySystem") then
    CoreGui.KlakzKeySystem:Destroy()
end

local KeyGui = Instance.new("ScreenGui")
KeyGui.Name = "KlakzKeySystem"
KeyGui.Parent = CoreGui

local KeyFrame = Instance.new("Frame")
KeyFrame.Size = UDim2.new(0, 320, 0, 180)
KeyFrame.Position = UDim2.new(0.5, -160, 0.5, -90)
KeyFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
KeyFrame.BorderSizePixel = 0
KeyFrame.Parent = KeyGui

local KeyCorner = Instance.new("UICorner")
KeyCorner.CornerRadius = UDim.new(0, 8)
KeyCorner.Parent = KeyFrame

local KeyTitle = Instance.new("TextLabel")
KeyTitle.Size = UDim2.new(1, 0, 0, 40)
KeyTitle.BackgroundTransparency = 1
KeyTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyTitle.Text = "Klakz Hub - Online Key"
KeyTitle.TextSize = 16
KeyTitle.Font = Enum.Font.SourceSansBold
KeyTitle.Parent = KeyFrame

local TextBox = Instance.new("TextBox")
TextBox.Size = UDim2.new(0.8, 0, 0, 40)
TextBox.Position = UDim2.new(0.1, 0, 0, 55)
TextBox.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.PlaceholderText = "GitHub'daki key'i yazın..."
TextBox.Text = ""
TextBox.TextSize = 14
TextBox.Font = Enum.Font.SourceSans
TextBox.Parent = KeyFrame

local BoxCorner = Instance.new("UICorner")
BoxCorner.CornerRadius = UDim.new(0, 6)
BoxCorner.Parent = TextBox

local SubmitBtn = Instance.new("TextButton")
SubmitBtn.Size = UDim2.new(0.8, 0, 0, 40)
SubmitBtn.Position = UDim2.new(0.1, 0, 0, 110)
SubmitBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitBtn.Text = "Key'i Kontrol Et"
SubmitBtn.TextSize = 14
SubmitBtn.Font = Enum.Font.SourceSansBold
SubmitBtn.Parent = KeyFrame

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 6)
BtnCorner.Parent = SubmitBtn

-- Key Doğrulama (GitHub'dan çekerek)
SubmitBtn.MouseButton1Click:Connect(function()
    SubmitBtn.Text = "Kontrol Ediliyor..."
    
    local githubKeyUrl = "https://raw.githubusercontent.com/lrbear/klakz-hub/refs/heads/main/key.txt"
    
    local success, remoteKey = pcall(function()
        return game:HttpGet(githubKeyUrl)
    end)
    
    if success and remoteKey then
        remoteKey = remoteKey:gsub("%s+", "")
        local userInput = TextBox.Text:gsub("%s+", "")
        
        if userInput == remoteKey then
            KeyGui:Destroy()
            
            -- Rayfield UI Kütüphanesini Yükleme
            local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

            local Window = Rayfield:CreateWindow({
               Name = "Klakz Hub",
               LoadingTitle = "Klakz Hub Yükleniyor...",
               LoadingSubtitle = "by Klakz",
               Theme = "Default",
               ConfigurationSaving = { Enabled = false },
               Discord = { Enabled = false, Invite = "noinvite" },
               KeySystem = false
            })

            -- Ana Sekme (Scriptler)
            local MainTab = Window:CreateTab("Scriptler", 4483362458)
            local MainSection = MainTab:CreateSection("Oyun Scriptleri")

            -- 1. Script Butonu: 2 Player Evolution Tycoon
            MainTab:CreateButton({
               Name = "2Player Evolution Tycoon",
               Callback = function()
                   local success, err = pcall(function()
                       loadstring(game:HttpGet("https://raw.githubusercontent.com/gumanba/Scripts/main/2PLAYEREvolutionTycoon"))()
                   end)
                   if not success then
                       warn("Script çalıştırılamadı: " .. tostring(err))
                   end
               end,
            })

            -- 2. Script Butonu: Murders vs Sheriff
            MainTab:CreateButton({
               Name = "Murders vs Sheriff",
               Callback = function()
                   local success, err = pcall(function()
                       loadstring(game:HttpGet("https://pastebin.com/raw/uZGr28ym"))()
                   end)
                   if not success then
                       warn("Script çalıştırılamadı: " .. tostring(err))
                   end
               end,
            })

            -- Ayarlar Sekmesi
            local MiscTab = Window:CreateTab("Ayarlar", 6023426915)

            MiscTab:CreateButton({
               Name = "Made in Turkey",
               Callback = function()
                   local chatSuccess = pcall(function()
                       game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("Made in Turkey")
                   end)
                   if not chatSuccess then
                       game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest"):FireServer("Made in Turkey", "All")
                   end
               end,
            })

            MiscTab:CreateButton({
               Name = "Menüyü Kapat",
               Callback = function()
                  Rayfield:Destroy()
               end,
            })
        else
            SubmitBtn.Text = "Key'i Kontrol Et"
            TextBox.Text = ""
            TextBox.PlaceholderText = "Yanlış Key!"
        end
    else
        SubmitBtn.Text = "Key'i Kontrol Et"
        TextBox.PlaceholderText = "Bağlantı Hatası!"
    end
end)
