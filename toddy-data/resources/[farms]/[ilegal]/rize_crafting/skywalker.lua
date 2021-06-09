local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
oC = {}
Tunnel.bindInterface("rize_crafting",oC)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ ARRAY ]------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local craft = {
	{ item = "lockpick" },
	{ item = "algema" },
	{ item = "capuz" },
	{ item = "dinheiro" },
    { item = "mhk" },
    { item = "gps" },
    { item = "cordas" },
    { item = "bandagem" }
}
-----------------------------------------------------------------------------------------------------------------------------------
--[ EVENTOS ]----------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("produzir-craft")
AddEventHandler("produzir-craft",function(item)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		for k,v in pairs(craft) do
			if item == v.item then
				if item == "lockpick" then
					if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("lockpick") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"dinheirosujo") >= 2200 then
                            if vRP.getInventoryItemAmount(user_id,"vidro") >= 1 then
                                if vRP.getInventoryItemAmount(user_id,"borracha") >= 1 then
                                    if vRP.getInventoryItemAmount(user_id,"bateria") >= 1 then
                                        if vRP.tryGetInventoryItem(user_id,"dinheirosujo",2200) and vRP.tryGetInventoryItem(user_id,"vidro",1) and vRP.tryGetInventoryItem(user_id,"borracha",1) and vRP.tryGetInventoryItem(user_id,"bateria",1) then
                                            TriggerClientEvent("fechar-nui",source)

                                            TriggerClientEvent("progress",source,5000,"Montando LockPick")

                                            SetTimeout(5000,function()
                                                vRP.giveInventoryItem(user_id,"lockpick",1)
                                                TriggerClientEvent("Notify",source,"sucesso","Sucesso","Você montou uma <b>LOCKPICK</b>.")
                                            end)
                                        end
                                    else
                                        TriggerClientEvent("Notify",source,"negado","Negado","Você não tem <b>1x Bateria</b> na mochila.")
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"negado","Negado","Você precisa de <b1x Borracha</b>.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Negado","Você precisa de <b>1x Vidro</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Negado","Você não tem <b>2200x Dinheiro Sujo</b> na mochila.")
                        end
					else
						TriggerClientEvent("Notify",source,"negado","Negado","Espaço insuficiente na mochila.")
                    end
                elseif item == "algema" then
					if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("algema") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"dinheirosujo") >= 50000 then
                            if vRP.getInventoryItemAmount(user_id,"cobre") >= 20 then
                                if vRP.getInventoryItemAmount(user_id,"plastico") >= 2 then
                                    if vRP.getInventoryItemAmount(user_id,"borracha") >= 4 then
                                        if vRP.tryGetInventoryItem(user_id,"dinheirosujo",50000) and vRP.tryGetInventoryItem(user_id,"cobre",20) and vRP.tryGetInventoryItem(user_id,"plastico",2) and vRP.tryGetInventoryItem(user_id,"borracha",4) then
                                            TriggerClientEvent("fechar-nui",source)

                                            TriggerClientEvent("progress",source,5000,"Montando Algema")

                                            SetTimeout(5000,function()
                                                vRP.giveInventoryItem(user_id,"algema",1)
                                                TriggerClientEvent("Notify",source,"sucesso","Sucesso","Você montou uma <b>Algema</b>.")
                                            end)
                                        end
                                    else
                                        TriggerClientEvent("Notify",source,"negado","Negado","Você não tem <b>4x Borracha</b> na mochila.")
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"negado","Negado","Você precisa de <b2x Plastico</b>.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Negado","Você precisa de <b>20x Cobre</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Negado","Você não tem <b>50000x Dinheiro Sujo</b> na mochila.")
                        end
					else
						TriggerClientEvent("Notify",source,"negado","Negado","Espaço insuficiente na mochila.")
                    end
                elseif item == "capuz" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("capuz") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"dinheirosujo") >= 50000 then
                            if vRP.getInventoryItemAmount(user_id,"linha") >= 12 then
                                if vRP.getInventoryItemAmount(user_id,"pano") >= 20 then
                                    if vRP.tryGetInventoryItem(user_id,"dinheirosujo",50000) and vRP.tryGetInventoryItem(user_id,"linha",12) and vRP.tryGetInventoryItem(user_id,"pano",20) then
                                        TriggerClientEvent("fechar-nui",source)

                                        TriggerClientEvent("progress",source,5000,"Montando CAPUZ")

                                        SetTimeout(5000,function()
                                            vRPclient._stopAnim(source,false)
                                            vRP.giveInventoryItem(user_id,"capuz",1)
                                            TriggerClientEvent("Notify",source,"sucesso","Sucesso","Você montou uma <b>UZI</b>.")
                                        end)
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"negado","Negado","Você não tem <b>20x Pano</b> na mochila.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Negado","Você precisa de <b>12x Linha</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Negado","Você precisa de <b>50000x Dinheiro Sujo</b>.")
                        end
				    else
					    TriggerClientEvent("Notify",source,"negado","Negado","Espaço insuficiente na mochila.")
                    end
                elseif item == "gps" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("gps") <= vRP.getInventoryMaxWeight(user_id) then
                            if vRP.getInventoryItemAmount(user_id,"plastico") >= 12 then
                                if vRP.getInventoryItemAmount(user_id,"bateria") >= 5 then
                                    if vRP.tryGetInventoryItem(user_id,"plastico",12) and vRP.tryGetInventoryItem(user_id,"bateria",5) then
                                        TriggerClientEvent("fechar-nui",source)

                                        TriggerClientEvent("progress",source,5000,"Montando GPS")

                                        SetTimeout(5000,function()
                                            vRPclient._stopAnim(source,false)
                                            vRP.giveInventoryItem(user_id,"gps",1)
                                            TriggerClientEvent("Notify",source,"sucesso","Sucesso","Você montou um <b>GPS</b>.")
                                        end)
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"negado","Negado","Você não tem <b>5x Baterias</b> na mochila.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Negado","Você precisa de <b>12x Plasticos</b>.")
                        end
				    else
					    TriggerClientEvent("Notify",source,"negado","Negado","Espaço insuficiente na mochila.")
                    end
                elseif item == "bandagem" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("bandagem") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"dinheirosujo") >= 20000 then
                            if vRP.getInventoryItemAmount(user_id,"linha") >= 15 then
                                if vRP.getInventoryItemAmount(user_id,"pano") >= 5 then
                                    if vRP.tryGetInventoryItem(user_id,"dinheirosujo",20000) and vRP.tryGetInventoryItem(user_id,"linha",15) and vRP.tryGetInventoryItem(user_id,"pano",5) then
                                        TriggerClientEvent("fechar-nui",source)

                                        TriggerClientEvent("progress",source,5000,"Montando Bandagem")

                                        SetTimeout(5000,function()
                                            vRPclient._stopAnim(source,false)
                                            vRP.giveInventoryItem(user_id,"bandagem",1)
                                            TriggerClientEvent("Notify",source,"sucesso","Sucesso","Você montou uma <b>BANDAGEM</b>.")
                                        end)
                                    end
                                else
                                    TriggerClientEvent("Notify",source,"negado","Negado","Você não tem <b>5x Pano</b> na mochila.")
                                end
                            else
                                TriggerClientEvent("Notify",source,"negado","Negado","Você precisa de <b>15x Linha</b>.")
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Negado","Você precisa de <b>20000x Dinheiro Sujo</b>.")
                        end
				    else
					    TriggerClientEvent("Notify",source,"negado","Negado","Espaço insuficiente na mochila.")
                    end
                elseif item == "dinheiro" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("dinheirosujo") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"distintivopolicial") >= 21 then
                            if vRP.tryGetInventoryItem(user_id,"distintivopolicial",21) then
                                TriggerClientEvent("fechar-nui",source)

                                TriggerClientEvent("progress",source,5000,"Montando DINHEIRO SUJO")

                                SetTimeout(5000,function()
                                    vRPclient._stopAnim(source,false)
                                    vRP.giveInventoryItem(user_id,"dinheirosujo",25000)
                                    TriggerClientEvent("Notify",source,"sucesso","Sucesso","Você pegou <b>DINHEIRO SUJO</b>.")
                                end)
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Negado","Você não tem <b>21x Distintivo Policial</b> na mochila.")
                        end
                    else
					    TriggerClientEvent("Notify",source,"negado","Negado","Espaço insuficiente na mochila.")
                    end
                elseif item == "cordas" then
                    if vRP.getInventoryWeight(user_id)+vRP.getItemWeight("cordas") <= vRP.getInventoryMaxWeight(user_id) then
                        if vRP.getInventoryItemAmount(user_id,"linha") >= 20 then
                            if vRP.tryGetInventoryItem(user_id,"linha",20) then
                                TriggerClientEvent("fechar-nui",source)

                                TriggerClientEvent("progress",source,5000,"Produzindo linha")

                                SetTimeout(5000,function()
                                    vRPclient._stopAnim(source,false)
                                    vRP.giveInventoryItem(user_id,"cordas",1)
                                    TriggerClientEvent("Notify",source,"sucesso","Sucesso","Você produziu uma- <b>CORDA</b>.")
                                end)
                            end
                        else
                            TriggerClientEvent("Notify",source,"negado","Negado","Você não tem <b>x20 Linhas</b> na mochila.")
                        end
                    end
				end
			end
		end
	end
end)