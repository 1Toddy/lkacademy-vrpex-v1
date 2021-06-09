local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
oC = {}
Tunnel.bindInterface("rush_craftwammo",oC)

local webhookarmas = "https://discord.com/api/webhooks/798075921931960340/BKSx4TeiBnyGnXfxws1PGb6HBc0sGq42UrRZT2xOT_3D_ynRhJ4hDy2ocQL1ahGzsoOP"

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
--[ ARRAY ]------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local armas = {
	--{ item = "g36" },
	--{ item = "sawnoffshotgun" },
	{ item = "fiveseven" },
	{ item = "sns" }
}
-----------------------------------------------------------------------------------------------------------------------------------
--[ EVENTOS ]----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("produzir-muni")
AddEventHandler("produzir-muni",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		for k,v in pairs(armas) do
			if item == v.item then
                if item == "fiveseven" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|WEAPON_PISTOL_MK2") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"componente") >= 50 then
                                        if vRP.tryGetInventoryItem(user_id,"componente",50) then
                                            TriggerClientEvent("fechar-m-nuis",source)

                                            TriggerClientEvent("progress",source,10000,"Montando Shotgun")
                                            TriggerClientEvent("bancada-armas:posicao",source)
                                            vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

                                            SetTimeout(10000,function()
                                                vRPclient._stopAnim(source,false)
                                                vRP.giveInventoryItem(user_id,"wammo|WEAPON_PISTOL_MK2",20)
                                                TriggerClientEvent("Notify",source,"sucesso","Sucesso","Você montou <b>20x munições</b>.")
                                                SendWebhookMessage(webhookarmas,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[FABRICOU]: 20x Munições "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
                                            end)
                                        end
                        else
                            TriggerClientEvent("Notify",source,"negado","Negado","Você não tem <b>50x Componentes")
                        end
					else
						TriggerClientEvent("Notify",source,"negado","Negado","Espaço insuficiente na mochila.")
                    end
                elseif item == "sns" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("wammo|WEAPON_SMG_MK2") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"componente") >= 80 then -- 10 + 10 + 5
                                        if vRP.tryGetInventoryItem(user_id,"componente",80) then
                                            TriggerClientEvent("fechar-m-nuis",source)

                                            TriggerClientEvent("progress",source,10000,"Montando SMG")
                                            TriggerClientEvent("bancada-armas:posicao",source)
                                            vRPclient._playAnim(source,false,{{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"}},true)

                                            SetTimeout(10000,function()
                                                vRPclient._stopAnim(source,false)
                                                vRP.giveInventoryItem(user_id,"wammo|WEAPON_SMG_MK2",50)
                                                TriggerClientEvent("Notify",source,"sucesso","Sucesso","Você montou uma <b>20x munições</b>.")
                                                SendWebhookMessage(webhookarmas,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[FABRICOU]: 1x SMG "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
                                            end)
                                        end
                                    else
                            TriggerClientEvent("Notify",source,"negado","Negado","Você não tem <b>80x Componentes")
                        end
					else
						TriggerClientEvent("Notify",source,"negado","Negado","Espaço insuficiente na mochila.")
                    end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------
--[ FUNÇÃO DE PERMISSÃO ]----------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
function oC.checkPermissao()
    local source = source
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"albanesa.permissao") or vRP.hasPermission(user_id,"servia.permissao") then
        return true
    end
end