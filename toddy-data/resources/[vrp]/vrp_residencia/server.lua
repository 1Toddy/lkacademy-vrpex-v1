	local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
local idgens = Tools.newIDGenerator()
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("vrp_residencia",src)
vCLIENT = Tunnel.getInterface("vrp_residencia")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = {}
local timehouses = {}
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		for k,v in pairs(timehouses) do
			if v > 0 then
				timehouses[k] = v - 1
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKLOCKPICK
-----------------------------------------------------------------------------------------------------------------------------------------
function src.checkLockpick(id,x,y,z,x2,y2,z2)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local policia = vRP.getUsersByPermission("dpla.permissao")
		if #policia >= 3 then
			if timehouses[id] == 0 or not timehouses[id] then
				if vRP.getInventoryItemAmount(user_id,"lockpick") >= 1 then
					vRP.tryGetInventoryItem(user_id,"lockpick",1)
					timehouses[id] = 2400
					vCLIENT.checkStatus(source,true)
					vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)	
					TriggerClientEvent("progress",source,20000,"invadindo")
					TriggerClientEvent("Notify",source,"sucesso","Sucesso","<b>Lockpick</b> utilizada com sucesso.",8000)
					SetTimeout(20000,function()
						if math.random(100) >= 85 then
							timehouses[id] = 0
							vCLIENT.checkStatus(source,false)
							vRPclient._stopAnim(source,false)
							TriggerClientEvent("Notify",source,"negado","Negado","Fechadura emperrada.",8000)
						else
							if math.random(100) >= 90 then
								vCLIENT.createLocker(source,true,x2,y2,z2)
							else
								vCLIENT.createLocker(source,false,x2,y2,z2)
							end
							vRPclient.teleport(source,x,y,z)
						end
					end)
				else
					TriggerClientEvent("Notify",source,"negado","Negado","<b>Lockpick</b> não encontrada.",8000)
				end
			else
				TriggerClientEvent("Notify",source,"importante","Aguarde <b>"..timehouses[id].." segundos</b>.",8000)
			end
		else
			TriggerClientEvent("Notify",source,"aviso","Número insuficiente de policiais no momento.",8000)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMLIST
-----------------------------------------------------------------------------------------------------------------------------------------
local itemlist = {
	["gavetas"] = {
		[1] = { ['index'] = "dinheirosujo", ['qtd'] = math.random(500,700), ['name'] = "Dinheiro Sujo" },
		[2] = { ['index'] = "radio", ['qtd'] = 2, ['name'] = "Rádio" }
	},
	["estante"] = {
		[1] = { ['index'] = "dinheirosujo", ['qtd'] = math.random(500,700), ['name'] = "Dinheiro Sujo" }
	},
	["cabeceira"] = {
		[1] = { ['index'] = "dinheirosujo", ['qtd'] = math.random(500,700), ['name'] = "Dinheiro Sujo" }
	},
	["mesinha"] = {
		[1] = { ['index'] = "dinheirosujo", ['qtd'] = math.random(500,700), ['name'] = "Dinheiro Sujo" }
	},
	["televisao"] = {
		[1] = { ['index'] = "dinheirosujo", ['qtd'] = math.random(500,700), ['name'] = "Dinheiro Sujo" }
	},
	["armario"] = {
		[1] = { ['index'] = "dinheirosujo", ['qtd'] = math.random(500,700), ['name'] = "Dinheiro Sujo" }
	},
	["bau"] = {
		[1] = { ['index'] = "dinheirosujo", ['qtd'] = math.random(500,700), ['name'] = "Dinheiro Sujo" },
		[2] = { ['index'] = "tabletroubado", ['qtd'] = 3, ['name'] = "Tablet" },
		[3] = { ['index'] = "maconha", ['qtd'] = 10, ['name'] = "Maconha" },
		[4] = { ['index'] = "mochila", ['qtd'] = 1, ['name'] = "Mochila" }
	},
	["comoda"] = {
		[1] = { ['index'] = "dinheirosujo", ['qtd'] = math.random(500,700), ['name'] = "Dinheiro Sujo" },
		[2] = { ['index'] = "wbody|WEAPON_FLASHLIGHT", ['qtd'] = 1, ['name'] = "Lanterna" },
		[3] = { ['index'] = "celular", ['qtd'] = 2, ['name'] = "Celular" }
	},
	["roupas"] = {
		[1] = { ['index'] = "dinheirosujo", ['qtd'] = math.random(500,700), ['name'] = "Dinheiro Sujo" },
		[2] = { ['index'] = "mochila", ['qtd'] = 1, ['name'] = "Mochila" }
	},
	["pia"] = {
		[1] = { ['index'] = "celular", ['qtd'] = 2, ['name'] = "Celular" }
	},
	["cama"] = {
		[1] = { ['index'] = "dinheirosujo", ['qtd'] = math.random(500,700), ['name'] = "Dinheiro Sujo" },
		[2] = { ['index'] = "wbody|WEAPON_DAGGER", ['qtd'] = 2, ['name'] = "Adaga" },
		[3] = { ['index'] = "maconha", ['qtd'] = 5, ['name'] = "Maconha" },
	},
	["locker2"] = {
		[1] = { ['index'] = "dinheirosujo", ['qtd'] = math.random(5000,25000), ['name'] = "Dinheiro Sujo" }
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKPAYMENT
-----------------------------------------------------------------------------------------------------------------------------------------
function src.checkPayment(house,mod,x,y,z)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRPclient.getAgachar(source) then
			randlist = math.random(100)
		else
			randlist = math.random(130)
		end
		if randlist <= 84 then
			local randitem = math.random(#itemlist[mod])
			vRP.giveInventoryItem(user_id,itemlist[mod][randitem].index,itemlist[mod][randitem].qtd)
			TriggerClientEvent("Notify",source,"sucesso","Sucesso","Você encontrou "..itemlist[mod][randitem].qtd.."x <b>"..itemlist[mod][randitem].name.."</b>.",8000)
		elseif randlist >= 85 and randlist <= 95 then
			TriggerClientEvent("Notify",source,"importante","Compartimento vazio.",8000)
		elseif randlist >= 96 then
			TriggerClientEvent("vrp_sound:source",source,'alarm',0.4)
			local policia = vRP.getUsersByPermission("dpla.permissao")
			for k,v in pairs(policia) do
				local player = vRP.getUserSource(parseInt(v))
				if player then
					async(function()
						local ids = idgens:gen()
						vRPclient.playSound(player,"Oneshot_Final","MP_MISSION_COUNTDOWN_SOUNDSET")
						blips[ids] = vRPclient.addBlip(player,x,y,z,1,59,"Roubo em andamento",0.5,true)
						TriggerClientEvent('chatMessage',player,"911",{65,130,255},"O alarme da residência ^1"..house.."^0 disparou, verifique o ocorrido.")
						SetTimeout(30000,function() vRPclient.removeBlip(player,blips[ids]) idgens:free(ids) end)
					end)
				end
			end
		end
	end
end