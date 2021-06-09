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
	{ ['id'] = 1, ['x'] = 28.151824951172, ['y'] = -1339.5554199219, ['z'] = 29.497022628784 },
    { ['id'] = 3, ['x'] = 1160.0583496094, ['y'] = -313.89276123047, ['z'] = 69.205070495605 },
    { ['id'] = 4, ['x'] = -709.35693359375, ['y'] = -904.12329101563, ['z'] = 19.215589523315 },
	{ ['id'] = 5, ['x'] = -42.820041656494, ['y'] = -1748.6987304688, ['z'] = 29.421016693115 },
	{ ['id'] = 6, ['x'] = 378.16299438477, ['y'] = 332.90216064453, ['z'] = 103.56639099121 },
	{ ['id'] = 7, ['x'] = -3249.6608886719, ['y'] = 1004.3889160156, ['z'] = 12.830709457397 },
	{ ['id'] = 12, ['x'] = 1707.8018798828, ['y'] = 4920.30078125, ['z'] = 42.063674926758 },
	{ ['id'] = 13, ['x'] = -1828.9145507813, ['y'] = 799.21514892578, ['z'] = 138.18203735352 },
	{ ['id'] = 14, ['x'] = 1395.1953125, ['y'] = 3613.6157226563, ['z'] = 34.980930328369 },
	{ ['id'] = 15, ['x'] = -3047.8112792969, ['y'] = 585.68365478516, ['z'] = 7.9089283943176 }

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
					toddy = 3
					DrawMarker(21,v.x,v.y,v.z-0.3,0,0,0,0,180.0,130.0,0.6,0.8,0.5,255,0,0,50,1,0,0,1)
					if IsControlJustPressed(0,38) and func.checkPermission() then
						func.checkRobberyLojinha(v.id,v.x,v.y,v.z)
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
RegisterNetEvent("lojinhainiciar")
AddEventHandler("lojinhainiciar",function(id,x,y,z)
	andamento = true
	segundos = 75
	id_loja = id
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONTAGEM
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local toddy = 1000
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
				toddy = 3
				drawTxt("AGUARDE  ~r~"..segundos.."~w~  PARA FINALIZAR O ROUBO, NÃO SAIA DO BALCÃO",4,0.5,0.93,0.50,255,255,255,180)
				if segundos == 0 then
					andamento = false
					func.giveAwardLojinha()
				end
			end
		end
		Citizen.Wait(toddy)
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