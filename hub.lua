-- Klakz Hub - Kesin Çözüm Scripti
local HttpService = game:GetService("HttpService")

-- Doğrudan Firebase veritabanı JSON adresi (Vercel'i aradan çıkarıyoruz)
local firebaseURL = "https://klakz-database-default-rtdb.firebaseio.com/scripts.json"

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KlakzHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 450, 0, 320)
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 45)
Title.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Text = "Klakz Hub - Canlı Sistem"
Title.TextSize = 16
Title.Font = Enum.Font.SourceSansBold
Title.Parent = MainFrame

local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Size = UDim2.new(1, -20, 1, -65)
ScrollingFrame.Position = UDim2.new(0, 10, 0, 55)
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
ScrollingFrame.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 8)
UIListLayout.Parent = ScrollingFrame

task.spawn(function()
    local success, response = pcall(function()
        -- Doğrudan Firebase'e istek atıyoruz
        return HttpService:JSONDecode(HttpService:GetAsync(firebaseURL))
    end)
    
    if success and response then
        for id, scriptData in pairs(response) do
            if type(scriptData) == "table" and scriptData.title and scriptData.code then
                local btn = Instance.new("TextButton")
                btn.Size = UDim2.new(1, 0, 0, 45)
                btn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
                btn.TextColor3 = Color3.fromRGB(255, 255, 255)
                btn.Text = "🎮 " .. tostring(scriptData.title)
                btn.TextSize = 14
                btn.Font = Enum.Font.SourceSansBold
                btn.Parent = ScrollingFrame
                
                btn.MouseButton1Click:Connect(function()
                    pcall(function()
                        loadstring(scriptData.code)()
                    end)
                end)
            end
        end
    else
        local errLbl = Instance.new("TextLabel")
        errLbl.Size = UDim2.new(1, 0, 0, 40)
        errLbl.TextColor3 = Color3.fromRGB(255, 50, 50)
        errLbl.Text = "Veriler çekilemedi! Bağlantıyı kontrol et."
        errLbl.TextSize = 13
        errLbl.Parent = ScrollingFrame
    end
end)
