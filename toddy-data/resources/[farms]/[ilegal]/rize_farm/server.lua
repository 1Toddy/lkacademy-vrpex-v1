local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
func = {}
Tunnel.bindInterface("dexter_farm",func)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function func.checkPermission(perm)
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,perm)
end

local src = {
	[1] = { ['re'] = nil, ['reqtd'] = nil, ['item'] = "folhademaconha", ['itemqtd'] = 2 },
	[2] = { ['re'] = "folhademaconha", ['reqtd'] = 2, ['item'] = "maconhamacerada", ['itemqtd'] = 2 },
	[3] = { ['re'] = "maconhamacerada", ['reqtd'] = 2, ['item'] = "maconha", ['itemqtd'] = 2 },

	--[4] = { ['re'] = nil, ['reqtd'] = nil, ['item'] = "capsula", ['itemqtd'] = 20 },
	--[5] = { ['re'] = "capsula", ['reqtd'] = 20, ['item'] = "polvora", ['itemqtd'] = 20 },
	--[6] = { ['re'] = "polvora", ['reqtd'] = 20, ['item'] = "wammo|WEAPON_ASSAULTSMG", ['itemqtd'] = 20 },
	--[7] = { ['re'] = "polvora", ['reqtd'] = 20, ['item'] = "wammo|WEAPON_ASSAULTRIFLE_MK2", ['itemqtd'] = 20 },
	--[8] = { ['re'] = "polvora", ['reqtd'] = 20, ['item'] = "wammo|WEAPON_SPECIALCARBINE", ['itemqtd'] = 20 },
	--[9] = { ['re'] = "polvora", ['reqtd'] = 20, ['item'] = "wammo|WEAPON_PISTOL_MK2", ['itemqtd'] = 20 },
	--[10] = { ['re'] = "polvora", ['reqtd'] = 20, ['item'] = "wammo|WEAPON_HEAVYPISTOL", ['itemqtd'] = 20 },
	--[11] = { ['re'] = "polvora", ['reqtd'] = 20, ['item'] = "wammo|WEAPON_COMBATPDW", ['itemqtd'] = 20 },
	--[12] = { ['re'] = "polvora", ['reqtd'] = 20, ['item'] = "wammo|WEAPON_MACHINEPISTOL", ['itemqtd'] = 20 },
	--[13] = { ['re'] = "polvora", ['reqtd'] = 20, ['item'] = "wammo|WEAPON_MINISMG", ['itemqtd'] = 20 },

	[4] = { ['re'] = nil, ['reqtd'] = nil, ['item'] = "folhadecoca", ['itemqtd'] = 2 },
	[5] = { ['re'] = "folhadecoca", ['reqtd'] = 2, ['item'] = "cocamisturada", ['itemqtd'] = 2 },
	[6] = { ['re'] = "cocamisturada", ['reqtd'] = 2, ['item'] = "cocaina", ['itemqtd'] = 2 },

	[7] = { ['re'] = nil, ['reqtd'] = nil, ['item'] = "complsd", ['itemqtd'] = 2 },
	[8] = { ['re'] = "complsd", ['reqtd'] = 2, ['item'] = "acidolisergico", ['itemqtd'] = 2 },
	[9] = { ['re'] = "acidolisergico", ['reqtd'] = 2, ['item'] = "lsd", ['itemqtd'] = 2 },

	--[18] = { ['re'] = nil, ['reqtd'] = nil, ['item'] = "pendriveinformacoes", ['itemqtd'] = 4 },
	--[19] = { ['re'] = "pendriveinformacoes", ['reqtd'] = 4, ['item'] = "acessodeepweb", ['itemqtd'] = 4 },
	--[10] = { ['re'] = "acessodeepweb", ['reqtd'] = 4, ['item'] = "keysinvasao", ['itemqtd'] = 4 },
	[10] = { ['re'] = nil, ['reqtd'] = nil, ['item'] = "bacteria", ['itemqtd'] = 10 },
	[11] = { ['re'] = "bacteria", ['reqtd'] = 10, ['item'] = "capsulas", ['itemqtd'] = 5 },
	[12] = { ['re'] = "capsulas", ['reqtd'] = 5, ['item'] = "remediomanipulado", ['itemqtd'] = 2 },

	--[24] = { ['re'] = nil, ['reqtd'] = nil, ['item'] = "capsula", ['itemqtd'] = 20 },
	[25] = { ['re'] = "capsulas", ['reqtd'] = 20, ['item'] = "polvora", ['itemqtd'] = 20 },
	[26] = { ['re'] = "polvora", ['reqtd'] = 20, ['item'] = "wammo|WEAPON_SMG_MK2", ['itemqtd'] = 30 },
    [27] = { ['re'] = "polvora", ['reqtd'] = 20, ['item'] = "wammo|WEAPON_PISTOL_MK2", ['itemqtd'] = 30 },
    
	[28] = { ['re'] = "capsulas", ['reqtd'] = 20, ['item'] = "polvora", ['itemqtd'] = 20 },
	[29] = { ['re'] = "polvora", ['reqtd'] = 20, ['item'] = "wammo|WEAPON_SMG_MK2", ['itemqtd'] = 30 },
    [30] = { ['re'] = "polvora", ['reqtd'] = 20, ['item'] = "wammo|WEAPON_PISTOL_MK2", ['itemqtd'] = 30 },
}

function func.checkPayment(id)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if src[id].re ~= nil then
			if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(src[id].item)*src[id].itemqtd <= vRP.getInventoryMaxWeight(user_id) then
				if vRP.tryGetInventoryItem(user_id,src[id].re,src[id].reqtd,false) then
					vRP.giveInventoryItem(user_id,src[id].item,src[id].itemqtd,false)
					vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a", "idle_a_female"}},true)
					return true
				end
			end
		else
			if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(src[id].item)*src[id].itemqtd <= vRP.getInventoryMaxWeight(user_id) then
				vRP.giveInventoryItem(user_id,src[id].item,src[id].itemqtd,false)
				vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a", "idle_a_female"}},true)
				return true
			end
		end
	end
end
--[[
local src2 = {
	[1] = { ['re'] = "pecadearma", ['reqtd'] = 4, ['item'] = "armacaodearma", ['itemqtd'] = 1, ['valor'] = 0 },
	[2] = { ['re'] = "armacaodearma", ['reqtd'] = 10, ['item'] = "wbody|WEAPON_ASSAULTSMG", ['itemqtd'] = 1, ['valor'] = 35000 },
	[3] = { ['re'] = "armacaodearma", ['reqtd'] = 15, ['item'] = "wbody|WEAPON_ASSAULTRIFLE_MK2", ['itemqtd'] = 1, ['valor'] = 60000 },	
	[4] = { ['re'] = "armacaodearma", ['reqtd'] = 5, ['item'] = "wbody|WEAPON_PISTOL_MK2", ['itemqtd'] = 1, ['valor'] = 15000 },
	
	[5] = { ['re'] = "pecadearma", ['reqtd'] = 4, ['item'] = "armacaodearma", ['itemqtd'] = 1, ['valor'] = 0 },
	[6] = { ['re'] = "armacaodearma", ['reqtd'] = 15, ['item'] = "wbody|WEAPON_SPECIALCARBINE", ['itemqtd'] = 1, ['valor'] = 60000 },
	[7] = { ['re'] = "armacaodearma", ['reqtd'] = 10, ['item'] = "wbody|WEAPON_COMBATPDW", ['itemqtd'] = 1, ['valor'] = 35000 },	
	[8] = { ['re'] = "armacaodearma", ['reqtd'] = 5, ['item'] = "wbody|WEAPON_HEAVYPISTOL", ['itemqtd'] = 1, ['valor'] = 15000 }
}

function func.checkPayment2(id)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if src2[id].re ~= nil then
			if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(src2[id].item)*src2[id].itemqtd <= vRP.getInventoryMaxWeight(user_id) then
				--if vRP.tryGetInventoryItem(user_id,src2[id].re,src2[id].reqtd,false) and vRP.tryPayment(user_id,parseInt(src2[id].valor)) then
				if vRP.getInventoryItemAmount(user_id,src2[id].re) >= src2[id].reqtd and vRP.getMoney(user_id) >= parseInt(src2[id].valor) then
					vRP.tryGetInventoryItem(user_id,src2[id].re,src2[id].reqtd,false)
					vRP.giveInventoryItem(user_id,src2[id].item,src2[id].itemqtd,false)
					vRP.tryPayment(user_id,parseInt(src2[id].valor))
					vRPclient._playAnim(source,false,{{"mini@repair","fixing_a_ped"}},true)
					return true
				else 
					TriggerClientEvent("Notify",source,"importante","Você não possui <b>"..src2[id].reqtd.."x</b> <b>"..src2[id].re.."</b> ou <b>R$"..src2[id].valor.."</b> de dinheiro.")
				end
			end
		end		
	end
end

]]
local src3 = {
	[1] = { ['re'] = nil, ['reqtd'] = nil, ['item'] = "linha", ['itemqtd'] = 5 },
	[2] = { ['re'] = "linha", ['reqtd'] = 5, ['item'] = "encomendaroupa", ['itemqtd'] = 1 },
}


function func.checkPayment3(id)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if src3[id].re ~= nil then
			if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(src3[id].item)*src3[id].itemqtd <= vRP.getInventoryMaxWeight(user_id) then
				if vRP.tryGetInventoryItem(user_id,src3[id].re,src3[id].reqtd,false) then
					vRP.giveInventoryItem(user_id,src3[id].item,src3[id].itemqtd,false)		

					vRPclient._playAnim(source,false,{{"anim@amb@business@coc@coc_packing_hi@","full_cycle_v1_pressoperator"}},true)					
					return true
				end
			end
		else
			if vRP.getInventoryWeight(user_id)+vRP.getItemWeight(src3[id].item)*src3[id].itemqtd <= vRP.getInventoryMaxWeight(user_id) then
				vRP.giveInventoryItem(user_id,src3[id].item,src3[id].itemqtd,false)
				vRPclient._playAnim(source,false,{{"anim@amb@business@coc@coc_packing_hi@","full_cycle_v1_pressoperator"}},true)
				return true
			end
		end
	end
end

