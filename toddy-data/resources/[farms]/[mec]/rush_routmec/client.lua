local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

primo = Tunnel.getInterface("rush_routmec")
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
--[ LOCAIS ]-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
-- -345.49,-130.92,39.01 - LS
local CoordenadaX = -345.49
local CoordenadaY = -130.92
local CoordenadaZ = 39.01
-- -204.64,-1342.62,30.9 - BENNYS
local Coordenada2X = -204.64
local Coordenada2Y = -1342.62
local Coordenada2Z = 30.9
-----------------------------------------------------------------------------------------------------------------------------------------
--[ RESIDENCIAS ]------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local locs = {
    [1] = { ['x'] = 252.49, ['y'] = 2596.5, ['z'] = 44.85 },
    [2] = { ['x'] = 387.48, ['y'] = 3585.09, ['z'] = 33.3 },
    [3] = { ['x'] = 1352.49, ['y'] = 3606.92, ['z'] = 34.91 },
    [4] = { ['x'] = 2030.17, ['y'] = 3184.24, ['z'] = 45.12 },
    [5] = { ['x'] = 2004.43, ['y'] = 3790.96, ['z'] = 32.19 },
    [6] = { ['x'] = 2506.5, ['y'] = 4097.63, ['z'] = 38.71 },
    [7] = { ['x'] = 1676.21, ['y'] = 4870.65, ['z'] = 42.04 },
    [8] = { ['x'] = 119.94, ['y'] = 6626.15, ['z'] = 31.96 },
    [9] = { ['x'] = -3179.91, ['y'] = 1093.7, ['z'] = 20.85 },
    [10] = { ['x'] = -1111.57, ['y'] = -1661.58, ['z'] = 4.36 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
--[ TRABALHAR ]--------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("sstartvermelhosstartsstart",function(source,args)
	if not servico then
		if not emprocesso then
			emprocesso = true
			vRP._playAnim(false,{{'amb@prop_human_parking_meter@female@idle_a','loop'}},false)
			--DisableControlAction(0,167,true)
			Wait(1000)
			servico = true
			segundos = 60
			selecionado = 1
			CriandoBlip(locs,selecionado)
			primo.Quantidade()
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
			if distance <= 1.5 and not IsPedInAnyVehicle(ped) then
				idle = 5
				drawTxt("PRESSIONE  ~r~E~w~  PARA INICIAR A COLETA",4,0.08,0.55,0.45,255,255,255,180)
				if IsControlJustPressed(0,38) and primo.checkGroup() then
					ExecuteCommand('sstartvermelhosstartsstart')
				end
			end
		end
		Citizen.Wait(idle)
	end
end)


-----------------------------------------------------------------------------------------------------------------------------------------
--[ TRABALHAR 2]--------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("sstartvermelhosstartsstart",function(source,args)
	if not servico then
		if not emprocesso then
			emprocesso = true
			vRP._playAnim(false,{{'amb@prop_human_parking_meter@female@idle_a','loop'}},false)
			--DisableControlAction(0,167,true)
			Wait(1)
			servico = true
			segundos = 60
			selecionado = 1
			CriandoBlip(locs,selecionado)
			primo.Quantidade()
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
		local bowz,cdz = GetGroundZFor_3dCoord(Coordenada2X,Coordenada2Y,Coordenada2Z)
		local distance = GetDistanceBetweenCoords(Coordenada2X,Coordenada2Y,cdz,x,y,z,true)
		if not servico then
			if distance <= 1.5 and not IsPedInAnyVehicle(ped) then
				idle = 5
				drawTxt("PRESSIONE  ~r~E~w~  PARA INICIAR A COLETA",4,0.08,0.55,0.45,255,255,255,180)
				if IsControlJustPressed(0,38) and primo.checkGroup() then
					ExecuteCommand('sstartvermelhosstartsstart')
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
				DrawMarker(27,locs[selecionado].x,locs[selecionado].y,locs[selecionado].z-1.0,0,0,0,0,180.0,130.0,0.8,0.8,0.8,255,255,0,50,0,0,0,1)
				if distance <= 1.1 then
					idle = 5
					drawTxt("PRESSIONE  ~r~E~w~  PARA COLETAR "..quantidade.." FERRAMENTAS",4,0.09,0.55,0.45,255,255,255,180)
					if IsControlJustPressed(0,38) then
						if primo.checkPayment() then
							RemoveBlip(blips)
							TriggerEvent("Notify","importante","Importante","Vá até o proximo destino e colete <b>"..quantidade.."x Ferramentas.")
							PlaySoundFrontend(-1, "HACKING_CLICK_GOOD", "", false)
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
			drawTxt2("~w~COLETE ~r~"..quantidade.." FERRAMENTAS ~w~NO DESTINO MARCADO",4,0.25,0.95,0.40,255,255,255,180)
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
RegisterNetEvent("quantidade-drogas")
AddEventHandler("quantidade-drogas",function(status)
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
	SetBlipColour(blips,73)
	SetBlipScale(blips,0.4)
	SetBlipAsShortRange(blips,false)
	SetBlipRoute(blips,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Coleta de Componetes")
	EndTextCommandSetBlipName(blips)
end