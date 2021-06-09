local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

doug = {}
Tunnel.bindInterface("rush_routmoney",doug)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ VARIÁVEIS ]--------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local quantidade = {}

function doug.Quantidade()
	local source = source

	if quantidade[source] == nil then
	   quantidade[source] = math.random(5,8)	
	end

	TriggerClientEvent("quantidade-key",source,parseInt(quantidade[source]))
end


local key = {}
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        for k,v in pairs(key) do
            if v > 0 then
                key[k] = v - 1
            end
        end
    end
end)

function doug.checkPayment()
	doug.Quantidade()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("keysinvasao")*quantidade[source] <= vRP.getInventoryMaxWeight(user_id) then
			vRP.giveInventoryItem(user_id,"keysinvasao",quantidade[source])
			vRP.giveInventoryItem(user_id,"energetico",math.random(1,2))
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
    if vRP.hasPermission(user_id,"life.permissao") or vRP.hasPermission(user_id,"bahamas.permissao") then
        return true
    end
end