local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

Policia = Tunnel.getInterface("rize_cloakroom")


--[ FUNCTION ]---------------------------------------------------------------------------------------------------------------------------

local menuactive = false

function ToggleActionMenu()
	menuactive = not menuactive
	if menuactive then
		SetNuiFocus(true,true)
		SendNUIMessage({ showmenu = true })
	else
		SetNuiFocus(false)
		SendNUIMessage({ hidemenu = true })
	end
end

--[ BUTTON ]-----------------------------------------------------------------------------------------------------------------------------

RegisterNUICallback("ButtonClick",function(data,cb)
	if data == "agente" then
		TriggerServerEvent("agente")
	
	elseif data == "agente-two" then
		TriggerServerEvent("agente-two")

	elseif data == "instrutor" then
		TriggerServerEvent("instrutor")

	elseif data == "treinamento" then
		TriggerServerEvent("treinamento")

	elseif data == "investigador" then
		TriggerServerEvent("investigador")

	elseif data == "tatico" then
		TriggerServerEvent("tatico")

	elseif data == "tirar-uniforme" then
		TriggerServerEvent("tirar-uniforme")

	elseif data == "fechar" then
		ToggleActionMenu()
	end
end)

--[ LOCAIS ]-----------------------------------------------------------------------------------------------------------------------------

local armarios = {
	{ ['x'] = 458.8, ['y'] = -990.79, ['z'] = 30.69 }
	--{ ['x'] = 1849.73, ['y'] = 3695.63, ['z'] = 34.27}
}

Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		local idle = 1000

		for k,v in pairs(armarios) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
			local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
			local armarios = armarios[k]

			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), armarios.x, armarios.y, armarios.z, true ) <= 2 then
				sleep = 5
				DrawText3D(armarios.x, armarios.y, armarios.z, "[~g~E~w~] Para ~g~ABRIR~w~ o armário.")
			end

			if distance < 5.1 then
				DrawMarker(27, armarios.x, armarios.y, armarios.z-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,0,140,255,90,0,0,0,1)
				idle = 5
				if distance <= 1.2 then
					if IsControlJustPressed(0,38) and Policia.checkPermissao() then
						ToggleActionMenu()
					end
				end
			end
		end

		Citizen.Wait(idle)
	end
end)

function DrawText3D(x,y,z, text)
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