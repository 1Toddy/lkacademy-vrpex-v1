local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
emP = Tunnel.getInterface("rush_routdrogas")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = false
local servico = false
local selecionado = 0
local processo = false
local segundos = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- [LOCALGROVE] -151.06,-1622.5,33.66
-----------------------------------------------------------------------------------------------------------------------------------------

local CoordenadaX = -151.06
local CoordenadaY = -1622.5
local CoordenadaZ = 33.66
-----------------------------------------------------------------------------------------------------------------------------------------
-- [LOCAL BALLAS] 84.17,-1966.68,20.94
-----------------------------------------------------------------------------------------------------------------------------------------
local Coordenada2X = 84.17
local Coordenada2Y = -1966.68
local Coordenada2Z = 20.94
-----------------------------------------------------------------------------------------------------------------------------------------
-- [LOCAL VAGOS] 360.75,-2042.59,22.36
-----------------------------------------------------------------------------------------------------------------------------------------
local Coordenada3X = 360.75
local Coordenada3Y = -2042.59
local Coordenada3Z = 22.36
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESIDENCIAS
-----------------------------------------------------------------------------------------------------------------------------------------
local locs = {
	[1] = { ['x'] = -952.31, ['y'] = -1077.87, ['z'] = 2.48 },
	[2] = { ['x'] = -978.23, ['y'] = -1108.09, ['z'] = 2.16 },
	[3] = { ['x'] = -1024.49, ['y'] = -1139.6, ['z'] = 2.75 }, 
	[4] = { ['x'] = -1063.76, ['y'] = -1159.88, ['z'] = 2.56 }, 
	[5] = { ['x'] = -1001.68, ['y'] = -1218.78, ['z'] = 5.75 }, 
	[6] = { ['x'] = -1171.54, ['y'] = -1575.61, ['z'] = 4.51 }, 
	[7] = { ['x'] = -1097.94, ['y'] = -1673.36, ['z'] = 8.4 }, 
	[8] = { ['x'] = -1286.17, ['y'] = -1267.12, ['z'] = 4.52 }, 
	[9] = { ['x'] = -1335.75, ['y'] = -1146.55, ['z'] = 6.74 }, 
	[10] = { ['x'] = -1750.47, ['y'] = -697.09, ['z'] = 10.18 }, 
	[11] = { ['x'] = -1876.84, ['y'] = -584.39, ['z'] = 11.86 }, 
	[12] = { ['x'] = -1772.23, ['y'] = -378.12, ['z'] = 46.49 }, 
	[13] = { ['x'] = -1821.38, ['y'] = -404.97, ['z'] = 46.65 }, 
	[14] = { ['x'] = -1965.33, ['y'] = -296.96, ['z'] = 41.1 }, 
	[15] = { ['x'] = -3089.24, ['y'] = 221.49, ['z'] = 14.07 }, 
	[16] = { ['x'] = -3088.62, ['y'] = 392.3, ['z'] = 11.45 },
	[17] = { ['x'] = -3077.98, ['y'] = 658.9, ['z'] = 11.67 }, 
	[18] = { ['x'] = -3243.07, ['y'] = 931.84, ['z'] = 17.23 },
	[19] = { ['x'] = 1230.8, ['y'] = -1590.97, ['z'] = 53.77 }, 
	[20] = { ['x'] = 1286.53, ['y'] = -1604.26, ['z'] = 54.83 }, 
	[21] = { ['x'] = 1379.38, ['y'] = -1515.23, ['z'] = 58.24 }, 
	[22] = { ['x'] = 1379.38, ['y'] = -1515.23, ['z'] = 58.24 }, 
	[23] = { ['x'] = 1437.37, ['y'] = -1492.53, ['z'] = 63.63 }, 
	[24] = { ['x'] = 450.04, ['y'] = -1863.49, ['z'] = 27.77 },
	[25] = { ['x'] = 403.75, ['y'] = -1929.72, ['z'] = 24.75 }, 
	[26] = { ['x'] = 430.16, ['y'] = -1559.31, ['z'] = 32.8 }, 
	[27] = { ['x'] = 446.06, ['y'] = -1242.17, ['z'] = 30.29 },
	[28] = { ['x'] = 322.39, ['y'] = -1284.7, ['z'] = 30.57 }, 
	[29] = { ['x'] = 369.65, ['y'] = -1194.79, ['z'] = 31.34 },
	[30] = { ['x'] = 474.27, ['y'] = -635.05, ['z'] = 25.65 }, 
	[31] = { ['x'] = 158.87, ['y'] = -1215.65, ['z'] = 29.3 }, 
	[32] = { ['x'] = 154.68, ['y'] = -1335.62, ['z'] = 29.21 }, 
	[33] = { ['x'] = 215.54, ['y'] = -1461.67, ['z'] = 29.19 },
	[34] = { ['x'] = 167.46, ['y'] = -1709.3, ['z'] = 29.3 },
	[35] = { ['x'] = -444.47, ['y'] = 287.68, ['z'] = 83.3 }, 
	[36] = { ['x'] = -179.56, ['y'] = 314.25, ['z'] = 97.88 }, 
	[37] = { ['x'] = -16.07, ['y'] = 216.7, ['z'] = 106.75 }, 
	[38] = { ['x'] = 164.02, ['y'] = 151.87, ['z'] = 105.18 },
	[39] = { ['x'] = 840.2, ['y'] = -181.93, ['z'] = 74.19 }, 
	[40] = { ['x'] = 952.27, ['y'] = -252.17, ['z'] = 67.77 },
	[41] = { ['x'] = 1105.27, ['y'] = -778.84, ['z'] = 58.27 }, 
	[42] = { ['x'] = 1099.59, ['y'] = -345.68, ['z'] = 67.19 }, 
	[43] = { ['x'] = -1211.12, ['y'] = -401.56, ['z'] = 38.1 }, 
	[44] = { ['x'] = -1302.69, ['y'] = -271.32, ['z'] = 40.0 }, 
	[45] = { ['x'] = -1468.65, ['y'] = -197.3, ['z'] = 48.84 }, 
	[46] = { ['x'] = -1583.18, ['y'] = -265.78, ['z'] = 48.28 }, 
	[47] = { ['x'] = -603.96, ['y'] = -774.54, ['z'] = 25.02 },
	[48] = { ['x'] = -805.14, ['y'] = -959.54, ['z'] = 18.13 }, 
	[49] = { ['x'] = -325.07, ['y'] = -1356.35, ['z'] = 31.3 }, 
	[50] = { ['x'] = -321.94, ['y'] = -1545.74, ['z'] = 31.02 }, 
	[51] = { ['x'] = -428.95, ['y'] = -1728.13, ['z'] = 19.79 }, 
	[52] = { ['x'] = -582.38, ['y'] = -1743.65, ['z'] = 22.44 }, 
	[53] = { ['x'] = -670.43, ['y'] = -889.09, ['z'] = 24.5 }
	--[[[54] = { ['x'] = 1691.4, ['y'] = 3866.21, ['z'] = 34.91 }, 
	[55] = { ['x'] = 1837.93, ['y'] = 3907.12, ['z'] = 33.26 },
	[56] = { ['x'] = 1937.08, ['y'] = 3890.89, ['z'] = 32.47}, 
	[57] = { ['x'] = 2439.7, ['y'] = 4068.45, ['z'] = 38.07 },
	[58] = { ['x'] = 2592.26, ['y'] = 4668.98, ['z'] = 34.08 }, 
	[59] = { ['x'] = 1961.53, ['y'] = 5184.91, ['z'] = 47.98 },
	[60] = { ['x'] = 2258.59, ['y'] = 5165.84, ['z'] = 59.12 }, 
	[61] = { ['x'] = 1652.7, ['y'] = 4746.1, ['z'] = 42.03 },
	[62] = { ['x'] = -359.09, ['y'] = 6062.05, ['z'] = 31.51 }, 
	[63] = { ['x'] = -160.13, ['y'] = 6432.2, ['z'] = 31.92 },
	[64] = { ['x'] = 33.33, ['y'] = 6673.27, ['z'] = 32.19 }, 
	[65] = { ['x'] = 175.03, ['y'] = 6643.14, ['z'] = 31.57 },
	[66] = { ['x'] = 22.8, ['y'] = 6488.44, ['z'] = 31.43 }, 
	[67] = { ['x'] = 64.39, ['y'] = 6309.17, ['z'] = 31.38 },
	[68] = { ['x'] = 122.42, ['y'] = 6406.02, ['z'] = 31.37 }, 
	[69] = { ['x'] = 1681.2, ['y'] = 6429.11, ['z'] = 32.18 },
	[70] = { ['x'] = 2928.01, ['y'] = 4474.74, ['z'] = 48.04 }, 
	[71] = { ['x'] = 2709.92, ['y'] = 3454.83, ['z'] = 56.32 },
	[72] = { ['x'] = -688.75, ['y'] = 5788.9, ['z'] = 17.34 }, 
	[73] = { ['x'] = -436.13, ['y'] = 6154.93, ['z'] = 31.48 },
	[74] = { ['x'] = -291.09, ['y'] = 6185.0, ['z'] = 31.49 }, 
	[75] = { ['x'] = 405.31, ['y'] = 6526.38, ['z'] = 27.69 },
	[76] = { ['x'] = -20.38, ['y'] = 6567.13, ['z'] = 31.88 }, 
	[77] = { ['x'] = -368.06, ['y'] = 6341.4, ['z'] = 29.85 },
	[78] = { ['x'] = 1842.89, ['y'] = 3777.72, ['z'] = 33.16 }, 
	[79] = { ['x'] = 1424.82, ['y'] = 3671.73, ['z'] = 34.18 },
	[80] = { ['x'] = 996.54, ['y'] = 3575.55, ['z'] = 34.62 }, 
	[81] = { ['x'] = 1697.52, ['y'] = 3596.14, ['z'] = 35.56 },
	[82] = { ['x'] = 2415.05, ['y'] = 5005.35, ['z'] = 46.68 }, 
	[83] = { ['x'] = 2336.21, ['y'] = 4859.41, ['z'] = 41.81},
	[84] = { ['x'] = 1800.9, ['y'] = 4616.07, ['z'] = 37.23 }]]
}
	
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRABALHAR GROVE
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local toddy = 1000
		if not servico then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(CoordenadaX,CoordenadaY,CoordenadaZ)
			local distance = GetDistanceBetweenCoords(CoordenadaX,CoordenadaY,cdz,x,y,z,true)
			if distance <= 3 then
				toddy = 4
				DrawMarker(27,CoordenadaX,CoordenadaY,CoordenadaZ-1.0,5,0,0,0,180.0,130.0,0.8,0.8,0.8,15, 214, 32,90,0,0,0,1)
				if distance <= 1.2 then
					toddy = 3
					drawTxt("PRESSIONE  ~g~E~w~  PARA INICIAR AS ENTREGAS",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) and emP.checkPermission() then
						servico = true
						selecionado = math.random(#locs)
						CriandoBlip(locs,selecionado)
						TriggerEvent("Notify","sucesso","Sucesso","Você entrou em serviço.")
						PlaySoundFrontend(-1, "HACKING_CLICK_GOOD", "", false)
					end
				end
			end
		end
		Citizen.Wait(toddy)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- TRABALHAR BALLAS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local toddy = 1000
		if not servico then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(Coordenada2X,Coordenada2Y,Coordenada2Z)
			local distance = GetDistanceBetweenCoords(Coordenada2X,Coordenada2Y,cdz,x,y,z,true)
			if distance <= 3 then
				toddy = 4
				DrawMarker(27,Coordenada2X,Coordenada2Y,Coordenada2Z-1.0,5,0,0,0,180.0,130.0,0.8,0.8,0.8,141, 15, 214,90,0,0,0,1)
				if distance <= 1.2 then
					toddy = 3
					drawTxt("PRESSIONE  ~p~E~w~  PARA INICIAR AS ENTREGAS",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) and emP.checkPermission() then
						servico = true
						selecionado = math.random(#locs)
						CriandoBlip(locs,selecionado)
						TriggerEvent("Notify","sucesso","Sucesso","Você entrou em serviço.")
						PlaySoundFrontend(-1, "HACKING_CLICK_GOOD", "", false)
					end
				end
			end
		end
		Citizen.Wait(toddy)
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- TRABALHAR VAGOS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local toddy = 1000
		if not servico then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(Coordenada3X,Coordenada3Y,Coordenada3Z)
			local distance = GetDistanceBetweenCoords(Coordenada3X,Coordenada3Y,cdz,x,y,z,true)
			if distance <= 3 then
				toddy = 4
				DrawMarker(27,Coordenada3X,Coordenada3Y,Coordenada3Z-1.0,5,0,0,0,180.0,130.0,0.8,0.8,0.8,218, 232, 28,90,0,0,0,1)
				if distance <= 1.2 then
					toddy = 3
					drawTxt("PRESSIONE  ~y~E~w~  PARA INICIAR AS ENTREGAS",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) and emP.checkPermission() then
						servico = true
						selecionado = math.random(#locs)
						CriandoBlip(locs,selecionado)
						TriggerEvent("Notify","sucesso","Sucesso","Você entrou em serviço.")
						PlaySoundFrontend(-1, "HACKING_CLICK_GOOD", "", false)
					end
				end
			end
		end
		Citizen.Wait(toddy)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENTREGAS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local toddy = 1000
		if servico then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z)
			local distance = GetDistanceBetweenCoords(locs[selecionado].x,locs[selecionado].y,cdz,x,y,z,true)

			if distance <= 10 then
				toddy = 4
				DrawMarker(21,locs[selecionado].x,locs[selecionado].y,locs[selecionado].z-0.6,5,0,0,0,180.0,130.0,0.8,0.8,0.8,0,229,255,90,0,0,0,1)
				if distance <= 1.2 then
					toddy = 3
					drawTxt("PRESSIONE  ~r~E~w~  PARA ENTREGAR AS DROGAS",4,0.5,0.93,0.50,255,255,255,180)
					if IsControlJustPressed(0,38) and emP.checkItens() and not IsPedInAnyVehicle(ped) then
						droga = CreateObject(GetHashKey("prop_weed_block_01"),locs[selecionado].x,locs[selecionado].y,locs[selecionado].z-1,true,true,true)
						if emP.checkPayment() then
							local random = math.random(1,100)
							if random >= 1 and random <= 70 then
								emP.MarcarOcorrencia()
							end

							TriggerEvent('cancelando',true)
							RemoveBlip(blips)
							backentrega = selecionado
							processo = true
							segundos = 5

							vRP._playAnim(true,{{"pickup_object","pickup_low"}},false)
							PlaySoundFrontend(-1, "HACKING_CLICK_GOOD", "", false)
							vRP._CarregarObjeto("pickup_object","pickup_low","hei_prop_heist_cash_pile",49,28422)

							SetTimeout(9000,function()
								DeleteObject(droga)
							end)

							while true do
								if backentrega == selecionado then
									selecionado = math.random(#locs)
								else
									break
								end
								Citizen.Wait(1)
							end
							CriandoBlip(locs,selecionado)						
						end
					end
				end
			end
		end
		Citizen.Wait(toddy)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANCELAR
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local toddy = 1000
		if servico then
			toddy = 4
			if IsControlJustPressed(0,168) then
				servico = false
				RemoveBlip(blips)
				TriggerEvent("Notify","aviso","Aviso","Você saiu de serviço.")
				PlaySoundFrontend(-1, "HACKING_CLICK_BAD", "", false)
			end
		end
		Citizen.Wait(toddy)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if segundos > 0 then
			segundos = segundos - 1
			if segundos == 0 then
				processo = false
				TriggerEvent('cancelando',false)
				ClearPedTasks(PlayerPedId())
				vRP._DeletarObjeto()
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

function CriandoBlip(locs,selecionado)
	blips = AddBlipForCoord(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z)
	SetBlipSprite(blips,496)
	SetBlipColour(blips,1)
	SetBlipScale(blips,0.4)
	SetBlipAsShortRange(blips,false)
	SetBlipRoute(blips,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Entregar Drogas")
	EndTextCommandSetBlipName(blips)
end