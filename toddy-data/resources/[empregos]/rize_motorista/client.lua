local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
emP = Tunnel.getInterface("rize_motorista")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local emservico = false
local bonus = 50

local coordenadas = {
	{ ['id'] = 1, ['x'] = 453.48, ['y'] = -607.74, ['z'] = 28.57 }, 
	{ ['id'] = 2, ['x'] = -215.64, ['y'] = 6219.25, ['z'] = 31.5 }, 
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- GERANDO LOCAL DE ENTREGA
-----------------------------------------------------------------------------------------------------------------------------------------
local entregas = {
	[1] = { ['x'] = 393.85, ['y'] = -673.72, ['z'] = 28.53 },
	[2] = { ['x'] = 199.48, ['y'] = -595.39, ['z'] = 28.67 },
	[3] = { ['x'] = 1.02, ['y'] = -544.54, ['z'] = 37.21 },
	[4] = { ['x'] = -17.82, ['y'] = -445.37, ['z'] = 39.68 },
	[5] = { ['x'] = -57.57, ['y'] = -239.3, ['z'] = 44.7 },
	[6] = { ['x'] = -256.89, ['y'] = -167.75, ['z'] = 39.74 },
	[7] = { ['x'] = -437.42, ['y'] = -231.84, ['z'] = 35.54 },
	[8] = { ['x'] = -522.66, ['y'] = -268.07, ['z'] = 34.61 },
	[9] = { ['x'] = -609.03, ['y'] = -203.08, ['z'] = 36.55 },
	[10] = { ['x'] = -646.36, ['y'] = -139.22, ['z'] = 37.02 },
	[11] = { ['x'] = -757.43, ['y'] = -39.48, ['z'] = 37.08 },
	[12] = { ['x'] = -790.74, ['y'] = -92.25, ['z'] = 36.96},
	[13] = { ['x'] = -682.48, ['y'] = -275.27, ['z'] = 35.49 },
	[14] = { ['x'] = -645.83, ['y'] = -635.72, ['z'] = 31.23 },
	[15] = { ['x'] = -645.97, ['y'] = -940.23, ['z'] = 21.4 },
	[16] = { ['x'] = -771.62, ['y'] = -1092.85, ['z'] = 9.91 },
	[17] = { ['x'] = -898.31, ['y'] = -884.22, ['z'] = 14.93 },
	[18] = { ['x'] = -1206.89, ['y'] = -597.29, ['z'] = 26.41 },
	[19] = { ['x'] = -1475.66, ['y'] = -265.7, ['z'] = 48.8 },
	[20] = { ['x'] = -1628.58, ['y'] = -276.96, ['z'] = 51.75 },
	[21] = { ['x'] = -1747.78, ['y'] = -419.02, ['z'] = 42.89 },
	[22] = { ['x'] = -1662.68, ['y'] = -585.28, ['z'] = 32.96 },
	[23] = { ['x'] = -1460.96, ['y'] = -743.5, ['z'] = 23.29 },
	[24] = { ['x'] = -1257.38, ['y'] = -1050.43, ['z'] = 7.78 },
	[25] = { ['x'] = -1164.49, ['y'] = -1324.59, ['z'] = 4.42 },
	[26] = { ['x'] = -976.95, ['y'] = -1249.44, ['z'] = 4.85 },
	[27] = { ['x'] = -786.81, ['y'] = -1135.15, ['z'] = 9.92 },
-----------------------------------------------------------------------------------------------------------------------------------------
-- COORDS PALETO
-----------------------------------------------------------------------------------------------------------------------------------------
	[28] = { ['x'] = -153.29, ['y'] = 6212.22, ['z'] = 32.04 }, 
	[29] = { ['x'] = -18.38, ['y'] = 6507.26, ['z'] = 32.11 }, 
	[30] = { ['x'] = 750.1, ['y'] = 6492.87, ['z'] = 26.96 }, 
	[31] = { ['x'] = 1605.67, ['y'] = 6382.96, ['z'] = 28.04 }, 
	[32] = { ['x'] = 2523.1, ['y'] = 5397.13, ['z'] = 43.79 }, 
	[33] = { ['x'] = 2417.2, ['y'] = 5146.35, ['z'] = 46.22 }, 
	[34] = { ['x'] = 2483.1, ['y'] = 4447.83, ['z'] = 34.72 }, 
	[35] = { ['x'] = 2009.0, ['y'] = 3754.48, ['z'] = 31.68 },
	[36] = { ['x'] = 1784.69, ['y'] = 3784.43, ['z'] = 34.56 }, 
	[37] = { ['x'] = 1645.95, ['y'] = 3594.46, ['z'] = 34.77 }, 
	[38] = { ['x'] = 2028.34, ['y'] = 3086.08, ['z'] = 46.26 }, 
	[39] = { ['x'] = 1243.86, ['y'] = 2685.01, ['z'] = 36.89 }, 
	[40] = { ['x'] = 301.27, ['y'] = 2643.21, ['z'] = 43.81 }, 
	[41] = { ['x'] = -457.07, ['y'] = 2854.16, ['z'] = 34.26 }, 
	[42] = { ['x'] = -1117.01, ['y'] = 2668.0, ['z'] = 17.46 }, 
	[43] = { ['x'] = -2220.02, ['y'] = 2304.25, ['z'] = 32.1 }, 
	[44] = { ['x'] = -2697.39, ['y'] = 2289.02, ['z'] = 18.42 }, 
	[45] = { ['x'] = -2542.61, ['y'] = 3416.97, ['z'] = 12.56 }, 
	[46] = { ['x'] = -2208.02, ['y'] = 4298.45, ['z'] = 47.47 }, 
	[47] = { ['x'] = -1530.62, ['y'] = 4954.68, ['z'] = 61.37 }, 
	[48] = { ['x'] = -1050.17, ['y'] = 5333.97, ['z'] = 44.0 }, 
	[49] = { ['x'] = -790.13, ['y'] = 5551.25, ['z'] = 32.34 }, 
	[50] = { ['x'] = -453.36, ['y'] = 6069.5, ['z'] = 30.66 }, 
	[51] = { ['x'] = -333.46, ['y'] = 6331.06, ['z'] = 29.42 }, 
	[52] = { ['x'] = -51.08, ['y'] = 6602.36, ['z'] = 29.08 }, 
	[53] = { ['x'] = -64.9, ['y'] = 6472.86, ['z'] = 30.68 }, 
	[54] = { ['x'] = -292.38, ['y'] = 6246.41, ['z'] = 30.71 }, 
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRABALHAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local toddy = 1000
		if not emservico then
			for _,v in pairs(coordenadas) do
				local ped = PlayerPedId()
				local x,y,z = table.unpack(GetEntityCoords(ped))
				local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
				local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)

				if distance <= 3 then
					toddy = 3
					DrawMarker(21,v.x,v.y,v.z-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,255,0,0,50,0,0,0,1)
					if distance <= 1.2 then
						toddy = 3
						drawTxt("PRESSIONE  ~r~E~w~  PARA INICIAR A ROTA",4,0.5,0.93,0.50,255,255,255,180)
						if IsControlJustPressed(0,38) then
							emservico = true
							if v.id == 2 then
								destino = 28
							else
								destino = 1
							end
							CriandoBlip(entregas,destino)
							TriggerEvent("Notify","sucesso","Sucesso","Você entrou em serviço.")
						end
					end
				end
			end
		end
		Citizen.Wait(toddy)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GERANDO ENTREGA
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local toddy = 1000
		local ped = PlayerPedId()
		if emservico then
			if IsPedInAnyVehicle(ped) then
				local vehicle = GetVehiclePedIsIn(ped)
				local distance = GetDistanceBetweenCoords(GetEntityCoords(ped),entregas[destino].x,entregas[destino].y,entregas[destino].z,true)
				if distance <= 50 then
					toddy = 3
					DrawMarker(21,entregas[destino].x,entregas[destino].y,entregas[destino].z+0.20,0,0,0,0,180.0,130.0,2.0,2.0,1.0,255,0,0,50,1,0,0,1)
					if distance <= 4 then
						--drawTxt("PRESSIONE  ~b~E~w~  PARA CONTINUAR A ROTA",4,0.5,0.93,0.50,255,255,255,180)
						if GetPedInVehicleSeat(vehicle,-1) == ped then
							if IsControlJustPressed(0,38) then
								if IsVehicleModel(GetVehiclePedIsUsing(ped),GetHashKey("coach")) or IsVehicleModel(GetVehiclePedIsUsing(ped),GetHashKey("bus")) then
									RemoveBlip(blip)
									if destino == 27 then
										emP.checkPayment(50)
										destino = 1
									elseif destino == 54 then
										destino = 28
									else
										emP.checkPayment(50)
										destino = destino + 1
									end
									CriandoBlip(entregas,destino)
								end
							end
						end
					end
				end
			end
		end
		Citizen.Wait(toddy)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCELANDO ENTREGA
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if emservico then
			if IsControlJustPressed(0,168) then
				emservico = false
				RemoveBlip(blip)
				TriggerEvent("Notify","aviso","Aviso","Você saiu de serviço.")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCOES
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

function CriandoBlip(entregas,destino)
	blip = AddBlipForCoord(entregas[destino].x,entregas[destino].y,entregas[destino].z)
	SetBlipSprite(blip,1)
	SetBlipColour(blip,5)
	SetBlipScale(blip,0.4)
	SetBlipAsShortRange(blip,false)
	SetBlipRoute(blip,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Rota de Motorista")
	EndTextCommandSetBlipName(blip)
end