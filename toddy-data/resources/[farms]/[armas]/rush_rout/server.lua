local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

doug = {}
Tunnel.bindInterface("rush_rout",doug)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ VARIÁVEIS ]--------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local quantidade = {}

function doug.Quantidade()
	local source = source

	if quantidade[source] == nil then
	   quantidade[source] = math.random(15,25)	
	end

	TriggerClientEvent("quantidade-drogas",source,parseInt(quantidade[source]))
end


local drogas = {}
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        for k,v in pairs(drogas) do
            if v > 0 then
                drogas[k] = v - 1
            end
        end
    end
end)

function doug.checkPayment()
	doug.Quantidade()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("pecadearma")*quantidade[source] <= vRP.getInventoryMaxWeight(user_id) then
			vRP.giveInventoryItem(user_id,"pecadearma",quantidade[source])
			vRP.giveInventoryItem(user_id,"placa-metal",math.random(2,3))
			vRP.giveInventoryItem(user_id,"molas",math.random(2,3))
			vRP.giveInventoryItem(user_id,"gatilho",math.random(2,3))
			quantidade[source] = nil
			return true
		else
			TriggerClientEvent("Notify",source,"negado","Negado","<b>Mochila</b> cheia.")
			return false
		end
	end
end

function doug.checkGroup()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"bloods.permissao") or vRP.hasPermission(user_id,"crips.permissao") then
        return true
    end
end