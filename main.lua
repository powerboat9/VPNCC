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
    for _, client in ipairs(clientList) do
        local hosted = client:ask("GET HOSTED VPN", "table")
        if devices[hosted.type] or allowUnknown then
            rList[hosted.name] = {type = hosted.type, client = client.pubKey, methods = hosted.methods}
        end
    end
    return rList
end

local function getBinding(connectedUtilityName)
    local rBinding, devList = {}, getConnected()
    local dev = devList[connectedUtilityName]
    for _, functName in ipairs(dev.methods) do
        rBinding[functName] = function(...)
            return table.unpack(dev.client:ask("EXECUTE: " .. textutils.serialize({functName, table.unpack(args)})))
        end
    end
    return rBinding
end
        
