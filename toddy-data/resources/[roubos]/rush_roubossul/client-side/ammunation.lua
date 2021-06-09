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
	{ ['id'] = 1, ['x'] = 253.92, ['y'] = -51.98, ['z'] = 69.95 },
	{ ['id'] = 2, ['x'] = -1304.31, ['y'] = -396.54, ['z'] = 36.7 },
	{ ['id'] = 3, ['x'] = -660.64, ['y'] = -933.08, ['z'] = 21.83 },
	{ ['id'] = 4, ['x'] = 24.61, ['y'] = -1105.61, ['z'] = 29.8 },
	{ ['id'] = 5, ['x'] = 840.5, ['y'] = -1035.58, ['z'] = 28.2 },
	{ ['id'] = 6, ['x'] = 808.95, ['y'] = -2159.71, ['z'] = 29.62 },
	--{ ['id'] = 6, ['x'] = 1693.48, ['y'] = 3763.06, ['z'] = 34.71 },
	--{ ['id'] = 7, ['x'] = -330.36, ['y'] = 6087.0, ['z'] = 31.46 },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROTEIRO DO ROUBO
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local toddy = 1000
		local ped = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(ped))
		if GetSelectedPedWeapon(ped) == GetHashKey("WEAPON_UNARMED") and not IsPedInAnyVehicle(ped) then
			for k,v in pairs(locais) do
				if Vdist(v.x,v.y,v.z,x,y,z) <= 1 and not andamento then
					toddy = 4
					DrawMarker(21,v.x,v.y,v.z-0.3,0,0,0,0,180.0,130.0,0.6,0.8,0.5,255,0,0,50,1,0,0,1)
					if IsControlJustPressed(0,38) and func.checkPermission() then
						func.checkRobberyAmmu(v.id,v.x,v.y,v.z)
					end
				end
			end
		end
		Citizen.Wait(toddy)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- INICIANDO O ROUBO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("iniciandolojadearmas")
AddEventHandler("iniciandolojadearmas",function(id,x,y,z)
	andamento = true
	segundos = 25
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
					func.giveAward()
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