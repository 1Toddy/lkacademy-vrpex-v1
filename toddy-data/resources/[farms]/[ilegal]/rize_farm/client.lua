local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
func = Tunnel.getInterface("dexter_farm")
-----------------------------------------------------------------------------------------------------------------------------------------
-- TELEPORT
-----------------------------------------------------------------------------------------------------------------------------------------
local Teleport = {
	["MARABUNTA"] = {
		positionFrom = { ['x'] = 2848.5, ['y'] = 4450.17, ['z'] = 48.52, ['perm'] = "marabunta.permissao" },
		positionTo = { ['x'] = 2849.89, ['y'] = 4451.06, ['z'] = 48.54, ['perm'] = "marabunta.permissao" }
	},
	["MAFIA"] = {
		positionFrom = { ['x'] = 2932.32, ['y'] = 4624.11, ['z'] = 48.73, ['perm'] = "corleone.permissao" },
		positionTo = { ['x'] = 894.49, ['y'] = -3245.88, ['z'] = -98.25, ['perm'] = "corleone.permissao" }
	},
	["CORLEONE"] = {
		positionFrom = { ['x'] = -70.93, ['y'] = -801.04, ['z'] = 44.22, ['perm'] = "corleone.permissao" },
		positionTo = { ['x'] = -75.71, ['y'] = -827.08, ['z'] = 243.39, ['perm'] = "corleone.permissao" }
	},
	["HOSPITAL"] = {
		positionFrom = { ['x'] = 315.48, ['y'] = -583.08, ['z'] = 43.29, ['perm'] = "paramedico.permissao" },
		positionTo = { ['x'] = 275.74, ['y'] = -1361.42, ['z'] = 24.53, ['perm'] = "paramedico.permissao" }
	}
}

Citizen.CreateThread(function()
	while true do
		local kswait = 1000
		for k,v in pairs(Teleport) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.positionFrom.x,v.positionFrom.y,v.positionFrom.z)
			local distance = GetDistanceBetweenCoords(v.positionFrom.x,v.positionFrom.y,cdz,x,y,z,true)
			local bowz,cdz2 = GetGroundZFor_3dCoord(v.positionTo.x,v.positionTo.y,v.positionTo.z)
			local distance2 = GetDistanceBetweenCoords(v.positionTo.x,v.positionTo.y,cdz2,x,y,z,true)

			if distance <= 3 then
				kswait = 4
				DrawMarker(3,v.positionFrom.x,v.positionFrom.y,v.positionFrom.z-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,232,67,147,100,1,0,0,1)
				if distance <= 1.5 then
					if IsControlJustPressed(0,38) and func.checkPermission(v.positionTo.perm) then
						SetEntityCoords(PlayerPedId(),v.positionTo.x,v.positionTo.y,v.positionTo.z-0.50)
					end
				end
			end

			if distance2 <= 3 then
				kswait = 4
				DrawMarker(3,v.positionTo.x,v.positionTo.y,v.positionTo.z-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,232,67,147,100,1,0,0,1)
				if distance2 <= 1.5 then
					if IsControlJustPressed(0,38) and func.checkPermission(v.positionFrom.perm) then
						SetEntityCoords(PlayerPedId(),v.positionFrom.x,v.positionFrom.y,v.positionFrom.z-0.50)
					end
				end
			end
		end
		Citizen.Wait(kswait)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local processo = false
local segundos = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS
-----------------------------------------------------------------------------------------------------------------------------------------
local locais = {
	{ ['id'] = 1, ['x'] = 102.78, ['y'] = 6339.46, ['z'] = 31.38, ['text'] = "COLHER FOLHA DE MACONHA", ['perm'] = "ballas.permissao" }, -- Maconha ADUBO
	{ ['id'] = 2, ['x'] = 114.28, ['y'] = 6360.26, ['z'] = 32.305, ['text'] = "PROCESSAR MACONHA MACERADA", ['perm'] = "ballas.permissao" }, -- Maconha FERTILIZANTE
	{ ['id'] = 3, ['x'] = 118.22, ['y'] = 6362.68, ['z'] = 32.3, ['text'] = "PRODUZIR MACONHA", ['perm'] = "ballas.permissao" }, -- Maconha PRODUZIR

	--{ ['id'] = 4, ['x'] = 882.80, ['y'] = -3202.40, ['z'] = -98.19, ['text'] = "COLETAR CAPSULA", ['perm'] = "corleone.permissao" }, -- mafia
	--{ ['id'] = 5, ['x'] = 883.91, ['y'] = -3207.62, ['z'] = -98.19, ['text'] = "PROCESSAR POLVORA", ['perm'] = "corleone.permissao" }, -- mafia
--	{ ['id'] = 6, ['x'] = 884.73, ['y'] = -3199.72, ['z'] = -98.19, ['text'] = "PRODUZIR MUNIÇÃO DE MTAR-21", ['perm'] = "corleone.permissao" }, -- mafia
--	{ ['id'] = 7, ['x'] = 891.98, ['y'] = -3196.91, ['z'] = -98.19, ['text'] = "PRODUZIR MUNIÇÃO DE AK-47", ['perm'] = "corleone.permissao" }, -- mafia
--	{ ['id'] = 8, ['x'] = 888.65, ['y'] = -3207.17, ['z'] = -98.19, ['text'] = "PRODUZIR MUNIÇÃO DE G36C", ['perm'] = "corleone.permissao" }, -- mafia
--	{ ['id'] = 9, ['x'] = 887.47, ['y'] = -3209.71, ['z'] = -98.19, ['text'] = "PRODUZIR MUNIÇÃO DE FN FIVE SEVEN", ['perm'] = "corleone.permissao" }, -- mafia
--	{ ['id'] = 10, ['x'] = 905.71, ['y'] = -3230.46, ['z'] = -98.29, ['text'] = "PRODUZIR MUNIÇÃO DE DESERT EAGLE", ['perm'] = "corleone.permissao" }, -- mafia
--	{ ['id'] = 11, ['x'] = 898.11, ['y'] = -3221.64, ['z'] = -98.24, ['text'] = "PRODUZIR MUNIÇÃO DE MPX", ['perm'] = "corleone.permissao" }, -- mafia
--	{ ['id'] = 12, ['x'] = 896.43, ['y'] = -3217.43, ['z'] = -98.22, ['text'] = "PRODUZIR MUNIÇÃO DE TEC-9", ['perm'] = "corleone.permissao" }, -- mafia
	--{ ['id'] = 13, ['x'] = 908.18, ['y'] = -3211.58, ['z'] = -98.22, ['text'] = "PRODUZIR MUNIÇÃO DE SCORPION", ['perm'] = "corleone.permissao" }, -- mafia

	{ ['id'] = 4, ['x'] = -1108.81, ['y'] = 4952.22, ['z'] = 218.65, ['text'] = "COLHER FOLHA DE COCA", ['perm'] = "grove.permissao" }, -- Cocaina COLHER
	{ ['id'] = 5, ['x'] = -1108.13, ['y'] = 4946.59, ['z'] = 218.65, ['text'] = "ESPALHAR A COCAINA", ['perm'] = "grove.permissao" }, -- Cocaina PASTA
	{ ['id'] = 6, ['x'] = -1107.43, ['y'] = 4941.38, ['z'] = 218.65, ['text'] = "PRODUZIR COCAINA", ['perm'] = "grove.permissao" }, -- Cocaina PRODUZIR

	{ ['id'] = 7, ['x'] = 1505.35, ['y'] = 6392.03, ['z'] = 20.79, ['text'] = "COLETAR COMP. LSD", ['perm'] = "vagos.permissao" }, -- Metanfetamina ACIDO
	{ ['id'] = 8, ['x'] = 1494.69, ['y'] = 6395.39, ['z'] = 20.79, ['text'] = "RETIRAR ACIDO ALISERGICO", ['perm'] = "vagos.permissao" }, -- Metanfetamina ANFETAMINA
	{ ['id'] = 9, ['x'] = 1493.22, ['y'] = 6390.25, ['z'] = 21.26, ['text'] = "PRODUZIR LSD", ['perm'] = "vagos.permissao" }, -- Metanfetamina PRODUZIR

	--{ ['id'] = 20, ['x'] = 1115.9, ['y'] = -3163.01, ['z'] = -36.87, ['text'] = "JUNTAR AS PEÇAS", ['perm'] = "motoclub.permissao" }, -- Mafia Juntar
	--{ ['id'] = 21, ['x'] = 1112.57, ['y'] = -3153.16, ['z'] = -37.51, ['text'] = "MONTAR MTAR-21", ['perm'] = "motoclub.permissao" }, -- Mafia Montar MTAR-21
	--{ ['id'] = 22, ['x'] = 1109.65, ['y'] = -3150.44, ['z'] = -37.51, ['text'] = "MONTAR AK-47", ['perm'] = "motoclub.permissao" }, -- Mafia Montar AK-103
	--{ ['id'] = 23, ['x'] = 1112.23, ['y'] = -3150.82, ['z'] = -37.51, ['text'] = "MONTAR SCORPION", ['perm'] = "motoclub.permissao" }, -- Mafia Montar AK-103
	--{ ['id'] = 24, ['x'] = 1098.02, ['y'] = -3142.2, ['z'] = -37.51, ['text'] = "MONTAR FN FIVE SEVEN", ['perm'] = "motoclub.permissao" }, -- Mafia Montar AK-103

	--{ ['id'] = 18, ['x'] = 2328.59, ['y'] = 2571.98, ['z'] = 46.67, ['text'] = "OBTER PENDRIVE COM INFORMAÇÕES", ['perm'] = "yakuza.permissao" }, -- MAFIA OBTER PENDRIVE
	--{ ['id'] = 19, ['x'] = -1053.86, ['y'] = -230.74, ['z'] = 44.03, ['text'] = "ACESSAR A DEEPWEB", ['perm'] = "yakuza.permissao" }, -- MAFIA ACESSO DEEPWEB
	--{ ['id'] = 10, ['x'] = -1056.69, ['y'] = -233.44, ['z'] = 44.04, ['text'] = "OBTER KEYS PARA INVASÃO", ['perm'] = "yakuza.permissao" }, -- MAFIA KEYS PARA INVASO

	--{ ['id'] = 31, ['x'] = -2354.04, ['y'] = 3254.75, ['z'] = 92.91, ['text'] = "JUNTAR AS PEÇAS", ['perm'] = "bratva.permissao" }, -- Mafia Juntar
	--{ ['id'] = 32, ['x'] = -2364.4, ['y'] = 3245.46, ['z'] = 92.91, ['text'] = "MONTAR G36C", ['perm'] = "bratva.permissao" }, -- MONTAR AKS-74U
	--{ ['id'] = 33, ['x'] = -2362.74, ['y'] = 3247.71, ['z'] = 92.91, ['text'] = "MONTAR MPX", ['perm'] = "bratva.permissao" }, -- MONTAR MPX
	--{ ['id'] = 34, ['x'] = -2358.39, ['y'] = 3241.92, ['z'] = 92.91, ['text'] = "MONTAR TEC-9", ['perm'] = "bratva.permissao" }, -- MONTAR TEC-9
	--{ ['id'] = 35, ['x'] = -2356.72, ['y'] = 3244.23, ['z'] = 92.91, ['text'] = "MONTAR DESERT EAGLE", ['perm'] = "bratva.permissao" }, -- MONTAR TEC-9

	--{ ['id'] = 10, ['x'] = 319.18, ['y'] = -600.75, ['z'] = 48.23, ['text'] = "COLETAR BACTÉRIA", ['perm'] = "paramedico.permissao" }, 
	--{ ['id'] = 11, ['x'] = 320.42, ['y'] = -597.02, ['z'] = 48.23, ['text'] = "ENCAPSULAR BACTÉRIA", ['perm'] = "paramedico.permissao" },
	--{ ['id'] = 12, ['x'] = 313.45, ['y'] = -593.22, ['z'] = 48.23, ['text'] = "EMPACOTAR REMÉDIO MANIPULADO", ['perm'] = "paramedico.permissao" },

	--{ ['id'] = 25, ['x'] = 575.22, ['y'] = -3111.03, ['z'] = 6.07, ['text'] = "PROCESSAR POLVORA", ['perm'] = "britanica.permissao" }, -- cosanostra
	--{ ['id'] = 26, ['x'] = 582.38, ['y'] = -3108.2, ['z'] = 6.07, ['text'] = "PRODUZIR MUNIÇÃO DE SUBMACHINE MK2", ['perm'] = "britanica.permissao" }, -- cosanostra
	--{ ['id'] = 27, ['x'] = 576.69, ['y'] = -3107.68, ['z'] = 6.07, ['text'] = "PRODUZIR MUNIÇÃO DE FIVESEVEN", ['perm'] = "britanica.permissao" }, -- cosanostra

	----------------------
	--[CARTEL]
	---------------------
	--{ ['id'] = 28, ['x'] = -2675.48, ['y'] = 1326.31, ['z'] = 140.89, ['text'] = "PROCESSAR POLVORA", ['perm'] = "cartel.permissao" }, -- cosanostra
 	--{ ['id'] = 29, ['x'] = -2678.48, ['y'] = 1332.61, ['z'] = 140.89, ['text'] = "PRODUZIR MUNIÇÃO DE SUBMACHINE MK2", ['perm'] = "cartel.permissao" }, -- cosanostra
	--{ ['id'] = 30, ['x'] = -2679.04, ['y'] = 1327.77, ['z'] = 140.89, ['text'] = "PRODUZIR MUNIÇÃO DE FIVESEVEN", ['perm'] = "cartel.permissao" }, -- cosanostra
}

Citizen.CreateThread(function()
	while true do
		local kswait = 1000
		for k,v in pairs(locais) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
			local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
			if distance <= 2.0 and not processo then
				kswait = 4
				drawTxt("PRESSIONE  ~r~E~w~  PARA "..v.text,4,0.5,0.93,0.50,255,255,255,180)
				if IsControlJustPressed(0,38) and func.checkPermission(v.perm) then
					if func.checkPayment(v.id) then
						TriggerEvent('cancelando',true)
						processo = true
						segundos = 5
					end
				end
			end
		end
		if processo then
			kswait = 4
			drawTxt("AGUARDE ~g~"..segundos.."~w~ SEGUNDOS ATÉ FINALIZAR O PROCESSO",4,0.5,0.93,0.50,255,255,255,180)
		end
		Citizen.Wait(kswait)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[[ VARIAVEIS ARMAMENTO
-----------------------------------------------------------------------------------------------------------------------------------------
local processo2 = false
local segundos2 = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS
-----------------------------------------------------------------------------------------------------------------------------------------
local locs = {
	
	{ ['id'] = 1, ['x'] = 1115.9, ['y'] = -3163.01, ['z'] = -36.87, ['text'] = "JUNTAR AS PEÇAS", ['perm'] = "motoclub.permissao" }, -- Mafia Juntar
	{ ['id'] = 2, ['x'] = 1112.57, ['y'] = -3153.16, ['z'] = -37.51, ['text'] = "MONTAR MTAR-21 ($35.000)", ['perm'] = "motoclub.permissao" }, -- Mafia Montar MTAR-21
	{ ['id'] = 3, ['x'] = 1109.65, ['y'] = -3150.44, ['z'] = -37.51, ['text'] = "MONTAR AK-47 ($60.000)", ['perm'] = "motoclub.permissao" }, -- Mafia Montar AK-103	
	{ ['id'] = 4, ['x'] = 1098.02, ['y'] = -3142.2, ['z'] = -37.51, ['text'] = "MONTAR FN FIVE SEVEN ($15.000)", ['perm'] = "motoclub.permissao" }, -- Mafia Montar AK-103

	{ ['id'] = 5, ['x'] = -2354.04, ['y'] = 3254.75, ['z'] = 92.91, ['text'] = "JUNTAR AS PEÇAS", ['perm'] = "bratva.permissao" }, -- Mafia Juntar
	{ ['id'] = 6, ['x'] = -2364.4, ['y'] = 3245.46, ['z'] = 92.91, ['text'] = "MONTAR G36C ($60.000)", ['perm'] = "bratva.permissao" }, -- MONTAR AKS-74U
	{ ['id'] = 7, ['x'] = -2362.74, ['y'] = 3247.71, ['z'] = 92.91, ['text'] = "MONTAR MPX ($35.000)", ['perm'] = "bratva.permissao" }, -- MONTAR MPX	
	{ ['id'] = 8, ['x'] = -2356.72, ['y'] = 3244.23, ['z'] = 92.91, ['text'] = "MONTAR DESERT EAGLE ($15.000)", ['perm'] = "bratva.permissao" }, -- MONTAR TEC-9
	
}

Citizen.CreateThread(function()
	while true do
		local kswait = 1000
		for k,v in pairs(locs) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
			local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
			if distance <= 1.4 and not processo2 then
				kswait = 0
				drawTxt("PRESSIONE  ~r~E~w~  PARA "..v.text,4,0.5,0.93,0.50,255,255,255,180)
				if IsControlJustPressed(0,38) and func.checkPermission(v.perm) then
					if func.checkPayment2(v.id) then
						TriggerEvent('cancelando',true)
						processo2 = true
						segundos2 = 5
					end
				end
			end
		end
		if processo2 then
			kswait = 0
			drawTxt("AGUARDE ~g~"..segundos2.."~w~ SEGUNDOS ATÉ FINALIZAR O PROCESSO",4,0.5,0.93,0.50,255,255,255,180)
		end
		Citizen.Wait(kswait)
	end
end)]]
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS COSTUREIRA
-----------------------------------------------------------------------------------------------------------------------------------------
local processo3 = false
local segundos3 = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCAIS
-----------------------------------------------------------------------------------------------------------------------------------------
local locs3 = {
	--{ ['id'] = 1, ['x'] = 715.13, ['y'] = -971.0, ['z'] = 30.4, ['text'] = "PEGAR NOVELO DE LINHA", ['perm'] = "admin.permissao" },
	--{ ['id'] = 2, ['x'] = 715.8, ['y'] = -960.09, ['z'] = 30.4, ['text'] = "COSTURAR PEÇA DE ROUPA", ['perm'] = "admin.permissao" },
}

Citizen.CreateThread(function()
	while true do
		local kswait = 1000
		for k,v in pairs(locs3) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
			local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
			if distance <= 1.4 and not processo3 then
				kswait = 4
				drawTxt("PRESSIONE  ~r~E~w~  PARA "..v.text,4,0.5,0.93,0.50,255,255,255,180)
				if IsControlJustPressed(0,38) then
					if func.checkPayment3(v.id) then
						TriggerEvent('cancelando',true)
						processo3 = true
						segundos3 = 8
					end
				end
			end
		end
		if processo3 then
			drawTxt("AGUARDE ~g~"..segundos3.."~w~ SEGUNDOS ATÉ FINALIZAR O PROCESSO",4,0.5,0.93,0.50,255,255,255,180)
		end
		Citizen.Wait(kswait)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONTAGEM --
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
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONTAGEM3 --
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if segundos3 > 0 then
			segundos3 = segundos3 - 1
			if segundos3 == 0 then
				processo3 = false
				TriggerEvent('cancelando',false)
				ClearPedTasks(PlayerPedId())
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