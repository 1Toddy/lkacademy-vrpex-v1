local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
func = Tunnel.getInterface("rush_roubossul")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local andamento = false
local roubando = false
local segundos = 0
local id_loja = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- GERANDO LOCAL DO ROUBO
-----------------------------------------------------------------------------------------------------------------------------------------
local locais = {
	{ ['id'] = 1, ['x'] = -2959.31, ['y'] = 387.43, ['z'] = 14.05 },
    { ['id'] = 3, ['x'] = -1479.17, ['y'] = -375.21, ['z'] = 39.17 },
    { ['id'] = 4, ['x'] = 1168.72, ['y'] = 2717.92, ['z'] = 37.16 },
    { ['id'] = 5, ['x'] = -1220.37, ['y'] = -915.91, ['z'] = 11.33 }

}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROTEIRO DO ROUBO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local kswait = 1000
		local ped = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(ped))
		if GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_UNARMED") and not IsPedInAnyVehicle(ped) then
			for k,v in pairs(locais) do
				if Vdist(v.x,v.y,v.z,x,y,z) <= 1 and not andamento then
					kswait = 4
					DrawMarker(21,v.x,v.y,v.z-0.3,0,0,0,0,180.0,130.0,0.6,0.8,0.5,255,0,0,50,1,0,0,1)
					if IsControlJustPressed(0,38) and func.checkPermission() then
						func.checkRobberyBebidas(v.id,v.x,v.y,v.z)
					end
				end
			end
		end
		Citizen.Wait(kswait)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- INICIANDO O ROUBO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("iniciandolojabebidas")
AddEventHandler("iniciandolojabebidas",function(id,x,y,z)
	andamento = true
	segundos = 50
	id_loja = id
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONTAGEM
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local waiting = 500
		if andamento then
			waiting = 5
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local distance = Vdist(x,y,z,locais[id_loja].x,locais[id_loja].y,locais[id_loja].z)
			if distance >= 5 then
				andamento = false
				TriggerEvent("Notify","negado","Negado","Seu roubo foi cancelado.")
			end
			if distance <= 5 then
				drawTxt("AGUARDE  ~r~"..segundos.."~w~  PARA FINALIZAR O ROUBO, NÃO SAIA DO BALCÃO",4,0.5,0.93,0.50,255,255,255,180)
				if segundos == 0 then
					andamento = false
					func.giveAwardBebidas()
				end
			end
		end
		Citizen.Wait(waiting)
	end
end)

Citizen.CreateThread(function()
	while true do
		if andamento then
			if segundos > 0 then
				segundos = segundos - 1
			end
		end
		Citizen.Wait(1000)
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