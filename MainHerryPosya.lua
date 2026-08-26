-- ===================================================
-- 👑 HERRY HACKS - VIP DASHBOARD & CHEATS SYSTEM 👑
-- ===================================================

local POSYA_RAW_LINK = "https://raw.githubusercontent.com/urdushahzaib111-ctrl/HerryBot-v4/main/PosyaByHerry.lua"
local KEYS_RAW_LINK = "https://raw.githubusercontent.com/urdushahzaib111-ctrl/HerryBot-v4/main/keys.txt"

-- String Helper
local function cleanStr(str)
    if not str then return "" end
    return (str:gsub("%s+", ""):gsub("\r", ""):gsub("\n", ""))
end

-- ---------------------------------------------------
-- 1. KEY VERIFICATION SYSTEM
-- ---------------------------------------------------
gg.toast("⚡ [HERRY HACKS] Connecting to Server...")

local NOCACHE_KEY = os.time() .. "_" .. math.random(1000, 9999)
local keys_response = gg.makeRequest(KEYS_RAW_LINK .. "?v=" .. NOCACHE_KEY)

if not keys_response or keys_response.code ~= 200 then
    gg.alert("❌ Network Error: Server connection failed!")
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
    if cleanStr(line):lower() == userKey then
        isValidKey = true
        break
    end
end

if not isValidKey then
    gg.alert("❌ Invalid or Expired Key!\nGet key from Discord (#get-key).")
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
        gg.alert("🚫 Access Denied! Key locked to another device.")
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
-- 3. POSYA CHEATS EXECUTOR
-- ---------------------------------------------------
function LOAD_POSYA_FAST()
    gg.toast("🔥 Executing Posya Cheats...")
    -- Yahan aapka Posya Cheats ka poora main hacking logic chalega
end

-- ---------------------------------------------------
-- 4. VIP DASHBOARD MENU (GAME LANDSCAPE SAFE)
-- ---------------------------------------------------
function MAIN_MENU()
    local options = {
        '⚡ Herry Hack Menu [In Dev]',
        '🔥 Posya Russian Script [v4.0]',
        '🌐 Posya English Script [Coming Soon]',
        '❌ Exit Script'
    }

    -- Title ko safe 1-line banaya hai taaki game mode mein options cut na ho
    local menu = gg.choice(options, nil, "👑 HERRY HACKS VIP v4.0 👑")

    if menu == 1 then
        gg.alert("⚠️ Currently under development!")
        MAIN_MENU()
    elseif menu == 2 then
        LOAD_POSYA_FAST()
    elseif menu == 3 then
        gg.alert("🚫 Posya English Script is coming soon.")
        MAIN_MENU()
    elseif menu == 4 or menu == nil then
        gg.toast("👋 Exiting Herry Hacks...")
        os.exit()
    end
end

-- Main Loop
while true do
    if gg.isVisible(true) then
        gg.setVisible(false)
        MAIN_MENU()
    end
    gg.sleep(100)
end
