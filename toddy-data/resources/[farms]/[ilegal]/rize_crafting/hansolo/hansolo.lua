local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

oC = Tunnel.getInterface("rize_crafting")
-------------------------------------------------------------------------------------------------
--[ MENU ]---------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
local menuactive = false
local onmenu = false

function ToggleActionMenu()
	menuactive = not menuactive
	if menuactive then
		SetNuiFocus(true,true)
		TransitionToBlurred(1000)
		SendNUIMessage({ showmenu = true })
	else
		SetNuiFocus(false)
		TransitionFromBlurred(1000)
		SendNUIMessage({ hidemenu = true })
	end
end
-------------------------------------------------------------------------------------------------
--[ BOTÕES ]-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
RegisterNUICallback("ButtonClick",function(data,cb)
	if data == "produzir-algema" then
		TriggerServerEvent("produzir-craft","algema")

	elseif data == "produzir-capuz" then
		TriggerServerEvent("produzir-craft","capuz")

	elseif data == "produzir-lockpick" then
		TriggerServerEvent("produzir-craft","lockpick")

	elseif data == "produzir-masterpick" then
		TriggerServerEvent("produzir-craft","masterpick")

	elseif data == "produzir-pendrive" then
		TriggerServerEvent("produzir-craft","pendrive")

	elseif data == "produzir-keycard" then
		TriggerServerEvent("produzir-craft","keycard")

	elseif data == "produzir-cartaodesmanche" then
		TriggerServerEvent("produzir-craft","cartaodesmanche")

	elseif data == "produzir-gps" then
		TriggerServerEvent("produzir-craft","gps")

	elseif data == "produzir-mochila" then
		TriggerServerEvent("produzir-craft","mochila")
		
	elseif data == "produzir-bandagem" then
		TriggerServerEvent("produzir-craft","bandagem")

	elseif data == "produzir-dinheirosujo" then
		TriggerServerEvent("produzir-craft","dinheirosujo")

	elseif data == "produzir-dinheiro" then
		TriggerServerEvent("produzir-craft","dinheiro")

	elseif data == "produzir-mhk" then
		TriggerServerEvent("produzir-craft","mhk")

	elseif data == "produzir-cordas" then
		TriggerServerEvent("produzir-craft","cordas")

	elseif data == "produzir-bombacaseira" then
		TriggerServerEvent("produzir-craft","bombacaseira")

	elseif data == "fechar" then
		ToggleActionMenu()
		onmenu = false
	end
end)


RegisterNetEvent("fechar-nui")
AddEventHandler("fechar-nui", function()
	ToggleActionMenu()
	onmenu = false

	local ped = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(ped))
	local distance = GetDistanceBetweenCoords(ped, cdz, x, y, z, true)

	if distance < 3.2 then
		TriggerEvent("armas:posicao1")	
	else
		TriggerEvent("armas:posicao2")
	end
end)

RegisterNetEvent("armas:posicao1")
AddEventHandler("armas:posicao1", function()
	local ped = PlayerPedId()
end)

RegisterNetEvent("armas:posicao2")
AddEventHandler("armas:posicao2", function()
	local ped = PlayerPedId()
end)
-------------------------------------------------------------------------------------------------
--[ AÇÃO ]---------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
RegisterCommand('craft', function(source, args, rawCmd)
	ToggleActionMenu()
	onmenu = true
end)