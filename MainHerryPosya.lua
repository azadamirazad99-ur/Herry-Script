-- ===================================================
-- 👑 HERRY HACKS - VIP DASHBOARD & CHEATS SYSTEM 👑
-- ===================================================

local POSYA_RAW_LINK = "https://raw.githubusercontent.com/urdushahzaib111-ctrl/HerryBot-v4/main/PosyaByHerry.lua"
local KEYS_RAW_LINK = "https://raw.githubusercontent.com/urdushahzaib111-ctrl/HerryBot-v4/main/keys.txt?t=" .. os.time()

-- Global flag so welcome popup shows ONLY ONCE
if not _G.FIRST_RUN_POPUP then
    _G.FIRST_RUN_POPUP = true
    gg.alert([[
░▒▓█ HERRY HACKS OFFICIAL █▓▒░

✨ WELCOME TO HERRY SCRIPT SYSTEM ✨

🔑 TO GET ACCESS KEY:
1️⃣ Go to HerryHacks Discord Server.
2️⃣ Find and open #get-key channel.

📩 No Discord Server Link?
DM Discord ID: herry_escobarr to get the invite link!
]])
end

-- String Cleaner
local function cleanStr(str)
    if not str then return "" end
    return (str:gsub("%s+", ""):gsub("\r", ""):gsub("\n", ""))
end

-- ---------------------------------------------------
-- 1. KEY VERIFICATION SYSTEM
-- ---------------------------------------------------
gg.toast("⚡ [HERRY HACKS] Connecting to Server...")

local keys_response = gg.makeRequest(KEYS_RAW_LINK)
if not keys_response or keys_response.code ~= 200 then
    gg.alert("❌ Network Error: Server connection failed! Please check your internet.")
    os.exit()
end

local input = gg.prompt({'🔑 Enter Your Access Key:'}, {[1]=''}, {[1]='text'})
if not input or cleanStr(input[1]) == '' then
    gg.alert("❌ Access Denied: Key input cannot be empty!")
    os.exit()
end

local userKey = cleanStr(input[1]):lower()
local isValidKey = false

for line in keys_response.content:gmatch("[^\r\n]+") do
    local cleanLine = cleanStr(line):lower()
    if cleanLine ~= "" and cleanLine == userKey then
        isValidKey = true
        break
    end
end

if not isValidKey then
    gg.alert("❌ Invalid or Expired Key!\n\nGet a valid key from Discord (#get-key channel).")
    os.exit()
end

-- ---------------------------------------------------
-- 2. DEVICE HWID LOCK SYSTEM
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
        gg.alert("🚫 Access Denied!\nThis key is already locked to another device.")
        os.exit()
    end
else
    local wfile = io.open(local_hwid_file, "w")
    if wfile then
        wfile:write(userKey .. ":" .. current_hwid)
        wfile:close()
    end
    gg.toast("✅ Key Verified & HWID Locked!")
end

-- ---------------------------------------------------
-- 3. VIP DASHBOARD MENU
-- ---------------------------------------------------
function MAIN_MENU()
    local dashboard_title = [[
▓████████████████████████████████████▓
        👑 HERRY HACKS VIP DASHBOARD 👑
▓████████████████████████████████████▓

👤 Owner    : Herry
📌 Version  : Latest (v4.0)
🎮 Game     : Grand Mobile / RP
🟢 Status   : Running / Safe ✅

⚠️ NOTE:
If you Buy this hack U got Scammed!
Get Free hack In Our discord server.
DM for getting This hack free: herry_escobarr
──────────────────────────────────────]]

    local menu = gg.choice({
        '⚡ Herry Hack Menu [In Dev]',
        '🔥 Posya Russian Script [v4.0]',
        '🌐 Posya English Script [Coming Soon]',
        '❌ Exit Script'
    }, nil, dashboard_title)

    if menu == 1 then
        gg.alert("⚠️ This hack is currently under development. Coming soon!")
        MAIN_MENU()
    elseif menu == 2 then
        LOAD_POSYA_FAST()
    elseif menu == 3 then
        gg.alert("🚫 Not Available!\n\nPosya English Script is coming soon.")
        MAIN_MENU()
    elseif menu == 4 or menu == nil then
        gg.toast("👋 Exiting Herry Hacks...")
        os.exit()
    end
end

-- ---------------------------------------------------
-- FAST DIRECT EXECUTOR (NO DELAY)
-- ---------------------------------------------------
function LOAD_POSYA_FAST()
    gg.toast("⚡ Instantly Executing Posya Script...")
    local res = gg.makeRequest(POSYA_RAW_LINK .. "?t=" .. os.time())
    
    if res and res.code == 200 and res.content and #res.content > 10 then
        local runPosya, err = (loadstring or load)(res.content)
        if runPosya then
            pcall(runPosya)
        else
            gg.alert("❌ Posya Script Syntax Error:\n" .. tostring(err))
        end
    else
        gg.alert("❌ Fast Load Failed! Check internet or GitHub link.")
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

