

local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

primo = Tunnel.getInterface("vrp_medsystem")

local health
local multi
local pulse = 70
local area = "Unknown"
local lastHit
local blood = 100
local bleeding = 0
local dead = false
local timer = 0

local cPulse = -1
local cBlood = -1
local cNameF = ""
local cNameL = ""
local cArea = ""
local cBleeding = "NONE"

RegisterCommand('getpulse', function(source, args)
	local health = GetEntityHealth(GetPlayerPed(-1))
	if health > 0 then
		pulse = (health / 4 + math.random(19, 28)) 
	end
	
	print(pulse)
	local hit, bone = GetPedLastDamageBone(GetPlayerPed(-1))
	print(bone)
	
end, false)

AddEventHandler('esx:onPlayerDeath', function(data)

	multi = 2.0
	blood = 100
	health = GetEntityHealth(GetPlayerPed(-1))
	area = "LEGS/ARMS"
	local hit, bone = GetPedLastDamageBone(GetPlayerPed(-1))
	bleeding = 1
	if (bone == 31086) then
		multi = 0.0
		print('HEADSHOT')
		TriggerEvent('chatMessage', "MedSystem", {255, 0, 0}, "You have been shot/damaged in HEAD area")
		bleeding = 5
		area = "HEAD"
	end
	if bone == 24817 or bone == 24818 or bone == 10706 or bone == 24816 or bone == 11816 then
		multi = 1.0
		print('BODYSHOT')
		TriggerEvent('chatMessage', "MedSystem", {255, 0, 0}, "You have been shot/damaged in BODY area")
		bleeding = 2
		area = "BODY"
	end
	
	pulse = ((health / 4 + 20) * multi) + math.random(0, 4)
	dead = true
end)

Citizen.CreateThread( function()
while true do
	Wait(5000)
	local hp = GetEntityHealth(GetPlayerPed(-1))
	if hp >= 1 and dead then
		dead = false
		bleeding = 0
		blood = 100
	end
	if dead and blood > 0 then
	blood = blood - bleeding
	end
end
end)

function DrawAdvancedText(x,y ,w,h,sc, text, r,g,b,a,font,jus)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(sc, sc)
	N_0x4e096588b13ffeca(jus)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,100)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
	DrawText(x - 0.1+w, y - 0.02+h)
end

RegisterNetEvent('medSystem:near')
AddEventHandler('medSystem:near', function(x,y,z, pulse, blood, nameF, nameL, area, bldn)
		
	
	local a,b,c = GetEntityCoords(GetPlayerPed(-1))
	
	if GetDistanceBetweenCoords(x,y,z,a,b,c,false) < 10 then
		timer = 10
		TriggerEvent('chatMessage', "MedSystem", {255,0 , 0}, "^1 [0-5] DEAD ^6[5-15] Needs hospital ^5[15-38] EMS Can help ^4[38-55] Police can help ^2[55+] Healthy")
		cBlood = blood
		cPulse = pulse
		cNameF = nameF
		cNameL = nameL
		cArea = area
		
		if bldn == 1 then
		cBleeding = "SLOW"
		elseif bldn == 2 then
		cBleeding "MEDIUM"
		elseif bldn == 5 then
		cBleeding = "FAST"
		elseif bldn == 0 then
		cBleeding = "NONE"
		end
		
	else
		timer = 0
		cBlood = -1
		cPulse = -1
		cNameF = ""
		cNameL = ""
		cArea = ""
		cBleeding = "SLOW"
	end
	

end)

Citizen.CreateThread( function()
	while true do
		Wait(1)
			while timer >= 1 do
				Wait(1)
				if cPulse ~= -1 and cBlood ~= -1 then
					DrawAdvancedText(0.7, 0.7, 0.005, 0.0028, 0.9, cNameF .. " " .. cNameL .. "\n~r~Pulse: ~w~" .. cPulse .. "BPM\n~r~Blood: ~w~" .. cBlood .. "%~r~\nHurt area: ~w~" .. cArea .. "\n~r~Bleeding: ~w~" .. cBleeding, 255, 255, 255, 255, 4, 1)
					
				end
			end
	end
end)

Citizen.CreateThread( function()
	while true do
		Wait(1000)
		if timer >= 1 then
			timer = timer - 1
		end	
	end
end)

RegisterNetEvent('medSystem:send')
AddEventHandler('medSystem:send', function(req)
		
	print('1')
	local health = GetEntityHealth(GetPlayerPed())
	print('2')
	if health > 0 then
		pulse = (health / 4 + math.random(19, 28)) 
	end
	print('3')
	local a, b, c = table.unpack(GetEntityCoords(GetPlayerPed()))
	print('4')

	print(a)
	TriggerServerEvent('medSystem:print', req, math.floor(pulse * (blood / 90)), area, blood, a, b, c, bleeding)
	print(bleeding)
	print(a)
	print(b)
	print(c)
	print(area)

end)

------------------------------------------------- FARM DUS CRIA --------------------------------------

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
-- 305.04,-598.28,43.3 - HP
local CoordenadaX = 305.04
local CoordenadaY = -598.28
local CoordenadaZ = 43.3

-----------------------------------------------------------------------------------------------------------------------------------------
--[ RESIDENCIAS ]------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local locs = {
    [1] = { ['x'] = 492.4, ['y'] = -742.5, ['z'] = 24.94 },
    [2] = { ['x'] = 490.02, ['y'] = -936.54, ['z'] = 26.8 },
    [3] = { ['x'] = 490.64, ['y'] = -1086.1, ['z'] = 29.13 },
    [4] = { ['x'] = 278.91, ['y'] = -1117.96, ['z'] = 29.42 },
    [5] = { ['x'] = 199.43, ['y'] = -1268.87, ['z'] = 29.18 },
    [6] = { ['x'] = 152.25, ['y'] = -1478.19, ['z'] = 29.35 },
    [7] = { ['x'] = 65.85, ['y'] = -1467.18, ['z'] = 29.31 },
    [8] = { ['x'] = -128.14, ['y'] = -1394.7, ['z'] = 29.54 },
    [9] = { ['x'] = -85.83, ['y'] = -1275.1, ['z'] = 29.3 },
    [10] = { ['x'] = -49.83, ['y'] = -1058.88, ['z'] = 27.81 },
    [11] = { ['x'] = 54.59, ['y'] = -799.35, ['z'] = 31.59 },
    [12] = { ['x'] = 364.59, ['y'] = -875.56, ['z'] = 29.3 },
    [13] = { ['x'] = 1102.09, ['y'] = -776.73, ['z'] = 58.35 },
    [14] = { ['x'] = 1093.16, ['y'] = -362.92, ['z'] = 67.07 },
    [15] = { ['x'] = 527.7, ['y'] = -152.4, ['z'] = 57.23 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
--[ TRABALHAR ]--------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("startbandagens",function(source,args)
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
					ExecuteCommand('startbandagens')
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
RegisterNetEvent("quantidade-bandagem")
AddEventHandler("quantidade-bandagem",function(status)
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