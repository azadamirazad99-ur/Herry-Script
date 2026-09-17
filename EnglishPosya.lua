-- ===================================================
-- 👑 HERRY HACKS OFFICIAL - DECOMPILE PROTECTED SCRIPT 👑
-- ===================================================

local function _protectDecompile()
    if pcall(function() string.dump(function() end) end) then
        local _sd = string.dump
        string.dump = function(f, strip)
            error("Access Denied: Decompilation Protected!")
        end
    end
    if debug and debug.getinfo then
        local _gi = debug.getinfo
        debug.getinfo = function(f, what)
            if type(f) == "function" then
                local info = _gi(f, what)
                if info then
                    info.source = "=[Protected]"
                    info.linedefined = 0
                    info.lastlinedefined = 0
                end
                return info
            end
            return _gi(f, what)
        end
    end
end
pcall(_protectDecompile)

gg.setVisible(false) 

-- Universal Bitwise OR Helper for Range Safety
local function bor(a, b, c, d, e)
    local res = a or 0
    for _, val in ipairs({b, c, d, e}) do
        if val then
            if bit32 and bit32.bor then
                res = bit32.bor(res, val)
            else
                res = res | val
            end
        end
    end
    return res
end

-- ==========================================
--          GLOBAL SETUP & CORE ENGINE
-- ==========================================

menuuuvis = 1
gg.clearResults()
gg.clearList()

function abc()
    gg.toast("🔵 ACTIVATED SUCCESSFULLY [⊂❍]")
end

function cba()
    gg.toast("🔴 DEACTIVATED SUCCESSFULLY [❍⊃]")
end

function qwea()
    gg.toast("❌ VALUE NOT FOUND IN MEMORY")
end

function showError(msg)
    gg.toast("❌ Error: " .. tostring(msg or "Operation Failed"))
end

toast = {
    success = function(msg) gg.toast(msg) end,
    hint = function(msg) gg.toast(msg) end,
    error = function(msg) gg.toast(msg) end
}

function showSuccess() 
    gg.toast("🟢 FEATURE ACTIVATED SUCCESSFULLY") 
end

fg = {}
Write = {}
fg.clean = gg.clearResults
Z = {}
ts = gg.toast
alert = gg.alert

-- Memory Type & Region Definitions with Fail-safe Fallbacks
A = gg.REGION_ANONYMOUS or 32
As = gg.REGION_ANONYMOUS or 524288
B = gg.REGION_BAD or 131072
Xa = gg.REGION_CODE_APP or 16384
Xs = gg.REGION_CODE_SYS or 32768
Ca = gg.REGION_C_ALLOC or 4
Cb = gg.REGION_C_BSS or 16
Cd = gg.REGION_C_DATA or 8
Ch = gg.REGION_C_HEAP or 1
J = gg.REGION_JAVA or 65536
Jh = gg.REGION_JAVA_HEAP or 2
O = gg.REGION_OTHER or -2080896
Ps = gg.REGION_PPSSPP or 262144
S = gg.REGION_STACK or 64
V = gg.REGION_VIDEO or 1048576

-- Combined Fallback Ranges
CalO = bor(Ca, Cd, O)

F = gg.TYPE_FLOAT or 16
D = gg.TYPE_DWORD or 4
E = gg.TYPE_QWORD or 64
Q = gg.TYPE_QWORD or 32
W = gg.TYPE_WORD or 2
X = gg.TYPE_XOR or 8
Byte = gg.TYPE_BYTE or 1

-- Dynamic UI Helper Functions
local function getUIHeader(title)
    local currentDate = os.date("%Y-%m-%d")
    local processInfo = gg.getTargetInfo()
    local processName = (processInfo and processInfo.label) or "Grand Mobile"
    return "━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n" ..
           "🔥 HERRY VIP SYSTEM 🔥\n" ..
           "📅 TODAY'S DATE: " .. currentDate .. "\n" ..
           "🎮 GAME PROCESS: " .. processName .. "\n" ..
           "━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n" ..
           "📌 " .. title .. "\n" ..
           "━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
end

gg.alert("━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n" ..
         "   HERRY VIP ENGINE ONLINE   \n" ..
         "━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n" ..
         "👤 Developer: Herry\n" ..
         "💬 Discord: herry_escobarr\n" ..
         "🚀 Version: Premium English Edition\n" ..
         "━━━━━━━━━━━━━━━━━━━━━━━━━━━━")

function setvalue(add, value, flags, dj)
    local WY = {}
    WY[1] = {}
    WY[1].address = add
    WY[1].value = value
    WY[1].flags = flags
    if dj == true then
        WY[1].freeze = true
        gg.addListItems(WY)
    else
        gg.setValues(WY)
    end
end

function Z.S(num, ty, nc, mb, qs, zd)
    gg.clearResults()
    local rangesToSet = nc or CalO
    if type(rangesToSet) ~= "number" or rangesToSet == 0 then
        rangesToSet = 4 + 8 + (-2080896)
    end
    pcall(function() gg.setRanges(rangesToSet) end)
    gg.searchNumber(num, ty, false, gg.SIGN_EQUAL, qs or 1, zd or -1)
    if mb ~= nil and mb ~= false and mb then
        gg.refineAddress(mb)
    end
    Result = gg.getResults(gg.getResultCount())
end

function Z.C(num, C, ty)
    if (Result and #Result ~= 0) then
        t = {}
        for i, v in ipairs(Result) do
            t[i] = {}
            t[i].address = v.address + C
            t[i].flags = ty
        end
        t = gg.getValues(t)
        for i, v in ipairs(t) do
            if v.value ~= num then
                Result[i] = nil
            end
        end
        local Z2 = {}
        for i, v in pairs(Result) do
            Z2[#Z2 + 1] = v
        end
        Result = Z2
    end
end

function Z.bc()
    data = {}
    if Result == nil or #Result == 0 then
        gg.toast("🔍 NO MEMORY VALUES FOUND")
    else
        for i, v in pairs(Result) do
            data[#data + 1] = v.address
        end
        gg.loadResults(Result)
    end
    Result = nil
end

function Z.W(nn, off, ty, dj)
    if (Result) then Z.bc() end
    if data and #data > 0 then
        for i, v in ipairs(data) do
            local val = nn
            if val == "" then
                local t = {{address = v + off, flags = ty}}
                t = gg.getValues(t)
                val = t[1].value
            end
            setvalue(v + off, val, ty, dj or false)
        end
    end
end

function Z.A(varName, offset, baseAddr)
    if not baseAddr then
        local results = gg.getResults(9999)
        if #results == 0 then
            gg.clearResults()
            showError("Value Not Found")
            return
        end
        baseAddr = results[1].address
    end
    
    local targetAddr = baseAddr + (offset or 0)
    
    if varName and type(varName) == "string" then
        _G[varName] = targetAddr
    end
    
    return targetAddr
end

function hookPLAYER(q1w, w2e, e3r, r4t)
    Z.S("100.14399719238", F, CalO)

    if not Result or #Result == 0 then
        showError()
        return false
    end
    
    local off = tonumber(q1w) or 0
    for i, v in ipairs(Result) do
        setvalue(v.address + off, e3r, w2e, r4t or false)
    end
    
    gg.clearResults()
    return true
end

function doTeleport(x, y, z)
    gg.clearResults()
    gg.setRanges(bor(Ca, O))
    gg.searchNumber("4575657250219098112", Q, false, gg.SIGN_EQUAL, 1, -1)
    
    local results = gg.getResults(1)
    if results and #results > 0 then
        local baseAddr = results[1].address
        
        if x ~= nil then setvalue(baseAddr + 132, x, F, false) end
        if y ~= nil then setvalue(baseAddr + 136, y, F, false) end
        if z ~= nil then setvalue(baseAddr + 140, z, F, false) end
        
        showSuccess()
    else
        showError()
    end
    gg.clearResults()
end

function formatToggle(title, isON)
    local stateIcon = isON and " ⊂❍" or " ❍⊃"
    return "\n➔ ⟦ " .. title .. stateIcon .. " ⟧"
end

function formatBtn(title)
    return "\n➔ ⟦ " .. title .. " ⟧"
end

-- ==========================================
--              MAIN MENU HUB
-- ==========================================

function mainMenu()
    while true do
        if menuuuvis ~= 0 then
            gg.setVisible(true)
        end
        local mainChoice = gg.choice({
            formatBtn("🎯 Aimbot Control Menu"),
            formatBtn("🏃 Player Enhancements"),
            formatBtn("🚗 Vehicle Modifications"),
            formatBtn("👁️ Visual Mods & ESP"),
            formatBtn("🔫 Weapon Arsenal Mods"),
            formatBtn("✈️ Teleportation Hub (All Locations)"),
            formatBtn("🚪 Exit Script")
        }, nil, getUIHeader("MAIN DASHBOARD"))
        
        if not mainChoice then
            gg.setVisible(true)
            os.exit()
        elseif mainChoice == 1 then
            AimbotMasterMenu()
        elseif mainChoice == 2 then
            player()
        elseif mainChoice == 3 then
            car()
        elseif mainChoice == 4 then
            visualy()
        elseif mainChoice == 5 then
            gun()
        elseif mainChoice == 6 then
            tpMenu()
        elseif mainChoice == 7 then
            gg.setVisible(true)
            os.exit()
        end
    end
end

-- ==========================================
--              AIMBOT MENU
-- ==========================================

aim_st = {
    {n = "HvH Rage Mode",  v = "1089999999", s = false},
    {n = "Ultra Aim",      v = "1080999999", s = false},
    {n = "Medium Aim",     v = "1076999999", s = false},
    {n = "Legit Aim",      v = "1055999999", s = false},
    {n = "Ultra Legit",    v = "1051999999", s = false}
}

function aimnew()
    local inNewAim = true
    while inNewAim do
        gg.setVisible(false)
        local names = {}
        for i, v in ipairs(aim_st) do 
            table.insert(names, formatToggle("🎯 " .. v.n, v.s)) 
        end
        table.insert(names, formatBtn("⬅️ Return Back"))
        
        local r = gg.choice(names, nil, getUIHeader("MODERN AIMBOT ENGINE"))
        if r and r <= #aim_st then
            aim_st[r].s = not aim_st[r].s
            local old = "1042536202"
            
            gg.clearResults()
            if aim_st[r].s then
                gg.setRanges(bor(gg.REGION_C_ALLOC, gg.REGION_OTHER))
                gg.searchNumber(old, gg.TYPE_DWORD)
                if gg.getResultCount() > 0 then
                    gg.getResults(10000)
                    gg.editAll(aim_st[r].v, gg.TYPE_DWORD)
                    abc()
                else
                    qwea()
                end
            else
                gg.setRanges(bor(gg.REGION_C_ALLOC, gg.REGION_OTHER))
                gg.searchNumber(aim_st[r].v, gg.TYPE_DWORD)
                if gg.getResultCount() > 0 then
                    gg.getResults(10000)
                    gg.editAll(old, gg.TYPE_DWORD)
                    cba()
                else
                    qwea()
                end
            end
            gg.clearResults()
        elseif r == #aim_st + 1 then 
            break
        elseif r == nil then 
            inNewAim = false 
        end
    end
end

function aimold()
    local aims = {
        {"HvH Rage Mode", "1089999999", "1042536202"},
        {"Ultra Aim",     "1080999999", "1042536202"},
        {"Medium Aim",    "1076999999", "1042536202"},
        {"Legit Aim",     "1055999999", "1042536202"},
        {"Ultra Legit",   "1051999999", "1042536202"}
    }
    local names = {}
    for i, v in ipairs(aims) do 
        table.insert(names, formatBtn("🎯 " .. v[1])) 
    end
    table.insert(names, formatBtn("⬅️ Return Back"))
    
    local s = gg.choice(names, nil, getUIHeader("LEGACY AIMBOT ENGINE"))
    if s and s <= #aims then
        gg.setVisible(false)
        gg.toast("Engine running... Tap GameGuardian icon to stop")
        for i = 1, 10000 do
            if gg.isVisible() then break end
            gg.clearResults()
            gg.setRanges(bor(gg.REGION_C_ALLOC, gg.REGION_OTHER))
            gg.searchNumber(aims[s][3], gg.TYPE_DWORD)
            if gg.getResultCount() > 0 then
                gg.getResults(10000)
                gg.editAll(aims[s][2], gg.TYPE_DWORD)
            end
            gg.clearResults()
            
            for j = 1, 20 do
                if gg.isVisible() then
                    gg.setVisible(false)
                    gg.clearResults()
                    gg.setRanges(bor(gg.REGION_C_ALLOC, gg.REGION_C_DATA, gg.REGION_OTHER))
                    gg.searchNumber(aims[s][2], gg.TYPE_DWORD)
                    if gg.getResultCount() > 0 then
                        gg.getResults(10000)
                        gg.editAll(aims[s][3], gg.TYPE_DWORD)
                    end
                    gg.clearResults()
                    gg.toast("Deactivated, returning to menu")
                    return aimold()
                end
                gg.sleep(200)
            end 
        end
        gg.setVisible(true)
        gg.clearResults()
    elseif s == #aims + 1 then 
        return
    end
end

function AimbotMasterMenu()
    local inAimMenu = true
    while inAimMenu do
        gg.setVisible(false)
        local aChoice = gg.choice({
            formatBtn("🎯 Modern Dynamic Aimbot"),
            formatBtn("🎯 Legacy Loop Aimbot"),
            formatBtn("⬅️ Return to Main Menu")
        }, nil, getUIHeader("AIMBOT CONTROL SYSTEM"))
        
        if aChoice == 1 then 
            aimnew()
        elseif aChoice == 2 then 
            aimold()
        elseif aChoice == 3 then 
            break
        elseif aChoice == nil then 
            inAimMenu = false 
        end
    end
end

-- ==========================================
--              PLAYER MODS
-- ==========================================

st_shv2 = false
st_mbq = false
st_gm4 = false
st_gm9 = false
st_gm5 = false
st_suic = false
st_walg = false
st_fastkil = false
st_hjj = false
st_whh = false
st_graviq = false
st_graviqq = false

function player()
menuuuvis = 0
local pChoice = gg.choice ({
 formatToggle("🏃 Speed Hack V1", st_shv2),
 formatToggle("🏃 Speed Hack V2", st_mbq),
 formatToggle("🛡️ Godmode Armor V1", st_gm4),
 formatToggle("🛡️ Godmode Armor V2", st_gm9),
 formatToggle("🛡️ Armor Bypass", st_gm5),
 formatBtn("❤️ Instant Health Restore"),
 formatToggle("☠️ Instant Suicide", st_suic),
 formatToggle("🧱 Wallwalk Hack", st_walg),
 formatBtn("⬆️ Flip Upwards (Custom)"),
 formatBtn("⬇️ Flip Downwards (Custom)"),
 formatToggle("🥊 Fast Melee Kill", st_fastkil),
 formatToggle("🦘 High Jump Booster", st_hjj),
 formatToggle("🔄 Sharp Cornering", st_whh),
 formatToggle("🌌 Gravity Mod V1", st_graviq),
 formatToggle("🌌 Gravity Mod V2", st_graviqq),
 formatBtn("⬅️ Return Back")
}, nil, getUIHeader("PLAYER ENHANCEMENT MODS"))

if not pChoice or pChoice == 16 then return mainMenu() end
if pChoice == 1 then shv22() end 
if pChoice == 2 then fovqqq() end 
if pChoice == 3 then gm2() end 
if pChoice == 4 then gm8() end 
if pChoice == 5 then gm3() end 
if pChoice == 6 then hpq() end 
if pChoice == 7 then suicc() end 
if pChoice == 8 then walgh() end 
if pChoice == 9 then flpp() end 
if pChoice == 10 then flpp1() end 
if pChoice == 11 then fastk() end 
if pChoice == 12 then hj() end 
if pChoice == 13 then wh() end 
if pChoice == 14 then gravity() end 
if pChoice == 15 then gravityv2() end 
menuuuvis = -1
end

function gm2()
    st_gm4 = not st_gm4
    if hookPLAYER(-4, F, st_gm4 and 505050 or 100) then 
        if st_gm4 then abc() else cba() end 
    end 
    gg.clearResults()
    player()
end

function hj()
    st_hjj = not st_hjj
    Z.S("4798022456217645875", Q, bor(Cd, O))
    Z.W(st_hjj and "-150" or "-0.10000000149", -0x4, F)
    gg.clearResults()
    if st_hjj then abc() else cba() end
    player()
end

function fovqqq()
    st_mbq = not st_mbq
    Z.S(st_mbq and "4489188110498131456" or "4489188110487257088", Q, bor(Ca, Cd, O))
    if Result and #Result ~= 0 then 
        gg.editAll(st_mbq and "4489188110487257088" or "4489188110498131456", Q)
        if st_mbq then abc() else cba() end 
    else 
        qwea() 
    end 
    gg.clearResults()
    player()
end

function walgh()
    st_walg = not st_walg
    Z.S(st_walg and "1114636288" or "1114767360", Q, bor(Ca, O, Cd))
    if Result and #Result ~= 0 then 
        gg.editAll(st_walg and "1114767360" or "1114636288", Q)
        if st_walg then abc() else cba() end 
    else 
        qwea() 
    end 
    gg.clearResults()
    player()
end

function fastk()
    st_fastkil = not st_fastkil
    Z.S(st_fastkil and "9187343240761165228" or "4489188110505082880", Q, bor(Ca, O, Cd))
    if Result and #Result ~= 0 then 
        gg.editAll(st_fastkil and "4489188110505082880" or "9187343240761165228", Q)
        Z.S(st_fastkil and "4489188110487257088" or "4489188110499840000", Q, bor(Ca, O, Cd))
        if Result and #Result ~= 0 then 
            gg.editAll(st_fastkil and "4489188110499840000" or "4489188110487257088", Q)
        end 
        if st_fastkil then abc() else cba() end 
    else 
        qwea() 
    end 
    gg.clearResults()
    player()
end

function gravityv2()
    st_graviqq = not st_graviqq
    Z.S("-4651317692702523392", Q, bor(Cd, O))
    Z.W(st_graviqq and "-1164859368" or "-1140649361", -0x4, D)
    gg.clearResults()
    if st_graviqq then abc() else cba() end
    player()
end

function gravity()
    st_graviq = not st_graviq
    Z.S("-4651317692702523392", Q, bor(Cd, O))
    Z.W(st_graviq and "-1164854368" or "-1140649361", -0x4, D)
    gg.clearResults()
    if st_graviq then abc() else cba() end
    player()
end

function shv22()
    st_shv2 = not st_shv2
    Z.S("4647714816510698455", Q, bor(Cd, O, Ca))
    Z.W(st_shv2 and "4489188112626352128" or "4489188110482223923", 0x18, Q)
    gg.clearResults()
    if st_shv2 then abc() else cba() end
    player()
end

function flpp()
    local inputVal = gg.prompt({"Enter value to go UP (e.g. 10):"}, {"10"}, {"number"})
    if not inputVal then return player() end
    local addVal = tonumber(inputVal[1]) or 10

    Z.S("4575657250219098112", Q, bor(Ca, O))
    if Result and #Result ~= 0 then 
        local t = {}
        for i,v in ipairs(Result) do t[i] = {address = v.address + 140, flags = F} end
        t = gg.getValues(t)
        for i,v in ipairs(t) do v.value = v.value + addVal end
        gg.setValues(t)
        abc()
    else 
        qwea()
    end
    gg.clearResults()
    player()
end

function flpp1()
    local inputVal = gg.prompt({"Enter value to go DOWN (e.g. 10):"}, {"10"}, {"number"})
    if not inputVal then return player() end
    local subVal = tonumber(inputVal[1]) or 10

    Z.S("4575657250219098112", Q, bor(Ca, O))
    if Result and #Result ~= 0 then 
        local t = {}
        for i,v in ipairs(Result) do t[i] = {address = v.address + 140, flags = F} end
        t = gg.getValues(t)
        for i,v in ipairs(t) do v.value = v.value - subVal end
        gg.setValues(t)
        abc()
    else 
        qwea()
    end
    gg.clearResults()
    player()
end

function gm3()
    st_gm5 = not st_gm5
    if st_gm5 then 
        if hookPLAYER(4, F, "9990", true) then abc() end 
    else 
        gg.clearList()
        cba() 
    end 
    gg.clearResults()
    player()
end

function gm8()
    st_gm9 = not st_gm9
    if not st_gm9 then gg.clearList() end 
    if hookPLAYER(-4, F, st_gm9 and "9999989.0" or "100", st_gm9) then 
        if st_gm9 then abc() else cba() end 
    end 
    player()
end

function hpq() if hookPLAYER(-4, F, 100) then abc() end player() end
function suicc() if hookPLAYER(-4, F, 0) then abc() end player() end

function wh()
    st_whh = not st_whh
    if not st_whh then gg.clearList() end 
    if hookPLAYER(28, F, st_whh and "65" or "7.5", st_whh) then 
        if st_whh then abc() else cba() end 
    end 
    player()
end

-- ==========================================
--              VEHICLE MODS
-- ==========================================

st_gmcarchik = false
st_shcar = false
st_mopsh = false
st_nitr = false
st_gidraa = false
st_upmotor = false
st_perevorot1 = false
st_carkoles1 = false

function car()
menuuuvis = 0
  local mashinka = gg.choice ({
   formatToggle("🛡️ Vehicle Godmode", st_gmcarchik),
   formatBtn("🔧 Instant Vehicle Repair"),
   formatBtn("💥 Destroy Vehicle Engine"),
   formatToggle("⚡ Nitro Boost", st_nitr),
   formatToggle("⚙️ Hydraulic Suspension", st_gidraa),
   formatToggle("🏎️ Vehicle Speed Hack", st_shcar),
   formatToggle("🛵 Scooter Speed Acceleration", st_mopsh),
   formatBtn("🚀 Launch Vehicle Into Space"),
   formatBtn("⬆️ Throw Vehicle Upwards"),
   formatToggle("⚙️ Engine Power Upgrade", st_upmotor),
   formatToggle("🔄 Anti-Rollover Stabilizer", st_perevorot1),
   formatToggle("🛞 Flip Vehicle On Wheels", st_carkoles1),
   formatBtn("⬅️ Return Back")
  }, nil, getUIHeader("VEHICLE MODIFICATION MENU"))
  
  if not mashinka or mashinka == 13 then return mainMenu() end
  if mashinka == 1 then gmcarq() end 
  if mashinka == 2 then hpcarq() end 
  if mashinka == 3 then breakcar() end 
  if mashinka == 4 then nitrolol() end 
  if mashinka == 5 then gidra() end 
  if mashinka == 6 then shcars() end 
  if mashinka == 7 then mopedsh() end
  if mashinka == 8 then kosmos() end
  if mashinka == 9 then carup11() end
  if mashinka == 10 then carupmotor() end
  if mashinka == 11 then perevorot() end
  if mashinka == 12 then carkoles() end
  menuuuvis = -1
end

function kosmos()
    Z.S("-0.00800000038", F, bor(Cd, Ca, O))
    if Result and #Result > 0 then
        gg.editAll("2.5", F)
        gg.sleep(100)
        gg.editAll("-0.00800000038", F)
        gg.clearResults()
        abc()
        car()
    end
end

function _car_logic(is_on)
    Z.S("4812096201845506048", Q, bor(Ca, O, Cd))
    if is_on then
        Z.W("0", 0x1C, D, true)
        Z.W("0", 0x20, D, true)
        abc()
    else
        Z.W("861939648", 0x1C, D, false)
        Z.W("-1315709440", 0x20, D, false)
        cba()
    end
    gg.clearResults()
    car()
end

function carkoles()
    st_carkoles1 = not st_carkoles1
    if st_carkoles1 then gg.clearList() end
    _car_logic(st_carkoles1)
end

function perevorot()
    st_perevorot1 = not st_perevorot1
    if st_perevorot1 then gg.clearList() end
    _car_logic(st_perevorot1)
end

function shcars()
    st_shcar = not st_shcar
    Z.S("4575243612898721792", Q, bor(Cd, O))
    Z.W(st_shcar and 2.5 or 0.00001, -0x8, F)
    gg.clearResults()
    if st_shcar then abc() else cba() end
    car()
end  

function gmcarq()
    st_gmcarchik = not st_gmcarchik
    Z.S("4812096201845506048", Q, bor(Ca, Cd, O))
    Z.W(st_gmcarchik and 999999 or 1000, 0x5DC, F)
    gg.clearResults()
    if st_gmcarchik then abc() else cba() end
    car()
end

function hpcarq() Z.S("4812096201845506048", Q, bor(Ca, Cd, O)) Z.W(1000, 0x5DC, F) gg.clearResults() abc() car() end
function breakcar() Z.S("4812096201845506048", Q, bor(Ca, Cd, O)) Z.W(20, 0x5DC, F) gg.clearResults() abc() car() end

function gidra()
    st_gidraa = not st_gidraa
    Z.S("-4647714812178464768", Q, bor(Cd, O, Ca))
    Z.W(st_gidraa and 655361 or -16777215, 0x160, D, false)
    gg.clearResults()
    if st_gidraa then abc() else cba() end
    car()
end

function nitrolol()
    st_nitr = not st_nitr
    gg.clearList()
    Z.S("-4647714812178464768", Q, bor(Cd, O, Ca))
    Z.W(st_nitr and 24772608 or 24772608, 0x2C, D, st_nitr)
    Z.W(st_nitr and -2145353216 or -2145353216, 0x634, D, st_nitr)
    if not st_nitr then gg.clearList() end
    gg.clearResults()
    if st_nitr then abc() else cba() end
    car()
end

function carupmotor()
    st_upmotor = not st_upmotor
    Z.S("4812096201845506048", Q, bor(Ca, O, Cd))
    Z.W(st_upmotor and -0.00179999997 or 0.0013, 0x64, F)
    gg.clearResults()
    if st_upmotor then abc() else cba() end
    car()
end

function carup11()
    Z.S("-0.00800000038", F, bor(Cd, O, Ca))
    gg.editAll("1.0", F)
    gg.setVisible(false) 
    gg.sleep(100)
    gg.editAll("-0.00800000038", F)
    gg.clearResults()
    abc()
end

function mopedsh()
    st_mopsh = not st_mopsh
    Z.S(st_mopsh and "4539628425391341620" or "4539628427538825268", Q, bor(Ca, O, Cd))
    gg.editAll(st_mopsh and "4539628427538825268" or "4539628425391341620", Q)
    gg.clearResults()
    if st_mopsh then 
        gg.toast("PRESS BRAKE TO ACCELERATE")
        abc()
    else 
        cba()
    end
    car()
end

-- ==========================================
--              VISUAL MODS
-- ==========================================

st_chamsiwhite = false
st_chamsired = false
st_fovv = false
st_ulfovq = false
st_esplol = false
st_invwal = false

function visualy()
menuuuvis = 0
  visuall = gg.choice ({
   formatToggle("🏷️ Name ESP Wallhack", st_esplol),
   formatToggle("⚪ White Chams Color", st_chamsiwhite), 
   formatToggle("🔴 Red Chams Color", st_chamsired),
   formatToggle("👁️ Expanded Field of View", st_fovv),
   formatToggle("👓 Ultra Wide Field of View", st_ulfovq),
   formatBtn("🔐 Modify Account Login ID"),
   formatBtn("✏️ Modify Player Nickname"),
   formatToggle("🧱 Invisible Walls Hack", st_invwal),
   formatBtn("⬅️ Return Back")
  }, nil, getUIHeader("VISUAL MODIFICATION MENU"))
  
  if not visuall or visuall == 9 then return mainMenu() end
  if visuall == 1 then esphack() end 
  if visuall == 2 then chamsw() end 
  if visuall == 3 then chamsr() end 
  if visuall == 4 then fov() end 
  if visuall == 5 then ulfov() end 
  if visuall == 6 then chanlog() end 
  if visuall == 7 then channick() end 
  if visuall == 8 then inviswall() end 
  menuuuvis = -1
end

function chamsw()
    st_chamsiwhite = not st_chamsiwhite
    Z.S("1132462073", Q, bor(Cd, O))
    Z.W(st_chamsiwhite and 1.999111188 or 0.00392156886, -4, F)
    gg.clearResults()
    if st_chamsiwhite then abc() else cba() end
    visualy()
end

function chamsr()
    st_chamsired = not st_chamsired
    Z.S("1132462073", Q, bor(Cd, O))
    Z.W(st_chamsired and -1.999111188 or 0.00392156886, -4, F)
    gg.clearResults()
    if st_chamsired then abc() else cba() end
    visualy()
end

function fov()
    st_fovv = not st_fovv
    Z.S("4252262742350898174", Q, bor(Cd, O))
    Z.W(st_fovv and "90" or "70", 0xC, F)
    gg.clearResults()
    if st_fovv then abc() else cba() end
    visualy()
end

function ulfov()
    st_ulfovq = not st_ulfovq
    Z.S("4252262742350898174", Q, bor(Cd, O))
    Z.W(st_ulfovq and "110" or "70", 0xC, F)
    gg.clearResults()
    if st_ulfovq then abc() else cba() end
    visualy()
end

function esphack()
    st_esplol = not st_esplol
    Z.S("5638878673340727297", Q, bor(A, O))
    Z.W(st_esplol and "199.90909090909" or "30.0101010101", -60, F)
    Z.W(st_esplol and "199.90909090909" or "30.0101010101", -56, F)
    gg.clearResults()
    if st_esplol then abc() else cba() end
    visualy()
end

function inviswall()
    st_invwal = not st_invwal
    Z.S("77190601328179", F, bor(Xa, O, Cd))
    Z.W(st_invwal and -4.99384990408 or 0.90375937, 0x14, F)
    gg.clearResults()
    if st_invwal then abc() else cba() end
    visualy()
end

function channick()
    local i1 = gg.prompt({"Enter Current Nickname:"}, {"Nick_Name"}, {"text"})
    if not i1 then return visualy() end 
    local i2 = gg.prompt({"Enter Target Nickname:"}, {"Nick_Name"}, {"text"})
    if not i2 then return visualy() end 
    gg.clearResults()
    gg.setRanges(bor(Jh, A))
    gg.searchNumber(":"..i1[1], 4)
    if gg.getResultCount() > 0 then 
        gg.getResults(99999) 
        gg.editAll(":"..i2[1], 4)
        abc()
    else 
        qwea()
    end 
    gg.clearResults()
    visualy()
end

function chanlog()
    local i1 = gg.prompt({"Enter Current Login ID:"}, {"Login"}, {"text"})
    if not i1 then return visualy() end 
    local i2 = gg.prompt({"Enter Target Login ID:"}, {"Login"}, {"text"})
    if not i2 then return visualy() end 
    gg.clearResults()
    gg.setRanges(bor(Jh, A))
    gg.searchNumber(":"..i1[1], 4)
    if gg.getResultCount() > 0 then 
        gg.getResults(99999) 
        gg.editAll(":"..i2[1], 4)
        abc()
    else 
        qwea()
    end 
    gg.clearResults()
    visualy()
end

-- ==========================================
--              WEAPON MODS
-- ==========================================

st_shshq = false
st_sc = false
st_fsk = false
st_avty = false
st_alertr = false

function gun()
menuuuvis = 0
local gChoice = gg.choice ({
 formatBtn("🔫 Custom Weapon Generator"),
 formatBtn("📦 Ammo Duping System"),
 formatBtn("🧹 Clear Active Weapon Slots"),
 formatBtn("❄️ Weapon Slot Freezer"),
 formatBtn("🔄 Anti-Reload Mechanism"),
 formatBtn("♾️ Unlimited Ammo System"),
 formatBtn("⚡ Rapid Fire Rate Overdrive"),
 formatToggle("🎯 Aiming Speed Multiplier", st_shshq),
 formatToggle("🎯 Zero Bullet Spread", st_sc),
 formatToggle("🌾 Weapon Skill Farming", st_fsk),
 formatToggle("💥 Assist C-Bug System", st_avty),
 formatToggle("🔥 Extreme Fire Speed", st_alertr),
 formatBtn("⬅️ Return Back")
}, nil, getUIHeader("WEAPON ARSENAL MODS")) 

if not gChoice or gChoice == 13 then return mainMenu() end
if gChoice == 1 then givegun() end 
if gChoice == 2 then dupept() end 
if gChoice == 3 then cleanslot() end 
if gChoice == 4 then freezeslot() end 
if gChoice == 5 then antirelo() end 
if gChoice == 6 then besk() end 
if gChoice == 7 then rapidik() end 
if gChoice == 8 then shlool() end 
if gChoice == 9 then scat() end 
if gChoice == 10 then farmsk() end 
if gChoice == 11 then avtoq() end 
if gChoice == 12 then scor2() end 
menuuuvis = -1
end

function rapidik()
    local p = gg.prompt({"Select Speed Multiplier [0.3 - 0.9]"}, nil, {"number"})
    if not p then return gun() end
    
    Z.S("4584664420663165927", Q, bor(Ca, O, Cd))
    if Result and #Result > 0 then
        local offs = {16, 28, 240, 252}
        for _, o in ipairs(offs) do 
            Z.W(p[1], o, F)
        end
        abc()
    else
        qwea()
    end
    
    fg.clean()
    gun()
end

function shlool()
    st_shshq = not st_shshq
    if st_shshq then
        local p = gg.prompt({"Enter Speed Range [1 - 100]"}, nil, {"number"})
        if not p then st_shshq = false return gun() end
        
        Z.S("4584664420663165927", Q, bor(Ca, O, Cd))
        Z.W(p[1], 8, F)
        Z.W(p[1], 232, F)
        abc()
    else
        Z.S("4584664420663165927", Q, bor(Ca, O, Cd))
        Z.W(1.2, 8, F)
        Z.W(1.2, 232, F)
        cba()
    end
    fg.clean()
    gun()
end

function scat()
    st_sc = not st_sc
    local _o, _m = "1120403456", "1119748096"
    Z.S(st_sc and _o or _m, D, bor(Ca, O, Cd))
    if Result and #Result ~= 0 then 
        gg.editAll(st_sc and _m or _o, D)
        if st_sc then abc() else cba() end
    else 
        qwea() 
    end
    gg.clearResults()
    gun()
end

function farmsk()
    st_fsk = not st_fsk
    local _o, _m = "4489188110487257088", "4489188110535131456"
    Z.S(st_fsk and _o or _m, Q, bor(Ca, O, Cd))
    if Result and #Result ~= 0 then 
        gg.editAll(st_fsk and _m or _o, Q)
        if st_fsk then abc() else cba() end
    else 
        qwea() 
    end
    gg.clearResults()
    gun()
end

function avtoq()
    st_avty = not st_avty
    local _o, _m = "4489188110487257088", "4489188110489300000"
    Z.S(st_avty and _o or _m, Q, bor(Ca, O, Cd))
    if Result and #Result ~= 0 then 
        gg.editAll(st_avty and _m or _o, Q)
        if st_avty then abc() else cba() end
    else 
        qwea() 
    end
    gg.clearResults()
    gun()
end

function scor2()
    st_alertr = not st_alertr
    local _o, _m = "4489188110487257088", "4489188110516131456"
    Z.S(st_alertr and _o or _m, Q, bor(Ca, O, Cd))
    if Result and #Result ~= 0 then 
        gg.editAll(st_alertr and _m or _o, Q)
        if st_alertr then abc() else cba() end
    else 
        qwea() 
    end
    gg.clearResults()
    gun()
end

function cleanslot()
    if not hookPLAYER("+192", D, 0, false) then return gun() end
    hookPLAYER("+256", D, 0, false)
    hookPLAYER("+288", D, 0, false)
    hookPLAYER("+224", D, 0, false)
    hookPLAYER("+320", D, 0, false)
    hookPLAYER("+352", D, 0, false)
    abc()
    gun()
end

st_relodgper = false 
st_relom4per = false
st_reloakper = false
st_relompper = false

function antirelo()
menuuuvis = 0
local rChoice = gg.choice ({
     formatToggle("Desert Eagle", st_relodgper),
     formatToggle("M4 Rifle", st_relom4per),
     formatToggle("AK-47 Rifle", st_reloakper),
     formatToggle("MP-5 Submachine", st_relompper),
     formatBtn("⬅️ Return Back")
}, nil, getUIHeader("ANTI-RELOAD OVERRIDE")) 

if not rChoice or rChoice == 5 then return gun() end
if rChoice == 1 then antirelodg() end 
if rChoice == 2 then antirelom4() end 
if rChoice == 3 then antireloak() end 
if rChoice == 4 then antirelomp() end 
menuuuvis = -1
end

function antirelomp()
    st_relompper = not st_relompper
    gg.clearList()
    if st_relompper then
        if not hookPLAYER("+264", D, 50, true) then st_relompper = false return gun() end
        abc()
    else
        cba()
    end
    gun()
end

function antireloak()
    st_reloakper = not st_reloakper
    gg.clearList()
    if st_reloakper then
        if not hookPLAYER("+296", D, 50, true) then st_reloakper = false return gun() end
        abc()
    else
        cba()
    end
    gun()
end

function antirelom4()
    st_relom4per = not st_relom4per
    gg.clearList()
    if st_relom4per then
        if not hookPLAYER("+296", D, 50, true) then st_relom4per = false return gun() end
        abc()
    else
        cba()
    end
    gun()
end

function antirelodg()
    st_relodgper = not st_relodgper
    gg.clearList()
    if st_relodgper then
        if not hookPLAYER("+200", D, 22, true) then st_relodgper = false return gun() end
        abc()
    else
        cba()
    end
    gun()
end

st_bdg = false
st_bmka = false
st_bkal = false
st_bdrobq = false
st_bmp5q = false

function besk()
menuuuvis = 0
local bChoice = gg.choice ({
     formatToggle("Desert Eagle", st_bdg),
     formatToggle("M4 Rifle", st_bmka),
     formatToggle("AK-47 Rifle", st_bkal),
     formatToggle("Shotgun", st_bdrobq),
     formatToggle("MP-5 Submachine", st_bmp5q),
     formatBtn("⬅️ Return Back")
}, nil, getUIHeader("UNLIMITED AMMO OVERRIDE")) 

if not bChoice or bChoice == 6 then return gun() end
if bChoice == 1 then bdgq() end 
if bChoice == 2 then bmkk() end 
if bChoice == 3 then bkalq() end 
if bChoice == 4 then bdrobe() end 
if bChoice == 5 then bmpsh() end 
menuuuvis = -1
end

function bdgq()
    st_bdg = not st_bdg
    gg.clearList()
    if st_bdg then
        if not hookPLAYER("+204", D, "", true) then st_bdg = false return gun() end
        abc()
    else
        cba()
    end
    gun()
end

function bmkk()
    st_bmka = not st_bmka
    gg.clearList()
    if st_bmka then
        if not hookPLAYER("+300", D, "", true) then st_bmka = false return gun() end
        abc()
    else
        cba()
    end
    gun()
end

function bkalq()
    st_bkal = not st_bkal
    gg.clearList()
    if st_bkal then
        if not hookPLAYER("+300", D, "", true) then st_bkal = false return gun() end
        abc()
    else
        cba()
    end
    gun()
end

function bmpsh()
    st_bmp5q = not st_bmp5q
    gg.clearList()
    if st_bmp5q then
        if not hookPLAYER("+268", D, "", true) then st_bmp5q = false return gun() end
        abc()
    else
        cba()
    end
    gun()
end

function bdrobe()
    st_bdrobq = not st_bdrobq
    gg.clearList()
    if st_bdrobq then
        if not hookPLAYER("+224", D, "", true) then st_bdrobq = false return gun() end
        abc()
    else
        cba()
    end
    gun()
end

function dupept()
menuuuvis = 0
local dChoice = gg.choice ({
     formatBtn("Desert Eagle"),
     formatBtn("Glock Pistol"),
     formatBtn("M4 Rifle"),
     formatBtn("AK-47 Rifle"),
     formatBtn("MP-5 Submachine"),
     formatBtn("Sniper Rifle"),
     formatBtn("Shotgun"),
     formatBtn("⬅️ Return Back")
}, nil, getUIHeader("AMMO DUPICATION MENU")) 

if not dChoice or dChoice == 8 then return gun() end
if dChoice == 1 then dupedg() end 
if dChoice == 2 then dupeglock() end 
if dChoice == 3 then dupem4() end 
if dChoice == 4 then dupeak() end 
if dChoice == 5 then dupemp() end 
if dChoice == 6 then dupevint() end 
if dChoice == 7 then dupeshotik() end 
menuuuvis = -1
end
        
function dupevint()
    local givptdg7 = gg.prompt({"Specify Ammo Amount [1 - 9900]"}, nil, {[1]="number"})
    if not givptdg7 then return dupept() end
    if not hookPLAYER("+332", D, givptdg7[1], false) then gg.clearResults() return dupept() end
    abc()
    dupept()
end

function dupeshotik()
    local givptdg6 = gg.prompt({"Specify Ammo Amount [1 - 9900]"}, nil, {[1]="number"})
    if not givptdg6 then return dupept() end
    if not hookPLAYER("+236", D, givptdg6[1], false) then gg.clearResults() return dupept() end
    abc()
    dupept()
end

function dupeglock()
    local givptdg5 = gg.prompt({"Specify Ammo Amount [1 - 9900]"}, nil, {[1]="number"})
    if not givptdg5 then return dupept() end
    if not hookPLAYER("+204", D, givptdg5[1], false) then gg.clearResults() return dupept() end
    abc()
    dupept()
end

function dupemp()
    local givptdg4 = gg.prompt({"Specify Ammo Amount [1 - 9900]"}, nil, {[1]="number"})
    if not givptdg4 then return dupept() end
    if not hookPLAYER("+268", D, givptdg4[1], false) then gg.clearResults() return dupept() end
    abc()
    dupept()
end

function dupem4()
    local givptdg3 = gg.prompt({"Specify Ammo Amount [1 - 9900]"}, nil, {[1]="number"})
    if not givptdg3 then return dupept() end
    if not hookPLAYER("+300", D, givptdg3[1], false) then gg.clearResults() return dupept() end
    abc()
    dupept()
end

function dupeak()
    local givptdg2 = gg.prompt({"Specify Ammo Amount [1 - 9900]"}, nil, {[1]="number"})
    if not givptdg2 then return dupept() end
    if not hookPLAYER("+300", D, givptdg2[1], false) then gg.clearResults() return dupept() end
    abc()
    dupept()
end

function dupedg()
    local givptdg1 = gg.prompt({"Specify Ammo Amount [1 - 9900]"}, nil, {[1]="number"})
    if not givptdg1 then return dupept() end
    if not hookPLAYER("+204", D, givptdg1[1], false) then gg.clearResults() return dupept() end
    abc()
    dupept()
end

frzsl = {false, false, false, false, false, false, false}

function freezeslot()
menuuuvis = 0
local fChoice = gg.choice ({
     formatToggle("Desert Eagle Slot", frzsl[1]),
     formatToggle("Glock Slot", frzsl[2]),
     formatToggle("M4 Slot", frzsl[3]),
     formatToggle("AK-47 Slot", frzsl[4]),
     formatToggle("MP-5 Slot", frzsl[5]),
     formatToggle("Sniper Slot", frzsl[6]),
     formatToggle("Shotgun Slot", frzsl[7]),
     formatBtn("⬅️ Return Back")
}, nil, getUIHeader("WEAPON SLOT FREEZE CONTROL")) 

if not fChoice or fChoice == 8 then return gun() end
if fChoice >= 1 and fChoice <= 7 then _frz(fChoice) end
menuuuvis = -1
end
        
function _frz(index)
    local offsets = {
        {o1 = "+192", v1 = 24, o2 = "+204"}, -- DE
        {o1 = "+192", v1 = 22, o2 = "+204"}, -- Glock
        {o1 = "+288", v1 = 31, o2 = "+300"}, -- M4
        {o1 = "+288", v1 = 30, o2 = "+300"}, -- AK
        {o1 = "+256", v1 = 29, o2 = "+268"}, -- MP5
        {o1 = "+320", v1 = 34, o2 = "+332"}, -- Sniper
        {o1 = "+224", v1 = 25, o2 = "+236"}  -- Shotgun
    }
    
    frzsl[index] = not frzsl[index]
    gg.clearList()
    
    if frzsl[index] then
        local cfg = offsets[index]
        if not hookPLAYER(cfg.o1, D, cfg.v1, true) or not hookPLAYER(cfg.o2, D, "", true) then 
            frzsl[index] = false
            gg.clearResults() 
            return freezeslot() 
        end
        abc()
    else
        gg.clearList()
        gg.clearResults()
        cba()
    end
    gg.clearResults()
    freezeslot()
end

function givegun()
menuuuvis = 0
local gChoice = gg.choice ({
             formatBtn("Desert Eagle"),
             formatBtn("M4 Rifle"),
             formatBtn("AK-47 Rifle"),
             formatBtn("Shotgun"),
             formatBtn("MP-5 Submachine"),
             formatBtn("Glock Pistol"),
             formatBtn("Sniper Rifle (No Scope)"),
             formatBtn("Sniper Rifle (With Scope)"),
             formatBtn("Heavy Minigun"),
             formatBtn("RPG Launcher"),
             formatBtn("Auto RPG Launcher"),
             formatBtn("Custom Weapon ID Generator"),
             formatBtn("View Weapon ID Directory"),
             formatBtn("⬅️ Return Back")
}, nil, getUIHeader("CUSTOM WEAPON GENERATOR")) 

if not gChoice or gChoice == 14 then return gun() end
if gChoice == 1 then gv11dg() end 
if gChoice == 2 then gv22m4() end         
if gChoice == 3 then gv33ak() end 
if gChoice == 4 then gv44shot() end 
if gChoice == 5 then gv55mp() end 
if gChoice == 6 then gv66gl() end 
if gChoice == 7 then gv77snap() end 
if gChoice == 8 then gv77snappr() end 
if gChoice == 9 then gv88minig() end 
if gChoice == 10 then gv99rpg() end 
if gChoice == 11 then gv111rpgauto() end 
if gChoice == 12 then givegun14() end 
if gChoice == 13 then givegun1488() end
end

function gv77snappr()
    if not hookPLAYER("+320", D, 34, false) then gg.clearResults() return givegun() end
    local givptdg77 = gg.prompt({"Specify Ammo Amount [1 - 9900]"}, nil, {[1]="number"})
    if not givptdg77 then return givegun() end
    if not hookPLAYER("+332", D, givptdg77[1], false) then gg.clearResults() return givegun() end
    abc()
    givegun()
end

function gv11dg()
    if not hookPLAYER("+192", D, 24, false) then gg.clearResults() return givegun() end
    local givptdg11 = gg.prompt({"Specify Ammo Amount [1 - 9900]"}, nil, {[1]="number"})
    if not givptdg11 then return givegun() end
    if not hookPLAYER("+204", D, givptdg11[1], false) then gg.clearResults() return givegun() end
    abc()
    givegun()
end

function gv22m4()
    if not hookPLAYER("+288", D, 31, false) then gg.clearResults() return givegun() end
    local givptdg22 = gg.prompt({"Specify Ammo Amount [1 - 9900]"}, nil, {[1]="number"})
    if not givptdg22 then return givegun() end
    if not hookPLAYER("+300", D, givptdg22[1], false) then gg.clearResults() return givegun() end
    abc()
    givegun()
end

function gv33ak()
    if not hookPLAYER("+288", D, 30, false) then gg.clearResults() return givegun() end
    local givptdg33 = gg.prompt({"Specify Ammo Amount [1 - 9900]"}, nil, {[1]="number"})
    if not givptdg33 then return givegun() end
    if not hookPLAYER("+300", D, givptdg33[1], false) then gg.clearResults() return givegun() end
    abc()
    givegun()
end

function gv44shot()
    if not hookPLAYER("+224", D, 25, false) then gg.clearResults() return givegun() end
    local givptdg44 = gg.prompt({"Specify Ammo Amount [1 - 9900]"}, nil, {[1]="number"})
    if not givptdg44 then return givegun() end
    if not hookPLAYER("+236", D, givptdg44[1], false) then gg.clearResults() return givegun() end
    abc()
    givegun()
end

function gv55mp()
    if not hookPLAYER("+256", D, 29, false) then gg.clearResults() return givegun() end
    local givptdg55 = gg.prompt({"Specify Ammo Amount [1 - 9900]"}, nil, {[1]="number"})
    if not givptdg55 then return givegun() end
    if not hookPLAYER("+268", D, givptdg55[1], false) then gg.clearResults() return givegun() end
    abc()
    givegun()
end

function gv66gl()
    if not hookPLAYER("+192", D, 22, false) then gg.clearResults() return givegun() end
    local givptdg66 = gg.prompt({"Specify Ammo Amount [1 - 9900]"}, nil, {[1]="number"})
    if not givptdg66 then return givegun() end
    if not hookPLAYER("+204", D, givptdg66[1], false) then gg.clearResults() return givegun() end
    abc()
    givegun()
end

function gv77snap()
    if not hookPLAYER("+320", D, 33, false) then gg.clearResults() return givegun() end
    local givptdg89 = gg.prompt({"Specify Ammo Amount [1 - 9900]"}, nil, {[1]="number"})
    if not givptdg89 then return givegun() end
    if not hookPLAYER("+332", D, givptdg89[1], false) then gg.clearResults() return givegun() end
    abc()
    givegun()
end

function gv88minig()
    if not hookPLAYER("+352", D, 38, false) then gg.clearResults() return givegun() end
    local givptdg888 = gg.prompt({"Specify Ammo Amount [1 - 9900]"}, nil, {[1]="number"})
    if not givptdg888 then return givegun() end
    if not hookPLAYER("+364", D, givptdg888[1], false) then gg.clearResults() return givegun() end
    abc()
    givegun()
end

function gv99rpg()
    if not hookPLAYER("+352", D, 35, false) then gg.clearResults() return givegun() end
    local givptdg99 = gg.prompt({"Specify Ammo Amount [1 - 9900]"}, nil, {[1]="number"})
    if not givptdg99 then return givegun() end
    if not hookPLAYER("+364", D, givptdg99[1], false) then gg.clearResults() return givegun() end
    abc()
    givegun()
end

function gv111rpgauto()
    if not hookPLAYER("+352", D, 36, false) then gg.clearResults() return givegun() end
    local givptdg111 = gg.prompt({"Specify Ammo Amount [1 - 9900]"}, nil, {[1]="number"})
    if not givptdg111 then return givegun() end
    if not hookPLAYER("+364", D, givptdg111[1], false) then gg.clearResults() return givegun() end
    abc()
    givegun()
end

function givegun14()
    local givptdg14888 = gg.prompt({"Specify Weapon ID [1 - 46]"}, nil, {[1]="number"})
    if not givptdg14888 then return givegun() end
    if not hookPLAYER("+192", D, givptdg14888[1], false) then gg.clearResults() return givegun() end
    
    local givptdg1488 = gg.prompt({"Specify Ammo Amount [1 - 9900]"}, nil, {[1]="number"})
    if not givptdg1488 then return givegun() end
    if not hookPLAYER("+204", D, givptdg1488[1], false) then gg.clearResults() return givegun() end
    abc()
    givegun() 
end

function givegun1488()
    gg.alert("🔫 WEAPON ID DIRECTORY 🔫\n\n1: Knuckles | 2: Key | 3: Baton | 4: Knife\n5: Bat | 6: Shovel | 7: Cue | 8: Katana\n9: Chainsaw | 10: Dildo 1 | 11: Dildo 2 | 14: Flowers\n16: Grenade | 17: Tear Gas | 18: Molotov\n22: 9mm Pistol | 23: Silenced Pistol | 24: Deagle\n25: Shotgun | 26: Sawed-Off | 27: Auto Shotgun\n28: Uzi | 29: MP5 | 30: AK-47 | 31: M4\n32: Tec-9 | 33: Rifle | 34: Sniper Rifle\n35: RPG | 36: Rocket Launcher | 38: Minigun\n41: Spray Can | 42: Extinguisher | 43: Camera")
    givegun()
end

-- ==========================================
--            TELEPORTATION HUB
-- ==========================================

local publicPlaces = {
    {name = '🏫 Driving School', x = 486, y = 2276, z = 12},
    {name = '🏛️ Military Base Gate', x = 1915, y = 2302, z = 15},
    {name = '🏦 Yuzhny Bank', x = 2372, y = -2142, z = 23},
    {name = '🏦 Bank Arzamas', x = -143, y = 593, z = 12},
    {name = '🏦 Bank Batyrevo', x = 1850, y = 2042, z = 16},
    {name = '⛪ Church', x = 1877, y = 1166, z = 31},
    {name = '🚗 Car Market', x = 878, y = 2236, z = 19},
    {name = '📮 Post Office', x = 801, y = 1349, z = 15}
}

local hiddenteleports = {
  {name = '🔒 ADMIN ZONE', x = -701.82, y = -2438.95, z = 1198.15},
  {name = '🔓 JAIL ESCAPE POINT', x = 644.01, y = 1049.21, z = 1208.26},
  {name = '🚔 HIGH SECURITY PRISON', x = -1830, y = -2870, z = 45},
  {name = '⚔️ MILITARY SECTOR #1', x = -1092.7, y = -2539.2, z = 28.6},
  {name = '⚔️ MILITARY SECTOR #2', x = -1002.8, y = -2497.4, z = 28.1},
  {name = '📡 TV BROADCAST TOWER', x = 2130, y = -1968, z = 270},
  {name = '🏥 HOSPITAL ROOFTOP', x = 382, y = 1332, z = 128},
  {name = '🏛️ GOVERNMENT ROOFTOP', x = 356, y = 1680, z = 108}
}

function tpMenu()
    while true do
        local choices = {
            formatBtn("🌍 Public Locations Hub"),
            formatBtn("🕵️ Secret / Hidden Teleports"),
            formatBtn("📍 Custom Coordinates Teleport"),
            formatBtn("⬅️ Return to Main Menu")
        }
        local choice = gg.choice(choices, nil, getUIHeader("TELEPORTATION HUB"))
        
        if not choice or choice == 4 then break end
        
        if choice == 1 then
            local names = {}
            for _, place in ipairs(publicPlaces) do table.insert(names, formatBtn(place.name)) end
            table.insert(names, formatBtn("⬅️ Back"))
            local pChoice = gg.choice(names, nil, getUIHeader("PUBLIC LOCATIONS"))
            if pChoice and pChoice <= #publicPlaces then
                local place = publicPlaces[pChoice]
                doTeleport(place.x, place.y, place.z)
            end
        elseif choice == 2 then
            local names = {}
            for _, place in ipairs(hiddenteleports) do table.insert(names, formatBtn(place.name)) end
            table.insert(names, formatBtn("⬅️ Back"))
            local hChoice = gg.choice(names, nil, getUIHeader("SECRET TELEPORTS"))
            if hChoice and hChoice <= #hiddenteleports then
                local place = hiddenteleports[hChoice]
                doTeleport(place.x, place.y, place.z)
            end
        elseif choice == 3 then
            local input = gg.prompt({"X Coordinate:", "Y Coordinate:", "Z Coordinate:"}, {"0", "0", "0"}, {"number", "number", "number"})
            if input then
                doTeleport(tonumber(input[1]), tonumber(input[2]), tonumber(input[3]))
            end
        end
    end
end

-- Start Main Menu
mainMenu()
