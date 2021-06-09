local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
rsh = Tunnel.getInterface("rush_dominacao",rsh)

-------------------------------------------------------------
-- VARIAVEIS
-------------------------------------------------------------
local segundos = 0 
local pegando = false 

-------------------------------------------------------------
-- COORDENADAS
-------------------------------------------------------------
local locais = {
    -- DROGAS

    [1] = { ['x'] = 1486.11, ['y'] = 1132.07, ['z'] = 114.34, ['perm'] = "crips.permissao", ['blip'] = 1},
    -- [2] = { ['x'] = 1419.14, ['y'] = 1089.14, ['z'] = 114.33, ['perm'] = "drogas.permissao", ['blip'] = 2},
    -- [3] = { ['x'] = 1469.96, ['y'] = 1134.51, ['z'] = 114.33, ['perm'] = "drogas.permissao", ['blip'] = 3},
    -- [4] = { ['x'] = 1460.0, ['y'] = 1086.62, ['z'] = 114.34, ['perm'] = "drogas.permissao", ['blip'] = 4},

    -- ARMAS

    [2] = { ['x'] = 1694.85, ['y'] = 3331.84, ['z'] = 41.49, ['perm'] = "armas.permissao", ['blip'] = 1}, -- 1694.85, 3331.84, 41.49
    [3] = { ['x'] = 1721.1, ['y'] = 3320.4, ['z'] = 41.23, ['perm'] = "armas.permissao", ['blip'] = 2}, -- 1721.1, 3320.4, 41.23
    [4] = { ['x'] = 1734.57, ['y'] = 3330.09, ['z'] = 41.23, ['perm'] = "armas.permissao", ['blip'] = 3}, -- 1734.57, 3330.09, 41.23
    -- [8] = { ['x'] = 2658.49, ['y'] = 1376.58, ['z'] = 24.06, ['perm'] = "armas.permissao", ['blip'] = 4},

    -- MUNICAO

    [5] = { ['x'] = 950.6, ['y'] = 2403.65, ['z'] = 51.11, ['perm'] = "municoes.permissao", ['blip'] = 1}, -- 950.6, 2403.65, 51.11
    [6] = { ['x'] = 1128.99, ['y'] = 2125.23, ['z'] = 55.55, ['perm'] = "municoes.permissao", ['blip'] = 2}, -- 1128.99, 2125.23, 55.55
    [7] = { ['x'] = 872.69, ['y'] = 2352.82, ['z'] = 51.71, ['perm'] = "municoes.permissao", ['blip'] = 3}, -- 872.69, 2352.82, 51.71
    -- [11] = { ['x'] = 65.41, ['y'] = 3606.59, ['z'] = 39.83, ['perm'] = "municoes.permissao", ['blip'] = 4},

    -- LAVAGEM
    
    [8] = { ['x'] = 2491.31, ['y'] = 3761.36, ['z'] = 42.26, ['perm'] = "lavagem.permissao", ['blip'] = 1},
    [9] = { ['x'] = 2482.49, ['y'] = 3722.35, ['z'] = 43.93, ['perm'] = "lavagem.permissao", ['blip'] = 2},

}

Citizen.CreateThread(function()
    while true do
        local timeDistance = 1000
        local ped = GetPlayerPed(-1)
        local x,y,z = table.unpack(GetEntityCoords(ped))
        for k,v in pairs(locais) do
            local dist = GetDistanceBetweenCoords(v.x, v.y, v.z, x, y, z, true)
            if dist <= 15 and not pegando then
                timeDistance = 4
                DrawMarker(23,v.x,v.y,v.z-1,0,0,0,0.0,0,0,1.5,1.5,1.5,255,0,0,50,0,0,0,1)
                if IsControlJustPressed(0, 38) and rsh.permissao(v.perm) and dist <= 1 then
                    if rsh.lootear(k) then
                        pegando = true 
                        TriggerEvent('cancelando',true)
                        FreezeEntityPosition(ped, true)
                        vRP._playAnim(false,{{"anim@heists@ornate_bank@grab_cash_heels","grab"}},true)
                        TriggerEvent("progress", 13000, "pegando")
                        SetTimeout(13000, function()
                            FreezeEntityPosition(ped, false)
                            vRP._stopAnim(false)
                            rsh.pagamento(v.perm,v.blip,k)
                            TriggerEvent('cancelando',false)
                            pegando = false
                        end)
                    else
                        TriggerEvent("Notify","negado","Já coletaram o farm!")
                    end            
                end    
            end    
        end
        Citizen.Wait(timeDistance)
    end    
end) 

