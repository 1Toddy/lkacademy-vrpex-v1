-- DEFAULT --
local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
GFclient = Tunnel.getInterface("rush_gifts")

GIFTs = {}
Proxy.addInterface("rush_gifts", GIFTs) -- comunicação entre resources
Tunnel.bindInterface("rush_gifts", GIFTs) -- comunicação entre client <-> server

local pickup_positions = {}
local total_gifts_requested = 0
local condneve = 0

RegisterCommand('rizegifts', function(source, args, rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id ~= nil then
		local player = vRP.getUserSource(user_id)
		if vRP.hasPermission(user_id,"administrador.permissao") and args[1] ~= nil then
			local qtd = tonumber(args[1])
			if qtd < 1 then qtd = 1 end
			if qtd > 100 then qtd = 100 end
			total_gifts_requested = total_gifts_requested + qtd
			TriggerClientEvent('chatMessage', player, '', { 255, 255, 255 }, '^2* Requested Gifts: ' .. qtd ..'')
			if total_gifts_requested > 0 then
				
				for i=1,total_gifts_requested do
					local newPickup = {id = math.random(1, 9999), position = {}, spawned = false, collecting = false }
					table.insert(pickup_positions, newPickup)
					TriggerClientEvent("rush:gift:host_request_new_dropper", player, newPickup.id)
					total_gifts_requested = total_gifts_requested - 1
				end
				local users = vRP.getUsers()
				for k,v in pairs(users) do
					local target_source = vRP.getUserSource(k)
					if target_source ~= nil then
						TriggerClientEvent("rush:gift:midsizedMessage", target_source, 21, "Presente pela cidade", "Deixamos presentes pela cidade!", 6)
					end
				end
			end
		end
	end
end)

RegisterServerEvent("rush:gift:host_request_new_dropper_callback")
AddEventHandler("rush:gift:host_request_new_dropper_callback", function(loc_id,loc_position)
	--print("ID: " .. loc_id .. " - Pos:" ..loc_position.x .. " - " ..loc_position.y .. " - " .. loc_position.z)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id ~= nil then
		local player = vRP.getUserSource(user_id)
		for k,v in pairs(pickup_positions) do
			if v.id == loc_id and not v.spawned then
				v.position = loc_position
				v.spawned = true
				TriggerClientEvent("rush:gift:new_dropper", -1, v.id, v.position)
				SetTimeout(15*60*1000, function()
					TriggerClientEvent("rush:gift:remove_dropper", -1, v.id)
				end)
			end
		end
	end
end)

--[[ Items ]]
local SpecialItem = "dinheirosujo"

local whiteWeapons = {
	"WEAPON_BAT",
	"WEAPON_KNUCKLE",
	"WEAPON_KNIFE",
	"WEAPON_FLASHLIGHT",
	"WEAPON_GOLFCLUB",
	"WEAPON_HAMMER",
	"WEAPON_CROWBAR",
	"WEAPON_HATCHET",
	"WEAPON_DAGGER",
	"WEAPON_MACHETE",
	"WEAPON_BOTTLE",
}

local commonLethalWeapons = {
	"WEAPON_PISTOL",
	"WEAPON_COMBATPISTOL",
	"WEAPON_STUNGUN"
}
local rareLethalWeapons = {
	"WEAPON_SMG",
	"WEAPON_ASSAULTSMG",
	"WEAPON_PUMPSHOTGUN"
}
local epicLethalWeapons = {
	"WEAPON_CARBINERIFLE",
	"WEAPON_ASSAULTRIFLE",
}


RegisterServerEvent("rush:pickup_dropper")
AddEventHandler("rush:pickup_dropper", function(loc_id)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id ~= nil then
		local player = vRP.getUserSource(user_id)
		for k,v in pairs(pickup_positions) do
			if v.id == loc_id and v.spawned and not v.collecting then
				v.collecting = true
				TriggerClientEvent("rush:gift:remove_dropper", -1, loc_id)

				local itemanameRandom = ""
				local lucky = math.random(1, 10000)

				if lucky <= 5000 then
					local moneyRandom = math.random(2000, 10000)
					vRP.giveMoney(user_id, moneyRandom)
					vRPclient.notify(player,"Você ganhou R$" ..moneyRandom)
					vRP.giveInventoryItem(user_id, SpecialItem, 10, true)
					SendWebhookMessage(ac_webhook_gifter, "**ADMIN #1 Gift** \n```\nID: "..user_id.." Money: "..moneyRandom.." Lucky: "..lucky.."```")
				elseif lucky > 5000 and lucky <= 8000 then
					local ceiaRandom = math.random(1, 2)
					vRP.giveInventoryItem(user_id, "ceianatalina", ceiaRandom,true)
					vRP.giveInventoryItem(user_id, SpecialItem, 10, true)
					SendWebhookMessage(ac_webhook_gifter, "**ADMIN #2 Gift** \n```\nID: "..user_id.." Ceia: "..ceiaRandom.." Lucky: "..lucky.."```")
				elseif lucky > 8000 and lucky <= 9000 then
					itemanameRandom = whiteWeapons[math.random(1, #whiteWeapons)]
					vRP.giveInventoryItem(user_id, "wbody|"..itemanameRandom, 1,true)
					vRP.giveInventoryItem(user_id, SpecialItem, 20, true)
					SendWebhookMessage(ac_webhook_gifter, "**ADMIN #3 Gift** \n```\nID: "..user_id.." whiteWeapons: "..itemanameRandom.." Lucky: "..lucky.."```")
				elseif lucky > 9000 and lucky <= 9500 then
					itemanameRandom = commonLethalWeapons[math.random(1, #commonLethalWeapons)]
					vRP.giveInventoryItem(user_id, "wbody|"..itemanameRandom, 1,true)
					vRP.giveInventoryItem(user_id, SpecialItem, 30, true)
					SendWebhookMessage(ac_webhook_gifter, "**ADMIN ##4 Gift** \n```\nID: "..user_id.." commonLethalWeapons: "..itemanameRandom.." Lucky: "..lucky.."```")
				elseif lucky > 9500 and lucky <= 9800 then
					itemanameRandom = rareLethalWeapons[math.random(1, #rareLethalWeapons)]
					vRP.giveInventoryItem(user_id, "wbody|"..itemanameRandom, 1,true)
					vRP.giveInventoryItem(user_id, SpecialItem, 40, true)
					SendWebhookMessage(ac_webhook_gifter, "**ADMIN ###5 Gift** \n```\nID: "..user_id.." rareLethalWeapons: "..itemanameRandom.." Lucky: "..lucky.."```")
				elseif lucky > 9800 and lucky <= 9820 then
					itemanameRandom = epicLethalWeapons[math.random(1, #epicLethalWeapons)]
					vRP.giveInventoryItem(user_id, "wbody|"..itemanameRandom, 1,true)
					vRP.giveInventoryItem(user_id, SpecialItem, 50, true)
					SendWebhookMessage(ac_webhook_gifter, "**ADMIN ####6 Gift** \n```\nID: "..user_id.." epicLethalWeapons: "..itemanameRandom.." Lucky: "..lucky.."```")
				else
					vRPclient.notify(player,"Você deu azar, e não ganhou nada.")
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	ac_webhook_gifter = GetConvar("ac_webhook_gifter", "none")

	function SendWebhookMessage(webhook,message)
		if webhook ~= "none" then
			PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
		end
	end
end)