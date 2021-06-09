local pedlist = {
-- GROVE
	{ ['x'] = -151.85, ['y'] = -1623.01, ['z'] = 33.65, ['h'] = 238.09, ['hash'] = 0xDB729238, ['hash2'] = "g_m_y_famdnf_01" },

-- BALLAS
	{ ['x'] = 83.43, ['y'] = -1967.63, ['z'] = 20.75, ['h'] = 231.71, ['hash'] = 0x14D7B4E0, ['hash2'] = "s_m_m_dockwork_01" },
 
-- VAGOS
	{ ['x'] = 362.04, ['y'] = -2043.44, ['z'] = 22.24, ['h'] = 138.34, ['hash'] = 0xCE2CB751, ['hash2'] = "u_m_m_jesus_01" }, -- outros

-- Venda Munições
	{ ['x'] = 951.8, ['y'] = -2527.47, ['z'] = 28.33, ['h'] = 176.42, ['hash'] = 0x9E08633D, ['hash2'] = "s_m_y_ammucity_01" }, -- Aztecas
	{ ['x'] = 1308.87, ['y'] = 316.07, ['z'] = 82.0, ['h'] = 55.65, ['hash'] = 0x9E08633D, ['hash2'] = "s_m_y_ammucity_01" }, -- Metralhas
-- Venda armas
	{ ['x'] = 1571.25, ['y'] = -2167.19, ['z'] = 77.59, ['h'] = 78.08, ['hash'] = 0x9E08633D, ['hash2'] = "s_m_y_ammucity_01" } -- Mafia
	
}

Citizen.CreateThread(function()
	for k,v in pairs(pedlist) do
		RequestModel(GetHashKey(v.hash2))
		while not HasModelLoaded(GetHashKey(v.hash2)) do
			Citizen.Wait(10)
		end

		local ped = CreatePed(4,v.hash,v.x,v.y,v.z-1,v.h,false,true)
		FreezeEntityPosition(ped,true)
		SetEntityInvincible(ped,true)
		SetBlockingOfNonTemporaryEvents(ped,true)
	end
end)