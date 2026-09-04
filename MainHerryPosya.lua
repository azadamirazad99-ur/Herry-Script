-- ===================================================
-- 👑 HERRY HACKS OFFICIAL - LOADER (HerryPosya.lua) 👑
-- ===================================================

local POSYA_RAW_LINK = "https://github.com/urdushahzaib111-ctrl/HerryBot-v4/blob/main/PosyaByHerry.lua"
local KEYS_RAW_LINK = "https://github.com/urdushahzaib111-ctrl/HerryBot-v4/blob/main/keys.txt"

local SECRET_OWNER_KEY = "HERRY_SECRET_PROTECT_2026_VIP"

local function cleanStr(str)
    if not str then return "" end
    return (str:gsub("%s+", ""):gsub("\r", ""):gsub("\n", ""))
end

-- 1. WELCOME POPUP
if not _G.FIRST_RUN_POPUP then
    _G.FIRST_RUN_POPUP = true
    gg.alert([[
░▒▓█ HERRY HACKS OFFICIAL █▓▒░

✨ WELCOME TO HERRY SCRIPT SYSTEM ✨

🔑 How to Get Key?
1️⃣ Go to HerryHacks Server.
2️⃣ Find the Channel: #├📃│get-key

❓ Don't have HerryHacks Server?
📩 DM Owner on Discord: herry_escobarr
]])
end

-- 2. VIP KEY VERIFICATION SYSTEM
gg.toast("⚡ [HERRY HACKS] Verifying Access...")

local input = gg.prompt({'🔑 Enter Your VIP Access Key:'}, {[1]=''}, {[1]='text'})
if not input or cleanStr(input[1]) == '' then
    gg.alert("❌ Access Denied: Key cannot be empty!")
    os.exit()
end

local userKey = cleanStr(input[1])

if userKey == SECRET_OWNER_KEY then
    gg.toast("👑 Master Owner Key Activated!")
else
    local keys_response = gg.makeRequest(KEYS_RAW_LINK, {
        ['User-Agent'] = 'Mozilla/5.0 (Linux; Android 10)'
    })

    if not keys_response or keys_response.code ~= 200 then
        gg.alert("❌ Network Error: Unable to connect to Key Server!")
        os.exit()
    end

    local isValidKey = false
    local currentSec = os.time()
    local currentMs = currentSec * 1000

    for line in keys_response.content:gmatch("[^\r\n]+") do
        local cleanedLine = cleanStr(line)
        local kName, kExpiry = line:match("([^|]+)|([^|]+)")

        if kName then
            if cleanStr(kName):lower() == userKey:lower() then
                local expTime = tonumber(cleanStr(kExpiry))
                if expTime then
                    local isExpired = false
                    if expTime > 1000000000000 then
                        if expTime < currentMs then isExpired = true end
                    else
                        if expTime < currentSec then isExpired = true end
                    end

                    if isExpired then
                        gg.alert("❌ Key Has Expired!\nPlease get a new key from Discord.")
                        os.exit()
                    end
                end
                isValidKey = true
                break
            end
        else
            if cleanedLine:lower() == userKey:lower() then
                isValidKey = true
                break
            end
        end
    end

    if not isValidKey then
        gg.alert("❌ Invalid or Expired Key!\n\nGet a key from Discord (#├📃│get-key).")
        os.exit()
    end
end

gg.alert([[
👑 HERRY HACKS VIP v4.0 👑
👤 Owner: Herry | 🎮 Game: Grand Mobile
🟢 Status: Running / Safe ✅

⚠️ NOTE: If you paid for this script, you got scammed! This hack is 100% FREE!
📩 Free Access / DM: herry_escobarr
]])

-- 3. AUTO FETCH MAIN SCRIPT (EVERY TIME LATEST)
function LOAD_POSYA_FAST()
    gg.toast("🔥 Loading Latest Posya Script...")

    local live_link = POSYA_RAW_LINK .. "?v=" .. os.time()
    local res = gg.makeRequest(live_link, {
        ['User-Agent'] = 'Mozilla/5.0 (Linux; Android 10)'
    })

    if res and res.code == 200 and res.content and #res.content > 10 then
        local runPosya, err = (loadstring or load)(res.content)
        if runPosya then
            pcall(runPosya)
        else
            gg.alert("❌ Syntax Error in Posya Script:\n" .. tostring(err))
        end
    else
        gg.alert("❌ Connection Delay! Please re-try.")
    end
end

-- 4. MAIN MENU
function MAIN_MENU()
    local options = {
        '⚡ Herry-Script [Coming Soon]',
        '🔥 Posya-Russian [v4.0]',
        '🌐 Posya-English [Coming Soon]',
        '❌ Exit Script'
    }

    local menu = gg.choice(options, nil, "👑 HERRY HACKS VIP CONTROL")

    if menu == nil then
        gg.toast("🙈 Menu Hidden! Click GG Icon to Re-open.")
        return
    end

    if menu == 1 then
        gg.alert("🚀 Herry-Script is under heavy development!\nStay tuned in Discord.")
    elseif menu == 2 then
        LOAD_POSYA_FAST()
    elseif menu == 3 then
        gg.alert("🌐 Posya-English Version is Coming Soon!")
    elseif menu == 4 then
        gg.toast("👋 Exiting Herry Hacks...")
        os.exit()
    end
end

while true do
    if gg.isVisible(true) then
        gg.setVisible(false)
        MAIN_MENU()
    end
    gg.sleep(100)
end
