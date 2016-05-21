local pass = PCrypt.sha3(...)
local clientList = {}
sockets.host("pass")

local devices = {modem = true, computer = true, turtle = true, drive = true, monitor = true, printer = true}

local function join()
    while true do
        local client = sockets.pullClient()
        clientList[#clientList + 1] = client
        coroutine.yield()
    end
end

--[[local function override() -- top level coroutine override, someone else made it up
    local pError = _G.printError
    _G.printError = function()
        _G.printError = pError
        
    end]]--

local function getConnected(allowUnknown)
    local rList = {}
    for k, client in ipairs(clientList) do
        local hosted = client.ask("GET HOSTED VPN", "string")
        local devices = {
            if devices[type] then
            
        rList[k] = {
            
