local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

primo = Tunnel.getInterface("vrp_medsystem")

Tunnel.bindInterface("vrp_medsystem",primo)

RegisterServerEvent('medSystem:print')
AddEventHandler('medSystem:print', function(req, pulse, area, blood, x, y, z, bleeding)

	local _source = source
	
	local xPlayer =  vRP.getUserId(_source)
	Wait(100)
	local name = vRP.getUserIdentity(_source)
	
	
	local xPlayers = vRP.getUsers()

	for i=1, #xPlayers, 1 do
		print(xPlayers[i])
		TriggerClientEvent('medSystem:near', xPlayers[i] ,x ,y ,z , pulse, blood, name.name, name.firstname, area, bleeding)
	end
	
end)

RegisterCommand('med', function(source, args)
	local _source = source
	if args[1] ~= nil then
	TriggerClientEvent('medSystem:send', args[1], _source)
	else
	TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Incorrect player ID!")
	end
	
end, false)

------------------------------- FARM DUS CRIA -----------------------------------------------

-----------------------------------------------------------------------------------------------------------------------------------------
--[ VARIÁVEIS ]--------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local quantidade = {}

function primo.Quantidade()
	local source = source

	if quantidade[source] == nil then
	   quantidade[source] = math.random(2,2)	
	end

	TriggerClientEvent("quantidade-bandagem",source,parseInt(quantidade[source]))
end


local bandagem = {}
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        for k,v in pairs(bandagem) do
            if v > 0 then
                bandagem[k] = v - 1
            end
        end
    end
end)

function primo.checkPayment()
	primo.Quantidade()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("bandagem")*quantidade[source] <= vRP.getInventoryMaxWeight(user_id) and vRP.getInventoryWeight(user_id)+vRP.getItemWeight("militec")*quantidade[source] <= vRP.getInventoryMaxWeight(user_id) then
			vRP.giveInventoryItem(user_id,"bandagem",quantidade[source])
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
    if vRP.hasPermission(user_id,"dmla.permissao") then
        return true
    end
end