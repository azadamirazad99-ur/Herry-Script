-- ===================================================
-- 👑 HERRY HACKS OFFICIAL - FAST VIP SCRIPT SYSTEM 👑
-- ===================================================

local POSYA_RAW_LINK = "https://raw.githubusercontent.com/urdushahzaib111-ctrl/HerryBot-v4/main/PosyaByHerry.lua"
local KEYS_RAW_LINK = "https://raw.githubusercontent.com/urdushahzaib111-ctrl/HerryBot-v4/main/keys.txt"

-- Memory Cache for Super Fast Reloads
_G.POSYA_CACHE = _G.POSYA_CACHE or nil

-- Helper String Cleaner
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
2️⃣ Find the Channel: #├📃│get-key

❓ Don't have HerryHacks Server?
📩 DM Owner on Discord: herry_escobarr
]])
end

-- ---------------------------------------------------
-- 2. VIP KEY VERIFICATION SYSTEM (OPTIMIZED)
-- ---------------------------------------------------
gg.toast("⚡ [HERRY HACKS] Verifying Access...")

local keys_response = gg.makeRequest(KEYS_RAW_LINK, {
    ['User-Agent'] = 'Mozilla/5.0 (Linux; Android 10)'
})

if not keys_response or keys_response.code ~= 200 then
    gg.alert("❌ Network Error: Unable to connect to Key Server!")
    os.exit()
end

local input = gg.prompt({'🔑 Enter Your VIP Access Key:'}, {[1]=''}, {[1]='text'})
if not input or cleanStr(input[1]) == '' then
    gg.alert("❌ Access Denied: Key cannot be empty!")
    os.exit()
end

local userKey = cleanStr(input[1]):lower()
local isValidKey = false

for line in keys_response.content:gmatch("[^\r\n]+") do
    if cleanStr(line):lower() == userKey then
        isValidKey = true
        break
    end
end

if not isValidKey then
    gg.alert("❌ Invalid or Expired Key!\n\nGet a key from Discord (#├📃│get-key).")
    os.exit()
end

-- ---------------------------------------------------
-- 3. DEVICE HWID LOCK SYSTEM
-- ---------------------------------------------------
local raw_info = gg.getTargetInfo()
local current_hwid = "DEV_" .. cleanStr(raw_info.packageName or "GAME") .. "_" .. cleanStr(os.getenv("USER") or "USER")
local local_hwid_file = gg.EXT_STORAGE .. "/.herry_hwid.dat"

local file = io.open(local_hwid_file, "r")
local savedContent = file and file:read("*all") or ""
if file then file:close() end

local savedKey, savedHwid = savedContent:match("([^:]+):([^:]+)")

if savedKey and cleanStr(savedKey):lower() == userKey then
    if savedHwid and cleanStr(savedHwid) ~= current_hwid then
        gg.alert("🚫 Access Denied!\nThis key is locked to another device.")
        os.exit()
    end
else
    local wfile = io.open(local_hwid_file, "w")
    if wfile then
        wfile:write(userKey .. ":" .. current_hwid)
        wfile:close()
    end
    gg.toast("✅ Key Verified & Device HWID Locked!")
end

-- ---------------------------------------------------
-- 4. ULTRA-FAST POSYA RUSSIAN EXECUTOR
-- ---------------------------------------------------
function LOAD_POSYA_FAST()
    -- Sub-second execution using cached memory if available
    if _G.POSYA_CACHE then
        gg.toast("⚡ Launching Posya Instantly...")
        local runPosya = (loadstring or load)(_G.POSYA_CACHE)
        if runPosya then pcall(runPosya) return end
    end

    gg.toast("🔥 Fast Fetching Posya Russian Script...")
    
    local res = gg.makeRequest(POSYA_RAW_LINK, {
        ['User-Agent'] = 'Mozilla/5.0 (Linux; Android 10)'
    })
    
    if res and res.code == 200 and res.content and #res.content > 10 then
        _G.POSYA_CACHE = res.content -- Store script in RAM for zero-delay reloads
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

-- ---------------------------------------------------
-- 5. VIP DASHBOARD MENU (CLEAN & FAST)
-- ---------------------------------------------------
function MAIN_MENU()
    local dashboard_banner = [[
👑 HERRY HACKS VIP v4.0 👑
👤 Owner: Herry | 🎮 Game: Grand Mobile
🟢 Status: Running / Safe ✅

⚠️ NOTE: If you paid for this script, you got scammed! This hack is 100% FREE!
📩 Free Access / DM: herry_escobarr]]

    local options = {
        '⚡ Herry-Script [Coming Soon]',
        '🔥 Posya-Russian [v4.0]',
        '🌐 Posya-English [Coming Soon]',
        '❌ Exit Script'
    }

    local menu = gg.choice(options, nil, dashboard_banner)

    if menu == 1 then
        gg.alert("🚀 Herry-Script is under heavy development!\nStay tuned in Discord.")
        MAIN_MENU()
    elseif menu == 2 then
        LOAD_POSYA_FAST()
    elseif menu == 3 then
        gg.alert("🌐 Posya-English Version is Coming Soon!")
        MAIN_MENU()
    elseif menu == 4 or menu == nil then
        gg.toast("👋 Exiting Herry Hacks...")
        os.exit()
    end
end

-- Main Script Loop
while true do
    if gg.isVisible(true) then
        gg.setVisible(false)
        MAIN_MENU()
    end
    gg.sleep(100)
end

