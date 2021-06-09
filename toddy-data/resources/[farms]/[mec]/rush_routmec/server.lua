local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

primo = {}
Tunnel.bindInterface("rush_routmec",primo)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ VARIÁVEIS ]--------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local quantidade = {}

function primo.Quantidade()
	local source = source

	if quantidade[source] == nil then
	   quantidade[source] = math.random(1,2)	
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

function primo.checkPayment()
	primo.Quantidade()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("repairkit")*quantidade[source] <= vRP.getInventoryMaxWeight(user_id) and vRP.getInventoryWeight(user_id)+vRP.getItemWeight("militec")*quantidade[source] <= vRP.getInventoryMaxWeight(user_id) then
			vRP.giveInventoryItem(user_id,"repairkit",quantidade[source])
			quantidade[source] = nil
			return true
		else
			TriggerClientEvent("Notify",source,"negado","Negado","<b>Mochila</b> cheia.")
			return false
		end
	end
end

function primo.checkGroup()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"bennys.permissao") then
        return true
    end
end