local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- ARRAY
-----------------------------------------------------------------------------------------------------------------------------------------
local valores = {
	{ item = "wbody|WEAPON_KNIFE", quantidade = 1, compra = 500 },
	{ item = "wbody|WEAPON_DAGGER", quantidade = 1, compra = 500 },
	{ item = "wbody|WEAPON_KNUCKLE", quantidade = 1, compra = 500},
	{ item = "wbody|WEAPON_MACHETE", quantidade = 1, compra = 500 },
	{ item = "wbody|WEAPON_SWITCHBLADE", quantidade = 1, compra = 500 },
	{ item = "wbody|WEAPON_WRENCH", quantidade = 1, compra = 500 },
	{ item = "wbody|WEAPON_HAMMER", quantidade = 1, compra = 500},
	{ item = "wbody|WEAPON_GOLFCLUB", quantidade = 1, compra = 500 },
	{ item = "wbody|WEAPON_CROWBAR", quantidade = 1, compra = 500},
	{ item = "wbody|WEAPON_HATCHET", quantidade = 1, compra = 500},
	{ item = "wbody|WEAPON_FLASHLIGHT", quantidade = 1, compra = 2000},
	{ item = "wbody|WEAPON_BAT", quantidade = 1, compra = 2000},
	{ item = "wbody|WEAPON_BOTTLE", quantidade = 1, compra = 2000},
	{ item = "wbody|WEAPON_BATTLEAXE", quantidade = 1, compra = 2000 },
	{ item = "wbody|WEAPON_POOLCUE", quantidade = 1, compra = 2000},
	{ item = "wbody|WEAPON_STONE_HATCHET", quantidade = 1, compra = 1000 },

	{ item = "wbody|GADGET_PARACHUTE", quantidade = 1, compra = 1000 },
	{ item = "compattach", quantidade = 1, compra = 10000 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMPRAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("armamentos-comprar")
AddEventHandler("armamentos-comprar",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if item == "colete" then
			if vRP.tryFullPayment(user_id,10000) then
				vRP.giveInventoryItem(user_id,"colete",1,true)
				TriggerClientEvent("Notify",source,"financeiro","Financeiro","Comprou <b>1x Colete</b> por <b>$10.000 dólares</b>.")
			else
				TriggerClientEvent("Notify",source,"financeiro","Financeiro","Dinheiro insuficiente.")
			end
		else
			for k,v in pairs(valores) do
				if item == v.item then
					if vRP.getInfinity(user_id) then 
					if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(v.item)*v.quantidade <= vRP.getInventoryMaxWeight(user_id) then
						if vRP.tryFullPayment(user_id,parseInt(v.compra*0.90)) then
							vRP.giveInventoryItem(user_id,v.item,parseInt(v.quantidade))
							TriggerClientEvent("Notify",source,"financeiro","Financeiro","Comprou <b>"..parseInt(v.quantidade).."x "..vRP.itemNameList(v.item).."</b> por <b>$"..vRP.format(parseInt(v.compra*0.90)).." dólares</b>.")
						else
							TriggerClientEvent("Notify",source,"importante","Importante","Dinheiro insuficiente.")
						end
					else
						TriggerClientEvent("Notify",source,"importante","Importante","Espaço insuficiente.")
					end
				else
					if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(v.item)*v.quantidade <= vRP.getInventoryMaxWeight(user_id) then
						if vRP.tryFullPayment(user_id,parseInt(v.compra)) then
							vRP.giveInventoryItem(user_id,v.item,parseInt(v.quantidade))
							TriggerClientEvent("Notify",source,"importante","Importante","Comprou <b>"..parseInt(v.quantidade).."x "..vRP.itemNameList(v.item).."</b> por <b>$"..vRP.format(parseInt(v.compra)).." dólares</b>.")
						else
							TriggerClientEvent("Notify",source,"importante","Importante","Dinheiro insuficiente.")
						end
					else
						TriggerClientEvent("Notify",source,"importante","Importante","Espaço insuficiente.")
        			    end
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VENDER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("armamentos-vender")
AddEventHandler("armamentos-vender",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(valores) do
			if item == v.item then
				if vRP.tryGetInventoryItem(user_id,v.item,parseInt(v.quantidade)) then
					vRP.giveMoney(user_id,parseInt(v.venda))
					TriggerClientEvent("Notify",source,"importante","Importante","Vendeu <b>"..parseInt(v.quantidade).."x "..vRP.itemNameList(v.item).."</b> por <b>$"..vRP.format(parseInt(v.venda)).." dólares</b>.")
				else
					TriggerClientEvent("Notify",source,"importante","Importante","Não possui <b>"..parseInt(v.quantidade).."x "..vRP.itemNameList(v.item).."</b> em sua mochila.")
				end
			end
		end
	end
end)