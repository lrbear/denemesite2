-- Klakz Hub Ana Scripti
local HttpService = game:GetService("HttpService")

-- Sitenin Firebase veritabanı adresi
local firebaseURL = "https://klakz-database-default-rtdb.firebaseio.com/scripts.json"

-- Önce şık bir arayüz (UI) oluşturalım
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KlakzHub"
ScreenGui.Parent = game.CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 450, 0, 300)
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Text = "Klakz Hub - Siteden Gelen Scriptler"
Title.TextSize = 16
Title.Font = Enum.Font.SourceSansBold
Title.Parent = MainFrame

local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Size = UDim2.new(1, -20, 1, -60)
ScrollingFrame.Position = UDim2.new(0, 10, 0, 50)
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.Offset(5, 5)
UIListLayout.Parent = ScrollingFrame

-- Siteden verileri çekme ve menüye ekleme fonksiyonu
task.spawn(function()
    local success, response = pcall(function()
        return HttpService:JSONDecode(HttpService:GetAsync(firebaseURL))
    end)
    
    if success and response then
        for id, scriptData in pairs(response) do
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, 0, 0, 40)
            btn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            btn.Text = scriptData.title or "İsimsiz Oyun"
            btn.TextSize = 14
            btn.Font = Enum.Font.SourceSans
            btn.Parent = ScrollingFrame
            
            -- Butona basıldığında siteden gelen asıl Lua kodunu çalıştır
            btn.MouseButton1Click:Connect(function()
                if scriptData.code then
                    local runSuccess, err = pcall(function()
                        loadstring(scriptData.code)()
                    end)
                    if not runSuccess then
                        warn("Script Çalıştırılamadı: " .. tostring(err))
                    end
                end
            end)
        end
    else
        local errLbl = Instance.new("TextLabel")
        errLbl.Size = UDim2.new(1, 0, 0, 40)
        errLbl.TextColor3 = Color3.fromRGB(255, 50, 50)
        errLbl.Text = "Scriptler siteden çekilemedi!"
        errLbl.Parent = ScrollingFrame
    end
end)
