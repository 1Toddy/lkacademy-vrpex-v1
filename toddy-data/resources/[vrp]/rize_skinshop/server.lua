local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","rize_skinshop")
vRPloja = Tunnel.getInterface("rize_skinshop")

RegisterServerEvent("LojaDeRoupas:Comprar")
AddEventHandler("LojaDeRoupas:Comprar", function(preco)
    local user_id = vRP.getUserId(source)
    if preco then
        if vRP.tryFullPayment(user_id, preco) then
            TriggerClientEvent("Notify",source,"sucesso","Sucesso","Você pagou R$"..preco.." pelas roupas.",10000)
            TriggerClientEvent('LojaDeRoupas:ReceberCompra', source, true)
        else
            TriggerClientEvent("Notify",source,"importante","Importante","Você não tem dinheiro suficiente para pagar.",10000)
            TriggerClientEvent('LojaDeRoupas:ReceberCompra', source, false)
        end
    end
end)

