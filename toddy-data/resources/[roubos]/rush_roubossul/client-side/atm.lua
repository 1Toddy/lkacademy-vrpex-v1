local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
func = Tunnel.getInterface("rush_roubossul")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local andamento = false
local segundos = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- GERANDO LOCAL DO ROUBO
-----------------------------------------------------------------------------------------------------------------------------------------
local locais = {
	{ ['id'] = 1, ['x'] = 119.10, ['y'] = -883.70, ['z'] = 31.12, ['h'] = 71.0 },
	{ ['id'] = 2, ['x'] = -1315.80, ['y'] = -834.76, ['z'] = 16.96, ['h'] = 305.0 },
	{ ['id'] = 3, ['x'] = 285.44, ['y'] = 143.38, ['z'] = 104.17, ['h'] = 159.0 },
	{ ['id'] = 4, ['x'] = 1138.23, ['y'] = -468.89, ['z'] = 66.73, ['h'] = 74.0 },
	{ ['id'] = 5, ['x'] = 1077.70, ['y'] = -776.54, ['z'] = 58.24, ['h'] = 182.0 },
	{ ['id'] = 6, ['x'] = -710.03, ['y'] = -818.90, ['z'] = 23.72, ['h'] = 0.0 },
	{ ['id'] = 7, ['x'] = -821.63, ['y'] = -1081.89, ['z'] = 11.13, ['h'] = 31.0 },
	{ ['id'] = 8, ['x'] = -1409.75, ['y'] = -100.44, ['z'] = 52.38, ['h'] = 107.0 },
	{ ['id'] = 9, ['x'] = -846.29, ['y'] = -341.28, ['z'] = 38.68, ['h'] = 116.0 },
	{ ['id'] = 10, ['x'] = -2072.36, ['y'] = -317.29, ['z'] = 13.31, ['h'] = 260.0 },
	{ ['id'] = 11, ['x'] = -526.64, ['y'] = -1222.97, ['z'] = 18.45, ['h'] = 153.0 },
	{ ['id'] = 12, ['x'] = -254.41, ['y'] = -692.46, ['z'] = 33.60, ['h'] = 159.0 },
	{ ['id'] = 13, ['x'] = -283.34, ['y'] = 6225.71, ['z'] = 31.5, ['h'] = 313.90 },
	{ ['id'] = 14, ['x'] = 155.6, ['y'] = 6642.58, ['z'] = 31.61, ['h'] = 313.90 },
	{ ['id'] = 13, ['x'] = -1429.98, ['y'] = -211.0, ['z'] = 46.51, ['h'] = 115.37 },
	{ ['id'] = 14, ['x'] = 89.56, ['y'] = 2.18, ['z'] = 68.33, ['h'] = 340.35 },
	{ ['id'] = 15, ['x'] = -272.82, ['y'] = -2024.81, ['z'] = 30.15, ['h'] = 34.17 },
	{ ['id'] = 16, ['x'] = -1205.4, ['y'] = -324.64, ['z'] = 37.86, ['h'] = 114.68 },
	{ ['id'] = 17, ['x'] = -1571.21, ['y'] = -547.16, ['z'] = 34.96, ['h'] = 214.27 },
	{ ['id'] = 18, ['x'] = -1305.07, ['y'] = -706.12, ['z'] = 25.33, ['h'] = 128.01 },
	{ ['id'] = 19, ['x'] = -58.01, ['y'] = -92.76, ['z'] = 57.79, ['h'] = 293.76 },
	{ ['id'] = 20, ['x'] = 526.71, ['y'] = -160.69, ['z'] = 57.08, ['h'] = 271.11 },
	{ ['id'] = 21, ['x'] = 89.45, ['y'] = 2.03, ['z'] = 68.34, ['h'] = 340.61 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- INICIO/CANCELAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local toddy = 1000
		local ped = PlayerPedId()
		local x,y,z = GetEntityCoords(ped)
		if GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_UNARMED") and not IsPedInAnyVehicle(ped) then
			for k,v in pairs(locais) do
				if Vdist(v.x,v.y,v.z,x,y,z) <= 1 and not andamento then
					toddy = 3
					drawTxt("PRESSIONE  ~r~G~w~  PARA INICIAR O ROUBO",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,47) and func.checkPermission() then
						func.checkRobberyATM(v.id,v.x,v.y,v.z,v.h)
					end
				end
			end
			if andamento then
				toddy = 3
				drawTxt("APERTE ~r~M~w~ PARA CANCELAR O ROUBO EM ANDAMENTO",4,0.5,0.91,0.36,255,255,255,30)
				toddy = 3
				drawTxt("RESTAM ~g~"..segundos.." SEGUNDOS ~w~PARA TERMINAR",4,0.5,0.93,0.50,255,255,255,180)
				if IsControlJustPressed(0,244) or GetEntityHealth(ped) <= 100 or IsPedBeingStunned(ped) then
					andamento = false
					ClearPedTasks(ped)
					func.cancelRobbery()
					TriggerEvent('cancelando',false)
				end
			end
		end
		Citizen.Wait(toddy)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INICIADO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("iniciandocaixaeletronico")
AddEventHandler("iniciandocaixaeletronico",function(x,y,z,secs,head)
	segundos = secs
	andamento = true
	SetEntityHeading(PlayerPedId(),head)
	SetEntityCoords(PlayerPedId(),x,y,z-1,false,false,false,false)
	SetPedComponentVariation(PlayerPedId(),5,45,0,2)
	TriggerEvent('cancelando',true)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONTAGEM
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if andamento then
			segundos = segundos - 1
			if segundos <= 0 then
				andamento = false
				ClearPedTasks(PlayerPedId())
				TriggerEvent('cancelando',false)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
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
-----------------------------------------------------------------------------------------------------------------------------------------
-- MARCAÇÃO
-----------------------------------------------------------------------------------------------------------------------------------------
local blip = nil
RegisterNetEvent('blip:criar:caixaeletronico')
AddEventHandler('blip:criar:caixaeletronico',function(x,y,z)
	if not DoesBlipExist(blip) then
		blip = AddBlipForCoord(x,y,z)
		SetBlipScale(blip,0.5)
		SetBlipSprite(blip,1)
		SetBlipColour(blip,59)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Roubo: Caixa Eletrônico")
		EndTextCommandSetBlipName(blip)
		SetBlipAsShortRange(blip,false)
		SetBlipRoute(blip,true)
	end
end)

RegisterNetEvent('blip:remover:caixaeletronico')
AddEventHandler('blip:remover:caixaeletronico',function()
	if DoesBlipExist(blip) then
		RemoveBlip(blip)
		blip = nil
	end
end)

RegisterNetEvent("setBlipsEletronico")
AddEventHandler("setBlipsEletronico",function()
	print("Triggered")
	for k,v in pairs(locais) do
		local blip = AddBlipForCoord(v.x,v.y,v.z)
		SetBlipSprite(blip,411)
		SetBlipAsShortRange(blip,true)
		SetBlipColour(blip,2)
		SetBlipScale(blip,0.4)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Caixinha ID: ~g~" .. v.id)
		EndTextCommandSetBlipName(blip)
		SetTimeout(30000,function()
			if DoesBlipExist(blip) then
				RemoveBlip(blip)
			end
		end)
	end
end)