local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

doug = Tunnel.getInterface("rush_routmoney")
-----------------------------------------------------------------------------------------------------------------------------------------
--[ VARIÁVEIS ]--------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = false
local servico = false
local emprocesso = false
local segundos = 0
local selecionado = 0
local quantidade = 0
-----------------------------------------------------------------------------------------------------------------------------------------
--[ LIFE -1083.02,-245.77,37.77 ]-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local CoordenadaX = -1083.02
local CoordenadaY = -245.77
local CoordenadaZ = 37.77

-----------------------------------------------------------------------------------------------------------------------------------------
--[ BAHAMAS: -72.45,-814.23,243.39]-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local Coordenada2X = -1386.49
local Coordenada2Y = -589.49
local Coordenada2Z = 30.32

-----------------------------------------------------------------------------------------------------------------------------------------
--[ RESIDENCIAS ]------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local locs = {
    [1] = { ['x'] = -1335.0, ['y'] = -337.97, ['z'] = 36.7 },
    [2] = { ['x'] = -1678.91, ['y'] = -401.36, ['z'] = 47.53 },
    [3] = { ['x'] = -2205.35, ['y'] = -373.05, ['z'] = 13.33 },
    [4] = { ['x'] = -2963.3, ['y'] = 65.75, ['z'] = 11.61 },
    [5] = { ['x'] = -3047.55, ['y'] = 589.99, ['z'] = 7.79 },
    [6] = { ['x'] = -2566.07, ['y'] = 2307.6, ['z'] = 33.22 },
    [7] = { ['x'] = -262.37, ['y'] = 6290.77, ['z'] = 31.49 },
    [8] = { ['x'] = 1695.57, ['y'] = 6430.92, ['z'] = 32.72 },
    [9] = { ['x'] = 2517.77, ['y'] = 4113.3, ['z'] = 38.64 },
    [10] = { ['x'] = 1689.87, ['y'] = 3581.52, ['z'] = 35.63 },
	[11] = { ['x'] = 182.65, ['y'] = 2779.58, ['z'] = 45.63 },
    [12] = { ['x'] = 550.27, ['y'] = 2656.45, ['z'] = 42.22 },
    [13] = { ['x'] = 1211.05, ['y'] = 1857.26, ['z'] = 78.97 },
    [14] = { ['x'] = -40.8, ['y'] = 227.87, ['z'] = 107.97 },
    [15] = { ['x'] = -478.64, ['y'] = 218.51, ['z'] = 83.7 },
    [16] = { ['x'] = -1452.86, ['y'] = -160.1, ['z'] = 48.85 },	
    [17] = { ['x'] = -1289.85, ['y'] = -852.28, ['z'] = 14.95 },
    [18] = { ['x'] = -970.55, ['y'] = -1431.33, ['z'] = 7.68 },
    [19] = { ['x'] = -1529.28, ['y'] = -908.79, ['z'] = 10.17 },
    [20] = { ['x'] = -1200.68, ['y'] = -338.11, ['z'] = 38.09 }


}
-----------------------------------------------------------------------------------------------------------------------------------------
--[ TRABALHAR ]--------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("lavagemrota2020",function(source,args)
	if not servico then
		if not emprocesso then
			emprocesso = true
			vRP._playAnim(false,{{'anim@heists@prison_heistig1_p1_guard_checks_bus','loop'}},false)
			--DisableControlAction(0,167,true)
			Wait(5000)
			servico = true
			segundos = 200
			selecionado = 1
			CriandoBlip(locs,selecionado)
			doug.Quantidade()
			TriggerEvent("Notify","sucesso","Sucesso","Você entrou em serviço.")
			PlaySoundFrontend(-1, "HACKING_CLICK_GOOD", "", false)
		else
			TriggerEvent("Notify","importante","Importante","Aguarde <b>"..segundos.." segundos</b> até acharmos outras coletas.")
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		local idle = 1000
		local ped = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local bowz,cdz = GetGroundZFor_3dCoord(CoordenadaX,CoordenadaY,CoordenadaZ)
		local distance = GetDistanceBetweenCoords(CoordenadaX,CoordenadaY,cdz,x,y,z,true)
		if not servico then
			if distance <= 1.1 and not IsPedInAnyVehicle(ped) then
				idle = 3
				drawTxt("PRESSIONE  ~r~E~w~  PARA INICIAR A COLETA",4,0.08,0.55,0.45,255,255,255,180)
				if IsControlJustPressed(0,38) and doug.checkGroup() then
					ExecuteCommand('lavagemrota2020')
				end
			end
		end
		Citizen.Wait(idle)
	end
end)

Citizen.CreateThread(function()
	while true do
		local idle = 1000
		local ped = PlayerPedId()
		local x,y,z = table.unpack(GetEntityCoords(ped))
		local bowz,cdz = GetGroundZFor_3dCoord(Coordenada2X,Coordenada2Y,Coordenada2Z)
		local distance = GetDistanceBetweenCoords(Coordenada2X,Coordenada2Y,cdz,x,y,z,true)
		if not servico then
			if distance <= 1.1 and not IsPedInAnyVehicle(ped) then
				idle = 5
				drawTxt("PRESSIONE  ~r~E~w~  PARA INICIAR A COLETA",4,0.08,0.55,0.45,255,255,255,180)
				if IsControlJustPressed(0,38) and doug.checkGroup() then
					ExecuteCommand('lavagemrota2020')
				end
			end
		end
		Citizen.Wait(idle)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ ENTREGAS ]---------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local idle = 1000
		if servico then
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(locs[selecionado].x,locs[selecionado].y,locs[selecionado].z)
			local distance = GetDistanceBetweenCoords(locs[selecionado].x,locs[selecionado].y,cdz,x,y,z,true)

			if distance <= 30 and not IsPedInAnyVehicle(ped) then
				DrawMarker(27,locs[selecionado].x,locs[selecionado].y,locs[selecionado].z-1.0,0,0,0,0,180.0,130.0,0.8,0.8,0.8,255,0,0,50,0,0,0,1)
				if distance <= 1.5 then
					idle = 5
					drawTxt("PRESSIONE  ~r~E~w~  PARA COLETAR "..quantidade.." COMPONENTES",4,0.09,0.55,0.45,255,255,255,180)
					if IsControlJustPressed(0,38) then
						if doug.checkPayment() then
							RemoveBlip(blips)
							backentrega = selecionado
							TriggerEvent("Notify","importante","Importante","Vá até o proximo destino e colete <b>"..quantidade.."x Componentes.")
							PlaySoundFrontend(-1, "HACKING_CLICK_GOOD", "", false)
							vRP._playAnim(true,{{"pickup_object","pickup_low"}},false)
							while true do
								if selecionado == 10 then
									selecionado = 1
								else
									selecionado = selecionado + 1
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
		Citizen.Wait(idle)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if emprocesso then
			if segundos > 0 then
				segundos = segundos - 1
				if segundos == 0 then
					emprocesso = false
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ CANCELAR ]---------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		if servico then
			drawTxt2("~w~COLETE ~r~"..quantidade.." COMPONENTES ~w~NO DESTINO MARCADO",4,0.25,0.95,0.40,255,255,255,180)
			drawTxt2("~w~PRESSIONE~r~  F7  ~w~PARA FINALIZAR O EXPEDIENTE",4,0.25,0.97,0.40,255,255,255,180)
			if IsControlJustPressed(0,121) then
			elseif IsControlJustPressed(0,168) then
				servico = false
				RemoveBlip(blips)
				TriggerEvent("Notify","aviso","Aviso","Você saiu de serviço.")
				PlaySoundFrontend(-1, "HACKING_CLICK_BAD", "", false)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ STATUS ]-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("quantidade-key")
AddEventHandler("quantidade-key",function(status)
    quantidade = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ FUNÇÕES ]----------------------------------------------------------------------------------------------------------------------------
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

function drawTxt2(text,font,x,y,scale,r,g,b,a)
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
	SetBlipSprite(blips,501)
	SetBlipColour(blips,1)
	SetBlipScale(blips,0.4)
	SetBlipAsShortRange(blips,false)
	SetBlipRoute(blips,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Coleta de Componetes")
	EndTextCommandSetBlipName(blips)
end