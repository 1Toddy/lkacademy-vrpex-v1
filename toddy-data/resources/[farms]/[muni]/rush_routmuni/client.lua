local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

doug = Tunnel.getInterface("rush_routmuni")
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
local CoordenadaX = 1061.31
local CoordenadaY = -1998.2
local CoordenadaZ = 31.02
-- 1061.31,-1998.2,31.02 : Mafia Albanesa
local Coordenada2X = 586.36
local Coordenada2Y = -3118.01
local Coordenada2Z = 18.71
-- 581.17,-3119.48,18.77 : Mafia Servia
-----------------------------------------------------------------------------------------------------------------------------------------
--[ RESIDENCIAS ]------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local locs = {
	[1] = { ['x'] = -716.71, ['y'] = -371.86, ['z'] = 34.78 }, 
	[2] = { ['x'] = -880.98, ['y'] = -182.65, ['z'] = 37.84 }, 
	[3] = { ['x'] = -229.34, ['y'] = -78.79, ['z'] = 49.8 }, 
	[4] = { ['x'] = 773.66, ['y'] = -150.35, ['z'] = 75.63 }, 
	[5] = { ['x'] = 1178.91, ['y'] = -1463.69, ['z'] = 34.91 }, 
	[6] = { ['x'] = 1041.14, ['y'] = -2115.86, ['z'] = 32.88 }, 
	[7] = { ['x'] = 764.65, ['y'] = -1722.99, ['z'] = 30.53 }, 
	[8] = { ['x'] = 520.81, ['y'] = -1653.01, ['z'] = 29.3 }, 
	[9] = { ['x'] = -321.03, ['y'] = -1401.03, ['z'] = 31.77 }, 
	[10] = { ['x'] = -703.6, ['y'] = -1179.9, ['z'] = 10.62 }, 
	[11] = { ['x'] = -1200.45, ['y'] = -1162.81, ['z'] = 7.7 }, 
	[12] = { ['x'] = -1570.88, ['y'] = -482.35, ['z'] = 35.55 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
--[ TRABALHAR ]--------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("rushrotasmuni",function(source,args)
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
				idle = 5
				drawTxt("PRESSIONE  ~r~E~w~  PARA INICIAR A COLETA",4,0.08,0.55,0.45,255,255,255,180)
				if IsControlJustPressed(0,38) and doug.checkGroup() then
					ExecuteCommand('rushrotasmuni')
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
					ExecuteCommand('rushrotasmuni')
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
				DrawMarker(27,locs[selecionado].x,locs[selecionado].y,locs[selecionado].z-1.0,0,0,0,0,180.0,130.0,0.8,0.8,0.8,0,255,0,50,0,0,0,1)
				if distance <= 1.5 then
					idle = 5
					drawTxt("PRESSIONE  ~g~E~w~  PARA COLETAR "..quantidade.." COMPONENTES",4,0.09,0.55,0.45,255,255,255,180)
					if IsControlJustPressed(0,38) then
						if doug.checkPayment() then
							RemoveBlip(blips)
							backentrega = selecionado
							TriggerEvent("Notify","importante","Importante","Vá até o proximo destino e colete <b>"..quantidade.."x Componentes.")
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
	SetBlipColour(blips,1)
	SetBlipScale(blips,0.4)
	SetBlipAsShortRange(blips,false)
	SetBlipRoute(blips,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Coleta de Peças")
	EndTextCommandSetBlipName(blips)
end