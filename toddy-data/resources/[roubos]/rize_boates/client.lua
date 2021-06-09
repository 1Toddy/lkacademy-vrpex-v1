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
Tunnel.bindInterface("rize_boates",src)
vSERVER = Tunnel.getInterface("rize_boates")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local robbery = false
local timedown = 0
local robmark = nil
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROBBERS
-----------------------------------------------------------------------------------------------------------------------------------------
local robbers = {
	[1] = { ['name'] = "Vanilla", ['x'] = 92.56, ['y'] = -1291.94, ['z'] = 29.27 },
}

local spawnObjects = {
	[1] = { ['x'] = 97.5805, ['y'] = -1288.971, ['z'] = 29.26876, ['h'] = 303.7659 }, -- COFRE VANILLA
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROBBERSBUTTON
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local kswait = 1000
		if not robbery then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			for k,v in pairs(robbers) do
				local distance = Vdist(x,y,z,v.x,v.y,v.z)
				if distance < 8 then
					kswait = 4
					DrawMarker(29,v.x,v.y,v.z,0,0,0,0.0,0,0,0.9,0.9,0.8,34,139,34,100,1,0,0,1)
					if distance <= 1.1 and GetEntityHealth(ped) > 101 then
						drawText("PRESSIONE  ~r~E~w~  PARA INICIAR O ROUBO",4,0.5,0.93,0.50,255,255,255,180)
						if IsControlJustPressed(0,38) and timedown <= 0 then
							if vSERVER.checkPolice() then
								timedown = 6
								vSERVER.startRobbery(k,v.x,v.y,v.z)						
							end
						end
					end	
				end
			end			
		else
			kswait = 4
			drawText("PARA CANCELAR O ROUBO SAIA DE PERTO DO COFRE",4,0.5,0.88,0.36,255,255,255,50)
			drawText("AGUARDE ~g~"..timedown.." SEGUNDOS~w~ ATÉ QUE TERMINE O ROUBO",4,0.5,0.9,0.46,255,255,255,150)
			if GetEntityHealth(PlayerPedId()) <= 101 then
				robbery = false
				vSERVER.stopRobbery()
			end
		end
		Citizen.Wait(kswait)
	end
end)

Citizen.CreateThread(function()
	while true do
		if robbery and timedown > 0 then
			vSERVER.giveAwards()
			Citizen.Wait(10000)
		end
		Citizen.Wait(4)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTROBBERY
-----------------------------------------------------------------------------------------------------------------------------------------
function src.startRobbery(time,x2,y2,z2)
	robbery = true
	timedown = time
	SetPedComponentVariation(PlayerPedId(),5,45,0,2)
	Citizen.CreateThread(function()
		while robbery do
			Citizen.Wait(5)
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(x2,y2,z2)
			local distance = GetDistanceBetweenCoords(x2,y2,cdz,x,y,z,true)
			if distance >= 17.0 then
				robbery = false
				timedown = 0
				vSERVER.stopRobbery()
			end
		end
	end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTROBBERYPOLICE
-----------------------------------------------------------------------------------------------------------------------------------------
function src.startRobberyPolice(x,y,z,localidade)
	if not DoesBlipExist(robmark) then
		robmark = AddBlipForCoord(x,y,z)
		SetBlipScale(robmark,0.5)
		SetBlipSprite(robmark,161)
		SetBlipColour(robmark,59)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Roubo: " .. localidade)
		EndTextCommandSetBlipName(robmark)
		SetBlipAsShortRange(robmark,false)
		SetBlipRoute(robmark,true)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOPROBBERYPOLICE
-----------------------------------------------------------------------------------------------------------------------------------------
function src.stopRobberyPolice()
	if DoesBlipExist(robmark) then
		RemoveBlip(robmark)
		robmark = nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TIMEDOWN
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if timedown >= 1 then
			timedown = timedown - 1
			if timedown == 0 then
				robbery = false
			end
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT
-----------------------------------------------------------------------------------------------------------------------------------------
function drawText(text,font,x,y,scale,r,g,b,a)
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
-- SPAWN COFRE
-----------------------------------------------------------------------------------------------------------------------------------------
--[[local vault = false
local propCreated = {}
Citizen.CreateThread(function()
	while true do
		local kswait = 1000
		local ped = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(ped))
		for k,v in pairs(spawnObjects) do
			local distance = Vdist(x,y,z,v.x,v.y,v.z)
			if distance <= 20 and not propCreated[k] or propCreated[k] == false then
				local prop = GetHashKey("prop_ld_int_safe_01")
				vault = CreateObject(prop,v.x,v.y,v.z,true,false,false)
				PlaceObjectOnGroundProperly(vault)
				FreezeEntityPosition(vault,true)
				SetEntityHeading(vault,v.h)
				propCreated[k] = true
			end
			if distance > 300 and propCreated[k] then
				propCreated[k] = false
			end
		end
		Citizen.Wait(kswait)
	end
end)]]

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