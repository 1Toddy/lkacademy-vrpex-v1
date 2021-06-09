UFclient = {}
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
UFserver = Tunnel.getInterface("rize_banco")

local cfg = module("rize_banco","uf_cfg")



RegisterCommand('bank', function(source, args, rawCmd)
    local likizao = 300
    local ped = PlayerPedId()
    local cds = GetEntityCoords(ped)
    for bancos = 1,#cfg.cds do 
        local dist = #(cds - cfg.cds[bancos])
        if dist <= 3.0 then 
            UFclient.clOpenNui()
        end
    end
end)


UFclient.close = function()
    SetCursorLocation(0.5,0.5)
	SetNuiFocus(false,false)
	SendNUIMessage({ acao = "close" })
    TransitionFromBlurred(500)
end

RegisterNUICallback("close",function(data)
	SetCursorLocation(0.5,0.5)
	SetNuiFocus(false,false)
	SendNUIMessage({ acao = "close" })
    TransitionFromBlurred(500)
end)

UFclient.clOpenNui = function()
    local carteira, banco, nome, telefone, multas = UFserver.info()
    local logs = "."
    SendNUIMessage({
        acao = "open",
        carteira = carteira,
        banco = banco,
        nome = nome,
        phone = telefone,
        logs = logs,
        multas = multas
    })
    SetNuiFocus(true, true)
    TransitionToBlurred(1000)
end

UFclient.updateBank = function()
    local carteira, banco, nome, telefone, multas = UFserver.info()
    local logs = "."
    SendNUIMessage({
        acao = "update",
        carteira = carteira,
        banco = banco,
        nome = nome,
        phone = telefone,
        logs = logs,
        multas = multas
    })
end

----------------------------------------------------------------
-- CB'S ACOES
----------------------------------------------------------------

RegisterNUICallback("transferencia",function(data)
    UFserver.transferencia(data.nid,data.amount)
    UFclient.updateBank()
end)
RegisterNUICallback("saque",function(data)
    UFserver.saque(data.amount)
    UFclient.updateBank()
end)
RegisterNUICallback("deposito",function(data)
    UFserver.depositar(data.amount)
    UFclient.updateBank()
end)
RegisterNUICallback("multas",function(data)
    UFserver.multas(data.amount)
    UFclient.updateBank()
end)