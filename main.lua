-- 🔐 USERID KORUMA
local allowed = {
    [9867529370] = true -- SEN
}

local player = game.Players.LocalPlayer
if not allowed[player.UserId] then
    player:Kick("Yetkin yok")
    return
end

-- 🔽 ASIL SCRIPT BURADA
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
    Name = "FunScripts UI",
    LoadingTitle = "FunScripts",
    LoadingSubtitle = "Teleport & Character",
    Theme = "Default",
    KeySystem = false
})

-- HOME TAB
local HomeTab = Window:CreateTab("🏡 Home", nil)
local SavedCFrame = nil

HomeTab:CreateButton({
    Name = "📍 Set Teleport Location",
    Callback = function()
        local char = player.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            SavedCFrame = char.HumanoidRootPart.CFrame
        end
    end
})

HomeTab:CreateButton({
    Name = "🚀 Teleport",
    Callback = function()
        local char = player.Character
        if char and char:FindFirstChild("HumanoidRootPart") and SavedCFrame then
            char.HumanoidRootPart.CFrame = SavedCFrame
        end
    end
})

-- CHARACTER TAB
local CharTab = Window:CreateTab("🧍 Character", nil)

CharTab:CreateSlider({
    Name = "WalkSpeed",
    Range = {16, 500},
    Increment = 1,
    CurrentValue = 16,
    Callback = function(v)
        local char = player.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = v
        end
    end
})

CharTab:CreateButton({
    Name = "Fly",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))()
    end
})

local noclip = false
local rs = game:GetService("RunService")

CharTab:CreateToggle({
    Name = "Noclip",
    CurrentValue = false,
    Callback = function(state)
        noclip = state
    end
})

rs.Stepped:Connect(function()
    if noclip then
        local char = player.Character
        if char then
            for _, v in pairs(char:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.CanCollide = false
                end
            end
        end
    end
end)
