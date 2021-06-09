local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

emP = {}
local idgens = Tools.newIDGenerator()
Tunnel.bindInterface("rush_routdrogas",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEBHOOK
-----------------------------------------------------------------------------------------------------------------------------------------
local webhookdrugs = "https://discord.com/api/webhooks/798075126130278470/ivWq1x2ZqTVkidGtlBJ7nfl5xlu519GllsrSwjGJ9GGVbn5f8Kp2s9URiWnwDOA5ez-n"

function SendWebhookMessage(webhook,message)
	if webhook ~= nil and webhook ~= "" then
		PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({content = message}), { ['Content-Type'] = 'application/json' })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- QUANTIDADE
-----------------------------------------------------------------------------------------------------------------------------------------
local quantidade = {}
function emP.Quantidade()
	local source = source
	if quantidade[source] == nil then
		quantidade[source] = math.random(2)
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- PERMISSAO
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPermission()
	local source = source
	local user_id = vRP.getUserId(source)

	if not vRP.searchReturn(source,user_id) and not vRP.hasPermission(user_id,"") then
          return true
	else 
		TriggerClientEvent("Notify",source,"negado","Negado","Você não pode realizar vendas.")
	end	
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECAGEM
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkItens()
	emP.Quantidade()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if not vRP.hasPermission(user_id,"") then
            return vRP.getInventoryItemAmount(user_id,"lsd") >= quantidade[source] or vRP.getInventoryItemAmount(user_id,"maconha") >= quantidade[source] or vRP.getInventoryItemAmount(user_id,"lancaperfume") >= quantidade[source] or vRP.getInventoryItemAmount(user_id,"cocaina") >= quantidade[source]			
		end

		return
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAGAMENTO
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPayment()
    local source = source
    local user_id = vRP.getUserId(source)
    local policia_multi_valor
    if user_id then
        local policia = vRP.getUsersByPermission("dpla.permissao")


        local sold = 0
        -- CONTA A QUANTIDADE DE DROGAS VENDIDAS
        if vRP.tryGetInventoryItem(user_id,"maconha",quantidade[source]) then
            sold = sold + 1
        end

        if vRP.tryGetInventoryItem(user_id,"lsd",quantidade[source]) then
            sold = sold + 1
        end

        if vRP.tryGetInventoryItem(user_id,"cocaina",quantidade[source]) then
            sold = sold + 1
        end
        if vRP.tryGetInventoryItem(user_id,"lancaperfume",quantidade[source]) then
            sold = sold + 1
        end        

        if sold > 0 then
            local amount_drugs = sold
            local policia_multiplicador = 150
            if vRP.hasPermission(user_id,"ilegal.permissao") then
                policia_multiplicador = 75
            end

            local amount_police = #policia
            --[[if amount_police > 20 then
            	amount_police = 20
            end]]

            policia_multi_valor = ((#policia * policia_multiplicador) * amount_drugs)
           
            local value = math.random(2500,3500) -- valor da droga temporária
            local calc = (value * amount_drugs) + (policia_multi_valor)

        	vRP.giveInventoryItem(user_id,"dinheirosujo", calc)
        	vRPclient._playAnim(source,true,{{"mp_common","givetake1_a"}},false)
            quantidade[source] = nil
        end
        return true
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICIA
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = {}
function emP.MarcarOcorrencia()
	local source = source
	local user_id = vRP.getUserId(source)
	local x,y,z = vRPclient.getPosition(source)
	local identity = vRP.getUserIdentity(user_id)
	if user_id then
		local soldado = vRP.getUsersByPermission("dpla.permissao")
		for l,w in pairs(soldado) do
			local player = vRP.getUserSource(parseInt(w))
			if player then
				async(function()
					local id = idgens:gen()
					blips[id] = vRPclient.addBlip(player,x,y,z,10,84,"Ocorrência",0.5,false)
					vRPclient._playSound(player,"CONFIRM_BEEP","HUD_MINI_GAME_SOUNDSET")
					TriggerClientEvent('chatMessage',player,"190",{64,64,255},"Recebemos uma denuncia de tráfico, verifique o ocorrido.")
					SetTimeout(20000,function() vRPclient.removeBlip(player,blips[id]) idgens:free(id) end)
				end)
			end
		end
		SendWebhookMessage(webhookdrugs,"```prolog\n[ID]: "..user_id.." "..identity.name.." "..identity.firstname.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")

	end
end

function emP.setSearchTimer()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.searchTimer(user_id,parseInt(60))
	end
end