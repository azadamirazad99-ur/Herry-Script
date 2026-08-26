-- ===================================================
-- 👑 HERRY HACKS - MAIN SCRIPT (GITHUB VERSION) 👑
-- ===================================================

local POSYA_RAW_LINK = "https://raw.githubusercontent.com/urdushahzaib111-ctrl/HerryBot-v4/main/PosyaByHerry.lua"
local KEYS_RAW_LINK = "https://raw.githubusercontent.com/urdushahzaib111-ctrl/HerryBot-v4/main/keys.txt"

-- First Run Welcome Popup
if not _G.FIRST_RUN_POPUP then
    _G.FIRST_RUN_POPUP = true
    gg.alert("👑 WELCOME TO HERRY HACKS VIP 👑\n\n🔑 Get key from Discord (#get-key).\n📩 DM: herry_escobarr")
end

-- String Helper
local function cleanStr(str)
    if not str then return "" end
    return (str:gsub("%s+", ""):gsub("\r", ""):gsub("\n", ""))
end

-- ---------------------------------------------------
-- 1. KEY VERIFICATION SYSTEM
-- ---------------------------------------------------
gg.toast("⚡ Connecting to Key Server...")

local NOCACHE_KEY = os.time() .. "_" .. math.random(1000, 9999)
local keys_response = gg.makeRequest(KEYS_RAW_LINK .. "?v=" .. NOCACHE_KEY)

if not keys_response or keys_response.code ~= 200 then
    gg.alert("❌ Network Error: Unable to fetch keys!")
    os.exit()
end

local input = gg.prompt({'🔑 Enter Access Key:'}, {[1]=''}, {[1]='text'})
if not input or cleanStr(input[1]) == '' then
    gg.alert("❌ Access Denied: Empty Key!")
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
    gg.alert("❌ Invalid or Expired Key!")
    os.exit()
end

-- ---------------------------------------------------
-- 2. HWID LOCK SYSTEM
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
        gg.alert("🚫 Access Denied! Device Mismatch.")
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
-- 3. LOAD POSYA RUSSIAN SCRIPT
-- ---------------------------------------------------
function LOAD_POSYA_FAST()
    gg.toast("⚡ Fetching Posya Russian Script...")
    local NOCACHE_LUA = os.time() .. "_" .. math.random(1000, 9999)
    local res = gg.makeRequest(POSYA_RAW_LINK .. "?v=" .. NOCACHE_LUA)
    
    if res and res.code == 200 and res.content and #res.content > 10 then
        local runPosya, err = (loadstring or load)(res.content)
        if runPosya then
            pcall(runPosya)
        else
            gg.alert("❌ Syntax Error in Posya Script:\n" .. tostring(err))
        end
    else
        gg.alert("❌ Failed to load Posya Script!")
    end
end

-- ---------------------------------------------------
-- 4. VIP DASHBOARD MENU (LANDSCAPE FIX)
-- ---------------------------------------------------
function MAIN_MENU()
    local options = {
        '⚡ Herry Hack Menu [In Dev]',
        '🔥 Posya Russian Script [v4.0]',
        '🌐 Posya English Script [Coming Soon]',
        '❌ Exit Script'
    }

    -- Short title prevents game mode overflow
    local menu = gg.choice(options, nil, "👑 HERRY HACKS VIP v4.0 👑")

    if menu == 1 then
        gg.alert("⚠️ Currently under development!")
        MAIN_MENU()
    elseif menu == 2 then
        LOAD_POSYA_FAST()
    elseif menu == 3 then
        gg.alert("🚫 English Script coming soon!")
        MAIN_MENU()
    elseif menu == 4 or menu == nil then
        gg.toast("👋 Exiting...")
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

