-- ===================================================
-- 👑 HERRY HACKS OFFICIAL - MAIN MASTER SCRIPT 👑
-- ===================================================

-- RAW GitHub Links
local KEYS_RAW_LINK = "https://raw.githubusercontent.com/azadamirazad99-ur/Herry-Script/main/keys.txt"
local POSYA_RUSSIAN_RAW = "https://raw.githubusercontent.com/azadamirazad99-ur/HerryBot-v4/main/PosyaByHerry.lua"

local SECRET_OWNER_KEY = "HERRY_SECRET_PROTECT_2026_VIP"

local function cleanStr(str)
    if not str then return "" end
    return (str:gsub("%s+", ""):gsub("\r", ""):gsub("\n", ""))
end

-- ---------------------------------------------------
-- 1. WELCOME POPUP
-- ---------------------------------------------------
if not _G.FIRST_RUN_POPUP then
    _G.FIRST_RUN_POPUP = true
    gg.alert([[
░▒▓█ HERRY HACKS OFFICIAL █▓▒░

✨ WELCOME TO HERRY SCRIPT SYSTEM ✨

🔑 How to Get Key?
1️⃣ Go to HerryHacks Server.
2️⃣ Find Channel: #├📃│get-key

❓ Don't have HerryHacks Server?
📩 DM Owner on Discord: herry_escobarr
]])
end

-- ---------------------------------------------------
-- 2. VIP KEY VERIFICATION SYSTEM
-- ---------------------------------------------------
gg.toast("⚡ [HERRY HACKS] Verifying Access...")

local input = gg.prompt({'🔑 Enter Your VIP Access Key:'}, {[1]=''}, {[1]='text'})
if not input or cleanStr(input[1]) == '' then
    gg.alert("❌ Access Denied: Key cannot be empty!")
    os.exit()
end

local userKey = cleanStr(input[1]):lower()

-- Secret Owner Key Bypass
if userKey == SECRET_OWNER_KEY:lower() then
    gg.toast("👑 Master Owner Key Activated!")
else
    -- Added Request Headers to prevent blocking by ISP/Sandbox
    local keys_response = gg.makeRequest(KEYS_RAW_LINK .. "?v=" .. os.time(), {
        ['User-Agent'] = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)',
        ['Accept'] = '*/*'
    })

    -- Check if content exists regardless of strict response code (bypasses sandbox network bugs)
    if not keys_response or not keys_response.content or #keys_response.content == 0 then
        gg.alert("❌ Network Error: Unable to connect to Key Server!\n\nCheck Virtual Space Internet Permissions or Private DNS.")
        os.exit()
    end

    local isValidKey = false
    local currentSec = os.time()
    local currentMs = currentSec * 1000

    for line in keys_response.content:gmatch("[^\r\n]+") do
        local cleanedLine = cleanStr(line)
        if cleanedLine ~= "" then
            -- Parse lines in KEY|EXPIRY|USERID format
            local kName, kExpiry = line:match("^([^|]+)|?([^|]*)")

            if kName and cleanStr(kName):lower() == userKey then
                local expTime = tonumber(cleanStr(kExpiry))
                if expTime then
                    local isExpired = (expTime > 1000000000000) and (expTime < currentMs) or (expTime < currentSec)
                    if isExpired then
                        gg.alert("❌ Key Has Expired!\nPlease get a new key from Discord.")
                        os.exit()
                    end
                end
                isValidKey = true
                break
            elseif cleanedLine:lower() == userKey then
                isValidKey = true
                break
            end
        end
    end

    if not isValidKey then
        gg.alert("❌ Invalid or Expired Key!\n\nGet a new key from Discord using /getkey command.")
        os.exit()
    end
end

-- Dashboard Banner
gg.alert([[
👑 HERRY HACKS VIP v4.0 👑
👤 Owner: Herry | 🎮 Game: Grand Mobile
🟢 Status: Running / Safe ✅

⚠️ NOTE: If you paid for this script, you got scammed! This hack is 100% FREE!
📩 Free Access / DM: herry_escobarr
]])

-- ---------------------------------------------------
-- 3. FETCH POSYA-RUSSIAN SCRIPT
-- ---------------------------------------------------
function LOAD_POSYA_RUSSIAN()
    gg.toast("🔥 Loading Posya-Russian Script...")

    local live_url = POSYA_RUSSIAN_RAW .. "?v=" .. os.time()
    local res = gg.makeRequest(live_url, {
        ['User-Agent'] = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)',
        ['Accept'] = '*/*'
    })

    if res and res.content and #res.content > 10 then
        if res.content:find("<!DOCTYPE html>") or res.content:find("<html>") or res.content:find("404: Not Found") then
            gg.alert("❌ RAW Link Error!\n\nMake sure 'HerryBot-v4' Repository is PUBLIC and file 'PosyaByHerry.lua' exists.")
            return
        end

        local runPosya, err = (loadstring or load)(res.content)
        if runPosya then
            local success, runErr = pcall(runPosya)
            if not success and runErr then
                local errStr = tostring(runErr)
                if not errStr:find("os.exit") and not errStr:find("called os.exit") then
                    gg.alert("❌ Runtime Error in PosyaByHerry.lua:\n" .. errStr)
                else
                    os.exit()
                end
            end
        else
            gg.alert("❌ Syntax Error in PosyaByHerry.lua:\n" .. tostring(err))
        end
    else
        gg.alert("❌ Failed to download PosyaByHerry.lua from GitHub!\nCheck Virtual Space Internet access.")
    end
end

-- ---------------------------------------------------
-- 4. MAIN MENU CONTROL
-- ---------------------------------------------------
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
        LOAD_POSYA_RUSSIAN()
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
