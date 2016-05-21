local vpnConnections = {}
sockets.host()

local function join()
    local client = sockets.pullClient()
    if client
