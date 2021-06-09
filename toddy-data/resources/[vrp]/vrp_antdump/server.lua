local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "vrp_antdump")

src = {}
Tunnel.bindInterface("vrp_antdump",src)
Proxy.addInterface("vrp_antdump",src)

local loaded = {}
function src.pegaTrouxa()
    local source = source
    local user_id = vRP.getUserId(source)

    local fields2 = {}
    table.insert(fields2, { name = "ChomeInspector:", value = 'ID => **'..user_id..'** \nFoi pego tentando roubar o Html/Client da cidade.', inline = true });
    PerformHttpRequest("https://discord.com/api/webhooks/790293400573313055/9i7Dw_xgXpZ7S3D4ZIfAr39-3sbrHNkP9B4QTDYb4SMTaTIHiq7afQ6IKnKIbP5ms_qC", function(err, text, headers) end, 'POST', json.encode({username = "In Game Log System", content = nil, embeds = {{color = 16754176, fields = fields2,}}}), { ['Content-Type'] = 'application/json' }) 
    print("Tentativa de Acesso ao Chrome Inspector! ID: "..user_id)
    vRP.kick(source,"Você foi banido permanentemente. Motivo: Dump")    
    vRP.setBanned(user_id,true)

end

