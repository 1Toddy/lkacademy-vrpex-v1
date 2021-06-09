-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("rize_boates",src)
vCLIENT = Tunnel.getInterface("rize_boates")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local robbery = false
local timedown = 0

local robbers = {
	[1] = { ['place'] = "Vanilla", ['seconds'] = 200, ['rewmin'] = 180000, ['rewmax'] = 210000 },
	[2] = { ['place'] = "Bahamas", ['seconds'] = 300, ['rewmin'] = 180000, ['rewmax'] = 210000 },
	[3] = { ['place'] = "Tequila-La", ['seconds'] = 300, ['rewmin'] = 180000, ['rewmax'] = 210000 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookboate = "https://discord.com/api/webhooks/798074608997367828/4iMgeg8iZrvsnZZUZWKtRK4YhoON0VM5MCqiLsIfEVA2yN7UKhvzQE0QRoGM2neH8LyD"

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKPOLICE
-----------------------------------------------------------------------------------------------------------------------------------------
function src.checkPolice()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local policia = vRP.getUsersByPermission("dpla.permissao")
		if #policia < 6 and not vRPclient.changingClothes(source) then
			TriggerClientEvent("Notify",source,"aviso","Aviso","Número insuficiente de policiais no momento.")
			return false
		elseif (os.time()-timedown) <= 2700 then
			TriggerClientEvent("Notify",source,"aviso","Aviso","Os cofres estão vazios, aguarde <b>"..vRP.format(parseInt((2700-(os.time()-timedown)))).." segundos</b> até que os civis efetuem depositos.")
			return false
		end
	end
	return true
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
function src.checkTimers2()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local policia = vRP.getUsersByPermission("dpla.permissao")
		if #policia < 5 then
			TriggerClientEvent("Notify",source,"aviso","Aviso","Número insuficiente de policiais no momento.")
			return false
		elseif (os.time()-timedown) <= 2700 then
			TriggerClientEvent("Notify",source,"aviso","Aviso","Os cofres estão vazios, aguarde <b>"..vRP.format(parseInt((2700-(os.time()-timedown)))).." segundos</b> até que os civis efetuem depositos.")
			return false
		else			
			return true
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTROBBERY
-----------------------------------------------------------------------------------------------------------------------------------------
function src.startRobbery(id,x,y,z)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		robbery = true
		timedown = os.time()
		vCLIENT.startRobbery(source,robbers[id].seconds,x,y,z)
		TriggerClientEvent("vrp_sound:source",source,'alarm',0.7)

		local policia = vRP.getUsersByPermission("dpla.permissao")
		for k,v in pairs(policia) do
			local policial = vRP.getUserSource(v)
			if policial then
				async(function()
					vCLIENT.startRobberyPolice(policial,x,y,z,robbers[id].place)
					vRPclient.playSound(policial,"Oneshot_Final","MP_MISSION_COUNTDOWN_SOUNDSET")
					TriggerClientEvent('chatMessage',policial,"911",{64,64,255},"Roubo ao ^1"..robbers[id].place.."^0 iniciada, dirija-se até o local e intercepte os assaltantes.")
				end)
			end
		end

		SendWebhookMessage(webhookboate,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		SetTimeout(robbers[id].seconds*1000,function()
			if robbery then
				robbery = false
				vRP.giveInventoryItem(user_id,"dinheirosujo",parseInt(math.random(robbers[id].rewmin,robbers[id].rewmax)))
				for k,v in pairs(policia) do
					local policial = vRP.getUserSource(v)
					if policial then
						async(function()
							vCLIENT.stopRobberyPolice(policial)
							TriggerClientEvent('chatMessage',policial,"911",{64,64,255},"O roubo terminou, os assaltantes estão correndo antes que vocês cheguem.")
						end)
					end
				end
			end
		end)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOPROBBERY
-----------------------------------------------------------------------------------------------------------------------------------------
function src.stopRobbery()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if robbery then
			robbery = false
			rewardsNumber = 1
			local policia = vRP.getUsersByPermission("dpla.permissao")
			for k,v in pairs(policia) do
				local policial = vRP.getUserSource(v)
				if policial then
					async(function()
						vCLIENT.stopRobberyPolice(policial)
						TriggerClientEvent('chatMessage',policial,"911",{64,64,255},"O assaltante saiu correndo e deixou tudo para trás.")
					end)
				end
			end
		end
	end
end

function src.giveAwards()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if robbery then
			local rewardsList = {
				[1] = { ['index'] = "energetico", ['qtd'] = math.random(1,1) },
				[2] = { ['index'] = "energetico", ['qtd'] = math.random(1,1) },
				[3] = { ['index'] = "energetico", ['qtd'] = math.random(1,1) },
				[4] = { ['index'] = "energetico", ['qtd'] = math.random(1,1) },
				[5] = { ['index'] = "energetico", ['qtd'] = math.random(1,1) },
				[6] = { ['index'] = "energetico", ['qtd'] = math.random(1,1) },
				[7] = { ['index'] = "energetico", ['qtd'] = math.random(1,1) },
			}

			vRP.searchTimer(user_id,0)
			local receivedReward = vRP.itemNameList("dinheirosujo")
			local receivedAmount = math.random(6000,12000)
			if math.random(100) >= 60 then
				vRP.giveInventoryItem(user_id,"dinheirosujo",receivedAmount)
			else
				local rewardsNumber = math.random(#rewardsList)
				receivedAmount = parseInt(rewardsList[rewardsNumber].qtd)
				receivedReward = vRP.itemNameList(rewardsList[rewardsNumber].index)
				vRP.giveInventoryItem(user_id,rewardsList[rewardsNumber].index,receivedAmount)
			end
			
			TriggerClientEvent("Notify",source,"importante","Importante","Você recebeu <b>"..receivedAmount.."x "..receivedReward.."</b>.")
		end
	end
end