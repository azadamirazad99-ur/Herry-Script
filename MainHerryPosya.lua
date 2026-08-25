-- ===================================================
-- 👑 HERRY HACKS - VIP DASHBOARD & CHEATS SYSTEM 👑
-- ===================================================

local POSYA_RAW_LINK = "https://raw.githubusercontent.com/urdushahzaib111-ctrl/HerryBot-v4/main/PosyaByHerry.lua"
local KEYS_RAW_LINK = "https://raw.githubusercontent.com/urdushahzaib111-ctrl/HerryBot-v4/main/keys.txt?t=" .. os.time()

-- Welcome Popup (Only Once)
if not _G.FIRST_RUN_POPUP then
    _G.FIRST_RUN_POPUP = true
    gg.alert("👑 WELCOME TO HERRY HACKS VIP DASHBOARD 👑\n\n🔑 Get key from Discord server (#get-key channel).\n📩 Contact: herry_escobarr")
end

-- String Helper Function
local function cleanStr(str)
    if not str then return "" end
    return (str:gsub("%s+", ""):gsub("\r", ""):gsub("\n", ""))
end

-- ---------------------------------------------------
-- 1. KEY VERIFICATION SYSTEM
-- ---------------------------------------------------
gg.toast("⚡ Connecting to Server...")

local keys_response = gg.makeRequest(KEYS_RAW_LINK)
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
    local cleanLine = cleanStr(line):lower()
    if cleanLine ~= "" and cleanLine == userKey then
        isValidKey = true
        break
    end
end

if not isValidKey then
    gg.alert("❌ Invalid or Expired Key!")
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
-- 3. AUTO-UPDATE EXECUTOR FUNCTION
-- ---------------------------------------------------
function LOAD_POSYA_FAST()
    gg.toast("⚡ Loading latest script from GitHub...")
    local res = gg.makeRequest(POSYA_RAW_LINK .. "?t=" .. os.time())
    
    if res and res.code == 200 and res.content and #res.content > 10 then
        local runPosya, err = (loadstring or load)(res.content)
        if runPosya then
            pcall(runPosya)
        else
            gg.alert("❌ Syntax Error in online Posya script:\n" .. tostring(err))
        end
    else
        gg.alert("❌ Load Failed! Check your internet connection or GitHub link.")
    end
end

-- ---------------------------------------------------
-- 4. SINGLE-LINE TITLE DASHBOARD (LANDSCAPE SAFE)
-- ---------------------------------------------------
function MAIN_MENU()
    local menu = gg.choice({
        '⚡ Herry Hack Menu [In Dev]',
        '🔥 Posya Russian Script [v4.0]',
        '🌐 Posya English Script [Coming Soon]',
        '❌ Exit Script'
    }, nil, "👑 HERRY HACKS VIP v4.0 👑")

    if menu == 1 then
        gg.alert("⚠️ Currently under development!")
    elseif menu == 2 then
        LOAD_POSYA_FAST()
    elseif menu == 3 then
        gg.alert("🚫 English Script coming soon!")
    elseif menu == 4 or menu == nil then
        gg.toast("👋 Exiting...")
        os.exit()
    end
end

-- MAIN LOOP
while true do
    if gg.isVisible(true) then
        gg.setVisible(false)
        MAIN_MENU()
    end
    gg.sleep(100)
end

