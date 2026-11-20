if not game:IsLoaded() then repeat task.wait() until game:IsLoaded() end

local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local SG = game:GetService("StarterGui")
local LP = Players.LocalPlayer
local PG = LP:WaitForChild("PlayerGui")
local UIS = game:GetService("UserInputService")
local Debris = game:GetService("Debris")
local Https = game:GetService("HttpService")
local TweenS = game:GetService("TweenService")
local MarketplaceService = game:GetService("MarketplaceService")
local WS = workspace

local VERSION_TAG = "45.0 LIVE DROP ALL CASE ITEMS + DELETE ICON FIX"
local LOGO_ID = 128483417570764

local THEMES = {
    Mars = {name="Mars", bgImageId=107598759461997, colors={
        bg=Color3.fromRGB(30,8,5), bgAlt=Color3.fromRGB(48,12,8), panel=Color3.fromRGB(68,18,10),
        card=Color3.fromRGB(82,26,16), cardHover=Color3.fromRGB(112,36,20), input=Color3.fromRGB(38,10,7),
        border=Color3.fromHex("d65a2e"), borderSoft=Color3.fromRGB(88,44,32), text=Color3.fromRGB(248,232,218),
        sub=Color3.fromRGB(255,205,170), muted=Color3.fromRGB(205,145,115), accent=Color3.fromHex("ff6538"),
        accentDark=Color3.fromHex("b84a28"), accentRose=Color3.fromHex("d94a30"),
        green=Color3.fromRGB(200,150,90), red=Color3.fromRGB(220,75,50),
        gold=Color3.fromHex("f0a55a"), purple=Color3.fromHex("c86535"), yellow=Color3.fromHex("e8b860")}},
    Moon = {name="Moon", bgImageId=89891303744189, colors={
        bg=Color3.fromRGB(7,20,48), bgAlt=Color3.fromRGB(12,36,78), panel=Color3.fromRGB(20,56,112),
        card=Color3.fromRGB(28,74,132), cardHover=Color3.fromRGB(38,102,174), input=Color3.fromRGB(8,28,62),
        border=Color3.fromHex("8fc8ff"), borderSoft=Color3.fromRGB(56,84,126), text=Color3.fromRGB(240,248,255),
        sub=Color3.fromRGB(195,230,255), muted=Color3.fromRGB(155,195,235), accent=Color3.fromHex("42baff"),
        accentDark=Color3.fromHex("5a9ce0"), accentRose=Color3.fromHex("c8e4ff"),
        green=Color3.fromRGB(130,225,245), red=Color3.fromRGB(225,115,130),
        gold=Color3.fromHex("e8f4ff"), purple=Color3.fromHex("a8c8f0"), yellow=Color3.fromHex("d8ecff")}},
    Galaxy = {name="Cosmos", bgImageId=136378402386149, colors={
        bg=Color3.fromRGB(15,3,42), bgAlt=Color3.fromRGB(30,5,72), panel=Color3.fromRGB(48,8,104),
        card=Color3.fromRGB(62,18,116), cardHover=Color3.fromRGB(88,26,154), input=Color3.fromRGB(24,5,56),
        border=Color3.fromHex("b44dff"), borderSoft=Color3.fromRGB(70,32,110), text=Color3.fromRGB(248,235,255),
        sub=Color3.fromRGB(225,190,255), muted=Color3.fromRGB(190,145,235), accent=Color3.fromHex("df55ff"),
        accentDark=Color3.fromHex("8a2be2"), accentRose=Color3.fromHex("ff5cc7"),
        green=Color3.fromRGB(180,130,255), red=Color3.fromRGB(255,90,150),
        gold=Color3.fromHex("e5b8ff"), purple=Color3.fromHex("b44dff"), yellow=Color3.fromHex("f0c4ff")}},
    Halloween = {name="Halloween", bgImageId=98610335736512, colors={
        bg=Color3.fromRGB(24,5,34), bgAlt=Color3.fromRGB(42,8,62), panel=Color3.fromRGB(64,12,88),
        card=Color3.fromRGB(76,18,104), cardHover=Color3.fromRGB(108,25,138), input=Color3.fromRGB(30,6,48),
        border=Color3.fromHex("ff8c1a"), borderSoft=Color3.fromRGB(70,36,52), text=Color3.fromRGB(255,240,220),
        sub=Color3.fromRGB(255,205,155), muted=Color3.fromRGB(215,155,120), accent=Color3.fromHex("ff9d22"),
        accentDark=Color3.fromHex("b84a28"), accentRose=Color3.fromHex("ff4d8f"),
        green=Color3.fromHex("8fff4a"), red=Color3.fromHex("ff4d5e"),
        gold=Color3.fromHex("ffcc4d"), purple=Color3.fromHex("a340ff"), yellow=Color3.fromHex("ffb347")}},
    NewYear = {name="New Year", bgImageId=138766728600198, colors={
        bg=Color3.fromRGB(5,18,42), bgAlt=Color3.fromRGB(8,34,76), panel=Color3.fromRGB(12,54,104),
        card=Color3.fromRGB(20,58,104), cardHover=Color3.fromRGB(28,82,142), input=Color3.fromRGB(6,24,52),
        border=Color3.fromHex("a8e8ff"), borderSoft=Color3.fromRGB(44,64,100), text=Color3.fromRGB(240,250,255),
        sub=Color3.fromRGB(195,235,255), muted=Color3.fromRGB(150,195,230), accent=Color3.fromHex("43d5ff"),
        accentDark=Color3.fromHex("4a9ad0"), accentRose=Color3.fromHex("ffd4f0"),
        green=Color3.fromHex("90ffd0"), red=Color3.fromRGB(255,122,138),
        gold=Color3.fromHex("f0faff"), purple=Color3.fromHex("9db4ff"), yellow=Color3.fromHex("e0f4ff")}},
}

local CONFIG = {
    UpgradeMaxChance=75, UpgradeHighPriceThreshold=2000000, UpgradeHighPriceDivisor=1.1,
    BlessingSaveChance=0.5, NormalSaveChance=0.15,
    PickerMaxPerItem=999, PickerHoldTime=0.6, PickerChunkSize=25,
    ModalMaxWidth=360, ModalMaxHeight=520, ModalRowHeight=54,
    PumpkinSpawnMin=1.4, PumpkinSpawnMax=2.6, PumpkinLifeMin=5.0, PumpkinLifeMax=9.0,
    PumpkinSizeMin=26, PumpkinSizeMax=52, PumpkinCount=3,
    LeafSpawnMin=1.8, LeafSpawnMax=3.0, DefaultSenderName="System",
    WinW=540, WinH=660, HeaderH=52, SidebarW=58, SaveInterval=30, ParticleZIndex=50,
    Transparency={win=0.28, header=0.20, sidebar=0.24, cHolder=0.34, card=0.15},
    InfiniteBuffSeconds=315360000,
}

local newcclosure = newcclosure or function(f) return f end
local getconnections = getconnections or (syn and syn.getconnections) or (fluxus and fluxus.getconnections)

local function tryReq(n, t)
    local m = RS:FindFirstChild(n)
    if not m then local ok, r = pcall(RS.WaitForChild, RS, n, t or 5); if ok then m = r end end
    if not m then return nil end
    local ok, res = pcall(require, m)
    return ok and res or nil
end
local Info = tryReq("Info", 10) or {Gifts={}, Cases={}, Backdrops={}, Patterns={}}
local Handler = tryReq("Handler")
local HalloweenCfg = tryReq("HalloweenConfigs") or {Spin={Prizes={}, FreeEvery=10800}, Cauldron={Recipes={}}, Products={}}
local NFTPassCfg = tryReq("NFTPassConfigs") or {Rewards={Free={},Plus={}}, LvlXP=function() return 0 end, Season=0}
local ExclusiveCfg = tryReq("ExclusiveConfig") or {Wheel=function() return {} end}
local CraftCfg = tryReq("CraftConfigs") or {Rarities={}, Drops=function() return {} end}
local ShopItemsCfg = tryReq("ShopItems") or {Items={}}
local RebirthCfg = tryReq("RebirthConfig") or {VoucherProducts={}}
local UpgradeCfg = tryReq("UpgradeConfigs")
local LimitedCfg = tryReq("LimitedConfigs")
local Ev = RS:WaitForChild("Events", 15)
local MailCfg = tryReq("MailConfig") or {Plans={{Name="Free",Limit=10},{Name="Plus",Limit=50},{Name="Pro",Limit=150}}}
-- This build intentionally exposes only finite local plans: 10 / 50 / 150 per day.
if type(MailCfg.Plans) == "table" then
    MailCfg.Plans[4] = {Name="150/day cap", Limit=150, Price=0, Id=0}
end

if Info and Info.Gifts then
    local mt = getmetatable(Info.Gifts) or {}
    local oi = mt.__index
    local fake = {Price=0, Image=0, DisplayName="", Hidden=true}
    setmetatable(Info.Gifts, {__index=function(t,k) if k==nil then return fake end if type(oi)=="function" then return oi(t,k) end return rawget(t,k) end})
end

local FOLDER = "SunsetSisi"
local FILES = {
    normal=FOLDER.."/01_normal_nfts.json", unique=FOLDER.."/02_unique_nfts.json",
    curr=FOLDER.."/03_fake_currencies.json", customcases=FOLDER.."/04_custom_cases.json",
    index=FOLDER.."/05_fake_index.json", promo=FOLDER.."/06_fake_promo_codes.json",
    best=FOLDER.."/07_best_drop.json", settings=FOLDER.."/08_settings.json",
    mail=FOLDER.."/fake_mail.json", log=FOLDER.."/log.json",
    buff=FOLDER.."/buffs_unused.json", cnft=FOLDER.."/custom_nfts_unused.json"
}
local hasFile = (type(writefile)=="function" and type(readfile)=="function" and type(isfile)=="function" and type(isfolder)=="function" and type(makefolder)=="function")
local LEGACY_FILES = {
    normal=FOLDER.."/normal_nfts.json", unique=FOLDER.."/unique_nfts.json",
    curr=FOLDER.."/fake_currencies.json", customcases=FOLDER.."/custom_cases.json",
    index=FOLDER.."/fake_index.json", promo=FOLDER.."/promo_codes.json",
    best=FOLDER.."/best_drop.json", settings=FOLDER.."/settings.json"
}
if hasFile then
    pcall(function() if not isfolder(FOLDER) then makefolder(FOLDER) end end)
    for key, f in pairs(FILES) do
        pcall(function()
            if not isfile(f) then
                local legacy = LEGACY_FILES[key]
                if legacy and isfile(legacy) then
                    local raw = readfile(legacy)
                    writefile(f, type(raw)=="string" and raw or "{}")
                else
                    writefile(f, "{}")
                end
            end
        end)
    end
end
local function rJSON(p, d)
    if not hasFile or not isfile(p) then return d end
    local ok, raw = pcall(readfile, p)
    if not ok or type(raw) ~= "string" or raw == "" then return d end
    local ok2, data = pcall(function() return Https:JSONDecode(raw) end)
    return ok2 and data or d
end
local function wJSON(p, d) if hasFile then pcall(function() writefile(p, Https:JSONEncode(d)) end) end end

local _nfts, _uniques, _currencies, _mail, _logs, _promo, _buffs, _best, _customNFTs, _customCases, _index, _settings = {}, {}, {}, {}, {}, {}, {}, {name=nil, old=nil}, {}, {}, {}, {FakeAllPurchases=true, Theme="Halloween", EventParticles=true, MailPlanOverride=0, MailPlanOverrideEnabled=false, GameSettings={}}
do
    for k, f in pairs(FILES) do
        local d = rJSON(f, {})
        if type(d) ~= "table" then continue end
        if k=="normal" then _nfts = d
        elseif k=="unique" then _uniques = d
        elseif k=="curr" then _currencies = d
        elseif k=="mail" then _mail = d
        elseif k=="log" then _logs = d
        elseif k=="promo" then _promo = d
        elseif k=="buff" then _buffs = d
        elseif k=="best" then _best = {name=d.name, old=d.old}
        elseif k=="cnft" then _customNFTs = d
        elseif k=="customcases" then _customCases = d
        elseif k=="index" then _index = d
        elseif k=="settings" then for kk, vv in pairs(d) do _settings[kk] = vv end end
    end
end
-- Persist only settings that are actually requested by the game's Settings hook.
if type(_settings.GameSettings) ~= "table" then _settings.GameSettings = {} end
if _settings.GameSettings.MusicSound == nil then _settings.GameSettings.MusicSound = 0.1 end
if _settings.GameSettings.Snow == nil then _settings.GameSettings.Snow = true end
if _settings.GameSettings.HideLiveDrop == nil then
    if _settings.LiveDrop ~= nil then
        _settings.GameSettings.HideLiveDrop = (_settings.LiveDrop == false)
    else
        _settings.GameSettings.HideLiveDrop = true
    end
end
_settings.GameSettings.Snow = (_settings.GameSettings.Snow == true or tonumber(_settings.GameSettings.Snow) == 1)
_settings.GameSettings.HideLiveDrop = (_settings.GameSettings.HideLiveDrop == true or tonumber(_settings.GameSettings.HideLiveDrop) == 1)
_settings.LiveDrop = nil
_settings.GameSounds = nil
_settings.Pumpkins = nil
_G.HideDrop = _settings.GameSettings.HideLiveDrop == true
local SAVE = {}
for k, f in pairs(FILES) do
    SAVE[k] = function()
        local d = k=="normal" and _nfts or k=="unique" and _uniques or k=="curr" and _currencies
            or k=="mail" and _mail or k=="log" and _logs or k=="promo" and _promo
            or k=="buff" and _buffs or k=="best" and _best or k=="cnft" and _customNFTs
            or k=="customcases" and _customCases or k=="index" and _index or k=="settings" and _settings or {}
        wJSON(f, d)
    end
end
local _lastLog = 0
local function pushLog(msg)
    local now = os.clock()
    if now - _lastLog < 0.05 then return end
    _lastLog = now
    table.insert(_logs, {t=os.time(), m=tostring(msg)})
    while #_logs > 200 do table.remove(_logs, 1) end
    task.delay(0.3, SAVE.log)
end

local CurrentTheme = THEMES[_settings.Theme] or THEMES.Halloween
local C = {}
for k, v in pairs(CurrentTheme.colors) do C[k] = v end
local function refreshTheme()
    CurrentTheme = THEMES[_settings.Theme] or THEMES.Halloween
    for k in pairs(C) do C[k] = nil end
    for k, v in pairs(CurrentTheme.colors) do C[k] = v end
end

for name, data in pairs(_customNFTs) do
    if type(data) == "table" then
        Info.Gifts[name] = {Price=tonumber(data.price) or 0, Image=tonumber(data.image) or 0, DisplayName=data.display or name, CustomUser=true, Hidden=false}
    end
end

local function num(n) return tostring(math.floor(tonumber(n) or 0)) end
local SUFFIXES = {"", "k", "M", "B", "T", "Qd", "Qn"}
local function fullNum(n)
    n = math.floor(tonumber(n) or 0)
    local i = 1
    while n >= 1000 and i < #SUFFIXES do n = n / 1000; i = i + 1 end
    if i == 1 then return tostring(math.floor(n)) end
    return string.format("%.1f", n):gsub("%.0$", "") .. SUFFIXES[i]
end
local MAX_LOCAL_VALUE = 9e18 -- IntValue signed-64-bit ceiling guard; Lua numbers lose integer precision above 2^53.
local function parseNum(str)
    if type(str) ~= "string" then return nil end
    local s = str:lower():gsub("%s", ""):gsub(",", "")
    if s == "" then return nil end
    local multipliers = {
        k=1e3, m=1e6, b=1e9, t=1e12,
        qd=1e15, qn=1e18,
    }
    local suffix2 = s:sub(-2)
    local suffix1 = s:sub(-1)
    local mult = multipliers[suffix2]
    local part = s
    if mult then
        part = s:sub(1, -3)
    else
        mult = multipliers[suffix1] or 1
        if mult ~= 1 then part = s:sub(1, -2) end
    end
    if part == "" or not part:match("^%d+%.?%d*$") then return nil end
    local n = tonumber(part)
    if not n or n ~= n or n == math.huge or n == -math.huge then return nil end
    n = n * mult
    if n > MAX_LOCAL_VALUE or n < 0 or n == math.huge then return nil end
    return math.floor(n)
end
local function fmtTime(sec)
    sec = math.max(0, math.floor(tonumber(sec) or 0))
    if sec >= 3600 then return string.format("%dh %02dm", sec//3600, (sec%3600)//60)
    elseif sec >= 60 then return string.format("%dm %02ds", sec//60, sec%60)
    else return sec .. "s" end
end
local function safeNumber(value, fallback, minV, maxV)
    local n = tonumber(value)
    if not n or n ~= n or n == math.huge or n == -math.huge then return fallback end
    if minV ~= nil then n = math.max(minV, n) end
    if maxV ~= nil then n = math.min(maxV, n) end
    return n
end
local function cleanText(value, maxLen)
    if type(value) ~= "string" then return "" end
    return value:gsub("[%c]", ""):gsub("^%s+", ""):gsub("%s+$", ""):sub(1, maxLen or 80)
end
local function addTextStroke(label, col, thick, trans)
    if not label then return end
    local s = Instance.new("UIStroke")
    s.Color = col or Color3.new(0, 0, 0)
    s.Thickness = thick or 1.2
    s.Transparency = trans or 0.35
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
    s.Parent = label
    return s
end
local function themeBgLum()
    return C.bg.R * 0.299 + C.bg.G * 0.587 + C.bg.B * 0.114
end

local CUR_LIST = {
    {key="_StarsValue", label="Stars", icon="rbxassetid://123580826852107"},
    {key="_GemsValue", label="Diamonds", icon="rbxassetid://110345687858105"},
    {key="_TONValue", label="TON", icon="rbxassetid://83906505399852"},
    {key="_Candy", label="Candy", icon="rbxassetid://73592038547777"},
    {key="_Pumpkins", label="Pumpkins", icon="rbxassetid://89119977920382"},
    {key="_HalloweenSpins", label="Spins", icon="rbxassetid://130601837776898"},
    {key="_Vouchers", label="Rebirth Tickets", icon="rbxassetid://138189270522554"},
    {key="_PassRerolls", label="Rerolls", icon="rbxassetid://138189270522554"},
    {key="_CustomCredits", label="Custom Case Tickets", icon="rbxassetid://138189270522554"},
}
local GP_IDS = {1628441770, 1651738174, 1831083023}
local _balRefs, _expected, _applying = {}, {}, false
local function getOrCreate(p, n, c, d)
    local o = p:FindFirstChild(n)
    if o then return o end
    o = Instance.new(c); o.Name = n; if d ~= nil then o.Value = d end; o.Parent = p
    return o
end
for _, c in ipairs(CUR_LIST) do
    local v = getOrCreate(LP, c.key, "IntValue", tonumber(_currencies[c.key]) or 0)
    _balRefs[c.key] = v
    if _currencies[c.key] == nil then _currencies[c.key] = v.Value end
    _expected[c.key] = v.Value
end
local function applyCur()
    _applying = true
    for _, c in ipairs(CUR_LIST) do
        local v = _balRefs[c.key]
        if v and v.Value ~= _currencies[c.key] then v.Value = _currencies[c.key] end
        _expected[c.key] = _currencies[c.key]
    end
    task.defer(function() _applying = false end)
end
applyCur()
for _, dt in ipairs({0.5, 1.5, 3, 8, 15}) do task.delay(dt, applyCur) end
for _, c in ipairs(CUR_LIST) do
    local v = _balRefs[c.key]
    v:GetPropertyChangedSignal("Value"):Connect(function()
        if _applying then return end
        if v.Value == _expected[c.key] then return end
        local delta = v.Value - (_expected[c.key] or 0)
        _currencies[c.key] = math.max(0, (_currencies[c.key] or 0) + delta)
        _expected[c.key] = v.Value
        task.defer(SAVE.curr)
    end)
end
local function setBal(k, v)
    v = tonumber(v) or 0
    if v ~= v or v == math.huge or v == -math.huge then v = 0 end
    v = math.floor(math.clamp(v, 0, MAX_LOCAL_VALUE))
    _currencies[k] = v; _expected[k] = v; _applying = true
    if _balRefs[k] then pcall(function() _balRefs[k].Value = v end) end
    task.defer(function() _applying = false end)
    SAVE.curr()
end
local function addBal(k, d)
    local delta = tonumber(d)
    if not delta or delta ~= delta or delta == math.huge or delta == -math.huge then return end
    delta = math.clamp(delta, -MAX_LOCAL_VALUE, MAX_LOCAL_VALUE)
    local current = tonumber(_currencies[k]) or 0
    setBal(k, math.clamp(current + delta, 0, MAX_LOCAL_VALUE))
end
local function getBal(k) return _currencies[k] or 0 end

local _buffEnd, _buffRunning = {}, {}
local LUCK_PAIRS = {
    {player="_LuckyPotion", rs="LuckValue"}, {player="_LuckyPotion2", rs="LuckValue2"},
    {player="_LuckyPotion3", rs="LuckValue3"}, {player="_Blessing", rs="CrossValue"},
}
local function ensureInt(parent, name)
    local o = parent:FindFirstChild(name)
    if o and (o:IsA("IntValue") or o:IsA("NumberValue")) then return o end
    if o then pcall(function() o:Destroy() end) end
    o = Instance.new("IntValue"); o.Name = name; o.Value = 0; o.Parent = parent
    return o
end
task.spawn(function() for _, p in ipairs(LUCK_PAIRS) do ensureInt(LP, p.player); ensureInt(RS, p.rs) end end)
local function findPair(key) for _, p in ipairs(LUCK_PAIRS) do if p.player==key or p.rs==key then return p end end return nil end
local function startBuff(key)
    local pair = findPair(key); local mk = pair and pair.player or key
    if _buffRunning[mk] then return end; _buffRunning[mk] = true
    task.spawn(function()
        local lastWrite = 0
        while _buffEnd[mk] and _buffEnd[mk] > tick() do
            local now = tick(); local remaining = math.max(0, math.floor(_buffEnd[mk] - now))
            if (now - lastWrite) >= 1 then
                local pv = LP:FindFirstChild(mk)
                if pv and pv:IsA("IntValue") and pv.Value ~= remaining then pcall(function() pv.Value = remaining end) end
                if pair then local rv = RS:FindFirstChild(pair.rs); if rv and rv.Value ~= remaining then pcall(function() rv.Value = remaining end) end end
                lastWrite = now
            end
            task.wait(0.1)
        end
        _buffEnd[mk] = 0; _buffRunning[mk] = nil
        local pv = LP:FindFirstChild(mk); if pv and pv:IsA("IntValue") then pcall(function() pv.Value = 0 end) end
        if pair then local rv = RS:FindFirstChild(pair.rs); if rv then pcall(function() rv.Value = 0 end) end end
    end)
end
local function forceAddBuff(key, seconds)
    seconds = math.max(1, math.floor(tonumber(seconds) or 0))
    if seconds <= 0 then return end
    local pair = findPair(key); local mk = pair and pair.player or key
    local now = tick()
    local remaining = math.max(0, (_buffEnd[mk] or 0) - now)
    local total = seconds + remaining
    _buffEnd[mk] = now + total
    local pv = LP:FindFirstChild(mk); if pv and pv:IsA("IntValue") then pcall(function() pv.Value = math.floor(total) end) end
    if pair then local rv = RS:FindFirstChild(pair.rs); if rv then pcall(function() rv.Value = math.floor(total) end) end end
    startBuff(mk); pushLog("Buff "..mk.." +"..seconds.."s")
end
local function pinBuff(key) forceAddBuff(key, CONFIG.InfiniteBuffSeconds) end
local function removeBuff(key)
    local pair = findPair(key); local mk = pair and pair.player or key
    _buffEnd[mk] = 0
    local pv = LP:FindFirstChild(mk); if pv and pv:IsA("IntValue") then pcall(function() pv.Value = 0 end) end
    if pair then local rv = RS:FindFirstChild(pair.rs); if rv then pcall(function() rv.Value = 0 end) end end
end
local function getLuck()
    local m = 1
    local p2 = LP:FindFirstChild("_LuckyPotion");  if p2 and p2.Value > 0 then m = m * 2 end
    local p4 = LP:FindFirstChild("_LuckyPotion2"); if p4 and p4.Value > 0 then m = m * 4 end
    local p6 = LP:FindFirstChild("_LuckyPotion3"); if p6 and p6.Value > 0 then m = m * 6 end
    return m
end
local function hasBlessing() local b = LP:FindFirstChild("_Blessing"); return b and b.Value > 0 end
local function removeAll() for _, p in ipairs(LUCK_PAIRS) do removeBuff(p.player) end end

local _Inv = getOrCreate(LP, "_Inventory", "Folder")
local _CustomCasesFolder = getOrCreate(LP, "_CustomCases", "Folder")
local function ensureCustomCasesFolder()
    if not _CustomCasesFolder or not _CustomCasesFolder.Parent then
        _CustomCasesFolder = getOrCreate(LP, "_CustomCases", "Folder")
    end
    return _CustomCasesFolder
end
local function ensureInv()
    if not _Inv or not _Inv.Parent then
        _Inv = LP:FindFirstChild("_Inventory")
        if not _Inv then _Inv = Instance.new("Folder"); _Inv.Name = "_Inventory"; _Inv.Parent = LP end
    end
    return _Inv
end
local function normNum(n)
    if n == nil then return "Collectible #" .. tostring(math.random(1, 999999)) end
    if type(n) == "number" then return "Collectible #" .. tostring(math.floor(n)) end
    local s = tostring(n)
    if s:find("Collectible", 1, true) then return s end
    if s:match("^%d+$") then return "Collectible #" .. s end
    return s
end
local function pickBackdrop()
    local bds = {}
    if Info.Backdrops then for b in pairs(Info.Backdrops) do if type(b) == "string" and string.lower(b) ~= "black" then table.insert(bds, b) end end end
    if #bds == 0 then if Info.Backdrops then for b in pairs(Info.Backdrops) do if type(b) == "string" then return b end end end; return "Black" end
    return bds[math.random(1, #bds)]
end
local function pickPattern()
    local ps = {}
    if Info.Patterns then for p in pairs(Info.Patterns) do if type(p) == "string" then table.insert(ps, p) end end end
    if #ps == 0 then return "Star" end
    return ps[math.random(1, #ps)]
end
-- Case openings create several inventory objects in one synchronous remote call.
-- Batch JSON/index writes so Android clients do not rewrite the full inventory for
-- every single drop while the game is waiting for OpenCase:InvokeServer to return.
local _inventoryBatch = nil
local function updateIndex(name, delta, deferSave)
    local idx = LP:FindFirstChild("_Index"); if not idx then idx = Instance.new("Folder"); idx.Name = "_Index"; idx.Parent = LP end
    local e = idx:FindFirstChild(name)
    if not e then e = Instance.new("IntValue"); e.Name = name; e.Value = 0; e.Parent = idx end
    if e:IsA("IntValue") then
        local change = math.floor(tonumber(delta) or 1)
        e.Value = math.max(0, e.Value + change)
        _index[name] = math.max(0, (tonumber(_index[name]) or 0) + change)
        if _index[name] == 0 then _index[name] = nil end
        if not deferSave then SAVE.index() end
    end
end
local function beginInventoryBatch()
    local batch = {normal=false, unique=false, index={}}
    local previous = _inventoryBatch
    _inventoryBatch = batch
    return batch, previous
end
local function finishInventoryBatch(batch, previous)
    if _inventoryBatch == batch then _inventoryBatch = previous end
    if previous then
        previous.normal = previous.normal or batch.normal
        previous.unique = previous.unique or batch.unique
        for name, delta in pairs(batch.index) do previous.index[name] = (previous.index[name] or 0) + delta end
        return
    end
    if batch.normal then pcall(SAVE.normal) end
    if batch.unique then pcall(SAVE.unique) end
    local changedIndex = false
    for name, delta in pairs(batch.index) do
        if delta ~= 0 then
            pcall(updateIndex, name, delta, true)
            changedIndex = true
        end
    end
    if changedIndex then pcall(SAVE.index) end
end
local function isInvChild(inst)
    if typeof(inst) ~= "Instance" then return false end
    local inv = LP:FindFirstChild("_Inventory")
    return inv ~= nil and inst.Parent == inv
end
local _restoringInventory = false
local function addNormal(name, favorite)
    if not Info.Gifts[name] then return end
    if not _nfts[name] then _nfts[name] = {favorite=false, count=0} end
    _nfts[name].count = _nfts[name].count + 1
    if favorite then _nfts[name].favorite = true end
    if _inventoryBatch then
        _inventoryBatch.normal = true
        if not _restoringInventory then _inventoryBatch.index[name] = (_inventoryBatch.index[name] or 0) + 1 end
    else
        SAVE.normal(); if not _restoringInventory then updateIndex(name, 1) end
    end
end
local function removeNormal(name)
    if not _nfts[name] then return false end
    _nfts[name].count = math.max(0, _nfts[name].count - 1)
    if _nfts[name].count == 0 then _nfts[name] = nil end
    if _inventoryBatch then
        _inventoryBatch.normal = true
        _inventoryBatch.index[name] = (_inventoryBatch.index[name] or 0) - 1
    else
        SAVE.normal(); updateIndex(name, -1)
    end
    return true
end
local function addUnique(name, data)
    if not Info.Gifts[name] then return end
    if not _uniques[name] then _uniques[name] = {} end
    table.insert(_uniques[name], {owner=LP.Name, model=name, pattern=data.pattern, backdrop=data.backdrop, date=os.date("%m/%d/%Y"), number=data.number, favorite=data.favorite==true})
    if _inventoryBatch then
        _inventoryBatch.unique = true
        if not _restoringInventory then _inventoryBatch.index[name] = (_inventoryBatch.index[name] or 0) + 1 end
    else
        SAVE.unique(); if not _restoringInventory then updateIndex(name, 1) end
    end
end
local function removeUnique(name, pattern, backdrop, number)
    if not _uniques[name] then return false end
    for i = #_uniques[name], 1, -1 do
        local d = _uniques[name][i]
        if d.pattern == pattern and d.backdrop == backdrop and d.number == number then
            table.remove(_uniques[name], i)
            if #_uniques[name] == 0 then _uniques[name] = nil end
            if _inventoryBatch then
                _inventoryBatch.unique = true
                _inventoryBatch.index[name] = (_inventoryBatch.index[name] or 0) - 1
            else
                SAVE.unique(); updateIndex(name, -1)
            end
            return true
        end
    end
    return false
end
local function destroyNFT(inst)
    if typeof(inst) ~= "Instance" then return end
    if inst:GetAttribute("Unique") then removeUnique(inst.Name, inst:GetAttribute("Pattern"), inst:GetAttribute("Backdrop"), inst:GetAttribute("Number"))
    else removeNormal(inst.Name) end
    pcall(function() inst:Destroy() end)
end
local function syncFav(inst)
    if typeof(inst) ~= "Instance" then return end
    local name, isU, fav = inst.Name, inst:GetAttribute("Unique") == true, inst:GetAttribute("Favorite") == true
    if isU then
        local list = _uniques[name]
        if list then for _, d in ipairs(list) do
            if d.pattern == inst:GetAttribute("Pattern") and d.backdrop == inst:GetAttribute("Backdrop") and d.number == inst:GetAttribute("Number") then
                d.favorite = fav; SAVE.unique(); return
            end
        end end
    else if _nfts[name] then _nfts[name].favorite = fav; SAVE.normal() end end
end
local function hookFav(inst) if typeof(inst)=="Instance" then pcall(function() inst:GetAttributeChangedSignal("Favorite"):Connect(function() pcall(syncFav, inst) end) end) end end
local _spawnCounter = 0
task.spawn(function()
    task.wait(1)
    pcall(function()
        local inv = ensureInv()
        _restoringInventory = true
        for name, data in pairs(_nfts) do
            if type(data) ~= "table" then continue end
            local count = tonumber(data.count) or 0
            for i = 1, count do
                local v = Instance.new("StringValue"); v.Name = name; v.Value = ""
                v:SetAttribute("Date", os.date("%m/%d/%Y")); v:SetAttribute("Owner", LP.Name)
                _spawnCounter = _spawnCounter + 1; v:SetAttribute("SpawnId", _spawnCounter)
                if data.favorite then v:SetAttribute("Favorite", true) end
                v.Parent = inv; hookFav(v)
            end
        end
        for name, list in pairs(_uniques) do
            if type(list) ~= "table" then continue end
            for _, d in ipairs(list) do
                local v = Instance.new("StringValue"); v.Name = name; v.Value = ""
                v:SetAttribute("Date", d.date or os.date("%m/%d/%Y")); v:SetAttribute("Owner", d.owner or LP.Name)
                _spawnCounter = _spawnCounter + 1; v:SetAttribute("SpawnId", _spawnCounter)
                v:SetAttribute("Unique", true); v:SetAttribute("Pattern", d.pattern or "Star")
                v:SetAttribute("Backdrop", d.backdrop or "Black"); v:SetAttribute("Number", d.number or normNum())
                if d.favorite then v:SetAttribute("Favorite", true) end
                v.Parent = inv; hookFav(v)
            end
        end
        _restoringInventory = false
        local idxFolder = LP:FindFirstChild("_Index")
        if not idxFolder then idxFolder = Instance.new("Folder"); idxFolder.Name = "_Index"; idxFolder.Parent = LP end
        for name, val in pairs(_index) do
            local e = idxFolder:FindFirstChild(name)
            if not e then e = Instance.new("IntValue"); e.Name = name; e.Parent = idxFolder end
            if e:IsA("IntValue") then
                local realCount = math.max(0, math.floor(tonumber(e.Value) or 0))
                e.Value = realCount + math.max(0, math.floor(tonumber(val) or 0))
            end
        end
    end)
end)

local _bestRef = nil
local function findConfiguredBestDrop()
    local bestName, bestPrice = nil, -1
    for name, gift in pairs(Info.Gifts or {}) do
        if type(name) == "string" and type(gift) == "table" then
            local price = tonumber(gift.Price) or 0
            if price > bestPrice and price > 0 then bestName, bestPrice = name, price end
        end
    end
    return bestName, bestPrice
end
local function getBestRef()
    if _bestRef and _bestRef.Parent then return _bestRef end
    local v = LP:FindFirstChild("_BestDrop")
    local cfgName = findConfiguredBestDrop()
    if not v then
        local initial = _best.name
        if not initial or not rawget(Info.Gifts, initial) then initial = cfgName end
        if not initial then return nil end
        v = Instance.new("StringValue"); v.Name = "_BestDrop"; v.Value = initial; v.Parent = LP
    end
    if not v:IsA("StringValue") then return nil end
    if type(v.Value) ~= "string" or not rawget(Info.Gifts, v.Value) then
        local initial = (_best.name and rawget(Info.Gifts, _best.name)) and _best.name or cfgName
        if initial then pcall(function() v.Value = initial end) end
    end
    if _best.name and rawget(Info.Gifts, _best.name) and rawget(Info.Gifts, v.Value) then
        local savedPrice = tonumber(rawget(Info.Gifts, _best.name).Price) or 0
        local livePrice = tonumber(rawget(Info.Gifts, v.Value).Price) or 0
        if savedPrice > livePrice then pcall(function() v.Value = _best.name end) end
    end
    _bestRef = v
    return v
end
local function refreshBestDropAtStartup()
    local ref = getBestRef()
    if not ref then return end
    local cfgName, cfgPrice = findConfiguredBestDrop()
    local currentGift = rawget(Info.Gifts, ref.Value)
    local currentPrice = currentGift and (tonumber(currentGift.Price) or 0) or 0
    local savedGift = _best.name and rawget(Info.Gifts, _best.name) or nil
    local savedPrice = savedGift and (tonumber(savedGift.Price) or 0) or 0
    local baseline = math.max(currentPrice, savedPrice)
    local previousName = ref.Value
    if cfgName and cfgPrice > baseline then
        ref.Value = cfgName
        _best.old = previousName
        _best.name = cfgName
        SAVE.best()
    elseif currentPrice > savedPrice and ref.Value ~= _best.name then
        _best.old = _best.name
        _best.name = ref.Value
        SAVE.best()
    end
end
local function updateBest(giftName)
    if type(giftName) ~= "string" or not Info.Gifts[giftName] then return end
    local ref = getBestRef(); if not ref then return end
    local curPrice = (Info.Gifts[ref.Value] and tonumber(Info.Gifts[ref.Value].Price)) or 0
    local newPrice = tonumber(Info.Gifts[giftName].Price) or 0
    if newPrice > curPrice then
        local old = ref.Value
        pcall(function() ref.Value = giftName end)
        _best.name = giftName; _best.old = old; SAVE.best()
    end
end

-- Compare the current game-config maximum with the saved/current best as soon as the script starts.
task.defer(function()
    pcall(refreshBestDropAtStartup)
end)

local function broadcastDrop(dropType, giftName, userName, extra, delayParam)
    -- In the original game this toggle is named HideLiveDrop, but the LiveDrop
    -- LocalScript actually displays entries only while _G.HideDrop == true.
    if (_settings.GameSettings or {}).HideLiveDrop ~= true then return end
    if type(dropType) ~= "string" or type(giftName) ~= "string" then return end
    if not (Info.Gifts and Info.Gifts[giftName]) then return end
    _G.HideDrop = true
    local DropEv = Ev and Ev:FindFirstChild("Drop")
    if not DropEv or not getconnections then return end
    task.spawn(function()
        pcall(function()
            for _, conn in ipairs(getconnections(DropEv.OnClientEvent)) do
                if conn.Function then pcall(conn.Function, {{dropType, giftName, userName or LP.Name, extra}}, delayParam) end
            end
        end)
    end)
end

-- Send every result from a multi-open case as one native LiveDrop payload.
-- The game's LiveDrop LocalScript iterates every row in the first argument.
local function broadcastDropBatch(dropType, giftNames, userName, extra, delayParam)
    if (_settings.GameSettings or {}).HideLiveDrop ~= true then return end
    if type(dropType) ~= "string" or type(giftNames) ~= "table" then return end
    local rows = {}
    for _, giftName in ipairs(giftNames) do
        if type(giftName) == "string" and Info.Gifts and rawget(Info.Gifts, giftName) then
            rows[#rows + 1] = {dropType, giftName, userName or LP.Name, extra}
        end
    end
    if #rows == 0 then return end
    local DropEv = Ev and Ev:FindFirstChild("Drop")
    if not DropEv or not getconnections then return end
    _G.HideDrop = true
    task.spawn(function()
        pcall(function()
            for _, conn in ipairs(getconnections(DropEv.OnClientEvent)) do
                if conn.Function then pcall(conn.Function, rows, delayParam) end
            end
        end)
    end)
end

local function spawnNFT(name, opts)
    opts = opts or {}
    if type(name) ~= "string" or name == "" or not Info.Gifts[name] then return nil end
    local inv = ensureInv(); if not inv then return nil end
    _spawnCounter = _spawnCounter + 1
    local v = Instance.new("StringValue")
    v.Name = name; v.Value = ""; v:SetAttribute("Date", os.date("%m/%d/%Y"))
    v:SetAttribute("Owner", LP.Name); v:SetAttribute("SpawnId", _spawnCounter)
    if opts.isUnique then
        v:SetAttribute("Unique", true)
        v:SetAttribute("Pattern", (type(opts.pattern)=="string" and opts.pattern) or pickPattern())
        v:SetAttribute("Backdrop", (type(opts.backdrop)=="string" and opts.backdrop) or pickBackdrop())
        v:SetAttribute("Number", normNum(opts.number))
    end
    if opts.favorite then v:SetAttribute("Favorite", true) end
    if not pcall(function() v.Parent = inv end) then pcall(function() v:Destroy() end); return nil end
    hookFav(v)
    if opts.isUnique then pcall(addUnique, name, {pattern=v:GetAttribute("Pattern"), backdrop=v:GetAttribute("Backdrop"), number=v:GetAttribute("Number"), favorite=opts.favorite or false})
    else pcall(addNormal, name, opts.favorite or false) end
    if opts.dropType and not opts.silentEffects then
        pcall(broadcastDrop, opts.dropType, name, LP.Name, opts.dropExtra, opts.dropDelay)
        pcall(updateBest, name)
    end
    return v
end

local _passState = nil
local function passClaimedRef()
    local nft = LP:FindFirstChild("_NFTPass"); if not nft then return nil end
    local c = nft:FindFirstChild("Claimed"); if not c then c = Instance.new("Folder"); c.Name="Claimed"; c.Parent=nft end
    return c
end
local function passKey(lvl, isPlus)
    local N = #(NFTPassCfg.Rewards and NFTPassCfg.Rewards.Free or {})
    return isPlus and (lvl + N) or lvl
end
local function isClaimed(lvl, isPlus) local c = passClaimedRef(); return c and c:GetAttribute(passKey(lvl, isPlus)) == true end
local function markClaimed(lvl, isPlus) local c = passClaimedRef(); if c and lvl then c:SetAttribute(passKey(lvl, isPlus), true) end end
local function weightedPick(weights)
    if type(weights) ~= "table" then return nil end
    local total, names = 0, {}
    for name, w in pairs(weights) do w = tonumber(w) or 0; if w > 0 then table.insert(names, name); total = total + w end end
    if total <= 0 then return nil end
    local r = math.random() * total; local acc = 0
    for _, name in ipairs(names) do acc = acc + (tonumber(weights[name]) or 0); if r <= acc then return name end end
    return names[#names]
end
local function giveReward(rw)
    if not rw or not rw[1] then return end
    local tp, amt = rw[1], rw[2]
    if tp == "NFT" then local chosen = weightedPick(amt); if chosen then spawnNFT(chosen, {isUnique=false}) end
    else
        local n = tonumber(amt) or 0
        if n <= 0 then return end
        if tp == "x2Luck" then forceAddBuff("_LuckyPotion", n)
        elseif tp == "x4Luck" then forceAddBuff("_LuckyPotion2", n)
        elseif tp == "x6Luck" then forceAddBuff("_LuckyPotion3", n)
        elseif tp == "Blessing" then forceAddBuff("_Blessing", n)
        elseif tp == "Stars" then addBal("_StarsValue", n)
        elseif tp == "Gems" then addBal("_GemsValue", n)
        elseif tp == "Tons" then addBal("_TONValue", n) end
    end
end

local function rollDrop(cfg)
    if not cfg or type(cfg.Drop) ~= "table" or #cfg.Drop == 0 then return nil end

    -- Keep the original math.random() flow. Luck changes only the local
    -- weighted selection used by this script; it cannot change server rolls.
    local luck = math.max(1, getLuck())
    local blessingBoost = hasBlessing() and 1.35 or 1
    local luckPower = math.max(0, luck - 1)
    local weighted, total = {}, 0

    for _, d in ipairs(cfg.Drop) do
        if type(d) == "table" and type(d[1]) == "string" and Info.Gifts[d[1]] then
            local w = safeNumber(d[2], 0, 0, 1e12)
            if w > 0 then
                local gift = Info.Gifts[d[1]]
                local price = safeNumber(gift and gift.Price, 0, 0, MAX_LOCAL_VALUE)
                -- More expensive/rarer gifts receive a stronger luck bonus.
                -- The smooth logarithmic curve avoids extreme jumps from price data.
                local rarity = math.clamp(math.log10(price + 1) / 6, 0, 1)
                local luckMultiplier = 1 + luckPower * (0.15 + rarity * 1.85)
                w = w * luckMultiplier * blessingBoost
                table.insert(weighted, {d[1], w})
                total = total + w
            end
        end
    end

    if total <= 0 then return nil end
    local r, acc = math.random() * total, 0
    for _, d in ipairs(weighted) do
        acc = acc + d[2]
        if r <= acc then return d[1] end
    end
    return weighted[#weighted][1]
end

local CHARS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
local function genParcel() local c = ""; for i = 1, 10 do local idx = math.random(1, #CHARS); c = c .. CHARS:sub(idx, idx) end; return c end
local function genUniqueParcel() local c = genParcel(); local n = 0; while _mail[c] and n < 30 do c = genParcel(); n = n + 1 end; return c end
local function updateMailPending()
    local count = 0
    for _, m in pairs(_mail) do
        if type(m) == "table" and (m.to == LP.UserId or m.toName == LP.Name) and not m.claimed and not m.declined and m.historyOnly ~= true then count = count + 1 end
    end
    pcall(function() LP:SetAttribute("MailPending", count) end)
    return count
end
updateMailPending()

local ON = {AdminPanel=true, OpenCase=true, Upgrade=true, Fuse=true, NFTPass=true, Halloween=true, Rebirth=true, Quests=true, Reroll=true, Craft=true, DailyRewards=true, Inventory=true, Favorite=true, TON=true, UpgradeInventory=true, ShopItems=true, Code=true, Settings=true, CustomCases=true, Mail=true}
local H = {}
local _buildCustomCaseConfig

-- The original game profile reads these exact Player ValueBases.
-- Keep a session-local delta because this script emulates the remote locally;
-- the server cannot persist a client-only counter update.
local _profileStatBase = {}
local _profileStatDelta = { _CasesOpened = 0, _UpgradesMade = 0 }
local function readGameStat(statName)
    local base = _profileStatBase[statName]
    if base == nil then
        local stat = LP:FindFirstChild(statName)
        if stat and stat:IsA("ValueBase") then
            base = math.max(0, math.floor(tonumber(stat.Value) or 0))
        else
            local attrName = statName == "_CasesOpened" and "CasesOpened" or "UpgradesMade"
            base = math.max(0, math.floor(tonumber(LP:GetAttribute(attrName)) or 0))
        end
        _profileStatBase[statName] = base
    end
    return math.max(0, base + (_profileStatDelta[statName] or 0))
end

local function addGameStat(statName, amount)
    amount = math.max(0, math.floor(tonumber(amount) or 0))
    if amount == 0 then return readGameStat(statName) end
    -- Seed from the real replicated stat before applying our local action delta.
    local current = readGameStat(statName)
    _profileStatDelta[statName] = (_profileStatDelta[statName] or 0) + amount
    local nextValue = current + amount
    local stat = LP:FindFirstChild(statName)
    if stat and stat:IsA("ValueBase") then pcall(function() stat.Value = nextValue end) end
    local attrName = statName == "_CasesOpened" and "CasesOpened" or "UpgradesMade"
    pcall(function() LP:SetAttribute(attrName, nextValue) end)
    return nextValue
end

local function syncGameStatAttributes()
    local cases = readGameStat("_CasesOpened")
    local upgrades = readGameStat("_UpgradesMade")
    pcall(function() LP:SetAttribute("CasesOpened", cases) end)
    pcall(function() LP:SetAttribute("UpgradesMade", upgrades) end)
    local casesValue = LP:FindFirstChild("_CasesOpened")
    local upgradesValue = LP:FindFirstChild("_UpgradesMade")
    if casesValue and casesValue:IsA("ValueBase") then pcall(function() casesValue.Value = cases end) end
    if upgradesValue and upgradesValue:IsA("ValueBase") then pcall(function() upgradesValue.Value = upgrades end) end
end

local function bumpQuestPrefix(prefix, amount)
    amount = math.max(0, math.floor(tonumber(amount) or 0))
    if amount == 0 then return end
    local Q = LP:FindFirstChild("_Quests")
    local cfg = tryReq("QuestsConfigs")
    local defs = cfg and cfg.Quests or {}
    if Q then
        for _, q in ipairs(Q:GetChildren()) do
            if q:IsA("IntValue") and q.Name:sub(1,#prefix) == prefix then
                local duration = q:GetAttribute("Duration") == "Weekly" and "Weekly" or "Daily"
                local def = defs[duration] and defs[duration][q.Name]
                local goal = def and tonumber(def.Goal) or math.huge
                q.Value = math.min(goal, math.max(0,q.Value) + amount)
            end
        end
    end
end
local function bumpHalloweenTrack(track, amount)
    local HQ = LP:FindFirstChild("_HalloweenQuests")
    if not HQ then return end
    local cfg = tryReq("HalloweenQuestsConfigs")
    local defs = cfg and cfg.Quests or {}
    for _, q in ipairs(HQ:GetChildren()) do
        if q:IsA("IntValue") then
            local def
            for _, group in pairs(defs) do if type(group)=="table" and group[q.Name] then def=group[q.Name]; break end end
            if def and def.Track == track then q.Value = math.min(tonumber(def.Goal) or math.huge, q.Value + math.max(0, math.floor(tonumber(amount) or 0))) end
        end
    end
end
local _caseBusy = false
local function processOpenCase(caseName, count, suppliedCfg)
    if not ON.OpenCase then return nil end
    if type(caseName) ~= "string" or not ensureInv() then return false, "Invalid" end
    count = math.max(1, math.min(10, math.floor(tonumber(count) or 1)))
    local cfg = Info.Cases and Info.Cases[caseName]
    local isLocalCustom = false
    if not cfg and _buildCustomCaseConfig then
        local ok, customCfg = pcall(_buildCustomCaseConfig, caseName)
        if ok and type(customCfg) == "table" then cfg = customCfg; isLocalCustom = true end
    end
    if not cfg and type(suppliedCfg) == "table" and type(suppliedCfg.Drop) == "table" then
        cfg = suppliedCfg
        isLocalCustom = true
    end
    if not cfg then return false, "Unknown case" end
    if type(cfg.Drop) ~= "table" or #cfg.Drop == 0 then return false, "Case has no drop table" end
    local hasValidDrop = false
    for _, drop in ipairs(cfg.Drop) do
        if type(drop) == "table" and type(drop[1]) == "string" and Info.Gifts[drop[1]] and safeNumber(drop[2], 0, 0, 1e12) > 0 then hasValidDrop = true; break end
    end
    if not hasValidDrop then return false, "Case drop table is invalid" end

    local costKey, totalCost = nil, 0
    if not cfg.Paid then
        costKey = "_StarsValue"
        if cfg.TON then costKey = "_TONValue" elseif cfg.GEMS then costKey = "_GemsValue"
        elseif cfg.CANDY then costKey = "_Candy" elseif cfg.PUMPKIN then costKey = "_Pumpkins" end
        local base = safeNumber(cfg.Price, 0, 0, MAX_LOCAL_VALUE)
        totalCost = math.floor(base * count - (count - 1) * 0.2 * base)
        if totalCost > 0 and getBal(costKey) < totalCost then return false, "Not enough" end
    end

    local drops, bestDrop, bestPrice = {}, nil, -1
    local batch, previousBatch = beginInventoryBatch()
    local okOpen, openErr = pcall(function()
        for _ = 1, count do
            local dropName = rollDrop(cfg)
            if dropName then
                -- The game's case result animation uses the returned drop list and cfg.
                -- Per-drop live-feed callbacks are unnecessary here and can stall mobile clients.
                local created = spawnNFT(dropName, {dropType="Case", dropExtra=caseName, silentEffects=true})
                if created then
                    table.insert(drops, dropName)
                    local price = tonumber(Info.Gifts[dropName] and Info.Gifts[dropName].Price) or 0
                    if price > bestPrice then bestPrice = price; bestDrop = dropName end
                end
            end
        end
    end)
    finishInventoryBatch(batch, previousBatch)
    if not okOpen then return false, "Case generation failed" end
    if #drops == 0 then return false, "No valid drops" end

    -- Charge only after successful local creation, avoiding lost currency on an error.
    if costKey and totalCost > 0 then addBal(costKey, -totalCost) end
    if bestDrop then pcall(updateBest, bestDrop) end
    -- Include every NFT in the case result, not only the most expensive one.
    -- The original LiveDrop client accepts a list of rows and displays each row.
    pcall(broadcastDropBatch, "Case", drops, LP.Name, caseName, nil)
    addGameStat("_CasesOpened", #drops)
    bumpQuestPrefix("CS", #drops); bumpHalloweenTrack("CursedCase", #drops)
    if isLocalCustom then pushLog("LOCAL CUSTOM CASE OPENED: "..caseName.." x"..#drops) end
    return true, drops, cfg
end
H.OpenCase = function(caseName, count, suppliedCfg)
    if _caseBusy then return false, "Case is already processing" end
    _caseBusy = true
    local packed = table.pack(pcall(processOpenCase, caseName, count, suppliedCfg))
    _caseBusy = false
    if not packed[1] then return false, "Case processing failed" end
    return table.unpack(packed, 2, packed.n)
end

H.Upgrade = function(item1, item2, useLuck)
    if not ON.Upgrade then return nil end
    if typeof(item1) ~= "Instance" or not isInvChild(item1) then return false, "Invalid source" end
    if item1:GetAttribute("Locked") then return false, "Source is locked" end
    local item2Name = typeof(item2) == "Instance" and item2.Name or (type(item2) == "string" and item2 or nil)
    if not item2Name then return false, "Invalid target" end
    local g1 = Info.Gifts[item1.Name]; local g2 = Info.Gifts[item2Name]
    if not g1 or not g2 then return false, "Unknown gift" end
    local p1 = tonumber(g1.Price) or 0; local p2 = tonumber(g2.Price) or 0
    if p1 <= 0 or p2 <= 0 then return false, "Invalid price" end
    if item1.Name == item2Name then return false, "Cannot upgrade into itself" end
    if p1 >= p2 then return false, "Cannot upgrade into cheaper or equal" end
    if (g1.Limited ~= g2.Limited) or (g1.Winter ~= g2.Winter) or (g1.Summer ~= g2.Summer) or (g1.Halloween ~= g2.Halloween) or (g1.Autumn ~= g2.Autumn) then
        return false, "Category mismatch"
    end
    if UpgradeCfg and type(UpgradeCfg.CanTarget) == "function" then
        local ok, canTarget = pcall(UpgradeCfg.CanTarget, g2)
        if ok and canTarget == false then return false, "This gift can't be a target" end
    end
    if LimitedCfg and type(LimitedCfg.Items) == "table" then
        local srcLim = LimitedCfg.Items[item1.Name] ~= nil
        local tgtLim = LimitedCfg.Items[item2Name] ~= nil
        if tgtLim and not srcLim then return false, "Cannot upgrade into a limited gift" end
    end
    local minRatio = (UpgradeCfg and tonumber(UpgradeCfg.MIN_RATIO)) or 0.75
    if type(minRatio) == "number" and minRatio > 0 and minRatio <= 1 then
        if p1 > p2 * minRatio then return false, "Price ratio too high" end
    end
    local luck = getLuck()
    local chance = nil
    if UpgradeCfg and type(UpgradeCfg.RealChance) == "function" then
        local ok, res = pcall(UpgradeCfg.RealChance, g1, g2, luck)
        if ok and type(res) == "number" then chance = res end
    end
    if not chance then
        chance = math.floor(p1 / p2 * 100 * 10) / 10
        if chance > 75 then chance = 75 end
        if p2 > 2000000 then chance = math.floor(chance / 1.1 * 10) / 10 end
    end
    if chance <= 0 then return false, "Upgrade chance is 0%" end
    local blessed = hasBlessing()
    local saveChance = blessed and 0.5 or 0.15
    local won = (math.random() * 100) <= chance
    local saved = (not won) and (math.random() < saveChance)
    if won then
        local created = spawnNFT(item2Name, {dropType="Upgrade"})
        if not created then return false, "Reward creation failed; item kept" end
        destroyNFT(item1)
        addGameStat("_UpgradesMade", 1)
        bumpQuestPrefix("UP", 1); bumpHalloweenTrack("HalloweenUpgrade", 1); return true, true, false
    elseif saved then
        addGameStat("_UpgradesMade", 1)
        bumpQuestPrefix("LS", 1)
        if blessed then pushLog("Blessing saved "..item1.Name) end
        return true, false, true
    else
        destroyNFT(item1)
        addGameStat("_UpgradesMade", 1)
        bumpQuestPrefix("LS", 1)
        return true, false, false
    end
end

H.Fuse = function(action, items, _)
    if not ON.Fuse or action ~= "Fuse" then return nil end
    if type(items) ~= "table" or #items ~= 5 then return false, "Need exactly 5 items" end
    local baseName, seen, names = nil, {}, {}
    for _, it in ipairs(items) do
        if typeof(it) ~= "Instance" or not isInvChild(it) then return false, "Item not in inventory" end
        if seen[it] then return false, "Duplicate item" end
        seen[it] = true
        if not Info.Gifts[it.Name] then return false, "Unknown NFT" end
        local base = string.split(it.Name, " (")[1]
        if not baseName then baseName = base elseif base ~= baseName then return false, "All 5 must match" end
        table.insert(names, it.Name)
    end
    local chosen = names[math.random(1, #names)]
    local pattern, backdrop = pickPattern(), pickBackdrop()
    local number = normNum(math.random(1, 999999))
    local created = spawnNFT(chosen, {isUnique=true, pattern=pattern, backdrop=backdrop, number=number, dropType="Fuse", dropExtra={backdrop, pattern}})
    if not created then return false, "Could not create fused NFT" end
    for _, it in ipairs(items) do destroyNFT(it) end
    bumpQuestPrefix("FS", 1); bumpHalloweenTrack("HalloweenFuse", 1)
    return true, {chosen, LP.Name, backdrop, pattern, os.date("%m/%d/%Y"), number, names}
end

H.Craft = function(data)
    if not ON.Craft or type(data) ~= "table" then return nil end
    if type(data.Items) ~= "table" or #data.Items < 1 or #data.Items > 50 then return false, "Invalid item list" end
    if type(data.Group) ~= "string" or data.Group == "" then return false, "Invalid group" end
    local seen, totalPrice = {}, 0
    for _, it in ipairs(data.Items) do
        if typeof(it) ~= "Instance" or not isInvChild(it) then return false, "Item not in inventory" end
        if seen[it] then return false, "Duplicate item" end
        seen[it] = true
        local gift = Info.Gifts[it.Name]
        if not gift then return false, "Unknown NFT" end
        totalPrice = totalPrice + math.max(0, safeNumber(gift.Price, 0, 0, MAX_LOCAL_VALUE))
    end
    local chance = 25
    if type(CraftCfg.Chance) == "function" then
        local ok, result = pcall(CraftCfg.Chance, data.Group, totalPrice)
        if ok then chance = safeNumber(result, 25, 0, 100) end
    end
    chance = math.clamp(chance, 0, 100)
    local drops = {}
    if type(CraftCfg.Drops) == "function" then
        local ok, result = pcall(CraftCfg.Drops, data.Group)
        if ok and type(result) == "table" then drops = result end
    end
    local rewardPools, totalWeight = {}, 0
    for _, rarity in ipairs(type(CraftCfg.Rarities) == "table" and CraftCfg.Rarities or {}) do
        if type(rarity) == "table" then
            local weight = safeNumber(rarity.Chance, 0, 0, 1e9)
            local pool = drops[rarity.Id]
            if weight > 0 and type(pool) == "table" and #pool > 0 then
                local valid = {}
                for _, gn in ipairs(pool) do if type(gn) == "string" and Info.Gifts[gn] then table.insert(valid, gn) end end
                if #valid > 0 then table.insert(rewardPools, {id=rarity.Id, weight=weight, gifts=valid}); totalWeight = totalWeight + weight end
            end
        end
    end
    if totalWeight <= 0 then return false, "No valid craft rewards" end
    local chosen, chosenRarity
    if math.random() * 100 <= chance then
        local roll, acc = math.random() * totalWeight, 0
        for _, pool in ipairs(rewardPools) do
            acc = acc + pool.weight
            if roll <= acc then chosenRarity = pool.id; chosen = pool.gifts[math.random(1, #pool.gifts)]; break end
        end
    end
    if chosen and not spawnNFT(chosen, {dropType="Case", dropExtra="Craft"}) then return false, "Reward creation failed" end
    for _, it in ipairs(data.Items) do destroyNFT(it) end
    if chosen then return true, {"Success", chosen, chosenRarity} end
    return false, "Craft failed"
end

H.NFTPass = function(action, idx, isPlus)
    if not ON.NFTPass or not LP:FindFirstChild("_NFTPass") then return nil end
    if action == "ClaimGift" then
        if not _passState then return false, "No active" end
        _passState = nil; return true, "Claimed"
    elseif action == "Claim" then
        local lvl = tonumber(idx); if not lvl then return false, "Invalid" end
        local rewards = (isPlus and NFTPassCfg.Rewards and NFTPassCfg.Rewards.Plus) or (NFTPassCfg.Rewards and NFTPassCfg.Rewards.Free) or {}
        if lvl < 1 or lvl > #rewards then return false, "Invalid lvl" end
        if isPlus then
            local pp = LP:FindFirstChild("_PlusPass")
            if not pp or pp.Value ~= (NFTPassCfg.Season or 0) then if pp and NFTPassCfg.Season then pp.Value = NFTPassCfg.Season end end
        end
        if isClaimed(lvl, isPlus) then return false, "Already claimed" end
        local rw = rewards[lvl]
        if rw[1] == "NFT" then
            local chosen = weightedPick(rw[2]); if not chosen then return false, "Empty" end
            local spawned = spawnNFT(chosen, {isUnique=false}); if not spawned then return false, "Spawn failed" end
            markClaimed(lvl, isPlus)
            _passState = {gift=chosen, isPlus=isPlus, level=lvl, spawned=spawned, rerollCount=0}
            return true, rw, chosen
        else giveReward(rw); markClaimed(lvl, isPlus); return true, rw[2], rw[2] end
    elseif action == "RerollGift" then
        if not _passState then return false, "No active" end
        if _passState.rerollCount >= 10 then return false, "Limit 10" end
        if getBal("_PassRerolls") < 1 then return false, "No rerolls" end
        local rewards = (_passState.isPlus and NFTPassCfg.Rewards and NFTPassCfg.Rewards.Plus) or (NFTPassCfg.Rewards and NFTPassCfg.Rewards.Free) or {}
        local rw = rewards[_passState.level]
        if not rw or rw[1] ~= "NFT" then return false, "Not NFT" end
        local chosen = weightedPick(rw[2]); if not chosen then return false, "Empty" end
        addBal("_PassRerolls", -1)
        if _passState.spawned and _passState.spawned.Parent then destroyNFT(_passState.spawned) end
        local spawned = spawnNFT(chosen, {isUnique=false})
        _passState.gift = chosen; _passState.spawned = spawned; _passState.rerollCount = _passState.rerollCount + 1
        return true, rw, chosen, _passState.rerollCount
    end
    return nil
end

H.Halloween = function(action, arg1, arg2)
    if not ON.Halloween then return false, "Halloween hook disabled" end

    if action == "Claim" then
        local earned = LP:FindFirstChild("_CandyEarned")
        local candy = math.floor(safeNumber(earned and earned.Value, 0, 0, MAX_LOCAL_VALUE))
        if candy <= 0 then return false, "Nothing to claim" end

        local x4 = LP:FindFirstChild("_HalloweenX4Candy")
        local x2 = LP:FindFirstChild("_HalloweenX2Candy")
        local multiplier = (x4 and x4.Value == 1) and 4 or ((x2 and x2.Value == 1) and 2 or 1)
        local reward = math.floor(candy * multiplier)
        addBal("_Candy", reward)
        if earned then earned.Value = 0 end
        pushLog("HALLOWEEN CLAIM +"..tostring(reward).." Candy")
        return true, reward

    elseif action == "Spin" then
        local spinCfg = HalloweenCfg and HalloweenCfg.Spin or {}
        local prizes = spinCfg.Prizes
        if type(prizes) ~= "table" or #prizes == 0 then return false, "No Halloween prizes configured" end

        local validPrizes, totalWeight = {}, 0
        for index, prize in ipairs(prizes) do
            if type(prize) == "table" then
                local weight = safeNumber(prize.Chance, 0, 0, 1e9)
                local validGift = type(prize.Gift) == "string" and Info.Gifts and Info.Gifts[prize.Gift] ~= nil
                local candy = math.floor(safeNumber(prize.Candy, 0, 0, MAX_LOCAL_VALUE))
                if weight > 0 and (validGift or candy > 0) then
                    table.insert(validPrizes, {index=index, data=prize, weight=weight})
                    totalWeight = totalWeight + weight
                end
            end
        end
        if #validPrizes == 0 or totalWeight <= 0 then return false, "No valid Halloween rewards" end

        local timerObj = getOrCreate(LP, "_HalloweenTimer", "IntValue", 0)
        local spinsObj = getOrCreate(LP, "_HalloweenSpins", "IntValue", 0)
        local now = os.time()
        local freeEvery = math.floor(safeNumber(spinCfg.FreeEvery, 10800, 60, 604800))
        local lastFree = math.floor(safeNumber(timerObj.Value, 0, 0, now))
        local isFree = lastFree <= 0 or (now - lastFree) >= freeEvery
        local spins = math.floor(safeNumber(spinsObj.Value, 0, 0, 1e9))
        if not isFree and spins < 1 then return false, "No Halloween spins available" end

        local roll, accumulated, selected = math.random() * totalWeight, 0, nil
        for _, entry in ipairs(validPrizes) do
            accumulated = accumulated + entry.weight
            if roll <= accumulated then selected = entry; break end
        end
        selected = selected or validPrizes[#validPrizes]
        local prize = selected.data

        -- Apply the reward before consuming the spin, so a failed local spawn never eats it.
        if prize.Gift then
            local spawned = spawnNFT(prize.Gift, {isUnique=true, dropType="Case", dropExtra="Halloween"})
            if not spawned then return false, "Halloween NFT reward could not be created" end
        else
            local candy = math.floor(safeNumber(prize.Candy, 0, 0, MAX_LOCAL_VALUE))
            if candy <= 0 then return false, "Invalid Halloween candy reward" end
            addBal("_Candy", candy)
        end

        if isFree then timerObj.Value = now else spinsObj.Value = spins - 1 end
        pushLog("HALLOWEEN SPIN -> prize "..tostring(selected.index))
        -- The game UI expects the prize INDEX, not the whole prize table.
        return true, selected.index

    elseif action == "Brew" then
        local slot = math.floor(safeNumber(arg1, 1, 1, 100))
        local recipeId = cleanText(arg2, 80)
        if recipeId == "" then return false, "Invalid recipe" end

        local recipes = HalloweenCfg and HalloweenCfg.Cauldron and HalloweenCfg.Cauldron.Recipes or {}
        local recipe
        for _, item in ipairs(recipes) do
            if type(item) == "table" and tostring(item.Id) == recipeId then recipe = item; break end
        end
        if not recipe then return false, "Recipe not found" end

        local slots = LP:FindFirstChild("_CauldronSlots")
        local maxSlots = math.floor(safeNumber(slots and slots.Value, 2, 1, 20))
        if slot > maxSlots then return false, "Slot locked" end

        local cauldron = LP:FindFirstChild("_Cauldron")
        if not cauldron then cauldron = Instance.new("Folder"); cauldron.Name = "_Cauldron"; cauldron.Parent = LP end
        local slotObj = cauldron:FindFirstChild(tostring(slot))
        if not slotObj then slotObj = Instance.new("Folder"); slotObj.Name = tostring(slot); slotObj.Parent = cauldron end
        if slotObj:GetAttribute("Recipe") then return false, "Slot busy" end

        local cost = math.floor(safeNumber(recipe.Cost, 0, 0, MAX_LOCAL_VALUE))
        if getBal("_Candy") < cost then return false, "Not enough Candy" end
        if cost > 0 then addBal("_Candy", -cost) end

        -- Match the reference script: the local cauldron completes instantly.
        local now = os.time()
        slotObj:SetAttribute("Recipe", recipeId)
        slotObj:SetAttribute("StartedAt", now)
        slotObj:SetAttribute("EndsAt", now)
        pushLog("HALLOWEEN BREW slot "..slot.." -> "..recipeId)
        return true, "Brewing"

    elseif action == "SelectSkip" then
        return true, "Skipped"

    elseif action == "Collect" then
        local slot = math.floor(safeNumber(arg1, 1, 1, 100))
        local cauldron = LP:FindFirstChild("_Cauldron")
        local slotObj = cauldron and cauldron:FindFirstChild(tostring(slot))
        if not slotObj then return false, "No cauldron slot" end

        local recipeId = slotObj:GetAttribute("Recipe")
        if type(recipeId) ~= "string" or recipeId == "" then return false, "Empty slot" end
        local endsAt = math.floor(safeNumber(slotObj:GetAttribute("EndsAt"), 0, 0, MAX_LOCAL_VALUE))
        if os.time() < endsAt then return false, "Still brewing" end

        local recipes = HalloweenCfg and HalloweenCfg.Cauldron and HalloweenCfg.Cauldron.Recipes or {}
        local recipe
        for _, item in ipairs(recipes) do
            if type(item) == "table" and tostring(item.Id) == recipeId then recipe = item; break end
        end
        if not recipe then
            slotObj:SetAttribute("Recipe", nil); slotObj:SetAttribute("StartedAt", nil); slotObj:SetAttribute("EndsAt", nil)
            return false, "Recipe no longer exists"
        end

        local reward = recipe.Rewards and recipe.Rewards[1]
        if type(reward) ~= "table" or type(reward.Potion) ~= "string" then return false, "Invalid potion reward" end
        local potionName = reward.Potion:gsub("^_", "")
        local knownPotion = false
        for _, pair in ipairs(LUCK_PAIRS) do if pair.player == "_"..potionName then knownPotion = true; break end end
        if not knownPotion then return false, "Unknown potion: "..potionName end

        local seconds = math.floor(safeNumber(reward.Seconds, 600, 1, 604800))
        forceAddBuff("_"..potionName, seconds)
        slotObj:SetAttribute("Recipe", nil); slotObj:SetAttribute("StartedAt", nil); slotObj:SetAttribute("EndsAt", nil)
        pushLog("HALLOWEEN COLLECT -> "..potionName)
        return true, potionName
    end

    -- Never let an unsupported Halloween action fall through to a real server call.
    return false, "Unsupported local Halloween action"
end

H.Rebirth = function(action)
    if not ON.Rebirth then return nil end
    if action == "Rebirth" then
        local rb = LP:FindFirstChild("_Rebirths")
        if not rb then rb = Instance.new("IntValue"); rb.Name="_Rebirths"; rb.Value=0; rb.Parent=LP end
        rb.Value = rb.Value + 1; return true, rb.Value
    elseif action == "Spin" then
        if getBal("_Vouchers") < 1 then return false, "No vouchers" end
        local st = math.floor(WS:GetServerTimeNow())
        local rot = (ExclusiveCfg.CurrentRotation and ExclusiveCfg.CurrentRotation(st)) or (st // 28800)
        local wheel = (ExclusiveCfg.Wheel and ExclusiveCfg.Wheel(rot)) or {}
        if type(wheel) ~= "table" or #wheel == 0 then return false, "Empty" end
        local total = 0
        for _, s in ipairs(wheel) do total = total + (tonumber(s.Chance) or 0) end
        if total <= 0 then return false, "No chances" end
        addBal("_Vouchers", -1)
        local r = math.random() * total; local acc = 0; local idx = 1
        for i, s in ipairs(wheel) do acc = acc + (tonumber(s.Chance) or 0); if r <= acc then idx = i; break end end
        local chosen = wheel[idx]
        if chosen.Loss then return true, chosen.Gift, idx, rot, {Loss=true, Gift=chosen.Gift} end
        local bd = pickBackdrop(); local pat = pickPattern(); local numV = normNum(math.random(1,999999))
        spawnNFT(chosen.Gift, {isUnique=true, backdrop=bd, pattern=pat, number=numV, dropType="Case", dropExtra="Rebirth"})
        return true, chosen.Gift, idx, rot, {Loss=false, Backdrop=bd, Pattern=pat, Number=numV}
    end
end

H.Reroll = function(inst)
    if not ON.Reroll or typeof(inst) ~= "Instance" or not isInvChild(inst) then return nil end
    local g = Info.Gifts[inst.Name]; if not g then return false, "Unknown" end
    local cost = math.max(1, math.floor(math.round(g.Price / 250) * 0.1))
    if getBal("_TONValue") < cost then return false, "Not enough TON" end
    addBal("_TONValue", -cost)
    local bd = pickBackdrop(); local pat = pickPattern()
    inst:SetAttribute("Backdrop", bd); inst:SetAttribute("Pattern", pat)
    return true, bd, pat
end

H.TON = function(action, target)
    if not ON.TON or action ~= "Sell" then return nil end
    if typeof(target) ~= "Instance" or not isInvChild(target) then return false, "Invalid" end
    if not target:GetAttribute("Unique") then return false, "Only unique" end
    local g = Info.Gifts[target.Name]; if not g then return false, "Unknown" end
    local base = math.round((tonumber(g.Price) or 0) / 250)
    if base <= 0 then return false, "No value" end
    local final = (target:GetAttribute("Backdrop") == "Black") and (base * 2) or base
    addBal("_TONValue", final); destroyNFT(target)
    return true, final
end

H.Inventory = function(action, target, extra)
    if not ON.Inventory then return nil end
    if action == "Sell" then
        local function sellOne(item)
            if typeof(item) ~= "Instance" or not isInvChild(item) then return 0 end
            -- Favorites are still sellable in the game's own Sell/Sell All UI;
            -- do not silently omit their price from the fake sale total.
            if ExclusiveCfg and type(ExclusiveCfg.IsBound) == "function" then
                local okBound, isBound = pcall(ExclusiveCfg.IsBound, item)
                if okBound and isBound then return 0 end
            end
            local gift = Info.Gifts and Info.Gifts[item.Name]
            local price = gift and tonumber(gift.Price) or 0
            if price <= 0 then return 0 end
            local ok = pcall(destroyNFT, item)
            if ok and item.Parent ~= _Inv then return price end
            return 0
        end
        if typeof(target) == "Instance" then
            local earned = sellOne(target)
            if earned > 0 then addBal("_StarsValue", earned); return true, earned end
            return false, "Item cannot be sold"
        elseif target == "ALL" then
            local isUnq = extra == true
            local total, sold = 0, 0
            local batch, previousBatch = beginInventoryBatch()
            -- Snapshot first: destroyNFT mutates the inventory while the sale is processed.
            for _, item in ipairs(_Inv:GetChildren()) do
                if (item:GetAttribute("Unique") == true) == isUnq then
                    local earned = sellOne(item)
                    if earned > 0 then
                        total = math.min(MAX_LOCAL_VALUE, total + earned)
                        sold = sold + 1
                    end
                end
            end
            finishInventoryBatch(batch, previousBatch)
            if total > 0 then addBal("_StarsValue", total) end
            return true, {amount=total, count=sold}
        end
        return false, "Invalid sale target"
    elseif action == "Favorite" then
        if typeof(target) == "Instance" then target:SetAttribute("Favorite", not (target:GetAttribute("Favorite") == true)) end
        return true
    end
end

H.Favorite = function(inst, isFav)
    if not ON.Favorite or typeof(inst) ~= "Instance" then return nil end
    inst:SetAttribute("Favorite", isFav and true or false); return true
end

H.UpgradeInventory = function()
    if not ON.UpgradeInventory then return nil end
    local slots = LP:FindFirstChild("_InventorySlots")
    if not slots then slots = Instance.new("IntValue"); slots.Name = "_InventorySlots"; slots.Value = 100; slots.Parent = LP end
    slots.Value = slots.Value + 100; return true, "Slots: "..slots.Value
end

H.ShopItems = function(action, arg)
    if not ON.ShopItems then return nil end
    if action == "Mode" then LP:SetAttribute("ShopToInventory", not (LP:GetAttribute("ShopToInventory") == true)); return true
    elseif action == "Use" then
        if typeof(arg) ~= "Instance" then return false, "Invalid" end
        local name = arg.Name; local secs = 300
        if name:find("x2") then forceAddBuff("_LuckyPotion", secs)
        elseif name:find("x4") then forceAddBuff("_LuckyPotion2", secs)
        elseif name:find("x6") then forceAddBuff("_LuckyPotion3", secs)
        elseif name:find("Blessing") then forceAddBuff("_Blessing", secs) end
        destroyNFT(arg); return true, name
    end
end

H.Code = function(code)
    if not ON.Code or type(code) ~= "string" then return nil end
    code = cleanText(code, 48):upper()
    if code == "" then return nil end
    local p = _promo[code] or _promo[code:lower()]
    if type(p) ~= "table" then return nil end
    _settings.redeemedPromos = type(_settings.redeemedPromos) == "table" and _settings.redeemedPromos or {}
    if _settings.redeemedPromos[code] then return false, "Already redeemed" end
    local values = {
        stars=safeNumber(p.stars, 0, 0, MAX_LOCAL_VALUE), gems=safeNumber(p.gems, 0, 0, MAX_LOCAL_VALUE),
        ton=safeNumber(p.ton, 0, 0, MAX_LOCAL_VALUE), candy=safeNumber(p.candy, 0, 0, MAX_LOCAL_VALUE),
        pumpkins=safeNumber(p.pumpkins, 0, 0, MAX_LOCAL_VALUE), spins=safeNumber(p.spins, 0, 0, 1e9),
        vouchers=safeNumber(p.vouchers, 0, 0, 1e9), rebirths=safeNumber(p.rebirths, 0, 0, 1e9)
    }
    local nftRewards = {}
    if type(p.nft) == "string" and Info.Gifts[p.nft] then table.insert(nftRewards, {name=p.nft, unique=false}) end
    if type(p.nft_list) == "table" then
        for _, name in ipairs(p.nft_list) do
            if type(name) == "string" and Info.Gifts[name] then table.insert(nftRewards, {name=name, unique=p.nft_list_unique == true}) end
        end
    end
    local hasReward = #nftRewards > 0
    for _, amount in pairs(values) do if amount > 0 then hasReward = true; break end end
    if not hasReward then return false, "Promo has no rewards" end
    local spawned = {}
    local batch, previousBatch = beginInventoryBatch()
    local spawnOK = true
    for _, nft in ipairs(nftRewards) do
        local inst = spawnNFT(nft.name, {isUnique=nft.unique, pattern=p.nft_list_pattern, backdrop=p.nft_list_backdrop, silentEffects=true})
        if not inst then
            spawnOK = false
            for _, created in ipairs(spawned) do pcall(destroyNFT, created) end
            break
        end
        table.insert(spawned, inst)
    end
    finishInventoryBatch(batch, previousBatch)
    if not spawnOK then return false, "Could not create promo NFT" end
    local rewards = {}
    if values.stars > 0 then addBal("_StarsValue", values.stars); table.insert(rewards, "⭐"..num(values.stars)) end
    if values.gems > 0 then addBal("_GemsValue", values.gems); table.insert(rewards, "💎"..num(values.gems)) end
    if values.ton > 0 then addBal("_TONValue", values.ton); table.insert(rewards, "💠"..num(values.ton)) end
    if values.candy > 0 then addBal("_Candy", values.candy); table.insert(rewards, "🍬"..num(values.candy)) end
    if values.pumpkins > 0 then addBal("_Pumpkins", values.pumpkins); table.insert(rewards, "🎃"..num(values.pumpkins)) end
    if values.spins > 0 then addBal("_HalloweenSpins", values.spins); table.insert(rewards, values.spins.." spins") end
    if values.vouchers > 0 then addBal("_Vouchers", values.vouchers); table.insert(rewards, values.vouchers.." vouchers") end
    if values.rebirths > 0 then
        local rb = getOrCreate(LP, "_Rebirths", "IntValue", 0)
        rb.Value = math.min(1e9, rb.Value + values.rebirths)
        addBal("_Vouchers", values.rebirths)
        table.insert(rewards, values.rebirths.." rebirths")
    end
    for _, nft in ipairs(nftRewards) do table.insert(rewards, nft.name) end
    _settings.redeemedPromos[code] = os.time(); SAVE.settings()
    return true, "Redeemed: "..table.concat(rewards, ", ")
end

H.Settings = function(action, key, val)
    if not ON.Settings then return nil end
    local gs = _settings.GameSettings
    if action == "RequestSettings" then
        return {MusicSound=tonumber(gs.MusicSound) or 0.1, Snow=gs.Snow ~= false, HideLiveDrop=gs.HideLiveDrop == true}
    end
    if action == "ChangeSettings" then
        if key == "HideLiveDrop" then
            local hidden = (val == true or tonumber(val) == 1)
            gs.HideLiveDrop = hidden
            _G.HideDrop = hidden
        elseif key == "MusicSound" then
            local volume = math.clamp(tonumber(val) or 0.1, 0, 0.15)
            gs.MusicSound = volume
            pcall(function() game:GetService("SoundService").AirSounds.Volume = volume end)
        elseif key == "Snow" then
            gs.Snow = (val == true or tonumber(val) == 1)
        else
            return nil
        end
        SAVE.settings()
        return true
    end
end

H.DailyRewards = function(idx)
    if not ON.DailyRewards then return nil end
    idx = tonumber(idx); if not idx then return false, "Invalid" end
    local claimed = LP:FindFirstChild("_ClaimedRewards")
    if claimed and claimed:FindFirstChild(tostring(idx)) then return false, "Already" end
    if claimed then local v = Instance.new("BoolValue"); v.Name = tostring(idx); v.Parent = claimed end
    return true, "Claimed"
end

H.Quests = function(name)
    if not ON.Quests or type(name) ~= "string" then return nil end
    -- Never fabricate completion: only let the real server claim an already completed quest.
    local Q = LP:FindFirstChild("_Quests")
    local q = Q and Q:FindFirstChild(name)
    if not q or not q:IsA("IntValue") then return nil end
    local cfg = tryReq("QuestsConfigs")
    local duration = q:GetAttribute("Duration") == "Weekly" and "Weekly" or "Daily"
    local def = cfg and cfg.Quests and cfg.Quests[duration] and cfg.Quests[duration][name]
    if not def or q.Value < (tonumber(def.Goal) or math.huge) then return nil end
    return nil
end

local _customCaseDrafts = {}
local function customCaseEligible(name, gift)
    if type(name) ~= "string" or type(gift) ~= "table" then return false end
    local price = safeNumber(gift.Price, 0, 0, MAX_LOCAL_VALUE)
    if price < 1000000 then return false end
    if gift.Summer or gift.Craftable or gift.Crafted or gift.Winter or gift.Old or gift.Hidden or gift.Halloween then return false end
    return true
end
local function customCaseInfo(gifts)
    if type(gifts) ~= "table" or #gifts < 3 or #gifts > 10 then return nil, "Select 3–10 gifts" end
    local seen, minPrice, totalWeight = {}, math.huge, 0
    for _, name in ipairs(gifts) do
        if type(name) ~= "string" or seen[name] then return nil, "Invalid or duplicate gift" end
        seen[name] = true
        local gift = Info.Gifts and Info.Gifts[name]
        if not customCaseEligible(name, gift) then return nil, "Gift cannot be used: "..tostring(name) end
        minPrice = math.min(minPrice, safeNumber(gift.Price, 0, 0, MAX_LOCAL_VALUE))
    end
    local weights, chances = {}, {}
    for _, name in ipairs(gifts) do
        local w = minPrice / math.max(1, safeNumber(Info.Gifts[name].Price, 1, 1, MAX_LOCAL_VALUE))
        weights[name] = w; totalWeight = totalWeight + w
    end
    if totalWeight <= 0 then return nil, "Invalid gift prices" end
    local chanceSum, cheapestName = 0, nil
    for _, name in ipairs(gifts) do
        local pct = math.floor((weights[name] / totalWeight * 100000) + 0.5) / 1000
        if pct <= 0 then
            return nil, "Chance is 0.000% for "..tostring(name)..". Remove this NFT or choose a cheaper combination."
        end
        chances[name] = pct
        chanceSum = math.floor((chanceSum + pct) * 1000 + 0.5) / 1000
        if not cheapestName or Info.Gifts[name].Price < Info.Gifts[cheapestName].Price then cheapestName = name end
    end
    if cheapestName then chances[cheapestName] = chances[cheapestName] + (100 - chanceSum) end
    local expected = 0
    for _, name in ipairs(gifts) do expected = expected + (chances[name] / 100) * safeNumber(Info.Gifts[name].Price, 0, 0, MAX_LOCAL_VALUE) end
    local roi = (math.max(2000000, math.min(500000000, expected)) - 2000000) / 498000000 * -0.3 + 0.8
    local price = math.floor((math.floor(expected + 0.5) / math.max(0.01, roi) / 5) + 0.5) * 5
    return {Price=price, Chances=chances, ROI=roi, Expected=expected}
end
local function restoreCustomCases()
    local folder = ensureCustomCasesFolder()
    for name, data in pairs(_customCases) do
        if type(name) == "string" and type(data) == "table" and type(data.gifts) == "table" then
            local createdAt = tonumber(data.createdAt) or os.time()
            if os.time() - createdAt >= (tonumber(data.duration) or 86400) then
                _customCases[name] = nil
                local expired = folder:FindFirstChild(name); if expired then expired:Destroy() end
            elseif data.creator and data.creator ~= LP.Name then
                local hidden = folder:FindFirstChild(name); if hidden then hidden:Destroy() end
            else
            local caseFolder = folder:FindFirstChild(name)
            if not caseFolder then caseFolder = Instance.new("Folder"); caseFolder.Name = name end
            -- Build completely before parenting: the game's ChildAdded listener reads gifts immediately.
            for _, child in ipairs(caseFolder:GetChildren()) do child:Destroy() end
            for _, giftName in ipairs(data.gifts) do
                if type(giftName) == "string" and Info.Gifts[giftName] then
                    local entry = Instance.new("StringValue"); entry.Name = giftName; entry.Value = giftName; entry.Parent = caseFolder
                end
            end
            caseFolder:SetAttribute("LocalOnly", true)
            caseFolder:SetAttribute("Price", tonumber(data.price) or 0)
            caseFolder:SetAttribute("Created", createdAt); caseFolder:SetAttribute("Creator", LP.Name); caseFolder:SetAttribute("ExpiresAt", createdAt + 86400)
            caseFolder.Parent = folder
            end
        end
    end
    SAVE.customcases()
end
restoreCustomCases()
task.spawn(function()
    while task.wait(1) do
        local root = LP:FindFirstChild("_CustomCases")
        if root then
            for _, cf in ipairs(root:GetChildren()) do
                local expiry = tonumber(cf:GetAttribute("ExpiresAt"))
                if expiry then
                    cf:SetAttribute("RemainingSeconds", math.max(0, expiry-os.time()))
                    if expiry <= os.time() then cf:Destroy() end
                end
            end
        end
    end
end)
_buildCustomCaseConfig = function(name)
    local folder = ensureCustomCasesFolder()
    local caseFolder = folder:FindFirstChild(name)
    if not caseFolder then return nil end
    local gifts = {}
    for _, child in ipairs(caseFolder:GetChildren()) do
        if child:IsA("StringValue") and Info.Gifts[child.Name] then table.insert(gifts, child.Name) end
    end
    if #gifts < 3 then return nil end
    local ok, cfg = pcall(function() return Handler and Handler.CaseInfo(gifts) end)
    if not ok or type(cfg) ~= "table" or type(cfg.Drop) ~= "table" then return nil end
    cfg.Price = tonumber(caseFolder:GetAttribute("Price")) or tonumber(cfg.Price) or 0
    cfg.Custom = true
    return cfg
end
H.CustomCases = function(action, arg1, arg2)
    if not ON.CustomCases then return nil end
    if action == "Generate" then
        local gifts = arg1
        local name = cleanText(arg2, 32)
        if name == "" or not name:match("^[a-zA-Z0-9_]+$") then return false, "Use English letters, numbers or _" end
        local info, err = customCaseInfo(gifts)
        if not info then return false, err end
        local giftKey = table.concat(gifts, "|")
        _customCaseDrafts[name] = {giftKey=giftKey, at=os.clock()}
        local previewChances = {}; for k,v in pairs(info.Chances) do previewChances[k] = v end
        return true, {info.Price, previewChances, info.ROI, info.Expected}
    elseif action == "Buy" then
        local gifts = arg1
        local name = cleanText(arg2, 32)
        if name == "" or not name:match("^[a-zA-Z0-9_]+$") then return false, "Enter a valid case name" end
        local folderRoot = ensureCustomCasesFolder()
        if _customCases[name] or folderRoot:FindFirstChild(name) then return false, "Case name already exists" end
        local draft = _customCaseDrafts[name]
        if not draft or os.clock() - (draft.at or 0) > 300 or draft.giftKey ~= table.concat(type(gifts)=="table" and gifts or {}, "|") then return false, "Generate the case preview first" end
        local info, err = customCaseInfo(gifts)
        if not info then return false, err end
        local credit = getBal("_CustomCredits")
        if credit < 1 then return false, "No Custom Credits" end
        local giftCopy = {}; for _, giftName in ipairs(gifts) do table.insert(giftCopy, giftName) end
        local createdAt = os.time()
        local data = {creator=LP.Name, gifts=giftCopy, price=info.Price, chances=info.Chances, roi=info.ROI, expected=info.Expected, createdAt=createdAt, duration=86400, localOnly=true}
        -- Create a complete instance first. The game's ChildAdded callback immediately reads
        -- the first three gift children and the Created attribute to build its native tile.
        local caseFolder = Instance.new("Folder")
        caseFolder.Name = name
        caseFolder:SetAttribute("LocalOnly", true)
        caseFolder:SetAttribute("Price", info.Price)
        caseFolder:SetAttribute("Created", createdAt); caseFolder:SetAttribute("Creator", LP.Name); caseFolder:SetAttribute("ExpiresAt", createdAt + 86400)
        for _, giftName in ipairs(giftCopy) do
            local entry = Instance.new("StringValue")
            entry.Name = giftName; entry.Value = giftName; entry.Parent = caseFolder
        end
        _customCases[name] = data
        caseFolder.Parent = folderRoot
        setBal("_CustomCredits", credit - 1)
        _customCaseDrafts[name] = nil
        SAVE.customcases()
        pushLog("LOCAL CUSTOM CASE CREATED: "..name)
        return true, "Created locally"
    elseif action == "Open" then
        local name = cleanText(arg1, 32)
        local data = _customCases[name]
        if type(data) ~= "table" or type(data.gifts) ~= "table" then return false, "Custom case not found" end
        if data.creator and data.creator ~= LP.Name then return false, "This local case belongs to another creator profile" end
        local expires = (tonumber(data.createdAt) or 0) + (tonumber(data.duration) or 86400)
        if expires > 0 and os.time() >= expires then return false, "Custom case timer expired" end
        local count = math.floor(safeNumber(arg2, 1, 1, 10))
        local info = customCaseInfo(data.gifts)
        if not info then return false, "Saved case is invalid" end
        local drops, cfgDrop = {}, {}
        for _, giftName in ipairs(data.gifts) do table.insert(cfgDrop, {giftName, info.Chances[giftName] or 0}) end
        local batch, previousBatch = beginInventoryBatch()
        local bestDrop, bestPrice = nil, -1
        local okDrops = pcall(function()
            for _ = 1, count do
                local giftName = rollDrop({Drop=cfgDrop})
                if giftName then
                    local created = spawnNFT(giftName, {dropType="Case", dropExtra=name, silentEffects=true})
                    if created then
                        table.insert(drops, giftName)
                        local price = tonumber(Info.Gifts[giftName] and Info.Gifts[giftName].Price) or 0
                        if price > bestPrice then bestPrice = price; bestDrop = giftName end
                    end
                end
            end
        end)
        finishInventoryBatch(batch, previousBatch)
        if not okDrops then return false, "Custom case generation failed" end
        if bestDrop then pcall(updateBest, bestDrop) end
        pcall(broadcastDropBatch, "Case", drops, LP.Name, name, nil)
        if #drops == 0 then return false, "No drop generated" end
        pushLog("LOCAL CUSTOM CASE OPENED: "..name.." x"..#drops)
        return true, drops
    elseif action == "Delete" then
        local name = cleanText(arg1, 32)
        if not _customCases[name] then return false, "Case not found" end
        _customCases[name] = nil; _customCaseDrafts[name] = nil
        local folder = ensureCustomCasesFolder():FindFirstChild(name); if folder then folder:Destroy() end
        SAVE.customcases(); return true, "Deleted locally"
    end
    return nil
end
H.AdminPanel = function(action, target)
    if not ON.AdminPanel then return false end
    if action == "LeadersBan" then
        -- Local sandbox response only. Never forward a ban request to Roblox servers.
        local targetId = tonumber(target) or (typeof(target) == "Instance" and tonumber(target:GetAttribute("PlayerID")))
        pushLog("LOCAL LEADERBOARD BAN PREVIEW: "..tostring(targetId or target or "unknown"))
        return true
    end
    return false
end


local function findMailRecord(requestedId)
    local id = tostring(requestedId or "")
    local direct = _mail[id]
    if type(direct) == "table" then return direct, id end
    for key, record in pairs(_mail) do
        if type(record) == "table" then
            if tostring(record.id or "") == id then return record, key end
            if tostring(record.originalId or "") == id then return record, key end
        end
    end
    return nil, nil
end

H.Mail = function(action, arg1, arg2)
    if not ON.Mail then return nil end
    if action == "Send" then
        local data = arg1
        if type(data) ~= "table" or not data.To then return false, "Invalid" end
        local items = data.Items or {}; local currency = data.Currency or {}
        if type(items) ~= "table" or type(currency) ~= "table" then return false, "Invalid parcel data" end
        local itemCount, maxIndex = 0, 0
        for index, inst in pairs(items) do
            if type(index) ~= "number" or index < 1 or index % 1 ~= 0 then return false, "Invalid NFT list" end
            if typeof(inst) ~= "Instance" or not isInvChild(inst) then return false, "Not in inv" end
            itemCount = itemCount + 1
            if index > maxIndex then maxIndex = index end
            if itemCount > 50 then return false, "A single mail can contain at most 50 NFTs" end
        end
        if itemCount ~= maxIndex then return false, "Invalid NFT list" end
        if itemCount == 0 and next(currency) == nil then return false, "Empty" end
        local planValue = LP:FindFirstChild("_MailPlan")
        local plans = MailCfg
        local purchasedPlan = math.clamp(math.floor(tonumber(planValue and planValue.Value) or 0), 0, 2)
        local plan = purchasedPlan
        if _settings.MailPlanOverrideEnabled == true then
            plan = math.clamp(math.floor(tonumber(_settings.MailPlanOverride) or 0), 0, 2)
        end
        local planData = plans.Plans and plans.Plans[plan+1]
        local dailyLimit = math.min(tonumber(planData and planData.Limit) or 10, 150)
        local sentToday = 0
        local nowDate = os.date("*t")
        local dayStart = os.time({year=nowDate.year, month=nowDate.month, day=nowDate.day, hour=0, min=0, sec=0})
        for _, oldMail in pairs(_mail) do
            if type(oldMail)=="table" and oldMail.historyOnly ~= true and tonumber(oldMail.fromId)==LP.UserId and (tonumber(oldMail.time) or 0)>=dayStart then sentToday=sentToday+1 end
        end
        if dailyLimit ~= math.huge and sentToday >= dailyLimit then return false, "Daily mail limit reached ("..tostring(dailyLimit)..")" end
        local serialized = {}; local counts = {}
        for _, inst in ipairs(items) do
            if inst:GetAttribute("Unique") then table.insert(serialized, {N=inst.Name, A={Number=inst:GetAttribute("Number"), Pattern=inst:GetAttribute("Pattern"), Backdrop=inst:GetAttribute("Backdrop")}})
            else counts[inst.Name] = (counts[inst.Name] or 0) + 1 end
        end
        for name, cnt in pairs(counts) do table.insert(serialized, {N=name, C=cnt}) end
        local serializedCur = {}
        for k, v in pairs(currency) do
            local amount = tonumber(v) or 0
            if amount > 0 and (k == "StarsValue" or k == "GemsValue" or k == "TONValue") then
                if getBal("_"..k) < amount then return false, "Not enough "..k end
                serializedCur[k] = amount
            end
        end
        local rName = "Unknown"
        for _, plr in ipairs(Players:GetPlayers()) do if plr.UserId == data.To then rName = plr.Name; break end end
        if rName == "Unknown" then local ok2, name = pcall(function() return Players:GetNameFromUserIdAsync(data.To) end); if ok2 and name then rName = name end end
        local batch, previousBatch = beginInventoryBatch()
        for _, inst in ipairs(items) do destroyNFT(inst) end
        finishInventoryBatch(batch, previousBatch)
        for k, v in pairs(serializedCur) do addBal("_"..k, -v) end
        local code = genUniqueParcel()
        _mail[code] = {id=code, to=data.To, toName=rName, fromId=LP.UserId, fromName=LP.Name, time=os.time(), items=serialized, currency=serializedCur, claimed=nil, declined=nil, fake=true}
        SAVE.mail()
        local nftCount = 0; for _, it in ipairs(serialized) do nftCount = nftCount + (tonumber(it.C) or (it.A and 1 or 0)) end
        local currencyTotal = 0; for _, v in pairs(serializedCur) do currencyTotal = currencyTotal + (tonumber(v) or 0) end
        -- The parcel record itself is the sent-history record; do not create a second H-S row.
        SAVE.mail(); pushLog("MAIL SENT "..code.." -> "..rName)
        task.defer(updateMailPending)
        return true, code
    elseif action == "Info" then
        local pending, log = {}, {}
        for code, m in pairs(_mail) do
            if type(m) ~= "table" or not m.id then continue end
            local mId = tostring(m.id or code)
            local mTo = tonumber(m.to) or 0
            local mFromId = tonumber(m.fromId) or 0
            local mTime = tonumber(m.time) or os.time()
            local mName = tostring(m.toName or "Unknown")
            local mFromName = tostring(m.fromName or "Unknown")
            local isIncoming = (mTo == LP.UserId) or (m.toName ~= nil and m.toName == LP.Name)
            local isSent = (mFromId == LP.UserId) and (mFromId ~= 0)
            if isIncoming and not m.claimed and not m.declined and m.historyOnly ~= true then
                table.insert(pending, {
                    ID = mId, FromName = mFromName, Time = mTime,
                    Items = type(m.items) == "table" and m.items or {},
                    Currency = type(m.currency) == "table" and m.currency or {},
                })
            elseif m.historyOnly == true and m.direction == "R" then
                table.insert(log, {I=mId, D="R", N=m.toName or "Unknown", T=mTime, C=tonumber(m.itemCount) or 0, V=tonumber(m.value) or 0, Fake=true})
            elseif isSent then
                if m.historyOnly == true then
                    local originalCode = tostring(code):match("^H%-S%-(.+)$")
                    if originalCode and _mail[originalCode] then continue end
                    table.insert(log, {I=mId, D="S", N=mName, T=mTime, C=tonumber(m.itemCount) or 0, V=tonumber(m.value) or 0, Fake=true})
                    continue
                end
                local nftCnt, starCnt = 0, 0
                for _, item in ipairs(type(m.items) == "table" and m.items or {}) do
                    if type(item) == "table" then
                        nftCnt = nftCnt + (tonumber(item.C) or 0) + (item.A and 1 or 0)
                    end
                end
                for _, v in pairs(type(m.currency) == "table" and m.currency or {}) do
                    starCnt = starCnt + (tonumber(v) or 0)
                end
                table.insert(log, {
                    I = mId, D = "S", N = mName,
                    T = mTime, C = nftCnt, V = starCnt,
                    Fake = m.historyOnly == true,
                })
            end
        end
        table.sort(pending, function(a,b) return (a.Time or 0) > (b.Time or 0) end)
        table.sort(log, function(a,b) return (a.T or 0) > (b.T or 0) end)
        local pv = LP:FindFirstChild("_MailPlan")
        local selectedPlan = math.clamp(math.floor(tonumber(pv and pv.Value) or 0), 0, 2)
        if _settings.MailPlanOverrideEnabled == true then
            selectedPlan = math.clamp(math.floor(tonumber(_settings.MailPlanOverride) or 0), 0, 2)
        end
        local sentCount = 0
        local nowDate = os.date("*t")
        local today = os.time({year=nowDate.year, month=nowDate.month, day=nowDate.day, hour=0, min=0, sec=0})
        for _, m in pairs(_mail) do if type(m)=="table" and tonumber(m.fromId)==LP.UserId and (tonumber(m.time) or 0)>=today and m.historyOnly~=true then sentCount=sentCount+1 end end
        return true, {Pending=pending, Log=log, Plan=selectedPlan, Sent=sentCount, Failed=false}
    elseif action == "Lookup" then
        local code = tostring(arg1 or ""):upper():gsub("%s", "")
        if code == "" then return false, "Invalid" end
        local historyRecord, historyKey = findMailRecord(code)
        local m = historyRecord
        local isHistory = false
        if m and m.historyOnly == true and m.originalId then
            local original = findMailRecord(m.originalId)
            if original then m = original; isHistory = true end
        elseif m and m.historyOnly == true then
            isHistory = true
        end
        if not m or type(m) ~= "table" then return false, "Not found" end
        return true, {
            ID=tostring(m.id or historyKey or code), FromName=m.fromName or "Unknown",
            ToName=m.toName or "Unknown", Time=m.time, Items=m.items or {},
            Currency=m.currency or {}, Claimed=m.claimed, Declined=m.declined,
            History=isHistory or (historyRecord and historyRecord.historyOnly == true) or false,
            OriginalID=m.id or (historyRecord and historyRecord.originalId),
        }
    elseif action == "Resolve" then
        local username = arg1
        if type(username) ~= "string" or username == "" then return false, "Invalid" end
        for _, plr in ipairs(Players:GetPlayers()) do if plr.Name:lower() == username:lower() then return true, {Id=plr.UserId, Name=plr.Name} end end
        local ok2, id = pcall(function() return Players:GetUserIdFromNameAsync(username) end)
        if ok2 and id then
            local ok3, name = pcall(function() return Players:GetNameFromUserIdAsync(id) end)
            if ok3 and name then return true, {Id=id, Name=name} end
            return true, {Id=id, Name=username}
        end
        return false, "Player not found"
    elseif action == "Claim" then
        local ids = arg1
        if type(ids) ~= "table" then return false, "Invalid" end
        local claimed = {}
        for _, id in ipairs(ids) do
            local code = tostring(id)
            local m = _mail[code]
            if m and type(m) == "table" and not m.claimed and not m.declined then
                local isIncoming = (tonumber(m.to) == LP.UserId) or (m.toName == LP.Name)
                if isIncoming then
                    local valid = true
                    for _, entry in ipairs(m.items or {}) do
                        if type(entry) ~= "table" or type(entry.N) ~= "string" or not rawget(Info.Gifts, entry.N) then valid = false; break end
                        local qty = entry.A and 1 or math.floor(tonumber(entry.C) or 1)
                        if qty < 1 or qty > 50 then valid = false; break end
                    end
                    if valid then
                        local spawned = {}
                        for _, entry in ipairs(m.items or {}) do
                            if entry.A then
                                local inst = spawnNFT(entry.N, {isUnique=true, pattern=entry.A.Pattern, backdrop=entry.A.Backdrop, number=entry.A.Number})
                                if inst then table.insert(spawned, inst) else valid = false; break end
                            else
                                for _ = 1, math.floor(tonumber(entry.C) or 1) do
                                    local inst = spawnNFT(entry.N, {isUnique=false})
                                    if inst then table.insert(spawned, inst) else valid = false; break end
                                end
                                if not valid then break end
                            end
                        end
                        if not valid then
                            for _, inst in ipairs(spawned) do pcall(destroyNFT, inst) end
                        else
                            for k, v in pairs(m.currency or {}) do
                                local amount = math.max(0, tonumber(v) or 0)
                                if k == "StarsValue" then addBal("_StarsValue", amount)
                                elseif k == "GemsValue" then addBal("_GemsValue", amount)
                                elseif k == "TONValue" then addBal("_TONValue", amount) end
                            end
                            m.claimed = os.time()
                            local nftCnt = #spawned
                            local val = 0; for _, amount in pairs(m.currency or {}) do val=val+(tonumber(amount) or 0) end
                            _mail["H-R-"..code.."-"..tostring(os.time())] = {historyOnly=true, id="CLAIM-"..code, fromId=LP.UserId, fromName=LP.Name, toName=m.fromName or "Unknown", time=os.time(), direction="R", itemCount=nftCnt, value=val, originalId=code}
                            table.insert(claimed, code)
                        end
                    end
                end
            end
        end
        if #claimed == 0 then return false, "No available parcels to claim" end
        SAVE.mail(); SAVE.normal(); SAVE.unique(); SAVE.curr(); SAVE.index(); pushLog("MAIL CLAIMED "..#claimed)
        task.defer(updateMailPending)
        return true, {Claimed=claimed, Full=false}
    elseif action == "Decline" then
        local id = tostring(arg1 or "")
        local m = _mail[id]
        if not m or type(m) ~= "table" or m.claimed or m.declined then return false, "Cannot decline" end
        local isIncoming = (m.to == LP.UserId) or (m.toName == LP.Name)
        if not isIncoming then return false, "Not addressed to you" end
        m.declined = os.time(); SAVE.mail()
        task.defer(updateMailPending)
        return true, "Declined"
    end
    return nil
end

LP:WaitForChild("_CasesOpened", 8)
LP:WaitForChild("_UpgradesMade", 8)
syncGameStatAttributes()
local _lbHooked = setmetatable({}, {__mode="k"})
local _lbInjectBusy = false
local function injectLB()
    if _lbInjectBusy then return end
    _lbInjectBusy = true
    local function finishLB() _lbInjectBusy = false end
    local LB = RS:FindFirstChild("Leaderboards")
    if not LB then finishLB(); return end
    task.delay(8, function() if _lbInjectBusy then finishLB() end end)
    local starsFolder = LB:FindFirstChild("Stars")
    local invFolder = LB:FindFirstChild("Inv")
    syncGameStatAttributes()
    local myStars = math.max(0, math.floor(tonumber(getBal("_StarsValue")) or 0))
    local myCases = readGameStat("_CasesOpened")
    local myUpgrades = readGameStat("_UpgradesMade")
    local myInv, counts = 0, {}
    local inv = ensureInv()
    for _, item in ipairs(inv:GetChildren()) do
        if item:IsA("ValueBase") then
            local gift = Info.Gifts and Info.Gifts[item.Name]
            -- The game's profile renderer dereferences Info.Gifts[name] directly;
            -- only publish entries the original renderer can safely display.
            if gift then
                local price = tonumber(gift.Price) or 0
                if price > 0 then myInv = myInv + price end
                counts[item.Name] = (counts[item.Name] or 0) + 1
            end
        end
    end
    local bestRef = getBestRef()
    local function updateProfileData(entry)
        entry:SetAttribute("PlayerID", LP.UserId)
        entry:SetAttribute("Stars", myStars)
        entry:SetAttribute("CasesOpened", myCases)
        entry:SetAttribute("UpgradesMade", myUpgrades)
        entry:SetAttribute("BestDrop", bestRef and bestRef.Value or "—")
        for _, child in ipairs(entry:GetChildren()) do child:Destroy() end
        for name, count in pairs(counts) do
            local value = Instance.new("IntValue")
            value.Name = name
            value.Value = count
            value.Parent = entry
        end
    end
    local function upsertRanked(folder, score, includeInventory)
        if not folder then return end
        local mine
        local entries = {}
        local seenPlayerIds = {}
        for _, entry in ipairs(folder:GetChildren()) do
            if entry:IsA("IntValue") then
                local playerId = tonumber(entry:GetAttribute("PlayerID"))
                if playerId then
                    if seenPlayerIds[playerId] then
                        -- A duplicate player row must never occupy a second rank.
                        if playerId == LP.UserId then
                            if not mine then mine = entry else entry:Destroy() end
                        else
                            entry:Destroy()
                        end
                    else
                        seenPlayerIds[playerId] = entry
                        if playerId == LP.UserId then mine = entry else table.insert(entries, entry) end
                    end
                else
                    table.insert(entries, entry)
                end
            end
        end
        if not mine then
            mine = Instance.new("IntValue")
            mine:SetAttribute("PlayerID", LP.UserId)
        end
        local previousMineValue = mine.Value
        mine.Value = math.clamp(math.floor(score), 0, 9000000000000000000)
        if includeInventory then
            updateProfileData(mine)
        else
            for _, child in ipairs(mine:GetChildren()) do child:Destroy() end
        end
        table.insert(entries, mine)
        table.sort(entries, function(a, b)
            local av, bv = tonumber(a.Value) or 0, tonumber(b.Value) or 0
            if av == bv then
                return (tonumber(a:GetAttribute("PlayerID")) or math.huge) < (tonumber(b:GetAttribute("PlayerID")) or math.huge)
            end
            return av > bv
        end)
        -- The game UI uses Instance.Name as the rank and clones rows only on ChildAdded.
        -- Rebuild rows only when a rank/value changes, avoiding duplicates/flicker.
        local needsRebuild = (previousMineValue ~= mine.Value) or (mine.Parent ~= folder)
        for index, entry in ipairs(entries) do
            if entry.Name ~= tostring(index) then needsRebuild = true end
        end
        if needsRebuild then
            for index, entry in ipairs(entries) do entry.Name = "_rank_tmp_" .. tostring(index) end
            for index, oldEntry in ipairs(entries) do
                local fresh = Instance.new("IntValue")
                fresh.Name = tostring(index)
                fresh.Value = oldEntry.Value
                for attribute, value in pairs(oldEntry:GetAttributes()) do
                    fresh:SetAttribute(attribute, value)
                end
                for _, child in ipairs(oldEntry:GetChildren()) do
                    if child:IsA("IntValue") then
                        local childCopy = Instance.new("IntValue")
                        childCopy.Name = child.Name
                        childCopy.Value = child.Value
                        childCopy.Parent = fresh
                    end
                end
                fresh.Parent = folder
                oldEntry:Destroy()
                entries[index] = fresh
            end
        else
            for index, entry in ipairs(entries) do entry.Name = tostring(index) end
        end
    end
    pcall(upsertRanked, starsFolder, myStars, false)
    pcall(upsertRanked, invFolder, myInv, true)
    finishLB()
end
local function hookBanButton(btn)
    if not btn or _lbHooked[btn] then return end
    if not (btn:IsA("TextButton") or btn:IsA("GuiObject")) then return end
    _lbHooked[btn] = true
    if not btn.Visible then pcall(function() btn.Visible = true end) end
    btn:GetPropertyChangedSignal("Visible"):Connect(function()
        if not btn.Visible and btn.Parent then task.defer(function() if btn.Parent then pcall(function() btn.Visible = true end) end end) end
    end)
    btn.AncestryChanged:Connect(function(_, newParent) if not newParent then _lbHooked[btn] = nil end end)
end

task.spawn(function()
    while true do
        task.wait(1.5)
        pcall(function()
            local mg = PG:FindFirstChild("MainGui")
            if not mg then return end
            for _, d in ipairs(mg:GetDescendants()) do if d.Name == "Ban" and not _lbHooked[d] then hookBanButton(d) end end
        end)
    end
end)
task.spawn(function() while true do task.wait(5); pcall(injectLB) end end)
task.wait(2); pcall(injectLB)

local PRODUCT_MAP = {}
for key, prod in pairs(HalloweenCfg.Products or {}) do
    if type(prod) == "table" and prod.Id and tonumber(prod.Id) then PRODUCT_MAP[tonumber(prod.Id)] = {type="halloween", key=key, prod=prod} end
end
for key, item in pairs(ShopItemsCfg.Items or {}) do
    if type(item) == "table" and item.Grant and tonumber(item.Grant) then PRODUCT_MAP[tonumber(item.Grant)] = {type="shop", key=key, item=item} end
end
if NFTPassCfg.Product then PRODUCT_MAP[tonumber(NFTPassCfg.Product)] = {type="nftpass_plus"} end
if NFTPassCfg.RerollProduct then PRODUCT_MAP[tonumber(NFTPassCfg.RerollProduct)] = {type="nftpass_reroll"} end
for i, id in ipairs(NFTPassCfg.SkipsList or {}) do PRODUCT_MAP[tonumber(id)] = {type="passskip", tier=i} end
for _, vp in ipairs(RebirthCfg.VoucherProducts or {}) do
    if vp.Id and tonumber(vp.Id) > 0 then PRODUCT_MAP[tonumber(vp.Id)] = {type="vouchers", amount=vp.Amount} end
end
for _, id in ipairs({3608607478, 3609298573, 3609298842}) do
    PRODUCT_MAP[tonumber(id)] = {type="custom_case", amount = id == 3608607478 and 1 or (id == 3609298573 and 3 or 10)}
end

local function handleFakeProduct(productId)
    if not productId or not _settings.FakeAllPurchases then return false end
    productId = tonumber(productId); if not productId then return false end
    local entry = PRODUCT_MAP[productId]; if not entry then return false end
    local label = "?"
    if entry.type == "halloween" then
        local p = entry.prod; label = entry.key
        if p.Spins then addBal("_HalloweenSpins", p.Spins) end
        if p.Candy then addBal("_Candy", p.Candy) end
        if p.Potion and p.Seconds then pinBuff("_"..p.Potion) end
        if p.Flag then
            local f = LP:FindFirstChild("_"..p.Flag) or Instance.new("IntValue")
            f.Name = "_"..p.Flag; f.Value = 1; f.Parent = LP
        end
        if p.CauldronSlot then local s = LP:FindFirstChild("_CauldronSlots"); if s then s.Value = (s.Value or 0) + 1 end end
        if p.CauldronSkip then
            local c = LP:FindFirstChild("_Cauldron")
            if c then for _, slot in ipairs(c:GetChildren()) do if slot:GetAttribute("Recipe") then slot:SetAttribute("EndsAt", os.time()) end end end
        end
        if p.Gift and type(p.Gift) == "string" and Info.Gifts[p.Gift] then spawnNFT(p.Gift, {isUnique=false}) end
    elseif entry.type == "shop" then
        local item = entry.item; label = entry.key
        if item.Kind == "Buff" then
            local name = item.Name or ""
            if name:find("x2") then pinBuff("_LuckyPotion")
            elseif name:find("x4") then pinBuff("_LuckyPotion2")
            elseif name:find("x6") then pinBuff("_LuckyPotion3")
            elseif name:find("Blessing") then pinBuff("_Blessing") end
        elseif item.Case then
            local cc = LP:FindFirstChild("_PaidCases")
            if not cc then cc = Instance.new("Folder"); cc.Name = "_PaidCases"; cc.Parent = LP end
            local v = cc:FindFirstChild(item.Case)
            if not v then v = Instance.new("IntValue"); v.Name = item.Case; v.Value = 0; v.Parent = cc end
            v.Value = v.Value + 1
        elseif item.GamePass then
            local v = LP:FindFirstChild("_"..tostring(item.GamePass))
            if not v then v = Instance.new("IntValue"); v.Name = "_"..tostring(item.GamePass); v.Value = 0; v.Parent = LP end
            v.Value = 1
        elseif item.Plus then
            local pp = LP:FindFirstChild("_PlusPass"); if pp and NFTPassCfg.Season then pp.Value = NFTPassCfg.Season end
        elseif item.Grant then
            local v = LP:FindFirstChild("_"..tostring(item.Grant))
            if not v then v = Instance.new("IntValue"); v.Name = "_"..tostring(item.Grant); v.Value = 0; v.Parent = LP end
            v.Value = 1
        end
    elseif entry.type == "nftpass_plus" then
        label = "NFT Pass Plus"
        local pp = LP:FindFirstChild("_PlusPass"); if pp and NFTPassCfg.Season then pp.Value = NFTPassCfg.Season end
    elseif entry.type == "nftpass_reroll" then
        label = "Pass Reroll"; addBal("_PassRerolls", 1)
    elseif entry.type == "passskip" then
        label = "Skip T"..entry.tier
        local nft = LP:FindFirstChild("_NFTPass")
        if nft and NFTPassCfg.LvlXP and NFTPassCfg.Rewards then
            local maxLv = math.min(#NFTPassCfg.Rewards.Free, entry.tier * 10)
            local XP = nft:FindFirstChild("XP")
            if XP and maxLv > 0 then XP.Value = math.max(XP.Value, NFTPassCfg.LvlXP(maxLv)) end
        end
    elseif entry.type == "vouchers" then
        label = "Vouchers x"..entry.amount; addBal("_Vouchers", entry.amount)
    elseif entry.type == "custom_case" then
        label = "Custom Case x"..entry.amount
        local cc = LP:FindFirstChild("_CustomCredits")
        if not cc then cc = Instance.new("IntValue"); cc.Name = "_CustomCredits"; cc.Value = 0; cc.Parent = LP end
        cc.Value = cc.Value + entry.amount
    end
    pushLog("FAKE BUY "..label.." (id "..productId..")")
    return true
end

local _hooksList = {}
local HOOK_NAMES = {"AdminPanel","OpenCase","Upgrade","Fuse","NFTPass","Halloween","Rebirth","Quests","Reroll","Craft","DailyRewards","Inventory","Favorite","TON","UpgradeInventory","ShopItems","Code","Settings","CustomCases","Mail"}
for _, n in ipairs(HOOK_NAMES) do
    local r = Ev:FindFirstChild(n)
    if r then _hooksList[n] = r else task.spawn(function() local r2 = Ev:WaitForChild(n, 120); if r2 then _hooksList[n] = r2 end end) end
end
local _hookStatus = "not installed"; local _hookInstalled = false
local remoteToName = {}
for n, r in pairs(_hooksList) do remoteToName[r] = n end
task.spawn(function() while true do task.wait(5); for n, r in pairs(_hooksList) do remoteToName[r] = n end end end)

local function installHooks()
    if _hookInstalled then return end
    if not (getrawmetatable and getnamecallmethod and setreadonly) then _hookStatus = "FAILED"; return end
    local ok, mt = pcall(getrawmetatable, game)
    if not ok or not mt then _hookStatus = "FAILED"; return end
    local oldNC = rawget(mt, "__namecall"); local oldIdx = rawget(mt, "__index")
    pcall(setreadonly, mt, false)
    if oldNC then
        local ok1 = pcall(function()
            mt.__namecall = newcclosure(function(self, ...)
                local m = getnamecallmethod()
                if m == "PromptProductPurchase" and self == MarketplaceService and _settings.FakeAllPurchases then
                    local args = {...}; local productId = args[2]
                    if productId and handleFakeProduct(productId) then return end
                end
                if m == "InvokeServer" then
                    local n = remoteToName[self]
                    if n and H[n] then
                        local packed = table.pack(pcall(H[n], ...))
                        if packed[1] and packed[2] ~= nil then
                            return table.unpack(packed, 2, packed.n)
                        end
                    end
                elseif m == "FireServer" then
                    local n = remoteToName[self]
                    if n and H[n] then
                        local packed = table.pack(pcall(H[n], ...))
                        -- Only consume the request when the local handler explicitly handled it.
                        -- Disabled/unavailable/failed handlers must not silently block the game's original request.
                        if packed[1] and packed[2] ~= nil then
                            return table.unpack(packed, 2, packed.n)
                        end
                    end
                end
                return oldNC(self, ...)
            end)
        end)
        if ok1 then _hookStatus = "installed (namecall)" end
    end
    if oldIdx then
        local ok2 = pcall(function()
            mt.__index = newcclosure(function(self, key)
                local r = oldIdx(self, key)
                if remoteToName[self] and (key == "InvokeServer" or key == "FireServer") and type(r) == "function" then
                    return newcclosure(function(...)
                        local first = select(1, ...)
                        if first == self then
                            local rest = {}; local n = select("#", ...)
                            for i = 2, n do rest[i-1] = select(i, ...) end
                            local name = remoteToName[self]
                            if key == "InvokeServer" then
                                if name and H[name] then
                                    local packed = table.pack(pcall(H[name], table.unpack(rest)))
                                    if packed[1] and packed[2] ~= nil then
                                        return table.unpack(packed, 2, packed.n)
                                    end
                                end
                            else
                                if name and H[name] then
                                    local packed = table.pack(pcall(H[name], table.unpack(rest)))
                                    if packed[1] and packed[2] ~= nil then
                                        return table.unpack(packed, 2, packed.n)
                                    end
                                end
                            end
                            return r(self, table.unpack(rest))
                        end
                        return r(self, ...)
                    end)
                end
                return r
            end)
        end)
        if ok2 then if _hookStatus == "installed (namecall)" then _hookStatus = "installed (namecall + index)" else _hookStatus = "installed (index only)" end end
    end
    pcall(setreadonly, mt, true)
    if _hookStatus ~= "not installed" then _hookInstalled = true else _hookStatus = "FAILED" end
end
installHooks()
task.spawn(function()
    local minuteAccumulator = 0
    while task.wait(60) do minuteAccumulator = minuteAccumulator + 1; bumpQuestPrefix("TM", 1) end
end)
task.spawn(function() task.wait(3); if not _hookInstalled then installHooks() end end)
pushLog("Hook: ".._hookStatus)

-- The game's native CaseCreator is left untouched; the script's own NFT picker uses the reference modal.

task.spawn(function()
    for _, gid in ipairs(GP_IDS) do
        local v = LP:FindFirstChild("_" .. gid)
        if not v then v = Instance.new("IntValue"); v.Name = "_" .. gid; v.Value = 0; v.Parent = LP end
        v.Value = 1
    end
    if not LP:FindFirstChild("_HalloweenTimer") then local t = Instance.new("IntValue"); t.Name = "_HalloweenTimer"; t.Value = 0; t.Parent = LP end
    if not LP:FindFirstChild("_HalloweenSpins") then local s = Instance.new("IntValue"); s.Name = "_HalloweenSpins"; s.Value = 0; s.Parent = LP end
    if not LP:FindFirstChild("_Cauldron") then local f = Instance.new("Folder"); f.Name = "_Cauldron"; f.Parent = LP end
    if not LP:FindFirstChild("_CauldronSlots") then local s = Instance.new("IntValue"); s.Name = "_CauldronSlots"; s.Value = 2; s.Parent = LP end
    if not LP:FindFirstChild("_CandyEarned") then local c = Instance.new("IntValue"); c.Name = "_CandyEarned"; c.Value = 0; c.Parent = LP end
    if not LP:FindFirstChild("_HalloweenX4Candy") then local v = Instance.new("IntValue"); v.Name = "_HalloweenX4Candy"; v.Value = 1; v.Parent = LP end
    local cauldron = LP:FindFirstChild("_Cauldron")
    if cauldron then for _, slot in ipairs(cauldron:GetChildren()) do pcall(function() slot:Destroy() end) end end
    local nft = LP:WaitForChild("_NFTPass", 90)
    if nft then
        local claimed = nft:FindFirstChild("Claimed")
        if not claimed then claimed = Instance.new("Folder"); claimed.Name = "Claimed"; claimed.Parent = nft end
        for k, _ in pairs(claimed:GetAttributes()) do if tonumber(k) ~= nil then claimed:SetAttribute(k, nil) end end
        local xp = nft:FindFirstChild("XP")
        if xp and NFTPassCfg.LvlXP and NFTPassCfg.Rewards and NFTPassCfg.Rewards.Free then
            local maxLv = #NFTPassCfg.Rewards.Free
            if maxLv > 0 then xp.Value = NFTPassCfg.LvlXP(maxLv) end
        end
    end
end)

local S = {winW=CONFIG.WinW, winH=CONFIG.WinH, headerH=CONFIG.HeaderH, pad=10, sidebarW=CONFIG.SidebarW, tabPad=5, contentPad=10, sectionH=22, gap=7, r=7, rSm=4, rLg=9}

local oldG = RS:FindFirstChild("OldSounds") or RS:FindFirstChild("Sounds")
local function pickSnd(n) return oldG and oldG:FindFirstChild(n) or nil end
local SND = {Error=pickSnd("UI_Error"), Cancel=pickSnd("UI_Error2"), Success=pickSnd("UI_Cash") or pickSnd("UI_Success"), Click=pickSnd("UI_Click"), Coins=pickSnd("UI_Coins")}
local function playSnd(s) if not s then return end pcall(function() local c = s:Clone(); c.Parent = PG; c:Play(); Debris:AddItem(c, (c.TimeLength or 5) + 0.3) end) end
local function notify(t, x) pcall(function() if Handler and Handler.Notify then Handler.Notify(t, x, nil) else SG:SetCore("SendNotification", {Title=t, Text=x}) end end) end

local MainGui
local function New(cls, props) local ok, o = pcall(Instance.new, cls); if not ok or not o then return nil end; if props then for k, v in pairs(props) do pcall(function() o[k] = v end) end end; return o end
local function corner(p, r) if p then local c = Instance.new("UICorner"); c.CornerRadius = UDim.new(0, r or S.r); c.Parent = p; return c end end
local function stroke(p, col, th, tr) if not p then return end local s = Instance.new("UIStroke"); s.Color = col or C.borderSoft; s.Thickness = th or 1; s.Transparency = tr or 0.3; s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border; s.Parent = p; return s end
local function gradStroke(p, c1, c2, rot, thickness, tr)
    if not p then return end
    local s = Instance.new("UIStroke"); s.Thickness = thickness or 1; s.Transparency = tr or 0.15; s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    local g = Instance.new("UIGradient"); g.Color = ColorSequence.new(c1 or C.accent, c2 or C.purple); g.Rotation = rot or 45; g.Parent = s
    s.Parent = p; return s, g
end
local function gradient2(p, c1, c2, rot)
    if not p then return end
    local g = Instance.new("UIGradient"); g.Color = ColorSequence.new(c1, c2); g.Rotation = rot or 0
    g.Parent = p; return g
end

local function makeBtn(parent, props, radius, variant)
    props = props or {}; variant = variant or "default"
    if props.BackgroundTransparency == nil then props.BackgroundTransparency = 0 end
    props.BorderSizePixel = 0; props.AutoButtonColor = false; props.Parent = parent
    if not props.Font then props.Font = Enum.Font.GothamBold end
    props.TextStrokeTransparency = 1
    local colors = {
        primary = {C.accentDark, C.accent}, success = {Color3.fromRGB(24, 105, 76), Color3.fromRGB(32, 145, 100)},
        danger = {Color3.fromRGB(130, 42, 55), Color3.fromRGB(185, 55, 72)},
        purple = {Color3.fromRGB(82, 48, 135), Color3.fromRGB(126, 70, 190)},
        ghost = {C.card, C.cardHover}, default = {C.card, C.cardHover},
    }
    local colPair = colors[variant] or colors.default
    local isColored = variant == "primary" or variant == "success" or variant == "danger" or variant == "purple"
    if not props.TextColor3 then
        -- White/soft text is deliberately distinct from every button fill.
        props.TextColor3 = isColored and Color3.fromRGB(250, 250, 255) or C.text
    end
    if not props.BackgroundColor3 then props.BackgroundColor3 = colPair[1] end
    local b = New("TextButton", props); if not b then return nil end
    corner(b, radius or 8)
    if isColored then gradient2(b, colPair[1], colPair[2], 90) end
    -- Clean surface: no text outline and no colored border around the button.
    local sc = Instance.new("UIScale", b); sc.Scale = 1
    b.MouseButton1Down:Connect(function()
        TweenS:Create(sc, TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Scale=0.95}):Play()
    end)
    b.MouseButton1Up:Connect(function()
        TweenS:Create(sc, TweenInfo.new(0.22, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale=1.025}):Play()
    end)
    b.MouseLeave:Connect(function()
        TweenS:Create(sc, TweenInfo.new(0.18, Enum.EasingStyle.Quad), {Scale=1}):Play()
        if variant == "default" or variant == "ghost" then
            TweenS:Create(b, TweenInfo.new(0.16, Enum.EasingStyle.Quad), {BackgroundColor3=colPair[1]}):Play()
        end
    end)
    b.MouseEnter:Connect(function()
        if variant == "default" or variant == "ghost" then
            TweenS:Create(b, TweenInfo.new(0.16, Enum.EasingStyle.Quad), {BackgroundColor3=colPair[2]}):Play()
        else
            TweenS:Create(sc, TweenInfo.new(0.16, Enum.EasingStyle.Quad), {Scale=1.02}):Play()
        end
    end)
    return b
end

local function makeField(parent, props, radius)
    props = props or {}
    if not props.BackgroundColor3 then props.BackgroundColor3 = C.input end
    if props.BackgroundTransparency == nil then props.BackgroundTransparency = CONFIG.Transparency.card end
    props.BorderSizePixel = 0
    if not props.TextColor3 then props.TextColor3 = C.text end
    if not props.PlaceholderColor3 then props.PlaceholderColor3 = C.muted end
    props.ClearTextOnFocus = false; props.Text = props.Text or ""
    props.MultiLine = false; props.TextWrapped = false
    if props.PlaceholderText == nil then props.PlaceholderText = "" end
    if not props.Font then props.Font = Enum.Font.Gotham end
    props.Parent = parent
    local f = New("TextBox", props); if not f then return nil end
    if f.Text == "TextBox" then f.Text = "" end
    if f.PlaceholderText == "TextBox" then f.PlaceholderText = "" end
    corner(f, radius or S.rSm)
    local st = stroke(f, C.borderSoft, 1, 0.35)
    f.Focused:Connect(function() TweenS:Create(st, TweenInfo.new(0.15), {Color=C.accent, Transparency=0.3}):Play() end)
    f.FocusLost:Connect(function() TweenS:Create(st, TweenInfo.new(0.15), {Color=C.borderSoft, Transparency=0.35}):Play() end)
    return f
end

local function makeTog(parent, init, cb)
    local t = New("TextButton", {Size=UDim2.new(0,38,0,20), BackgroundColor3=init and C.green or C.input, BackgroundTransparency=0, BorderSizePixel=0, AutoButtonColor=false, Text="", Parent=parent})
    if not t then return function() return init end end
    corner(t, 10); stroke(t, C.borderSoft, 1, 0.3)
    local toggleScale = Instance.new("UIScale"); toggleScale.Scale = 1; toggleScale.Parent = t
    local k = New("Frame", {Size=UDim2.new(0,12,0,12), Position=init and UDim2.new(1,-16,0.5,-6) or UDim2.new(0,4,0.5,-6), BackgroundColor3=C.text, BorderSizePixel=0, Parent=t})
    corner(k, 6)
    local state = init
    t.Activated:Connect(function()
        state = not state
        toggleScale.Scale = 0.88
        TweenS:Create(toggleScale, TweenInfo.new(0.22, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale=1}):Play()
        local info = TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
        TweenS:Create(t, info, {BackgroundColor3 = state and C.green or C.input}):Play()
        TweenS:Create(k, info, {Position = state and UDim2.new(1,-16,0.5,-6) or UDim2.new(0,4,0.5,-6)}):Play()
        if cb then pcall(cb, state) end
        playSnd(SND.Click)
    end)
    return function() return state end
end

local function sectionT(parent, text, order)
    local row = New("Frame", {Size=UDim2.new(1,0,0,S.sectionH), BackgroundTransparency=1, LayoutOrder=order, Parent=parent})
    local bar = New("Frame", {Size=UDim2.new(0,3,0,13), Position=UDim2.new(0,0,0.5,-6.5), BackgroundColor3=C.accent, BorderSizePixel=0, Parent=row})
    corner(bar, 2); gradient2(bar, C.accent, C.purple, 90)
    local lbl = New("TextLabel", {Size=UDim2.new(1,-12,1,0), Position=UDim2.new(0,12,0,0), BackgroundTransparency=1, Text=string.upper(text), TextColor3=C.sub, Font=Enum.Font.GothamBold, TextSize=9, TextXAlignment=Enum.TextXAlignment.Left, Parent=row})
    addTextStroke(lbl, Color3.new(0,0,0), 1, themeBgLum() > 0.4 and 0.7 or 0.5)
end

local modalLayer, modalStack, openModal, closeModal

local function buildGui()
    if MainGui and MainGui.Parent then return MainGui end
    pcall(function() for _, g in ipairs(PG:GetChildren()) do if g.Name=="SunsetSisiTop" and g:IsA("ScreenGui") then g:Destroy() end end end)
    local sg = New("ScreenGui", {Name="SunsetSisiTop", ResetOnSpawn=false, IgnoreGuiInset=true, ZIndexBehavior=Enum.ZIndexBehavior.Sibling, DisplayOrder=950, Parent=PG})
    if not sg then return nil end
    MainGui = sg
    local scale = Instance.new("UIScale"); scale.Parent = sg
    local function refreshScale()
        local cam = workspace.CurrentCamera; if not cam then return end
        local vp = cam.ViewportSize; if vp.X<=0 or vp.Y<=0 then return end
        scale.Scale = math.clamp(math.min(vp.X/1920, vp.Y/1080)*0.9, 0.55, 1.05)
    end
    refreshScale()
    local scaleCamera = workspace.CurrentCamera
    if scaleCamera then
        scaleCamera:GetPropertyChangedSignal("ViewportSize"):Connect(refreshScale)
    end
    local vpY = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize.Y or 1080
    local winW = S.winW
    local winH = math.min(math.floor(vpY - 12), S.winH)
    local win = New("Frame", {Name="Window", Size=UDim2.new(0,winW,0,winH), Position=UDim2.new(0,24,0,10), BackgroundColor3=C.bg, BackgroundTransparency=CONFIG.Transparency.win, BorderSizePixel=0, Active=true, Draggable=true, Parent=sg, ClipsDescendants=true, ZIndex=2})
    corner(win, S.rLg); stroke(win, C.borderSoft, 1, 0.3)
    local winIntro = Instance.new("UIScale"); winIntro.Scale = 0.965; winIntro.Parent = win
    TweenS:Create(winIntro, TweenInfo.new(0.32, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale=1}):Play()

    local bgImg = New("ImageLabel", {Size=UDim2.new(1,0,1,0), BackgroundTransparency=1, Image="rbxassetid://"..tostring(CurrentTheme.bgImageId), ImageTransparency=0, ImageColor3=Color3.new(1.55, 1.55, 1.55), ScaleType=Enum.ScaleType.Crop, ZIndex=1, Parent=win})
    corner(bgImg, S.rLg)
    local bgTint = New("ImageLabel", {Size=UDim2.new(1,0,1,0), BackgroundTransparency=1, Image="rbxassetid://5028857084", ImageColor3=C.accent, ImageTransparency=0.65, ScaleType=Enum.ScaleType.Crop, ZIndex=1, Parent=win})
    corner(bgTint, S.rLg)
    local bgOverlay = New("Frame", {Size=UDim2.new(1,0,1,0), BackgroundColor3=C.bg, BackgroundTransparency=0.36, BorderSizePixel=0, ZIndex=1, Parent=win})
    corner(bgOverlay, S.rLg)
    local bgOverlayGrad = Instance.new("UIGradient")
    bgOverlayGrad.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, C.accentDark), ColorSequenceKeypoint.new(0.5, C.bg), ColorSequenceKeypoint.new(1, C.purple)})
    bgOverlayGrad.Rotation = 45
    bgOverlayGrad.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0.0, 0.4), NumberSequenceKeypoint.new(0.5, 0.8), NumberSequenceKeypoint.new(1.0, 0.55)})
    bgOverlayGrad.Parent = bgOverlay

    local particles = New("Frame", {Size=UDim2.new(1,0,1,0), BackgroundTransparency=1, ClipsDescendants=true, Active=false, ZIndex=CONFIG.ParticleZIndex, Parent=win})
    if _settings.EventParticles ~= false and (CurrentTheme == THEMES.NewYear or CurrentTheme == THEMES.Halloween) then
        task.spawn(function()
            local snowId = "rbxassetid://95412477874814"
            local activeParticles = 0
            local isHalloweenParticles = CurrentTheme == THEMES.Halloween
            local maxParticles = isHalloweenParticles and 8 or 10
            while particles and particles.Parent and MainGui == sg do
                if _settings.EventParticles == false then break end
                if activeParticles < maxParticles then
                    activeParticles = activeParticles + 1
                    task.spawn(function()
                        local seasonal = CurrentTheme == THEMES.NewYear and "snow" or "spooky"
                        local p
                        if seasonal == "snow" then
                            p = New("ImageLabel", {Name="SeasonParticle", Size=UDim2.fromOffset(math.random(14,28),math.random(14,28)), Position=UDim2.new(math.random(),0,-0.08,0), BackgroundTransparency=1, Image=snowId, ImageTransparency=math.random(5,28)/100, Rotation=math.random(0,360), ZIndex=CONFIG.ParticleZIndex, Parent=particles})
                        else
                            local glyphs = {"🎃", "🍬", "🍭"}
                            p = New("TextLabel", {Name="SeasonParticle", Size=UDim2.fromOffset(math.random(16,24),math.random(16,24)), Position=UDim2.new(math.random(),0,-0.08,0), BackgroundTransparency=1, Text=glyphs[math.random(1,#glyphs)], TextSize=math.random(14,19), TextTransparency=math.random(8,22)/100, TextStrokeTransparency=0.72, ZIndex=CONFIG.ParticleZIndex, Parent=particles})
                        end
                        if p then
                            local duration = math.random(11,18)
                            local target = UDim2.new(math.clamp(p.Position.X.Scale + (math.random(-16,16)/100),0,1),0,1.12,0)
                            local tw = TweenS:Create(p, TweenInfo.new(duration, Enum.EasingStyle.Linear), {Position=target, Rotation=p.Rotation+math.random(90,270)})
                            tw:Play(); tw.Completed:Wait()
                            if p and p.Parent then p:Destroy() end
                        end
                        activeParticles = math.max(0, activeParticles - 1)
                    end)
                end
                task.wait(isHalloweenParticles and 0.28 or 0.14)
            end
        end)
    end
    local header = New("Frame", {Size=UDim2.new(1,0,0,S.headerH), BackgroundColor3=C.bgAlt, BackgroundTransparency=CONFIG.Transparency.header, BorderSizePixel=0, Parent=win, ZIndex=3})
    corner(header, S.rLg)
    New("Frame", {Size=UDim2.new(1,0,0,1), Position=UDim2.new(0,0,1,-1), BackgroundColor3=C.borderSoft, BackgroundTransparency=0.4, BorderSizePixel=0, Parent=header})
    local logoFrame = New("Frame", {Size=UDim2.new(0,38,0,38), Position=UDim2.new(0,12,0.5,-19), BackgroundColor3=C.card, BorderSizePixel=0, ZIndex=3, Parent=header, ClipsDescendants=true})
    corner(logoFrame, 10); gradStroke(logoFrame, C.accent, C.accentRose, 45, 1, 0.2)
    local logoImg = New("ImageLabel", {Size=UDim2.new(1,-4,1,-4), Position=UDim2.new(0,2,0,2), BackgroundTransparency=1, Image="rbxassetid://"..LOGO_ID, ScaleType=Enum.ScaleType.Crop, ZIndex=4, Parent=logoFrame})
    corner(logoImg, 8)

    local titleLbl = New("TextLabel", {
        Size=UDim2.new(1,-180,0,18), Position=UDim2.new(0,58,0,8),
        BackgroundTransparency=1, Text="SUNSET SISI • "..string.upper(CurrentTheme.name),
        TextColor3=Color3.new(1, 1, 1), Font=Enum.Font.GothamBold, TextSize=14,
        TextXAlignment=Enum.TextXAlignment.Left, ZIndex=4, Parent=header,
    })
    local titleOutline = Instance.new("UIStroke")
    titleOutline.Color = Color3.fromRGB(0, 0, 0)
    titleOutline.Thickness = 1.5; titleOutline.Transparency = 0.35
    titleOutline.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
    titleOutline.Parent = titleLbl
    local titleFillGrad = Instance.new("UIGradient")
    titleFillGrad.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0.00, Color3.fromHSV(0.55, 0.75, 1)),
        ColorSequenceKeypoint.new(0.20, Color3.fromHSV(0.65, 0.75, 1)),
        ColorSequenceKeypoint.new(0.40, Color3.fromHSV(0.80, 0.75, 1)),
        ColorSequenceKeypoint.new(0.60, Color3.fromHSV(0.93, 0.75, 1)),
        ColorSequenceKeypoint.new(0.80, Color3.fromHSV(0.05, 0.75, 1)),
        ColorSequenceKeypoint.new(1.00, Color3.fromHSV(0.55, 0.75, 1)),
    })
    titleFillGrad.Parent = titleLbl
    local titleScale = Instance.new("UIScale")
    titleScale.Scale = 1
    titleScale.Parent = titleLbl
    task.spawn(function()
        while sg.Parent and titleLbl.Parent do
            local grow = TweenS:Create(titleScale, TweenInfo.new(1.35, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Scale=1.035})
            local glow = TweenS:Create(titleOutline, TweenInfo.new(1.35, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Transparency=0.12, Thickness=2.1})
            grow:Play(); glow:Play(); grow.Completed:Wait()
            if not (sg.Parent and titleLbl.Parent) then break end
            local settle = TweenS:Create(titleScale, TweenInfo.new(1.35, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Scale=1})
            local dim = TweenS:Create(titleOutline, TweenInfo.new(1.35, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Transparency=0.38, Thickness=1.5})
            settle:Play(); dim:Play(); settle.Completed:Wait()
        end
    end)
    task.spawn(function()
        while sg.Parent do
            titleFillGrad.Offset = Vector2.new(-1, 0)
            local t = TweenS:Create(titleFillGrad, TweenInfo.new(3.2, Enum.EasingStyle.Linear), {Offset = Vector2.new(1, 0)})
            t:Play(); t.Completed:Wait(); task.wait(0.25)
        end
    end)
    New("TextLabel", {Size=UDim2.new(1,-180,0,12), Position=UDim2.new(0,58,0,27), BackgroundTransparency=1, Text="v"..VERSION_TAG.."  •  ✨  •  ".._hookStatus, TextColor3=C.sub, Font=Enum.Font.Gotham, TextSize=9, TextXAlignment=Enum.TextXAlignment.Left, ZIndex=3, Parent=header})
    local hb = makeBtn(header, {Size=UDim2.new(0,50,0,24), Position=UDim2.new(1,-60,0.5,-12), Text="HIDE", Font=Enum.Font.GothamBold, TextSize=9, ZIndex=3}, 5, "danger")
    hb.Activated:Connect(function()
        playSnd(SND.Click)
        for k in pairs(SAVE) do pcall(SAVE[k]) end
        sg.Enabled = false; notify("Sunset Sisi Top","RShift = toggle")
    end)
    local bodyTop = S.headerH + S.pad
    local bodyH = winH - bodyTop - 4
    local sidebar = New("Frame", {Size=UDim2.new(0,S.sidebarW,0,bodyH), Position=UDim2.new(0,S.pad,0,bodyTop), BackgroundColor3=C.bgAlt, BackgroundTransparency=CONFIG.Transparency.sidebar, BorderSizePixel=0, Parent=win, ZIndex=3})
    corner(sidebar, S.r); stroke(sidebar, C.borderSoft, 1, 0.35)
    local cX = S.pad + S.sidebarW + S.pad
    local cW = winW - cX - S.pad
    local cHolder = New("Frame", {Size=UDim2.new(0,cW,0,bodyH), Position=UDim2.new(0,cX,0,bodyTop), BackgroundColor3=C.bgAlt, BackgroundTransparency=CONFIG.Transparency.cHolder, BorderSizePixel=0, Parent=win, ZIndex=3})
    corner(cHolder, S.r); stroke(cHolder, C.borderSoft, 1, 0.35)
    local content = New("ScrollingFrame", {Size=UDim2.new(1,-S.contentPad*2,1,-S.contentPad*2), Position=UDim2.new(0,S.contentPad,0,S.contentPad), BackgroundTransparency=1, BorderSizePixel=0, Parent=cHolder, CanvasSize=UDim2.new(0,0,0,0), AutomaticCanvasSize=Enum.AutomaticSize.Y, ScrollingDirection=Enum.ScrollingDirection.Y, ScrollBarThickness=5, ScrollBarImageColor3=C.accent, ScrollBarImageTransparency=0.3, ElasticBehavior=Enum.ElasticBehavior.WhenScrollable, ZIndex=4})
    local ul = Instance.new("UIListLayout", content); ul.Padding=UDim.new(0,S.gap); ul.SortOrder=Enum.SortOrder.LayoutOrder
    local up = Instance.new("UIPadding", content); up.PaddingLeft=UDim.new(0,4); up.PaddingRight=UDim.new(0,4); up.PaddingTop=UDim.new(0,3); up.PaddingBottom=UDim.new(0,10)
    local tabs, pages = {}, {}
    local TAB_ORDER = {"NFT","CURR","BUFF","MAIL","SETTINGS","INFO"}
    local TAB_ICONS = {NFT="rbxassetid://92835421199871", CURR="rbxassetid://106906356643360", BUFF="rbxassetid://73298142408981", MAIL="rbxassetid://116909575223311", SETTINGS="rbxassetid://73975269431953", INFO="rbxassetid://121033438450739"}
    local n = #TAB_ORDER
    local avail = bodyH - 12 - (S.tabPad * (n - 1))
    local tabH = math.clamp(math.floor(avail / n), 38, 52)
    local totalTabsH = tabH * n + S.tabPad * (n - 1)
    local startY = math.max(6, math.floor((bodyH - totalTabsH) / 2))
    for i, key in ipairs(TAB_ORDER) do
        local y = startY + (i - 1) * (tabH + S.tabPad)
        local wrap = New("Frame", {Size=UDim2.new(1, -8, 0, tabH), Position=UDim2.new(0, 4, 0, y), BackgroundTransparency=1, Parent=sidebar})
        local b = New("TextButton", {Size=UDim2.new(1,0,1,0), BackgroundColor3=C.card, BackgroundTransparency=0.15, BorderSizePixel=0, Text="", AutoButtonColor=false, Parent=wrap, ZIndex=4})
        corner(b, S.r); stroke(b, C.borderSoft, 1, 0.35)
        local ic = New("ImageLabel", {Size=UDim2.new(1,-12,1,-12), Position=UDim2.new(0,6,0,6), BackgroundTransparency=1, Image=TAB_ICONS[key] or "", ScaleType=Enum.ScaleType.Fit, Parent=b})
        local badge, badgeLbl
        if key == "MAIL" then
            badge = New("Frame", {Size=UDim2.new(0,18,0,18), Position=UDim2.new(1,-6,0,-6), BackgroundColor3=C.red, BorderSizePixel=0, Visible=false, ZIndex=6, Parent=wrap})
            corner(badge, 9); stroke(badge, C.bgAlt, 2, 0)
            badgeLbl = New("TextLabel", {Size=UDim2.new(1,0,1,0), BackgroundTransparency=1, Text="0", TextColor3=C.text, Font=Enum.Font.GothamBold, TextSize=9, Parent=badge, ZIndex=7})
        end
        tabs[key] = {wrap=wrap, btn=b, icon=ic, badge=badge, badgeLbl=badgeLbl}
        local p = New("Frame", {Size=UDim2.new(1,0,0,0), AutomaticSize=Enum.AutomaticSize.Y, BackgroundTransparency=1, BorderSizePixel=0, LayoutOrder=i, Visible=false, Parent=content})
        local l = Instance.new("UIListLayout", p); l.FillDirection=Enum.FillDirection.Vertical; l.SortOrder=Enum.SortOrder.LayoutOrder; l.Padding=UDim.new(0,S.gap)
        pages[key] = p
    end
    local activeTab = nil
    local function setTab(key)
        if activeTab == key then return end
        activeTab = key
        for k, p in pairs(pages) do
            if k == key then
                p.Visible = true
                p.Position = UDim2.fromOffset(12, 0)
                local scale = p:FindFirstChild("TabEnterScale") or Instance.new("UIScale")
                scale.Name = "TabEnterScale"; scale.Scale = 0.985; scale.Parent = p
                TweenS:Create(p, TweenInfo.new(0.24, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position=UDim2.fromOffset(0,0)}):Play()
                TweenS:Create(scale, TweenInfo.new(0.24, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale=1}):Play()
            else
                p.Visible = false
            end
        end
        for k, t in pairs(tabs) do
            local a = (k==key)
            TweenS:Create(t.btn, TweenInfo.new(0.2, Enum.EasingStyle.Quint), {BackgroundColor3 = a and C.cardHover or C.card}):Play()
            TweenS:Create(t.icon, TweenInfo.new(0.2), {ImageTransparency = a and 0 or 0.24}):Play()
        end
        content.CanvasPosition = Vector2.new(0,0)
    end
    setTab("NFT")
    for k, t in pairs(tabs) do t.btn.Activated:Connect(function() setTab(k); playSnd(SND.Click) end) end
    local function updateMailBadge()
        local tab = tabs["MAIL"]; if not tab or not tab.badge then return end
        local pn = LP:GetAttribute("MailPending") or 0
        tab.badge.Visible = pn > 0
        tab.badgeLbl.Text = pn > 99 and "99+" or tostring(pn)
    end
    updateMailBadge()
    LP:GetAttributeChangedSignal("MailPending"):Connect(updateMailBadge)

    local THEME_KEY = _settings.Theme or "Halloween"
    if THEME_KEY ~= "Halloween" and THEME_KEY ~= "NewYear" then
        local PALETTE = {C.accent, C.purple, C.gold}
        local LEAF_IMGS = {74573765558950, 102296906709217}
        task.spawn(function()
            while sg.Parent do
                task.wait(math.random(math.floor(CONFIG.LeafSpawnMin*100), math.floor(CONFIG.LeafSpawnMax*100)) / 100)
                if not win.Visible then continue end
                local img = New("ImageLabel", {Size = UDim2.fromScale(math.random(6,14)/1000, math.random(6,14)/1000), Position = UDim2.fromScale(math.random(5,95)/100, 1.02), BackgroundTransparency = 1, Image = "rbxassetid://"..LEAF_IMGS[math.random(1,#LEAF_IMGS)], ImageColor3 = PALETTE[math.random(1,#PALETTE)], ImageTransparency = 0.55, Parent = particles, ZIndex = CONFIG.ParticleZIndex})
                local dur = math.random(70,120)/10
                TweenS:Create(img, TweenInfo.new(dur, Enum.EasingStyle.Sine), {Position = UDim2.fromScale(img.Position.X.Scale+(math.random()-0.5)*0.2, math.random()*0.35), ImageTransparency = 1}):Play()
                Debris:AddItem(img, dur+0.2)
            end
        end)
    end
    TweenS:Create(logoFrame, TweenInfo.new(2.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {Rotation=5}):Play()
    modalLayer = New("TextButton", {Name="ModalLayer", Size=UDim2.new(1,0,1,0), BackgroundColor3=Color3.new(0,0,0), BackgroundTransparency=0.55, BorderSizePixel=0, Text="", AutoButtonColor=false, Visible=false, ZIndex=1000, Parent=sg})
    modalStack = {}
    closeModal = function() local t = table.remove(modalStack); if t and t.destroy then pcall(t.destroy) end; modalLayer.Visible = #modalStack > 0 end
    modalLayer.MouseButton1Click:Connect(function() if #modalStack > 0 then closeModal() end end)
    openModal = function(cfg)
        -- Match the user's reference script: NFT selection is a searchable vertical row list, never a tile grid.
        cfg = cfg or {}
        cfg.grid = false
        while #modalStack > 0 do closeModal() end
        local cam = workspace.CurrentCamera
        local vp = cam and cam.ViewportSize or Vector2.new(1280,720)
        local sc = scale.Scale or 1
        local cw = math.min(CONFIG.ModalMaxWidth, vp.X/sc-24)
        local ch = math.min(CONFIG.ModalMaxHeight, vp.Y/sc-24)
        local card = New("Frame", {Size = UDim2.new(0, cw, 0, ch), Position = UDim2.new(0.5, 0, 0.1, 0), AnchorPoint = Vector2.new(0.5, 0), BackgroundColor3 = C.bg, BackgroundTransparency = 0.1, BorderSizePixel = 0, Active = true, Draggable = true, ZIndex = 1001, Parent = modalLayer})
        corner(card, 10); stroke(card, C.borderSoft, 1, 0.25)
        local mScale = Instance.new("UIScale", card); mScale.Scale = 0.9
        TweenS:Create(mScale, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale=1}):Play()
        local headH = 46
        local mHead = New("Frame", {Size = UDim2.new(1, 0, 0, headH), BackgroundColor3 = C.bgAlt, BackgroundTransparency = 0.15, BorderSizePixel = 0, Active = true, ZIndex = 1002, Parent = card})
        corner(mHead, 10)
        local hSep = New("Frame", {Size=UDim2.new(1,0,0,1), Position=UDim2.new(0,0,1,-1), BackgroundColor3=C.borderSoft, BorderSizePixel=0, Parent=mHead})
        local hSepGrad = Instance.new("UIGradient"); hSepGrad.Color = ColorSequence.new(C.accent, C.purple)
        hSepGrad.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5, 0.3), NumberSequenceKeypoint.new(1, 1)})
        hSepGrad.Parent = hSep
        New("TextLabel", {Size = UDim2.new(1, -100, 0, 16), Position = UDim2.new(0, 14, 0, 8), BackgroundTransparency = 1, Text = cfg.title or "Select", TextColor3 = C.text, Font = Enum.Font.GothamBold, TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 1003, Parent = card})
        local countLbl = New("TextLabel", {Size = UDim2.new(1, -100, 0, 12), Position = UDim2.new(0, 14, 0, 24), BackgroundTransparency = 1, Text = "", TextColor3 = C.sub, Font = Enum.Font.Gotham, TextSize = 8, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 1003, Parent = card})
        local cb = makeBtn(card, {Size = UDim2.new(0, 26, 0, 26), Position = UDim2.new(1, -34, 0, 10), Text = "✕", Font = Enum.Font.GothamBold, TextSize = 12, ZIndex = 1003}, 6, "danger")
        cb.Activated:Connect(closeModal)
        local searchFrame = New("Frame", {Size = UDim2.new(1, -24, 0, 28), Position = UDim2.new(0, 12, 0, headH + 6), BackgroundColor3 = C.input, BackgroundTransparency = 0.15, BorderSizePixel = 0, ZIndex = 1003, Parent = card})
        corner(searchFrame, S.r); stroke(searchFrame, C.borderSoft, 1, 0.35)
        local sr = New("TextBox", {Size = UDim2.new(1, -16, 1, 0), Position = UDim2.new(0, 8, 0, 0), BackgroundTransparency = 1, Text = "", TextColor3 = C.text, PlaceholderColor3 = C.muted, Font = Enum.Font.Gotham, TextSize = 10, ClearTextOnFocus = false, PlaceholderText = "Search...", TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 1004, Parent = searchFrame})
        local listTop = headH + 6 + 28 + 8
        local listH = cfg.multi and (ch - listTop - 14 - 46) or (ch - listTop - 14)
        local scroll = New("ScrollingFrame", {Size = UDim2.new(1, -20, 0, listH), Position = UDim2.new(0, 10, 0, listTop), BackgroundTransparency = 1, BorderSizePixel = 0, ScrollBarThickness = 5, ScrollBarImageColor3 = C.accent, ScrollBarImageTransparency = 0.2, CanvasSize = UDim2.new(0, 0, 0, 0), AutomaticCanvasSize = Enum.AutomaticSize.Y, ZIndex = 1002, Parent = card})
        local sl2
        local gridCellW = 0
        if cfg.grid then
            local cols = (cw >= 360) and 3 or 2
            gridCellW = math.max(88, math.floor((cw - 40 - (cols - 1) * 6) / cols))
            sl2 = Instance.new("UIGridLayout", scroll)
            sl2.CellSize = UDim2.new(0, gridCellW, 0, 116)
            sl2.CellPadding = UDim2.new(0, 6, 0, 6)
            sl2.SortOrder = Enum.SortOrder.LayoutOrder
        else
            sl2 = Instance.new("UIListLayout", scroll)
            sl2.Padding = UDim.new(0, 5); sl2.SortOrder = Enum.SortOrder.LayoutOrder
        end
        local multiSelected = {}
        local maxTotalSelected = math.max(1, math.floor(tonumber(cfg.maxTotal) or 999999))
        if cfg.multi and cfg.initialSelected then
            local initialTotal = 0
            for _, entry in ipairs(cfg.initialSelected) do
                local name = type(entry) == "string" and entry or (type(entry) == "table" and entry.name)
                local requested = type(entry) == "table" and tonumber(entry.count) or 1
                requested = math.max(0, math.floor(requested or 0))
                local accepted = math.min(requested, math.max(0, maxTotalSelected - initialTotal))
                if name and accepted > 0 then multiSelected[name] = accepted; initialTotal = initialTotal + accepted end
                if initialTotal >= maxTotalSelected then break end
            end
        end
        local getMaxQty = cfg.getMaxQuantity or function() return cfg.maxQuantity or CONFIG.PickerMaxPerItem end
        local CHUNK = CONFIG.PickerChunkSize
        local filtered, renderedCount, rendering, rows, destroyed = {}, 0, false, {}, false
        local function countTotalSelected() local sum = 0; for _, c in pairs(multiSelected) do sum = sum + (c or 0) end; return sum end
        local updateBtnCountRef = nil
        local function updateCounter()
            if cfg.multi then countLbl.Text = string.format("%d items selected", countTotalSelected())
            else countLbl.Text = string.format("%d items", #filtered) end
        end
        if cfg.multi then
            local confirmBar = New("Frame", {Size = UDim2.new(1, -24, 0, 40), Position = UDim2.new(0, 12, 1, -48), BackgroundColor3 = C.bgAlt, BackgroundTransparency = 0.15, BorderSizePixel = 0, ZIndex = 1003, Parent = card})
            corner(confirmBar, S.r); stroke(confirmBar, C.borderSoft, 1, 0.35)
            local cntLbl = New("TextLabel", {Size = UDim2.new(0.5, -16, 1, 0), Position = UDim2.new(0, 10, 0, 0), BackgroundTransparency = 1, Text = "", TextColor3 = C.text, Font = Enum.Font.GothamBold, TextSize = 9, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 1004, Parent = confirmBar})
            local confirmBtn = makeBtn(confirmBar, {Size = UDim2.new(0, 110, 0, 28), Position = UDim2.new(1, -116, 0.5, -14), Text = "APPLY", Font = Enum.Font.GothamBold, TextSize = 9, ZIndex = 1004}, 5, "success")
            local function updateBtnCount() cntLbl.Text = string.format("%d selected", countTotalSelected()) end
            updateBtnCountRef = updateBtnCount
            confirmBtn.Activated:Connect(function()
                local picked = {}
                for _, it in ipairs(cfg.items or {}) do
                    local q = multiSelected[it.name] or 0
                    if q > 0 then table.insert(picked, {item=it, count=q}) end
                end
                closeModal(); if cfg.onPickMulti then pcall(cfg.onPickMulti, picked) end
            end)
            updateBtnCount()
        end
        -- Resolve the six requested menu images directly from this game's Info.Gifts.
        local MENU_IMAGE_SOURCE_KEYS = {
            ["Pin Cursed"]="TG Pin (Cursed)", ["TG Pin (Cursed)"]="TG Pin (Cursed)",
            ["Pin Christmas"]="Telegram Pin (Christmas)", ["Telegram Pin (Christmas)"]="Telegram Pin (Christmas)",
            ["Pin Fracture"]="TG Pin (Fracture)", ["TG Pin (Fracture)"]="TG Pin (Fracture)",
            ["Pin Ruby"]="TG Pin (Ruby)", ["TG Pin (Ruby)"]="TG Pin (Ruby)",
            ["Pin Halloween"]="TG Pin (Halloween)", ["TG Pin (Halloween)"]="TG Pin (Halloween)",
            ["Bear Natsuki"]="Toy Bear (Natsuki)", ["Toy Bear (Natsuki)"]="Toy Bear (Natsuki)",
        }
        local function resolveMenuImage(itemName, itemDisplay, item)
            -- Resolve the requested canonical Info.Gifts entry before generic item data.
            -- This handles both short display aliases and the game's internal NFT names.
            local sourceKey = MENU_IMAGE_SOURCE_KEYS[itemName] or MENU_IMAGE_SOURCE_KEYS[itemDisplay]
            local sourceData = sourceKey and Info.Gifts and rawget(Info.Gifts, sourceKey)
            local sourceImage = sourceData and tonumber(sourceData.Image)
            if sourceImage and sourceImage > 0 then return "rbxassetid://"..tostring(sourceImage) end
            local directData = Info.Gifts and rawget(Info.Gifts, itemName)
            local directImage = directData and tonumber(directData.Image)
            if directImage and directImage > 0 then return "rbxassetid://"..tostring(directImage) end
            local supplied = item.image or item.Image
            if type(supplied) == "number" then return supplied > 0 and ("rbxassetid://"..tostring(supplied)) or nil end
            if type(supplied) == "string" and supplied ~= "" then
                return supplied:find("rbxassetid://", 1, true) == 1 and supplied or ("rbxassetid://"..supplied)
            end
            local giftData = Info.Gifts and Info.Gifts[itemName]
            local giftImage = giftData and tonumber(giftData.Image)
            if giftImage and giftImage > 0 then return "rbxassetid://"..tostring(giftImage) end
            return nil
        end
        local function buildRow(item, order)
            local itemName = tostring(item.name or item.Name or "")
            local itemDisplay = tostring(item.display or item.displayName or item.DisplayName or itemName)
            local itemImage = resolveMenuImage(itemName, itemDisplay, item)
            local curQty = multiSelected[item.name] or 0
            local sel = curQty > 0
            local tileH = cfg.grid and 116 or CONFIG.ModalRowHeight
            local b = New("TextButton", {Size = cfg.grid and UDim2.new(0, gridCellW, 0, tileH) or UDim2.new(1, 0, 0, tileH), BackgroundColor3 = sel and C.cardHover or C.card, BackgroundTransparency = 0.1, BorderSizePixel = 0, AutoButtonColor = false, Text = "", LayoutOrder = order, Parent = scroll, ZIndex = 1003})
            corner(b, S.r)
            local st = stroke(b, sel and C.accent or C.borderSoft, sel and 1.5 or 1, sel and 0.2 or 0.4)
            local tileScale = cfg.grid and Instance.new("UIScale") or nil
            if tileScale then tileScale.Scale = 1; tileScale.Parent = b end
            local pw
            if cfg.grid then
                pw = New("Frame", {Size=UDim2.fromOffset(48,48), Position=UDim2.new(0.5,-24,0,6), BackgroundColor3=C.bg, BorderSizePixel=0, Parent=b, ZIndex=1004})
            else
                pw = New("Frame", {Size=UDim2.new(0,40,0,40), Position=UDim2.new(0,6,0.5,-20), BackgroundColor3=C.bg, BorderSizePixel=0, Parent=b, ZIndex=1004})
            end
            corner(pw, S.rSm)
            if itemImage then New("ImageLabel", {Size = UDim2.new(1, -4, 1, -4), Position = UDim2.new(0, 2, 0, 2), BackgroundTransparency = 1, Image = itemImage, ScaleType = Enum.ScaleType.Fit, Parent = pw, ZIndex = 1004})
            elseif item.bgColor then New("Frame", {Size = UDim2.new(1, -4, 1, -4), Position = UDim2.new(0, 2, 0, 2), BackgroundColor3 = item.bgColor, BorderSizePixel = 0, Parent = pw, ZIndex = 1004}) end
            local rightArea = cfg.multi and 84 or 20
            if cfg.grid then
                New("TextLabel", {Size=UDim2.new(1,-8,0,24), Position=UDim2.new(0,4,0,57), BackgroundTransparency=1, Text=item.display or item.name, TextColor3=C.text, Font=Enum.Font.GothamBold, TextSize=8, TextWrapped=true, TextXAlignment=Enum.TextXAlignment.Center, TextYAlignment=Enum.TextYAlignment.Center, Parent=b, ZIndex=1004})
                if item.price then New("TextLabel", {Size=UDim2.new(1,-8,0,12), Position=UDim2.new(0,4,0,81), BackgroundTransparency=1, Text="⭐ "..item.price, TextColor3=C.gold, Font=Enum.Font.GothamBold, TextSize=8, TextXAlignment=Enum.TextXAlignment.Center, Parent=b, ZIndex=1004}) end
            else
                New("TextLabel", {Size = UDim2.new(1, -rightArea - 60, 0, 16), Position = UDim2.new(0, 52, 0, 10), BackgroundTransparency = 1, Text = item.display or item.name, TextColor3 = C.text, Font = Enum.Font.GothamBold, TextSize = 10, TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = b, ZIndex = 1004})
                if item.price then New("TextLabel", {Size = UDim2.new(1, -rightArea - 60, 0, 12), Position = UDim2.new(0, 52, 0, 26), BackgroundTransparency = 1, Text = "⭐ " .. item.price, TextColor3 = C.gold, Font = Enum.Font.GothamBold, TextSize = 9, TextXAlignment = Enum.TextXAlignment.Left, Parent = b, ZIndex = 1004}) end
            end
            if cfg.multi then
                local function getFreshMax()
                    local m = getMaxQty(item)
                    if type(m) ~= "number" or m ~= m or m == math.huge then m = CONFIG.PickerMaxPerItem end
                    m = math.floor(m); if m < 1 then m = 1 end
                    return m
                end
                local minusPos = cfg.grid and UDim2.new(0, 8, 1, -28) or UDim2.new(1, -84, 0.5, -11)
                local countPos = cfg.grid and UDim2.new(0.5, -14, 1, -28) or UDim2.new(1, -58, 0.5, -11)
                local plusPos = cfg.grid and UDim2.new(1, -30, 1, -28) or UDim2.new(1, -28, 0.5, -11)
                local minusBtn = New("TextButton", {Size = UDim2.new(0, 22, 0, 22), Position = minusPos, BackgroundColor3 = C.input, BorderSizePixel = 0, AutoButtonColor = false, Text = "-", TextColor3 = C.text, Font = Enum.Font.GothamBold, TextSize = 14, Parent = b, ZIndex = 1005})
                corner(minusBtn, 4); stroke(minusBtn, C.borderSoft, 1, 0.4)
                local countLbl2 = New("TextLabel", {Size = UDim2.new(0, 28, 0, 22), Position = countPos, BackgroundColor3 = C.input, BorderSizePixel = 0, Text = tostring(curQty), TextColor3 = sel and C.gold or C.muted, Font = Enum.Font.GothamBold, TextSize = 11, Parent = b, ZIndex = 1004})
                corner(countLbl2, 4); stroke(countLbl2, C.borderSoft, 1, 0.4)
                local plusBtn = New("TextButton", {Size = UDim2.new(0, 22, 0, 22), Position = plusPos, BackgroundColor3 = C.input, BorderSizePixel = 0, AutoButtonColor = false, Text = "+", TextColor3 = C.text, Font = Enum.Font.GothamBold, TextSize = 14, Parent = b, ZIndex = 1005})
                corner(plusBtn, 4); stroke(plusBtn, C.borderSoft, 1, 0.4)
                local function refreshRow()
                    local q = multiSelected[item.name] or 0
                    local isSel = q > 0
                    countLbl2.Text = tostring(q)
                    countLbl2.TextColor3 = isSel and C.gold or C.muted
                    TweenS:Create(b, TweenInfo.new(0.15), {BackgroundColor3 = isSel and C.cardHover or C.card}):Play()
                    TweenS:Create(st, TweenInfo.new(0.15), {Color = isSel and C.accent or C.borderSoft, Transparency = isSel and 0.2 or 0.4, Thickness = isSel and 1.5 or 1}):Play()
                    if tileScale then
                        tileScale.Scale = 0.96
                        TweenS:Create(tileScale, TweenInfo.new(0.18, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale=1}):Play()
                    end
                    TweenS:Create(countLbl2, TweenInfo.new(0.1), {TextColor3=isSel and C.gold or C.muted}):Play()
                end
                local lastQtyTap = 0
                local function changeQty(delta)
                    local now = os.clock()
                    if now - lastQtyTap < 0.09 then return end
                    lastQtyTap = now
                    local cur = multiSelected[item.name] or 0
                    local remainingForThis = math.max(0, maxTotalSelected - (countTotalSelected() - cur))
                    local nextQty = math.clamp(cur + delta, 0, math.min(getFreshMax(), remainingForThis))
                    if nextQty == cur then playSnd(SND.Error); return end
                    multiSelected[item.name] = nextQty > 0 and nextQty or nil
                    refreshRow(); updateCounter(); playSnd(SND.Click)
                    if updateBtnCountRef then updateBtnCountRef() end
                end
                minusBtn.Activated:Connect(function() changeQty(-1) end)
                plusBtn.Activated:Connect(function() changeQty(1) end)
            else
                b.MouseButton1Click:Connect(function() closeModal(); if cfg.onPick then pcall(cfg.onPick, item) end end)
                b.MouseEnter:Connect(function() TweenS:Create(b, TweenInfo.new(0.12), {BackgroundColor3=C.cardHover}):Play() end)
                b.MouseLeave:Connect(function() TweenS:Create(b, TweenInfo.new(0.12), {BackgroundColor3=C.card}):Play() end)
            end
            table.insert(rows, b); return b
        end
        local function renderNextChunk()
            if destroyed or rendering then return end
            if renderedCount >= #filtered then return end
            rendering = true
            local target = math.min(renderedCount + CHUNK, #filtered)
            for i = renderedCount + 1, target do buildRow(filtered[i], i) end
            renderedCount = target; rendering = false
            updateCounter()
        end
        local function checkLoadMore()
            if destroyed or rendering then return end
            if renderedCount >= #filtered then return end
            local viewY = scroll.AbsoluteSize.Y
            if viewY <= 0 then return end
            if scroll.CanvasPosition.Y + viewY >= scroll.AbsoluteCanvasSize.Y - 300 then
                local prev = renderedCount; renderNextChunk()
                if renderedCount > prev then task.defer(checkLoadMore) end
            end
        end
        local function clearAll()
            for _, r in ipairs(rows) do pcall(function() r:Destroy() end) end
            rows = {}; renderedCount = 0
        end
        local function applyFilter(text)
            text = (text or ""):lower()
            filtered = {}
            for _, item in ipairs(cfg.items or {}) do
                if text == "" then table.insert(filtered, item)
                else
                    local name = item.name or ""
                    local disp = item.display or name
                    if name:lower():find(text, 1, true) or disp:lower():find(text, 1, true) then table.insert(filtered, item) end
                end
            end
            clearAll(); updateCounter(); renderNextChunk(); task.defer(checkLoadMore)
        end
        scroll:GetPropertyChangedSignal("CanvasPosition"):Connect(checkLoadMore)
        scroll:GetPropertyChangedSignal("AbsoluteCanvasSize"):Connect(checkLoadMore)
        sr:GetPropertyChangedSignal("Text"):Connect(function() applyFilter(sr.Text) end)
        applyFilter("")
        modalLayer.Visible = true
        table.insert(modalStack, {destroy = function() destroyed = true; pcall(function() card:Destroy() end) end})
    end
    local giftItems = {}
    for name, data in pairs(Info.Gifts) do
        if type(data) == "table" and not data.Hidden and tonumber(data.Image) then
            table.insert(giftItems, {name=name, display=data.DisplayName or name, image="rbxassetid://"..tostring(data.Image), price=num(data.Price or 0)})
        end
    end
    table.sort(giftItems, function(a,b) return (Info.Gifts[a.name].Price or 0) > (Info.Gifts[b.name].Price or 0) end)
    local patItems = {}
    for n, id in pairs(Info.Patterns or {}) do table.insert(patItems, {name=n, display=n, image="rbxassetid://"..tostring(id)}) end
    table.sort(patItems, function(a,b) return a.name < b.name end)
    local bdItems = {}
    for n, col in pairs(Info.Backdrops or {}) do table.insert(bdItems, {name=n, display=n, bgColor=col}) end
    table.sort(bdItems, function(a,b) return a.name < b.name end)
    local function makePickerRow(parent, order, config)
        local row = New("Frame", {Size=UDim2.new(1,0,0,44), BackgroundColor3=C.card, BackgroundTransparency=0.1, BorderSizePixel=0, LayoutOrder=order, Parent=parent})
        corner(row, S.r); stroke(row, C.borderSoft, 1, 0.4)
        local preview = New("ImageLabel", {Size=UDim2.new(0,32,0,32), Position=UDim2.new(0,6,0.5,-16), BackgroundColor3=C.input, BorderSizePixel=0, Image="rbxasset://textures/ui/GuiImagePlaceholder.png", ScaleType=Enum.ScaleType.Fit, Parent=row})
        corner(preview, S.rSm)
        local lbl = New("TextLabel", {Size=UDim2.new(1,-(6+32+6+66+8),1,0), Position=UDim2.new(0,44,0,0), BackgroundTransparency=1, Text=config.emptyText or "— Select —", TextColor3=C.text, Font=Enum.Font.GothamBold, TextSize=10, TextXAlignment=Enum.TextXAlignment.Left, TextTruncate=Enum.TextTruncate.AtEnd, Parent=row})
        local btn = makeBtn(row, {Size=UDim2.new(0,60,0,26), Position=UDim2.new(1,-66,0.5,-13), Text="SELECT", Font=Enum.Font.GothamBold, TextSize=9}, 4, "primary")
        local function setSelection(giftName)
            local gi = giftName and Info.Gifts[giftName] or nil
            if not gi then
                preview.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
                lbl.Text = config.emptyText or "— Select —"; row.BackgroundColor3 = C.card
            else
                preview.Image = "rbxassetid://"..tostring(gi.Image or 0)
                lbl.Text = (gi.DisplayName or giftName).."   ⭐ "..num(gi.Price or 0); row.BackgroundColor3 = C.cardHover
            end
        end
        btn.Activated:Connect(function()
            openModal({title=config.title or "Select", items=config.items or giftItems, isSelected=function(it) return config.getSelected and config.getSelected() == it.name end, onPick=function(it) setSelection(it.name); if config.onPick then pcall(config.onPick, it) end end})
        end)
        return {row=row, preview=preview, label=lbl, btn=btn, setSelection=setSelection}
    end
    local function makeChipDisplay(parent, order, getList, removeFn, height)
        local frame = New("Frame", {Size=UDim2.new(1,0,0,height or 42), BackgroundColor3=C.input, BackgroundTransparency=0.15, BorderSizePixel=0, LayoutOrder=order, Parent=parent})
        corner(frame, S.r); stroke(frame, C.borderSoft, 1, 0.4)
        local scroll = New("ScrollingFrame", {Size=UDim2.new(1,-8,1,-8), Position=UDim2.new(0,4,0,4), BackgroundTransparency=1, BorderSizePixel=0, ScrollBarThickness=3, ScrollBarImageColor3=C.accent, CanvasSize=UDim2.new(0,0,0,0), AutomaticCanvasSize=Enum.AutomaticSize.X, ScrollingDirection=Enum.ScrollingDirection.X, Parent=frame})
        local lay = Instance.new("UIListLayout", scroll); lay.FillDirection=Enum.FillDirection.Horizontal; lay.Padding=UDim.new(0,4); lay.VerticalAlignment=Enum.VerticalAlignment.Center
        local function refresh()
            for _, c in ipairs(scroll:GetChildren()) do if c:IsA("TextButton") or c:IsA("TextLabel") or c:IsA("Frame") or c:IsA("ImageLabel") then c:Destroy() end end
            local list = getList()
            if #list == 0 then New("TextLabel", {Size=UDim2.new(0,220,1,0), BackgroundTransparency=1, Text="— Nothing selected —", TextColor3=C.muted, Font=Enum.Font.Gotham, TextSize=9, TextXAlignment=Enum.TextXAlignment.Left, Parent=scroll}); return end
            local expanded = {}
            for _, entry in ipairs(list) do
                local name, count
                if type(entry) == "string" then name = entry; count = 1
                else name = entry.name; count = entry.count or 1 end
                for _ = 1, count do table.insert(expanded, name) end
            end
            for i, name in ipairs(expanded) do
                local g = Info.Gifts[name]
                local chip = New("TextButton", {Size = UDim2.new(0, 30, 0, 30), BackgroundColor3 = C.card, BorderSizePixel = 0, AutoButtonColor = false, Text = "", LayoutOrder = i, Parent = scroll})
                corner(chip, S.rSm); stroke(chip, C.borderSoft, 1, 0.4)
                if g then New("ImageLabel", {Size = UDim2.new(1,-4,1,-4), Position = UDim2.new(0,2,0,2), BackgroundTransparency = 1, Image = "rbxassetid://"..tostring(g.Image or 0), ScaleType = Enum.ScaleType.Fit, Parent = chip}) end
                chip.MouseEnter:Connect(function() TweenS:Create(chip, TweenInfo.new(0.12), {BackgroundColor3=C.red}):Play() end)
                chip.MouseLeave:Connect(function() TweenS:Create(chip, TweenInfo.new(0.12), {BackgroundColor3=C.card}):Play() end)
                chip.Activated:Connect(function() removeFn(name, 1); refresh(); playSnd(SND.Click) end)
            end
        end
        refresh(); return refresh
    end

    local nftPage = pages["NFT"]
    local selectedGift, uniqueOn, selPattern, selBackdrop, customNum = nil, false, nil, nil, ""
    sectionT(nftPage, "SELECT NFT", 1)
    makePickerRow(nftPage, 2, {emptyText="— Select NFT —", title="Select NFT", getSelected=function() return selectedGift end, onPick=function(it) selectedGift = it.name end})
    sectionT(nftPage, "ATTRS", 10)
    local uRow = New("Frame", {Size=UDim2.new(1,0,0,28), BackgroundColor3=C.card, BackgroundTransparency=0.1, BorderSizePixel=0, LayoutOrder=11, Parent=nftPage})
    corner(uRow, S.r); stroke(uRow, C.borderSoft, 1, 0.4)
    New("TextLabel", {Size=UDim2.new(1,-60,1,0), Position=UDim2.new(0,10,0,0), BackgroundTransparency=1, Text="Unique NFT", TextColor3=C.text, Font=Enum.Font.GothamBold, TextSize=10, TextXAlignment=Enum.TextXAlignment.Left, Parent=uRow})
    local uW = New("Frame", {Size=UDim2.new(0,38,0,20), Position=UDim2.new(1,-50,0.5,-10), BackgroundTransparency=1, Parent=uRow})
    makeTog(uW, false, function(s) uniqueOn = s end)
    local pbR = New("Frame", {Size=UDim2.new(1,0,0,28), BackgroundTransparency=1, LayoutOrder=12, Parent=nftPage})
    local pbL = Instance.new("UIListLayout", pbR); pbL.FillDirection=Enum.FillDirection.Horizontal; pbL.Padding=UDim.new(0,S.gap)
    local patBtn = makeBtn(pbR, {Size=UDim2.new(0.5,-S.gap/2,1,0), Text="Pattern", Font=Enum.Font.GothamBold, TextSize=10, LayoutOrder=1}, 4, "purple")
    local bdBtn = makeBtn(pbR, {Size=UDim2.new(0.5,-S.gap/2,1,0), Text="Backdrop", Font=Enum.Font.GothamBold, TextSize=10, LayoutOrder=2}, 4, "purple")
    patBtn.Activated:Connect(function() openModal({title="Pattern", items=patItems, isSelected=function(it) return selPattern==it.name end, onPick=function(it) selPattern=it.name; patBtn.Text=it.name:sub(1,12) end}) end)
    bdBtn.Activated:Connect(function() openModal({title="Backdrop", items=bdItems, isSelected=function(it) return selBackdrop==it.name end, onPick=function(it) selBackdrop=it.name; bdBtn.Text=it.name:sub(1,12) end}) end)
    local numR = New("Frame", {Size=UDim2.new(1,0,0,28), BackgroundColor3=C.card, BackgroundTransparency=0.1, BorderSizePixel=0, LayoutOrder=13, Parent=nftPage})
    corner(numR, S.r); stroke(numR, C.borderSoft, 1, 0.4)
    New("TextLabel", {Size=UDim2.new(0.5,-10,1,0), Position=UDim2.new(0,10,0,0), BackgroundTransparency=1, Text="Custom #", TextColor3=C.text, Font=Enum.Font.GothamBold, TextSize=10, TextXAlignment=Enum.TextXAlignment.Left, Parent=numR})
    local numBox = makeField(numR, {Size=UDim2.new(0,120,0,22), Position=UDim2.new(1,-130,0.5,-11), PlaceholderText="auto", TextSize=10}, 4)
    numBox.FocusLost:Connect(function() local raw = (numBox.Text or ""):gsub("^%s+",""):gsub("%s+$","") if raw ~= "" then customNum = normNum(raw); numBox.Text = customNum else customNum = "" end end)
    local addR = New("Frame", {Size=UDim2.new(1,0,0,30), BackgroundTransparency=1, LayoutOrder=14, Parent=nftPage})
    local aL = Instance.new("UIListLayout", addR); aL.FillDirection=Enum.FillDirection.Horizontal; aL.Padding=UDim.new(0,S.gap)
    local function buildOpts() local o = {isUnique=uniqueOn, pattern=selPattern, backdrop=selBackdrop} if customNum ~= "" then o.number = customNum end return o end
    local add1 = makeBtn(addR, {Size=UDim2.new(0.5,-S.gap/2,1,0), Text="+ 1", Font=Enum.Font.GothamBold, TextSize=11, LayoutOrder=1}, 4, "success")
    local add5 = makeBtn(addR, {Size=UDim2.new(0.5,-S.gap/2,1,0), Text="+ 5", Font=Enum.Font.GothamBold, TextSize=11, LayoutOrder=2}, 4, "primary")
    add1.Activated:Connect(function() if not selectedGift then playSnd(SND.Error); return end; if spawnNFT(selectedGift, buildOpts()) then playSnd(SND.Coins) end end)
    add5.Activated:Connect(function() if not selectedGift then playSnd(SND.Error); return end; for _=1,5 do spawnNFT(selectedGift, buildOpts()) end; playSnd(SND.Coins) end)
    sectionT(nftPage, "INVENTORY", 20)
    local invScroll = New("ScrollingFrame", {Size=UDim2.new(1,0,0,240), BackgroundColor3=C.input, BackgroundTransparency=0.15, BorderSizePixel=0, CanvasSize=UDim2.new(0,0,0,0), AutomaticCanvasSize=Enum.AutomaticSize.Y, ScrollBarThickness=5, ScrollBarImageColor3=C.accent, LayoutOrder=21, Parent=nftPage})
    corner(invScroll, S.r); stroke(invScroll, C.borderSoft, 1, 0.4)
    local il = Instance.new("UIListLayout", invScroll); il.Padding=UDim.new(0,3)
    local ip = Instance.new("UIPadding", invScroll); ip.PaddingLeft=UDim.new(0,5); ip.PaddingRight=UDim.new(0,5); ip.PaddingTop=UDim.new(0,5); ip.PaddingBottom=UDim.new(0,5)
    local invRows = {}; local INV_LIMIT = 100
    local function refreshInv()
        for _, c in ipairs(invRows) do pcall(function() c:Destroy() end) end
        invRows = {}
        local items = {}
        for _, it in ipairs(_Inv:GetChildren()) do
            local g = Info.Gifts[it.Name]
            if g then table.insert(items, {inst=it, price=g.Price or 0, disp=g.DisplayName or it.Name, uq=it:GetAttribute("Unique"), fav=it:GetAttribute("Favorite"), backdrop=it:GetAttribute("Backdrop"), pattern=it:GetAttribute("Pattern"), number=it:GetAttribute("Number")}) end
        end
        table.sort(items, function(a,b) return a.price>b.price end)
        for i = 1, math.min(INV_LIMIT, #items) do
            local item = items[i]
            local bgCol = C.card
            if item.uq and item.backdrop and Info.Backdrops and Info.Backdrops[item.backdrop] then bgCol = Info.Backdrops[item.backdrop]:Lerp(C.card, 0.35) end
            local row = New("Frame", {Size = UDim2.new(1,0,0,36), BackgroundColor3 = bgCol, BackgroundTransparency = 0.1, BorderSizePixel = 0, LayoutOrder = i, Parent = invScroll})
            corner(row, S.rSm)
            local g = Info.Gifts[item.inst.Name]
            local pw = New("Frame", {Size=UDim2.new(0,30,0,30), Position=UDim2.new(0,3,0.5,-15), BackgroundColor3=C.bg, BorderSizePixel=0, Parent=row})
            corner(pw, S.rSm)
            New("ImageLabel", {Size=UDim2.new(1,-4,1,-4), Position=UDim2.new(0,2,0,2), BackgroundTransparency=1, Image="rbxassetid://"..tostring(g.Image or 0), ScaleType=Enum.ScaleType.Fit, Parent=pw})
            local titleText = (item.fav and "★ " or "") .. item.disp
            if item.uq then titleText = titleText .. "  [" .. tostring(item.backdrop or "?") .. " | " .. tostring(item.pattern or "?") .. "]" end
            New("TextLabel", {Size=UDim2.new(1,-80,0,14), Position=UDim2.new(0,38,0,4), BackgroundTransparency=1, Text=titleText, TextColor3=C.text, Font=Enum.Font.GothamBold, TextSize=10, TextXAlignment=Enum.TextXAlignment.Left, TextTruncate=Enum.TextTruncate.AtEnd, Parent=row})
            New("TextLabel", {Size=UDim2.new(1,-80,0,12), Position=UDim2.new(0,38,0,19), BackgroundTransparency=1, Text="⭐ "..num(item.price)..(item.uq and (" • "..tostring(item.number or "")) or ""), TextColor3=C.gold, Font=Enum.Font.GothamBold, TextSize=9, TextXAlignment=Enum.TextXAlignment.Left, Parent=row})
            -- Use the exact in-game delete icon supplied by the user.
            local del = New("ImageButton", {Name="DeleteNFT", Size=UDim2.new(0,27,0,27), Position=UDim2.new(1,-32,0.5,-13.5), BackgroundColor3=Color3.fromRGB(190,12,28), BorderSizePixel=0, AutoButtonColor=true, Image="rbxassetid://97377886518526", ImageColor3=Color3.new(1,1,1), ScaleType=Enum.ScaleType.Fit, Parent=row})
            corner(del, 8)
            gradient2(del, Color3.fromRGB(255,65,75), Color3.fromRGB(178,8,24), 90)
            stroke(del, Color3.fromRGB(255,125,135), 1.5, 0.08)
            del.Activated:Connect(function() destroyNFT(item.inst); refreshInv() end)
            table.insert(invRows, row)
        end
        if #items > INV_LIMIT then
            local more = New("Frame", {Size=UDim2.new(1,0,0,20), BackgroundTransparency=1, LayoutOrder=INV_LIMIT+1, Parent=invScroll})
            New("TextLabel", {Size=UDim2.new(1,0,1,0), BackgroundTransparency=1, Text="+"..(#items-INV_LIMIT).." more...", TextColor3=C.muted, Font=Enum.Font.GothamBold, TextSize=9, Parent=more})
            table.insert(invRows, more)
        end
    end
    refreshInv()
    task.spawn(function() while MainGui and MainGui.Parent do task.wait(2); if nftPage.Visible then refreshInv() end end end)

    sectionT(nftPage, "DELETE BY NAME", 30)
    local delNameRow = New("Frame", {Size=UDim2.new(1,0,0,30), BackgroundTransparency=1, LayoutOrder=31, Parent=nftPage})
    local dnL = Instance.new("UIListLayout", delNameRow); dnL.FillDirection = Enum.FillDirection.Horizontal; dnL.Padding = UDim.new(0, S.gap)
    local delNameBox = makeField(delNameRow, {Size=UDim2.new(0.62,-S.gap/2,1,0), PlaceholderText="NFT name (exact)...", TextSize=10, LayoutOrder=1})
    local delNameBtn = makeBtn(delNameRow, {Size=UDim2.new(0.38,-S.gap/2,1,0), Text="DELETE ALL", Font=Enum.Font.GothamBold, TextSize=9, LayoutOrder=2}, 4, "danger")
    delNameBtn.Activated:Connect(function()
        local target = (delNameBox.Text or ""):gsub("^%s+",""):gsub("%s+$","")
        if target == "" then playSnd(SND.Error); return end
        local count = 0
        for _, inst in ipairs(_Inv:GetChildren()) do
            local g = Info.Gifts[inst.Name]
            local dispName = g and (g.DisplayName or inst.Name) or inst.Name
            if inst.Name == target or dispName == target then pcall(destroyNFT, inst); count = count + 1 end
        end
        notify("DELETE", "Removed "..count.." × "..target)
        delNameBox.Text = ""; refreshInv(); playSnd(SND.Coins)
    end)

    local cp = pages["CURR"]
    sectionT(cp, "ВАЛЮТЫ", 1)
    local balLbls = {}
    for i, c in ipairs(CUR_LIST) do
        local row = New("Frame", {Size=UDim2.new(1,0,0,34), BackgroundColor3=C.card, BackgroundTransparency=0.1, BorderSizePixel=0, LayoutOrder=i+1, Parent=cp})
        corner(row, S.r); stroke(row, C.borderSoft, 1, 0.4)
        New("ImageLabel", {Size=UDim2.new(0,22,0,22), Position=UDim2.new(0,7,0.5,-11), BackgroundTransparency=1, Image=c.icon, ScaleType=Enum.ScaleType.Fit, Parent=row})
        New("TextLabel", {Size=UDim2.new(0.25,-6,1,0), Position=UDim2.new(0,34,0,0), BackgroundTransparency=1, Text=c.label, TextColor3=C.text, Font=Enum.Font.GothamBold, TextSize=10, TextXAlignment=Enum.TextXAlignment.Left, Parent=row})
        local v = New("TextLabel", {Size=UDim2.new(0.25,-6,1,0), Position=UDim2.new(0.28,0,0,0), BackgroundTransparency=1, Text=fullNum(getBal(c.key)), TextColor3=C.gold, Font=Enum.Font.GothamBold, TextSize=10, TextXAlignment=Enum.TextXAlignment.Left, Parent=row})
        balLbls[c.key] = v
        local bx = makeField(row, {Size=UDim2.new(0,82,0,26), Position=UDim2.new(1,-164,0.5,-13), PlaceholderText="amount", TextSize=9}, 4)
        local addBtn = makeBtn(row, {Size=UDim2.new(0,72,0,26), Position=UDim2.new(1,-76,0.5,-13), Text="ADD", Font=Enum.Font.GothamBlack, TextSize=11}, 4, "success")
        addBtn.Activated:Connect(function() local v2 = parseNum(bx.Text); if v2 then addBal(c.key, v2); bx.Text = ""; playSnd(SND.Coins) end end)
    end
    task.spawn(function() while MainGui and MainGui.Parent do task.wait(0.5); for k, l in pairs(balLbls) do if l.Parent then l.Text = fullNum(getBal(k)) end end end end)
    sectionT(cp, "КАСТОМ ПРОМО", 20)
    local promoDraft = {stars=0, ton=0, gems=0}
    local promoUnique = false
    local promoPattern, promoBackdrop = nil, nil
    local promoCodeBox = makeField(cp, {Size=UDim2.new(1,0,0,28), PlaceholderText="Promo Code Name", TextSize=10, LayoutOrder=21})
    local promoNftQuantities = {}
    local promoNftBtn = makeBtn(cp, {Size=UDim2.new(1,0,0,32), Text="+ SELECT NFT", Font=Enum.Font.GothamBold, TextSize=10, LayoutOrder=22}, 4, "primary")
    local promoRefresh = makeChipDisplay(cp, 23, function()
        local list = {}
        for name, count in pairs(promoNftQuantities) do if count > 0 then table.insert(list, {name=name, count=count}) end end
        table.sort(list, function(a,b) return a.name < b.name end)
        return list
    end, function(name, countToRemove)
        if not name then return end
        local cur = promoNftQuantities[name] or 0
        local newVal = math.max(0, cur - (countToRemove or 1))
        if newVal > 0 then promoNftQuantities[name] = newVal else promoNftQuantities[name] = nil end
    end, 42)
    promoNftBtn.Activated:Connect(function()
        local initial = {}
        for name, count in pairs(promoNftQuantities) do if count > 0 then table.insert(initial, {name=name, count=count}) end end
        openModal({title="NFT for Promo", items=giftItems, multi=true, maxQuantity=99, initialSelected=initial, onPickMulti=function(picked)
            promoNftQuantities = {}
            for _, p in ipairs(picked) do promoNftQuantities[p.item.name] = p.count end
            promoRefresh(); playSnd(SND.Coins)
        end})
    end)
    local promoURow = New("Frame", {Size=UDim2.new(1,0,0,28), BackgroundColor3=C.card, BackgroundTransparency=0.1, BorderSizePixel=0, LayoutOrder=24, Parent=cp})
    corner(promoURow, S.r); stroke(promoURow, C.borderSoft, 1, 0.4)
    New("TextLabel", {Size=UDim2.new(1,-60,1,0), Position=UDim2.new(0,10,0,0), BackgroundTransparency=1, Text="Unique NFTs", TextColor3=C.text, Font=Enum.Font.GothamBold, TextSize=10, TextXAlignment=Enum.TextXAlignment.Left, Parent=promoURow})
    local promoUW = New("Frame", {Size=UDim2.new(0,38,0,20), Position=UDim2.new(1,-50,0.5,-10), BackgroundTransparency=1, Parent=promoURow})
    makeTog(promoUW, false, function(s) promoUnique = s end)
    local promoAttrRow = New("Frame", {Size=UDim2.new(1,0,0,26), BackgroundTransparency=1, LayoutOrder=25, Parent=cp})
    local paLay = Instance.new("UIListLayout", promoAttrRow); paLay.FillDirection=Enum.FillDirection.Horizontal; paLay.Padding=UDim.new(0,S.gap)
    local promoPatBtn = makeBtn(promoAttrRow, {Size=UDim2.new(0.5,-S.gap/2,1,0), Text="Pattern", Font=Enum.Font.GothamBold, TextSize=10, LayoutOrder=1}, 4, "purple")
    local promoBdBtn = makeBtn(promoAttrRow, {Size=UDim2.new(0.5,-S.gap/2,1,0), Text="Backdrop", Font=Enum.Font.GothamBold, TextSize=10, LayoutOrder=2}, 4, "purple")
    promoPatBtn.Activated:Connect(function() openModal({title="Pattern", items=patItems, isSelected=function(it) return promoPattern==it.name end, onPick=function(it) promoPattern=it.name; promoPatBtn.Text="P: "..it.name:sub(1,8) end}) end)
    promoBdBtn.Activated:Connect(function() openModal({title="Backdrop", items=bdItems, isSelected=function(it) return promoBackdrop==it.name end, onPick=function(it) promoBackdrop=it.name; promoBdBtn.Text="B: "..it.name:sub(1,8) end}) end)
    sectionT(cp, "ВАЛЮТЫ В ПРОМО", 26)
    local promoCurDefs = {{key="stars", label="Stars", icon="rbxassetid://123580826852107"},{key="ton", label="TON", icon="rbxassetid://83906505399852"},{key="gems", label="Gems", icon="rbxassetid://110345687858105"}}
    for i, def in ipairs(promoCurDefs) do
        local row = New("Frame", {Size=UDim2.new(1,0,0,34), BackgroundColor3=C.card, BackgroundTransparency=0.1, BorderSizePixel=0, LayoutOrder=26+i, Parent=cp})
        corner(row, S.r); stroke(row, C.borderSoft, 1, 0.4)
        New("ImageLabel", {Size=UDim2.new(0,22,0,22), Position=UDim2.new(0,6,0.5,-11), BackgroundTransparency=1, Image=def.icon, ScaleType=Enum.ScaleType.Fit, Parent=row})
        New("TextLabel", {Size=UDim2.new(0.3,-6,1,0), Position=UDim2.new(0,32,0,0), BackgroundTransparency=1, Text=def.label, TextColor3=C.text, Font=Enum.Font.GothamBold, TextSize=10, TextXAlignment=Enum.TextXAlignment.Left, Parent=row})
        local bx = makeField(row, {Size=UDim2.new(0,110,0,22), Position=UDim2.new(1,-180,0.5,-11), PlaceholderText="0", TextSize=9}, 4)
        local setBtn = makeBtn(row, {Size=UDim2.new(0,70,0,22), Position=UDim2.new(1,-74,0.5,-11), Text="SET", Font=Enum.Font.GothamBold, TextSize=9}, 4, "success")
        setBtn.Activated:Connect(function() local v = parseNum(bx.Text); if v and v > 0 then promoDraft[def.key] = v; bx.Text = num(v); playSnd(SND.Coins) else promoDraft[def.key] = 0; bx.Text = "" end end)
    end
    local createPromoBtn = makeBtn(cp, {Size=UDim2.new(1,0,0,36), Text="CREATE PROMO CODE", Font=Enum.Font.GothamBold, TextSize=11, LayoutOrder=40}, 5, "success")
    createPromoBtn.Activated:Connect(function()
        local code = (promoCodeBox.Text or ""):gsub("^%s+",""):gsub("%s+$",""):upper()
        if code == "" then playSnd(SND.Error); notify("PROMO","Enter name"); return end
        local entry, hasAny = {}, false
        for k, v in pairs(promoDraft) do if type(v) == "number" and v > 0 then entry[k] = v; hasAny = true end end
        local nftList = {}
        for name, count in pairs(promoNftQuantities) do for _ = 1, count do table.insert(nftList, name) end end
        if #nftList > 0 then
            entry.nft_list = nftList; hasAny = true
            if promoUnique then entry.nft_list_unique = true; entry.nft_list_pattern = promoPattern; entry.nft_list_backdrop = promoBackdrop end
        end
        if not hasAny then playSnd(SND.Error); notify("PROMO","Add at least one value"); return end
        _promo[code] = entry; SAVE.promo()
        playSnd(SND.Success); notify("PROMO","Code "..code.." created!")
        promoCodeBox.Text = ""
        promoDraft = {stars=0, ton=0, gems=0}
        promoNftQuantities = {}; promoRefresh()
    end)

    -- Luck controls are in the dedicated LUCK tab.

    local bp = pages["BUFF"]
    sectionT(bp, "LUCK CENTER", 1)

    local luckSummary = New("Frame", {Size=UDim2.new(1,0,0,42), BackgroundColor3=C.panel, BackgroundTransparency=0, BorderSizePixel=0, LayoutOrder=2, Parent=bp})
    luckSummary.Visible = false -- removed the redundant top summary block from Luck menu\n    corner(luckSummary, 10); stroke(luckSummary, C.borderSoft, 1, 0.35)
    gradient2(luckSummary, C.accentDark, C.purple, 0)
    New("TextLabel", {Size=UDim2.new(1,-100,0,12), Position=UDim2.fromOffset(10,5), BackgroundTransparency=1, Text="LUCK POWER", TextColor3=Color3.fromRGB(255,255,255), Font=Enum.Font.GothamBold, TextSize=8, TextXAlignment=Enum.TextXAlignment.Left, Parent=luckSummary})
    local summaryValue = New("TextLabel", {Size=UDim2.new(1,-100,0,22), Position=UDim2.fromOffset(10,17), BackgroundTransparency=1, Text="x1", TextColor3=Color3.fromRGB(255,245,130), Font=Enum.Font.GothamBlack, TextSize=19, TextXAlignment=Enum.TextXAlignment.Left, Parent=luckSummary})
    local blessingTag = New("TextLabel", {Size=UDim2.fromOffset(88,22), Position=UDim2.new(1,-96,0.5,-11), BackgroundColor3=Color3.fromRGB(75,65,100), BorderSizePixel=0, Text="BLESSING OFF", TextColor3=Color3.fromRGB(255,255,255), Font=Enum.Font.GothamBold, TextSize=7, Parent=luckSummary})
    corner(blessingTag, 7)

    local BUFF_DEFS = {
        {key="_LuckyPotion", label="LUCK BOOST", level="x2", icon="rbxassetid://128430299231950", tint=Color3.fromRGB(70,235,145), fill=Color3.fromRGB(24,43,42)},
        {key="_LuckyPotion2", label="LUCK BOOST", level="x4", icon="rbxassetid://108057211812703", tint=Color3.fromRGB(190,115,255), fill=Color3.fromRGB(39,31,54)},
        {key="_LuckyPotion3", label="LUCK BOOST", level="x6", icon="rbxassetid://120273846740549", tint=Color3.fromRGB(255,105,125), fill=Color3.fromRGB(53,31,40)},
        {key="_Blessing", label="BLESSING", level="LUCK", icon="rbxassetid://102560611108829", tint=Color3.fromRGB(75,195,255), fill=Color3.fromRGB(27,42,57)},
    }
    local luckRows = {}
    for i, cfg in ipairs(BUFF_DEFS) do
        local row = New("Frame", {Size=UDim2.new(1,0,0,48), BackgroundColor3=cfg.fill, BackgroundTransparency=0, BorderSizePixel=0, LayoutOrder=2+i, Parent=bp})
        corner(row, 9); stroke(row, C.borderSoft, 1, 0.55)
        local accent = New("Frame", {Size=UDim2.new(0,3,1,-12), Position=UDim2.new(0,0,0,6), BackgroundColor3=cfg.tint, BorderSizePixel=0, Parent=row})
        corner(accent, 2)
        local iconBg = New("Frame", {Size=UDim2.fromOffset(30,30), Position=UDim2.new(0,8,0.5,-15), BackgroundColor3=cfg.tint, BackgroundTransparency=0.12, BorderSizePixel=0, Parent=row})
        corner(iconBg, 8)
        New("ImageLabel", {Size=UDim2.new(1,-6,1,-6), Position=UDim2.fromOffset(3,3), BackgroundTransparency=1, Image=cfg.icon, ScaleType=Enum.ScaleType.Fit, Parent=iconBg})
        New("TextLabel", {Size=UDim2.new(0,84,0,11), Position=UDim2.new(0,45,0,5), BackgroundTransparency=1, Text=cfg.label, TextColor3=Color3.fromRGB(235,238,245), Font=Enum.Font.GothamBold, TextSize=7, TextXAlignment=Enum.TextXAlignment.Left, Parent=row})
        local level = New("TextLabel", {Size=UDim2.new(0,48,0,19), Position=UDim2.new(0,45,0,17), BackgroundTransparency=1, Text=cfg.level, TextColor3=cfg.tint, Font=Enum.Font.GothamBlack, TextSize=15, TextXAlignment=Enum.TextXAlignment.Left, Parent=row})
        local statusLbl = New("TextLabel", {Size=UDim2.new(0,90,0,10), Position=UDim2.new(0,91,0,22), BackgroundTransparency=1, Text="○ OFF", TextColor3=Color3.fromRGB(190,195,205), Font=Enum.Font.GothamMedium, TextSize=7, TextXAlignment=Enum.TextXAlignment.Left, Parent=row})
        local inputBg = New("Frame", {Size=UDim2.fromOffset(43,24), Position=UDim2.new(1,-145,0.5,-12), BackgroundColor3=C.input, BackgroundTransparency=0, BorderSizePixel=0, Parent=row})
        corner(inputBg, 6)
        local secsInput = New("TextBox", {Size=UDim2.new(1,-4,1,0), Position=UDim2.fromOffset(2,0), BackgroundTransparency=1, Text="300", TextColor3=C.text, PlaceholderColor3=C.muted, Font=Enum.Font.GothamBold, TextSize=9, ClearTextOnFocus=false, TextXAlignment=Enum.TextXAlignment.Center, Parent=inputBg})
        local startBtn = makeBtn(row, {Size=UDim2.fromOffset(43,24), Position=UDim2.new(1,-98,0.5,-12), Text="START", Font=Enum.Font.GothamBlack, TextSize=7}, 6, "success")
        local stopBtn = makeBtn(row, {Size=UDim2.fromOffset(43,24), Position=UDim2.new(1,-51,0.5,-12), Text="STOP", Font=Enum.Font.GothamBlack, TextSize=7}, 6, "danger")
        startBtn.Activated:Connect(function()
            local secs = tonumber(secsInput.Text)
            if not secs or secs <= 0 then playSnd(SND.Error); notify("LUCK", "Введи корректное количество секунд"); return end
            secs = math.clamp(math.floor(secs),1,604800)
            forceAddBuff(cfg.key,secs); playSnd(SND.Success)
            TweenS:Create(row, TweenInfo.new(0.14,Enum.EasingStyle.Quad), {BackgroundTransparency=0.08}):Play()
            TweenS:Create(level, TweenInfo.new(0.16,Enum.EasingStyle.Back), {TextSize=17}):Play()
            task.delay(0.18,function() if level.Parent then TweenS:Create(level,TweenInfo.new(0.16),{TextSize=15}):Play() end end)
        end)
        stopBtn.Activated:Connect(function() removeBuff(cfg.key); playSnd(SND.Click) end)
        luckRows[#luckRows+1] = {key=cfg.key,tint=cfg.tint,status=statusLbl,title=level,row=row}
    end

    task.spawn(function()
        while MainGui and MainGui.Parent and bp.Parent do
            for _, item in ipairs(luckRows) do
                local v=LP:FindFirstChild(item.key); local seconds=v and tonumber(v.Value) or 0
                if seconds>0 then item.status.Text="● "..fmtTime(seconds); item.status.TextColor3=item.tint
                else item.status.Text="○ OFF"; item.status.TextColor3=Color3.fromRGB(190,195,205) end
            end
            summaryValue.Text="x"..tostring(getLuck())
            local blessingOn=hasBlessing(); blessingTag.Text=blessingOn and "BLESSING ON" or "BLESSING OFF"
            blessingTag.BackgroundColor3=blessingOn and Color3.fromRGB(18,125,165) or Color3.fromRGB(75,65,100)
            task.wait(0.7)
        end
    end)
    sectionT(bp, "QUICK ACTION", 8)
    local stopAllBtn = makeBtn(bp, {Size=UDim2.new(1,0,0,27), Text="STOP ALL EFFECTS", Font=Enum.Font.GothamBlack, TextSize=8, LayoutOrder=9}, 8, "danger")
    stopAllBtn.Activated:Connect(function() removeAll(); playSnd(SND.Click); notify("LUCK","Все эффекты остановлены") end)

    local mailPage = pages["MAIL"]
    local mailNftQuantities = {}
    local mailCur = {StarsValue=0, GemsValue=0, TONValue=0}
    local mailCurInputs = {}
    local mailSender = _settings.mailSender or ""
    sectionT(mailPage, "SENDER", 1)
    local mailSenderBox = makeField(mailPage, {Size=UDim2.new(1,0,0,28), PlaceholderText="Sender nickname (Admin, Support...)", TextSize=10, Text=mailSender, LayoutOrder=2})
    mailSenderBox:GetPropertyChangedSignal("Text"):Connect(function() mailSender = (mailSenderBox.Text or ""):gsub("^@",""):gsub("%s+$","") _settings.mailSender = mailSender SAVE.settings() end)
    sectionT(mailPage, "NFT IN PARCEL", 3)
    local mailNftBtn = makeBtn(mailPage, {Size=UDim2.new(1,0,0,32), Text="+ SELECT NFT", Font=Enum.Font.GothamBold, TextSize=10, LayoutOrder=4}, 4, "primary")
    local function countInventory() local counts = {} for _, it in ipairs(_Inv:GetChildren()) do counts[it.Name] = (counts[it.Name] or 0) + 1 end return counts end
    local mailRefresh = makeChipDisplay(mailPage, 5, function()
        local list = {}
        for name, count in pairs(mailNftQuantities) do if count > 0 then table.insert(list, {name=name, count=count}) end end
        table.sort(list, function(a,b) return a.name < b.name end)
        return list
    end, function(name, countToRemove)
        if not name then return end
        local cur = mailNftQuantities[name] or 0
        local newVal = math.max(0, cur - (countToRemove or 1))
        if newVal > 0 then mailNftQuantities[name] = newVal else mailNftQuantities[name] = nil end
    end, 42)
    mailNftBtn.Activated:Connect(function()
        local invCounts = countInventory()
        local initial = {}
        for name, count in pairs(mailNftQuantities) do if count > 0 then table.insert(initial, {name=name, count=count}) end end
        openModal({title = "NFT for Parcel (MAX 50)", items = giftItems, multi = true, grid=true, maxTotal=50, initialSelected = initial, getMaxQuantity = function() return 50 end, onPickMulti = function(picked)
            local total = 0
            for _, p in ipairs(picked) do total = total + math.max(0, math.floor(tonumber(p.count) or 0)) end
            if total > 50 then playSnd(SND.Error); notify("MAIL", "Maximum 50 NFTs per parcel"); return end
            mailNftQuantities = {}
            for _, p in ipairs(picked) do mailNftQuantities[p.item.name] = p.count end
            mailRefresh(); playSnd(SND.Coins)
        end})
    end)
    sectionT(mailPage, "CURRENCIES", 10)
    local mailCurDefs = {{key="StarsValue", label="Stars", icon="rbxassetid://123580826852107"},{key="TONValue", label="TON", icon="rbxassetid://83906505399852"},{key="GemsValue", label="Gems", icon="rbxassetid://110345687858105"}}
    for i, def in ipairs(mailCurDefs) do
        local row = New("Frame", {Size=UDim2.new(1,0,0,34), BackgroundColor3=C.card, BackgroundTransparency=0.1, BorderSizePixel=0, LayoutOrder=10+i, Parent=mailPage})
        corner(row, S.r); stroke(row, C.borderSoft, 1, 0.4)
        New("ImageLabel", {Size=UDim2.new(0,22,0,22), Position=UDim2.new(0,6,0.5,-11), BackgroundTransparency=1, Image=def.icon, ScaleType=Enum.ScaleType.Fit, Parent=row})
        New("TextLabel", {Size=UDim2.new(0.35,-6,1,0), Position=UDim2.new(0,32,0,0), BackgroundTransparency=1, Text=def.label, TextColor3=C.text, Font=Enum.Font.GothamBold, TextSize=10, TextXAlignment=Enum.TextXAlignment.Left, Parent=row})
        local bx = makeField(row, {Size=UDim2.new(0,110,0,22), Position=UDim2.new(1,-180,0.5,-11), PlaceholderText="0", TextSize=9}, 4)
        local setBtn = makeBtn(row, {Size=UDim2.new(0,70,0,22), Position=UDim2.new(1,-74,0.5,-11), Text="SET", Font=Enum.Font.GothamBold, TextSize=9}, 4, "success")
        mailCurInputs[def.key] = bx
        setBtn.Activated:Connect(function() local v = parseNum(bx.Text); if v and v > 0 then mailCur[def.key] = v; bx.Text = num(v); playSnd(SND.Coins) else mailCur[def.key] = 0; bx.Text = "" end end)
    end
    sectionT(mailPage, "INCOMING", 20)
    local pendingList = New("ScrollingFrame", {Size=UDim2.new(1,0,0,120), BackgroundColor3=C.input, BackgroundTransparency=0.15, BorderSizePixel=0, CanvasSize=UDim2.new(0,0,0,0), AutomaticCanvasSize=Enum.AutomaticSize.Y, ScrollBarThickness=4, ScrollBarImageColor3=C.accent, LayoutOrder=21, Parent=mailPage})
    corner(pendingList, S.r); stroke(pendingList, C.borderSoft, 1, 0.4)
    local pendingL = Instance.new("UIListLayout", pendingList); pendingL.Padding=UDim.new(0,3)
    local pendingP = Instance.new("UIPadding", pendingList); pendingP.PaddingLeft=UDim.new(0,5); pendingP.PaddingRight=UDim.new(0,5); pendingP.PaddingTop=UDim.new(0,5); pendingP.PaddingBottom=UDim.new(0,5)
    local function refreshPendingIncoming()
        for _, c in ipairs(pendingList:GetChildren()) do if c:IsA("Frame") or c:IsA("TextLabel") then c:Destroy() end end
        local incoming = {}
        for code, m in pairs(_mail) do
            if type(m) == "table" and (m.to == LP.UserId or m.toName == LP.Name) and not m.claimed and not m.declined and m.historyOnly ~= true then
                table.insert(incoming, {code=code, m=m})
            end
        end
        table.sort(incoming, function(a,b) return (a.m.time or 0) > (b.m.time or 0) end)
        if #incoming == 0 then New("TextLabel", {Size=UDim2.new(1,0,0,24), BackgroundTransparency=1, Text="No incoming", TextColor3=C.muted, Font=Enum.Font.GothamBold, TextSize=9, Parent=pendingList}); return end
        for i, item in ipairs(incoming) do
            local m = item.m
            local row = New("Frame", {Size=UDim2.new(1,0,0,36), BackgroundColor3=C.card, BackgroundTransparency=0.1, BorderSizePixel=0, LayoutOrder=i, Parent=pendingList})
            corner(row, S.rSm); stroke(row, C.borderSoft, 1, 0.4)
            local nftCnt, curCnt = 0, 0
            for _, entry in ipairs(m.items or {}) do nftCnt = nftCnt + (entry.C or (entry.A and 1) or 0) end
            for _, v in pairs(m.currency or {}) do curCnt = curCnt + (tonumber(v) or 0) end
            New("TextLabel", {Size=UDim2.new(1,-110,0,14), Position=UDim2.new(0,8,0,4), BackgroundTransparency=1, Text="From "..(m.fromName or "?"), TextColor3=C.text, Font=Enum.Font.GothamBold, TextSize=9, TextXAlignment=Enum.TextXAlignment.Left, Parent=row})
            New("TextLabel", {Size=UDim2.new(1,-110,0,12), Position=UDim2.new(0,8,0,20), BackgroundTransparency=1, Text=nftCnt.." NFT • "..num(curCnt).." cur", TextColor3=C.sub, Font=Enum.Font.Code, TextSize=8, TextXAlignment=Enum.TextXAlignment.Left, Parent=row})
            local claimBtn = makeBtn(row, {Size=UDim2.new(0,68,0,24), Position=UDim2.new(1,-74,0.5,-12), Text="CLAIM", Font=Enum.Font.GothamBold, TextSize=9}, 4, "success")
            claimBtn.Activated:Connect(function()
                local okCall, success, result = pcall(H.Mail, "Claim", {item.code})
                refreshPendingIncoming()
                if okCall and success and type(result) == "table" and #result.Claimed > 0 then
                    playSnd(SND.Coins); notify("MAIL","Claimed from "..(m.fromName or "?"))
                else
                    playSnd(SND.Error); notify("MAIL","Claim failed — parcel was not changed")
                end
            end)
        end
    end
    refreshPendingIncoming()
    -- The original game's MailClient can claim parcels independently of this
    -- custom tab. Rebuild the custom inbox whenever the shared pending count changes.
    LP:GetAttributeChangedSignal("MailPending"):Connect(function()
        task.defer(function()
            if mailPage and mailPage.Parent then refreshPendingIncoming() end
        end)
    end)
    sectionT(mailPage, "CREATE INCOMING", 30)
    local createParcelBtn = makeBtn(mailPage, {Size=UDim2.new(1,0,0,36), Text="CREATE INCOMING PARCEL", Font=Enum.Font.GothamBold, TextSize=11, LayoutOrder=31}, 5, "success")
    createParcelBtn.Activated:Connect(function()
        local hasAny = false
        for _, count in pairs(mailNftQuantities) do if count > 0 then hasAny = true; break end end
        if not hasAny then for _, v in pairs(mailCur) do if v > 0 then hasAny = true; break end end end
        if not hasAny then playSnd(SND.Error); notify("MAIL","Add NFT or currency"); return end
        local items, totalNfts = {}, 0
        for name, count in pairs(mailNftQuantities) do
            count = math.max(0, math.floor(tonumber(count) or 0))
            if count > 0 then
                totalNfts = totalNfts + count
                if totalNfts > 50 then playSnd(SND.Error); notify("MAIL", "Maximum 50 NFTs per parcel"); return end
                table.insert(items, {N=name, C=count})
            end
        end
        local currency = {}
        for k, v in pairs(mailCur) do if v > 0 then currency[k] = v end end
        if totalNfts > 50 then notify("MAIL","Maximum 50 NFTs per parcel"); return end
        local code = genUniqueParcel()
        local senderName = (mailSender ~= "" and mailSender) or CONFIG.DefaultSenderName
        _mail[code] = {id=code, to=LP.UserId, toName=LP.Name, fromId=0, fromName=senderName, time=os.time(), items=items, currency=currency, fake=true, incoming=true}
        SAVE.mail(); playSnd(SND.Success)
        notify("MAIL","Parcel "..code.." from "..senderName)
        mailNftQuantities = {}; mailRefresh()
        for k in pairs(mailCur) do mailCur[k] = 0 end
        for _, box in pairs(mailCurInputs) do box.Text = "" end
        refreshPendingIncoming(); updateMailPending()
    end)

    local hp = pages["SETTINGS"]
    local totalItems = 0
    sectionT(hp, "THEME", 1)
    local themeGrid = New("Frame", {Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, BorderSizePixel = 0, LayoutOrder = 2, Parent = hp})
    local tgLayout = Instance.new("UIGridLayout", themeGrid)
    tgLayout.CellSize = UDim2.new(1, 0, 0, 140); tgLayout.CellPadding = UDim2.new(0, 0, 0, 10); tgLayout.SortOrder = Enum.SortOrder.LayoutOrder
    local THEME_TAGS = {Mars={text=""},Moon={text=""},Galaxy={text=""},Halloween={text="EVENT"},NewYear={text="EVENT"}}
    local themeOrder = {"Mars", "Moon", "Galaxy", "Halloween", "NewYear"}
    for i, themeKey in ipairs(themeOrder) do
        local themeData = THEMES[themeKey]
        local isActive = (_settings.Theme == themeKey)
        local isEvent = themeKey == "Halloween" or themeKey == "NewYear"
        local tag = THEME_TAGS[themeKey] or {text=""}
        local cell = New("TextButton", {BackgroundColor3 = themeData.colors.bg, BackgroundTransparency = 0, BorderSizePixel = 0, AutoButtonColor = false, Text = "", LayoutOrder = i, Parent = themeGrid, ClipsDescendants = true})
        corner(cell, 9)
        local preview = New("ImageLabel", {Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, Image = "rbxassetid://"..tostring(themeData.bgImageId), ImageTransparency = isActive and 0 or 0.025, ImageColor3 = Color3.new(1.2, 1.2, 1.2), ScaleType = Enum.ScaleType.Crop, Parent = cell})
        corner(preview, 9)
        local tint = New("Frame", {Size = UDim2.new(1, 0, 1, 0), BackgroundColor3 = Color3.new(0, 0, 0), BackgroundTransparency = 0.28, BorderSizePixel = 0, Parent = cell})
        corner(tint, 9)
        local tintG = Instance.new("UIGradient")
        tintG.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(0,0,0)),ColorSequenceKeypoint.new(0.5, themeData.colors.bg),ColorSequenceKeypoint.new(1, themeData.colors.accentDark)})
        tintG.Rotation = 90
        tintG.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,0.2),NumberSequenceKeypoint.new(0.55,0.55),NumberSequenceKeypoint.new(1,0.85)})
        tintG.Parent = tint
        if isEvent then
            local glow = New("Frame", {Size = UDim2.new(1, 0, 0, 40), BackgroundColor3 = themeData.colors.accent, BackgroundTransparency = isActive and 0.5 or 0.7, BorderSizePixel = 0, Parent = cell})
            corner(glow, 9)
            local gg = Instance.new("UIGradient"); gg.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,0),NumberSequenceKeypoint.new(1,1)}); gg.Rotation = 90; gg.Parent = glow
        end
        local nameLbl = New("TextLabel", {Size = UDim2.new(1, -70, 0, 22), Position = UDim2.new(0, 12, 0, 8), BackgroundTransparency = 1, Text = themeData.name, TextColor3 = Color3.new(1,1,1), Font = Enum.Font.GothamBold, TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left, Parent = cell})
        addTextStroke(nameLbl, Color3.new(0,0,0), 1.5, 0.3)
        if isEvent then
            local badge = New("Frame", {Size = UDim2.new(0, 48, 0, 14), Position = UDim2.new(0, 12, 0, 29), BackgroundColor3 = themeData.colors.accent, BorderSizePixel = 0, Parent = cell})
            corner(badge, 8)
            New("TextLabel", {Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, Text = tag.text, TextColor3 = Color3.new(0,0,0), Font = Enum.Font.GothamBold, TextSize = 9, Parent = badge})
        end
        local dotsFrame = New("Frame", {Size = UDim2.new(0, 110, 0, 10), Position = UDim2.new(0, 12, 1, -18), BackgroundTransparency = 1, Parent = cell})
        local dl = Instance.new("UIListLayout", dotsFrame); dl.FillDirection = Enum.FillDirection.Horizontal; dl.Padding = UDim.new(0, 5)
        for _, ck in ipairs({"accent", "purple", "gold", "green", "accentRose"}) do
            local d = New("Frame", {Size = UDim2.fromOffset(10, 10), BackgroundColor3 = themeData.colors[ck], BorderSizePixel = 0, Parent = dotsFrame})
            corner(d, 7)
            local ds = Instance.new("UIStroke"); ds.Color = Color3.new(0,0,0); ds.Thickness = 1; ds.Transparency = 0.6; ds.Parent = d
        end
        New("Frame", {Size = UDim2.new(1, 0, 0, 4), Position = UDim2.new(0, 0, 1, -4), BackgroundColor3 = themeData.colors.accent, BorderSizePixel = 0, Parent = cell})
        local st = Instance.new("UIStroke")
        if isActive then st.Color = themeData.colors.accent st.Thickness = 2.5 st.Transparency = 0
        elseif isEvent then st.Color = themeData.colors.accent st.Thickness = 1.2 st.Transparency = 0.55
        else st.Color = Color3.fromRGB(70,70,80) st.Thickness = 1 st.Transparency = 0.5 end
        st.ApplyStrokeMode = Enum.ApplyStrokeMode.Border; st.Parent = cell
        if isActive then
            local check = New("TextLabel", {Size = UDim2.fromOffset(26, 26), Position = UDim2.new(1, -38, 1, -36), BackgroundColor3 = themeData.colors.accent, BorderSizePixel = 0, Text = "✓", TextColor3 = Color3.new(0,0,0), Font = Enum.Font.GothamBold, TextSize = 15, Parent = cell})
            corner(check, 13)
            local cs = Instance.new("UIStroke"); cs.Color = Color3.new(1,1,1); cs.Thickness = 1.5; cs.Transparency = 0.5; cs.Parent = check
            TweenS:Create(st, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {Transparency = 0.35}):Play()
        end
        cell.MouseEnter:Connect(function() if isActive then return end TweenS:Create(preview, TweenInfo.new(0.15), {ImageTransparency = 0.02}):Play() TweenS:Create(st, TweenInfo.new(0.15), {Color = themeData.colors.accent, Transparency = isEvent and 0.15 or 0.1, Thickness = isEvent and 2 or 1.5}):Play() end)
        cell.MouseLeave:Connect(function() if isActive then return end TweenS:Create(preview, TweenInfo.new(0.15), {ImageTransparency = 0.025}):Play() TweenS:Create(st, TweenInfo.new(0.15), {Color = isEvent and themeData.colors.accent or Color3.fromRGB(70,70,80), Transparency = isEvent and 0.55 or 0.5, Thickness = isEvent and 1.2 or 1}):Play() end)
        cell.Activated:Connect(function()
            if isActive then return end
            _settings.Theme = themeKey SAVE.settings() refreshTheme() playSnd(SND.Coins)
            notify("THEME", "Switching to "..themeData.name.."...")
            if MainGui then pcall(function() MainGui:Destroy() end); MainGui = nil end
            task.wait(0.15) pcall(buildGui)
            if MainGui then MainGui.Enabled = true; MainGui.DisplayOrder = 950 end
        end)
    end
    totalItems = 2
    sectionT(hp, "HOOKS", totalItems + 1)
    local HL = {
        {key="OpenCase", label="OpenCase"}, {key="Upgrade", label="Upgrade"}, {key="Fuse", label="Fuse"},
        {key="NFTPass", label="NFT Pass"}, {key="Halloween", label="Halloween"}, {key="Rebirth", label="Rebirth"},
        {key="Quests", label="Quests"}, {key="Reroll", label="Reroll"}, {key="Craft", label="Craft"},
        {key="DailyRewards", label="Daily"}, {key="Inventory", label="Inventory"}, {key="Favorite", label="Favorite"},
        {key="TON", label="TON"}, {key="UpgradeInventory", label="Upg Inv"}, {key="ShopItems", label="ShopItems"},
        {key="Code", label="Code"}, {key="Settings", label="Settings"}, {key="Mail", label="Mail"}, {key="AdminPanel", label="Leaderboard Ban (visual only)"},
    }
    for i, h in ipairs(HL) do
        local row = New("Frame", {Size=UDim2.new(1,0,0,24), BackgroundColor3=C.card, BackgroundTransparency=0.1, BorderSizePixel=0, LayoutOrder=totalItems+1+i, Parent=hp})
        corner(row, S.rSm); stroke(row, C.borderSoft, 1, 0.4)
        New("TextLabel", {Size=UDim2.new(1,-60,1,0), Position=UDim2.new(0,10,0,0), BackgroundTransparency=1, Text=h.label, TextColor3=C.text, Font=Enum.Font.GothamBold, TextSize=9, TextXAlignment=Enum.TextXAlignment.Left, Parent=row})
        local w = New("Frame", {Size=UDim2.new(0,38,0,20), Position=UDim2.new(1,-50,0.5,-10), BackgroundTransparency=1, Parent=row})
        makeTog(w, ON[h.key] ~= false, function(s) ON[h.key]=s end)
    end
    local hooksEnd = totalItems + 1 + #HL + 1
    sectionT(hp, "OPTIONS", hooksEnd)
    local sr = New("Frame", {Size=UDim2.new(1,0,0,24), BackgroundColor3=C.card, BackgroundTransparency=0.1, BorderSizePixel=0, LayoutOrder=hooksEnd+1, Parent=hp})
    corner(sr, S.rSm); stroke(sr, C.borderSoft, 1, 0.4)
    New("TextLabel", {Size=UDim2.new(1,-60,1,0), Position=UDim2.new(0,10,0,0), BackgroundTransparency=1, Text="Fake Robux Purchases", TextColor3=C.text, Font=Enum.Font.GothamBold, TextSize=9, TextXAlignment=Enum.TextXAlignment.Left, Parent=sr})
    local sw = New("Frame", {Size=UDim2.new(0,38,0,20), Position=UDim2.new(1,-50,0.5,-10), BackgroundTransparency=1, Parent=sr})
    makeTog(sw, _settings.FakeAllPurchases ~= false, function(s) _settings.FakeAllPurchases = s; SAVE.settings() end)
    local function optionRow(label, order, value, callback)
        local row = New("Frame", {Size=UDim2.new(1,0,0,24), BackgroundColor3=C.card, BackgroundTransparency=0.1, BorderSizePixel=0, LayoutOrder=order, Parent=hp})
        corner(row, S.rSm); stroke(row, C.borderSoft, 1, 0.4)
        New("TextLabel", {Size=UDim2.new(1,-60,1,0), Position=UDim2.new(0,10,0,0), BackgroundTransparency=1, Text=label, TextColor3=C.text, Font=Enum.Font.GothamBold, TextSize=9, TextXAlignment=Enum.TextXAlignment.Left, Parent=row})
        local w = New("Frame", {Size=UDim2.new(0,38,0,20), Position=UDim2.new(1,-50,0.5,-10), BackgroundTransparency=1, Parent=row})
        makeTog(w, value, callback)
    end
    optionRow("Event Particles", hooksEnd+2, _settings.EventParticles ~= false, function(v) _settings.EventParticles=v; SAVE.settings(); notify("PARTICLES", "Reopen menu to refresh seasonal particles") end)
    local planRow = New("Frame", {Size=UDim2.new(1,0,0,68), BackgroundColor3=C.card, BackgroundTransparency=0.1, BorderSizePixel=0, LayoutOrder=hooksEnd+3, Parent=hp})
    corner(planRow, S.rSm); stroke(planRow, C.borderSoft, 1, 0.4)
    New("TextLabel", {Size=UDim2.new(0.65,0,0,22), Position=UDim2.new(0,8,0,3), BackgroundTransparency=1, Text="Mail daily limit override", TextColor3=C.text, Font=Enum.Font.GothamBold, TextSize=9, TextXAlignment=Enum.TextXAlignment.Left, Parent=planRow})
    local mailPlanToggleWrap = New("Frame", {Size=UDim2.new(0,38,0,20), Position=UDim2.new(1,-48,0,4), BackgroundTransparency=1, Parent=planRow})
    makeTog(mailPlanToggleWrap, _settings.MailPlanOverrideEnabled == true, function(enabled)
        _settings.MailPlanOverrideEnabled = enabled
        if enabled and _settings.MailPlanOverride == nil then _settings.MailPlanOverride = 0 end
        SAVE.settings()
        notify("MAIL", enabled and "Local limit override enabled" or "Using the game's purchased mail plan")
    end)
    local mailPlanOptions = {{0,"10 / day"},{1,"50 / day"},{2,"150 / day"}}
    for i, opt in ipairs(mailPlanOptions) do
        local isSelected = (_settings.MailPlanOverrideEnabled == true and tonumber(_settings.MailPlanOverride) == opt[1])
        local b = makeBtn(planRow, {Size=UDim2.new(0.29,0,0,25), Position=UDim2.new(0.035+(i-1)*0.315,0,0,34), Text=opt[2], TextSize=8, Font=Enum.Font.GothamBold}, 4, isSelected and "success" or "ghost")
        b.Activated:Connect(function()
            _settings.MailPlanOverride = opt[1]
            _settings.MailPlanOverrideEnabled = true
            SAVE.settings()
            notify("MAIL", "Local daily limit set to "..opt[2])
            if MainGui then pcall(function() MainGui:Destroy() end); MainGui=nil; task.defer(buildGui) end
        end)
    end
    sectionT(hp, "CREATE CUSTOM NFT (session only)", hooksEnd + 7)
    local cnftCard = New("Frame", {Size=UDim2.new(1,0,0,0), AutomaticSize=Enum.AutomaticSize.Y, BackgroundColor3=C.card, BackgroundTransparency=0.15, BorderSizePixel=0, LayoutOrder=hooksEnd+8, Parent=hp})
    corner(cnftCard, S.r); stroke(cnftCard, C.borderSoft, 1, 0.4)
    local cnftPad = Instance.new("UIPadding", cnftCard); cnftPad.PaddingLeft=UDim.new(0,6); cnftPad.PaddingRight=UDim.new(0,6); cnftPad.PaddingTop=UDim.new(0,6); cnftPad.PaddingBottom=UDim.new(0,6)
    local cnftList = Instance.new("UIListLayout", cnftCard); cnftList.Padding=UDim.new(0,5); cnftList.SortOrder=Enum.SortOrder.LayoutOrder
    local cnftImgFrame = New("Frame", {Size=UDim2.new(1,0,0,90), BackgroundColor3=C.input, BackgroundTransparency=0.25, BorderSizePixel=0, LayoutOrder=1, Parent=cnftCard})
    corner(cnftImgFrame, 6); stroke(cnftImgFrame, C.borderSoft, 1, 0.3)
    local cnftImgPrv = New("ImageLabel", {Size=UDim2.new(1,-8,1,-8), Position=UDim2.new(0,4,0,4), BackgroundTransparency=1, Image="", ScaleType=Enum.ScaleType.Fit, Parent=cnftImgFrame})
    New("TextLabel", {Size=UDim2.new(1,0,1,0), BackgroundTransparency=1, Text="Preview", TextColor3=C.muted, Font=Enum.Font.GothamBold, TextSize=10, TextTransparency=0.5, Parent=cnftImgFrame, ZIndex=1})
    local cnftName = makeField(cnftCard, {Size=UDim2.new(1,0,0,24), PlaceholderText="NFT Name", TextSize=10, LayoutOrder=2})
    local cnftImg = makeField(cnftCard, {Size=UDim2.new(1,0,0,24), PlaceholderText="Image ID (digits)", TextSize=10, LayoutOrder=3})
    local cnftPrice = makeField(cnftCard, {Size=UDim2.new(1,0,0,24), PlaceholderText="Price (1000000 / 1m)", TextSize=10, LayoutOrder=4})
    cnftImg:GetPropertyChangedSignal("Text"):Connect(function() local id = (cnftImg.Text or ""):gsub("%D", "") cnftImgPrv.Image = id ~= "" and "rbxassetid://"..id or "" end)
    local cnftAddBtn = makeBtn(cnftCard, {Size=UDim2.new(1,0,0,28), Text="ADD (session only)", Font=Enum.Font.GothamBold, TextSize=10, LayoutOrder=5}, 4, "success")
    cnftAddBtn.Activated:Connect(function()
        local nm = (cnftName.Text or ""):gsub("^%s+",""):gsub("%s+$","")
        local idStr = (cnftImg.Text or ""):gsub("%D", "")
        local priceStr = (cnftPrice.Text or ""):gsub("^%s+",""):gsub("%s+$","")
        if nm == "" or idStr == "" then playSnd(SND.Error); notify("CUSTOM","Fill name & image"); return end
        local price = parseNum(priceStr); if not price or price <= 0 then playSnd(SND.Error); notify("CUSTOM","Enter valid price"); return end
        if rawget(Info.Gifts, nm) then playSnd(SND.Error); notify("CUSTOM","Name already exists"); return end
        local imgNum = tonumber(idStr)
        if not imgNum then playSnd(SND.Error); notify("CUSTOM","Invalid Image ID"); return end
        _customNFTs[nm] = {name=nm, image=imgNum, price=price, display=nm, created=os.time(), noSave=true}
        Info.Gifts[nm] = {Price=price, Image=imgNum, DisplayName=nm, CustomUser=true, Hidden=false}
        playSnd(SND.Success); notify("CUSTOM NFT","Created: "..nm.." ⭐"..num(price).." (session only)")
        pushLog("CUSTOM NFT "..nm.." (session)")
        cnftName.Text = ""; cnftImg.Text = ""; cnftPrice.Text = ""; cnftImgPrv.Image = ""
    end)
    sectionT(hp, "QUICK ACTIONS", hooksEnd + 14)
    local function mkA(text, order, cb, variant)
        local b = makeBtn(hp, {Size=UDim2.new(1,0,0,26), Text=text, Font=Enum.Font.GothamBold, TextSize=9, LayoutOrder=order}, 4, variant or "ghost")
        b.Activated:Connect(function() pcall(cb); playSnd(SND.Coins) end)
    end
    mkA("Max Pass Level", hooksEnd+11, function() local N = LP:FindFirstChild("_NFTPass"); if N and NFTPassCfg.LvlXP and NFTPassCfg.Rewards then local XP = N:FindFirstChild("XP"); if XP then XP.Value = NFTPassCfg.LvlXP(#NFTPassCfg.Rewards.Free) end end end)
    mkA("Reset Pass Claims", hooksEnd+12, function() local c = passClaimedRef(); if c then for k, _ in pairs(c:GetAttributes()) do if tonumber(k) ~= nil then c:SetAttribute(k, nil) end end end end)
    mkA("Force Plus Pass", hooksEnd+13, function() local pp = LP:FindFirstChild("_PlusPass"); if pp and NFTPassCfg.Season then pp.Value = NFTPassCfg.Season end end)
    mkA("Best Drop Info", hooksEnd+14, function() local r = getBestRef(); if r then notify("BEST", r.Value.." ⭐"..num((Info.Gifts[r.Value] and Info.Gifts[r.Value].Price) or 0)) end end)
    mkA("Refresh Leaderboard", hooksEnd+15, function() pcall(injectLB) end, "success")
    mkA("Clear Log", hooksEnd+16, function() _logs = {}; SAVE.log() end, "danger")

    local ip2 = pages["INFO"]
    sectionT(ip2, "STATUS", 1)
    local function addR(order, k, v)
        local r = New("Frame", {Size=UDim2.new(1,0,0,22), BackgroundColor3=C.card, BackgroundTransparency=0.1, BorderSizePixel=0, LayoutOrder=order, Parent=ip2})
        corner(r, S.rSm); stroke(r, C.borderSoft, 1, 0.4)
        local pad = Instance.new("UIPadding", r); pad.PaddingLeft = UDim.new(0,10); pad.PaddingRight = UDim.new(0,12)
        New("TextLabel", {Size=UDim2.new(0.5,0,1,0), BackgroundTransparency=1, Text=k, TextColor3=C.sub, Font=Enum.Font.GothamBold, TextSize=9, TextXAlignment=Enum.TextXAlignment.Left, Parent=r})
        return New("TextLabel", {Size=UDim2.new(0.5,0,1,0), Position=UDim2.new(0.5,0,0,0), BackgroundTransparency=1, Text=v, TextColor3=C.text, Font=Enum.Font.GothamBold, TextSize=9, TextXAlignment=Enum.TextXAlignment.Left, TextTruncate=Enum.TextTruncate.AtEnd, Parent=r})
    end
    addR(2, "Hook", _hookStatus); addR(3, "Owner", LP.Name); addR(4, "Theme", CurrentTheme.name)
    local lN = addR(5, "Normal", "0"); local lU = addR(6, "Uniques", "0")
    local lI = addR(7, "Inventory", "0"); local lL = addR(8, "Luck", "x1")
    local lB = addR(9, "Best", "—"); local lC = addR(10, "Custom", "0")
    local lM = addR(11, "Mail Pending", "0")
    task.spawn(function() while MainGui and MainGui.Parent do task.wait(2); if ip2.Visible then
        local n2, u = 0, 0
        for _ in pairs(_nfts) do n2 = n2 + 1 end
        for _ in pairs(_uniques) do u = u + 1 end
        local c2 = 0; for _ in pairs(_customNFTs) do c2 = c2 + 1 end
        lN.Text = tostring(n2); lU.Text = tostring(u); lI.Text = tostring(#_Inv:GetChildren()); lL.Text = "x"..getLuck()
        local br = getBestRef(); lB.Text = br and br.Value or "—"
        lC.Text = tostring(c2); lM.Text = tostring(LP:GetAttribute("MailPending") or 0)
    end end end)
    sectionT(ip2, "LOG", 20)
    local lb = New("ScrollingFrame", {Size=UDim2.new(1,0,0,240), BackgroundColor3=C.input, BackgroundTransparency=0.15, BorderSizePixel=0, CanvasSize=UDim2.new(0,0,0,0), AutomaticCanvasSize=Enum.AutomaticSize.Y, ScrollBarThickness=4, ScrollBarImageColor3=C.accent, LayoutOrder=21, Parent=ip2})
    corner(lb, S.r); stroke(lb, C.borderSoft, 1, 0.4)
    local ll = Instance.new("UIListLayout", lb); ll.Padding=UDim.new(0,1)
    local lpp = Instance.new("UIPadding", lb); lpp.PaddingLeft=UDim.new(0,6); lpp.PaddingRight=UDim.new(0,6); lpp.PaddingTop=UDim.new(0,5); lpp.PaddingBottom=UDim.new(0,5)
    local function renderLog()
        for _, c in ipairs(lb:GetChildren()) do if c:IsA("TextLabel") then c:Destroy() end end
        local s = math.max(1, #_logs - 80)
        for i = s, #_logs do local e = _logs[i]; New("TextLabel", {Size=UDim2.new(1,0,0,14), BackgroundTransparency=1, Text="["..os.date("%H:%M:%S", e.t).."] "..e.m, TextColor3=C.sub, Font=Enum.Font.Code, TextSize=8, TextXAlignment=Enum.TextXAlignment.Left, TextTruncate=Enum.TextTruncate.AtEnd, LayoutOrder=i, Parent=lb}) end
    end
    renderLog()
    task.spawn(function() while MainGui and MainGui.Parent do task.wait(2); if ip2.Visible then renderLog() end end end)
    return sg
end

pcall(buildGui)
if MainGui then MainGui.Enabled = true; MainGui.DisplayOrder = 950 end

UIS.InputBegan:Connect(function(input, processed)
    if processed or UIS:GetFocusedTextBox() or not input.KeyCode then return end
    if input.KeyCode == Enum.KeyCode.RightShift then
        if MainGui and MainGui.Parent then MainGui.Enabled = not MainGui.Enabled end
    elseif input.KeyCode == Enum.KeyCode.V then
        _logs = {}; SAVE.log()
    end
end)

task.spawn(function() while MainGui and MainGui.Parent do task.wait(CONFIG.SaveInterval); for k in pairs(SAVE) do pcall(SAVE[k]) end end end)
pcall(function() game:BindToClose(function() for k in pairs(SAVE) do pcall(SAVE[k]) end end) end)
pcall(function() notify("Sunset Sisi Top", "v" .. VERSION_TAG .. " | " .. _hookStatus) end)
pushLog("READY v" .. VERSION_TAG .. " | " .. _hookStatus)
print("[SST44.5] READY | " .. _hookStatus .. " | Theme: " .. CurrentTheme.name)
