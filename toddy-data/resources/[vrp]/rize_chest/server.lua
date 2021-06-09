-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
src = {}
Tunnel.bindInterface("rize_chest",src)
vCLIENT = Tunnel.getInterface("rize_chest")
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookbaupolicia1 = "https://discord.com/api/webhooks/799813796851220490/krR3smuatM-PiRrnDO0Q5X0V34ok_j--BlCP00Q-TRSBQJ5cHbTqzJ2p1QRBxyY3Sw9O"
local webhookbauvagos1 = "https://discord.com/api/webhooks/847244088209833995/c4iVlZyt58qeI6iC3g4fqYifp2L13p7n0Brs9JqEhmC9iapbFHlCoSpL0b6AAHWN1jkD"
local webhookbaugroove1 = "https://discord.com/api/webhooks/847243934614290473/7rTzcLGLT4zRIZxJp7jrXuA6OMvXfWuGoutZPZEx9sr6bmBdlvIOBt9vRbOGSq_u-Qca"
local webhookbauballas1 = "https://discord.com/api/webhooks/847244035903062059/EsXahhNq6cwqht5ns6iM_XkBFb4cTWcsPcKfRS03xzdP-1F11ObBgu0aIlS5A5ZQTG-K"
local webhookbaualbanesa = "https://discord.com/api/webhooks/847244897035223040/d7tJL9jwh5JNGyTj_r9Xx4nFwAqhamS5yL8Au_51SHq4NTu9_gilFCUTNnhdWcNGCkcr"
local webhookbaucrips1 = "https://discord.com/api/webhooks/847244267372937246/zpKwPkFwLYIcjRQMfMPMhgewxHprljo2bvsylbKFhuIP7JPHRMEgDeY-386RGRPDJnws"
local webhookbaubloods1 = "https://discord.com/api/webhooks/847244409624199219/oDrEd5Cagu_L7vfRdUsAoi2d0RGogWFNpi-g-LepsuRx3wnmrNwGc027yGxD7x2qAB5S"
local webhookbaucartel1 = "https://discord.com/api/webhooks/779081385817931839/pJLVLiNWxFKrveaj4dlJM-bX5iMwv8h6dAbnf4ISlxlW0Y_8Hg3j7hHeNtijMBjDbEiZ"
local webhooklifeinvader1 = "https://discord.com/api/webhooks/847244732295938048/ouBE04QxbweDzObytNeUKYwKYFDWapbewyhyCkDABaxFv5nQg3f7TCrsJo2Hepo_N0R2"
local webhookbaubahamas1 = "https://discord.com/api/webhooks/847245039020670996/HNVgpJhvtPWJCNwy0ccKMy2ZEm6LO4qFAYs2Ef7qdpnVW8NxzplFq1DF_eE5wqFDZ9A2"
local webhookbauhospital1 = "https://discord.com/api/webhooks/799815000424185897/nKV4I-1yBfOPLkz0NrdVyjXRneUJcWseYsDJV7EeU9HQffiagILm6_iYbUwEZUtpLNlw"
local webhookbauservia = "https://discord.com/api/webhooks/847244415038521355/U9Zvx2HsobOKhwjcZA9Q7YGxcqo2d73U3sX6mNEpsJbugHdWloiNGBi56SIbB2gfsWlZ"


function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHEST
-----------------------------------------------------------------------------------------------------------------------------------------

local chest = {
    ["Policia"] = {30000, "policia.permissao"},
    ["PoliciaN"] = {30000, "policia.permissao"},
	["Hospital"] = {30000, "dmla.permissao"},
    ["Albanesa"] = {30000, "albanesa.permissao"},
    ["Servia"] = {30000, "servia.permissao"},
	["Ballas"] = {30000, "ballas.permissao"},
	["Grove"] = {30000, "grove.permissao"},
	["Vagos"] = {30000, "vagos.permissao"},
	["Crips"] = {30000, "crips.permissao"},
	["Bloods"] = {30000, "bloods.permissao"},
	["Life"] = {30000, "life.permissao"},
	["Bennys"] = {30000, "b.permissao"},
	["LS"] = {30000, "ls.permissao"},
	["Bahamas"] = {30000, "bahamas.permissao"}
	}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIÁVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local actived = {}
local opened = {}
local chestTimer = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACTIVEDOWNTIME
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		for k,v in pairs(actived) do
			if v > 0 then
				actived[k] = v - 1
				if v == 0 then
					actived[k] = nil
				end
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CHESTTIMER
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        if chestTimer > 0 then
            chestTimer = chestTimer - 1
        end
    end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKINTPERMISSIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function src.checkIntPermissions(chestName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if not vRP.searchReturn(source,user_id) then
			if vRP.hasPermission(user_id,chest[chestName][2]) then
				return true
			end
		end
	end
	return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- OPENCHEST
-----------------------------------------------------------------------------------------------------------------------------------------
function src.openChest(chestName)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local hsinventory = {}
		local myinventory = {}
		local data = vRP.getSData("chest:"..tostring(chestName))
        local result = json.decode(data) or {}
        TriggerClientEvent("vrp_sound:source",source,'mochila',0.2)
		if result then
			for k,v in pairs(result) do
				table.insert(hsinventory,{ amount = parseInt(v.amount), name = vRP.itemNameList(k), index = vRP.itemIndexList(k), key = k, peso = vRP.getItemWeight(k) })
			end

			local inv = vRP.getInventory(parseInt(user_id))
			for k,v in pairs(inv) do
				table.insert(myinventory,{ amount = parseInt(v.amount), name = vRP.itemNameList(k), index = vRP.itemIndexList(k), key = k, peso = vRP.getItemWeight(k) })
			end
		end
		return hsinventory,myinventory,vRP.getInventoryWeight(user_id),vRP.getInventoryMaxWeight(user_id),vRP.computeItemsWeight(result),parseInt(chest[tostring(chestName)][1])
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOREITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function src.storeItem(chestName,itemName,amount)
    local source = source
    if itemName then
        local user_id = vRP.getUserId(source)
        local identity = vRP.getUserIdentity(user_id)
        if user_id  then
            if string.match(itemName,"identidade") then
                TriggerClientEvent("Notify",source,"importante","Importante","Não pode guardar este item.",8000)
                return
            end
 
            local data = vRP.getSData("chest:"..tostring(chestName))
            local items = json.decode(data) or {}
            if items then
                if parseInt(amount) > 0 then
                    local new_weight = vRP.computeItemsWeight(items)+vRP.getItemWeight(itemName)*parseInt(amount)
                    if new_weight <= parseInt(chest[tostring(chestName)][1]) then
                        if actived[parseInt(user_id)] == 0 or not actived[parseInt(user_id)] then
                            if chestName == "Policia" then
                                SendWebhookMessage(webhookbaupolicia,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
                                SendWebhookMessage(webhookbaupolicia1,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
                          
                            elseif chestName == "Ballas" then
                                SendWebhookMessage(webhookbauballas,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
                                SendWebhookMessage(webhookbauballas1,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
 
                            elseif chestName == "Vagos" then
                                SendWebhookMessage(webhookbauvagos,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
                                SendWebhookMessage(webhookbauvagos1,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
 
                            elseif  chestName == "Grove" then
                                SendWebhookMessage(webhookbaugroove,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
                                SendWebhookMessage(webhookbaugroove1,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
 
                            elseif  chestName == "Crips" then
                                SendWebhookMessage(webhookbaucrips,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
                                SendWebhookMessage(webhookbaucrips1,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
 
                            elseif  chestName == "Bloods1" then
                                SendWebhookMessage(webhookbaubloods,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
                                SendWebhookMessage(webhookbaubloods1,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
 
                            elseif  chestName == "Servia" then
                                SendWebhookMessage(webhookbauservia,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
                                SendWebhookMessage(webhookbauservia,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
                            
                            elseif  chestName == "Cartel" then
                                SendWebhookMessage(webhookbaucartel,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
                                SendWebhookMessage(webhookbaucartel1,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
 
                            elseif  chestName == "Life" then
                                SendWebhookMessage(webhooklifeinvader,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
                                SendWebhookMessage(webhooklifeinvader1,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
 
                            elseif  chestName == "Albanesa" then
                                SendWebhookMessage(webhookbaualbanesa,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
                                SendWebhookMessage(webhookbaualbanesa,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
 
                            elseif  chestName == "Hospital" then
                                SendWebhookMessage(webhookbauhospital,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
                                SendWebhookMessage(webhookbauhospital1,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
 
                            elseif  chestName == "Bahamas" then
                                SendWebhookMessage(webhookbaubahamas,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
                                SendWebhookMessage(webhookbaubahamas1,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
  
                            elseif  chestName == "Bennys" then
                                SendWebhookMessage(webhookbaubennys,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
                                SendWebhookMessage(webhookbaubennys1,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[GUARDOU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
                    
                            end
                            if user_id and vRP.tryGetInventoryItem(parseInt(user_id),itemName,parseInt(amount)) then
                                actived[parseInt(user_id)] = 4
                                chestTimer = 10
                                if items[itemName] ~= nil then
                                    items[itemName].amount = parseInt(items[itemName].amount) + parseInt(amount)
                                else
                                    items[itemName] = { amount = parseInt(amount) }
                                end
                                vRP.setSData("chest:"..tostring(chestName),json.encode(items))
                                TriggerClientEvent('KSRP:UpdateChest',source,'updateChest')
                            else
                                TriggerClientEvent("Notify",source,"aviso","Aviso","Você está fazendo ações muito rapido!")
                            end 
                        end
                    else
                        TriggerClientEvent("Notify",source,"Negado","Negado","<b>Chest</b> cheio.",8000)
                    end
                else
                    TriggerClientEvent("Notify",source,"Negado","Negado","Digite o valor corretamente.",8000)
                end
            end
        end
    end
    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKEITEM
-----------------------------------------------------------------------------------------------------------------------------------------
function src.takeItem(chestName,itemName,amount)
    local source = source
    if itemName then
        local user_id = vRP.getUserId(source)
        local identity = vRP.getUserIdentity(user_id)
        if user_id then
            local data = vRP.getSData("chest:"..tostring(chestName))
            local items = json.decode(data) or {}
            if items then
                if parseInt(amount) > 0 then
                    if items[itemName] ~= nil and parseInt(items[itemName].amount) >= parseInt(amount) then
                        if vRP.getInventoryWeight(parseInt(user_id))+vRP.getItemWeight(itemName)*parseInt(amount) <= vRP.getInventoryMaxWeight(parseInt(user_id)) then
                            if chestName == "Policia" then
                                SendWebhookMessage(webhookbaupolicia,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
                                SendWebhookMessage(webhookbaupolicia1,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
                          
                            elseif chestName == "Ballas" then
                                SendWebhookMessage(webhookbauballas,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
                                SendWebhookMessage(webhookbauballas1,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
 
                            elseif chestName == "Vagos" then
                                SendWebhookMessage(webhookbauvagos,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
                                SendWebhookMessage(webhookbauvagos1,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
 
                            elseif  chestName == "Grove1" then
                                SendWebhookMessage(webhookbaugroove,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
                                SendWebhookMessage(webhookbaugroove1,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
 
                            elseif  chestName == "Crips" then
                                SendWebhookMessage(webhookbaucrips,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
                                SendWebhookMessage(webhookbaucrips1,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
 
                            elseif  chestName == "Bloods1" then
                                SendWebhookMessage(webhookbaubloods,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
                                SendWebhookMessage(webhookbaubloods1,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
                                
                            elseif  chestName == "Cartel" then
                                SendWebhookMessage(webhookbaucartel,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
                                SendWebhookMessage(webhookbaucartel1,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
                                
                            elseif  chestName == "Servia" then
                                SendWebhookMessage(webhookbauservia,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
                                SendWebhookMessage(webhookbauservia,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
                                
                            elseif  chestName == "Life" then
                                SendWebhookMessage(webhooklifeinvader,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
                                SendWebhookMessage(webhooklifeinvader1,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
                                
                            elseif  chestName == "Albanesa" then
                                SendWebhookMessage(webhookbaualbanesa,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
                                SendWebhookMessage(webhookbaualbanesa,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
                                
                            elseif  chestName == "Bahamas" then
                                SendWebhookMessage(webhookbaubahamas,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
                                SendWebhookMessage(webhookbaubahamas1,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
 
                             elseif  chestName == "Hospital" then
                                SendWebhookMessage(webhookbauhospital,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
                                SendWebhookMessage(webhookbauhospital1,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
            
                             elseif  chestName == "Bennys" then
                                SendWebhookMessage(webhookbaubennys,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
                                SendWebhookMessage(webhookbaubennys1,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." \n[RETIROU]: "..vRP.format(parseInt(amount)).." "..vRP.itemNameList(itemName).." \n[BAU]: "..chestName.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
    

                            end
                            if user_id and actived[parseInt(user_id)] == 0 or not actived[parseInt(user_id)] and chestTimer <= 0 then
                                actived[parseInt(user_id)] = 4
                                chestTimer = 10
                                vRP.giveInventoryItem(parseInt(user_id),itemName,parseInt(amount))
                                items[itemName].amount = parseInt(items[itemName].amount) - parseInt(amount)
                                if parseInt(items[itemName].amount) <= 0 then
                                    items[itemName] = nil
                                end
                                TriggerClientEvent('KSRP:UpdateChest',source,'updateChest')
                                vRP.setSData("chest:"..tostring(chestName),json.encode(items))
                            else
                                TriggerClientEvent("Notify",source,"aviso","Aviso","Você está fazendo ações muito rapido!")
                            end 
                        else
                            TriggerClientEvent("Notify",source,"negado","Negado","<b>Mochila</b> cheia.",8000)
                        end
                    end
                else
                    TriggerClientEvent("Notify",source,"negado","Negado","Digite o valor corretamente.",8000)
                end
            end
        end
    end
    return false
end