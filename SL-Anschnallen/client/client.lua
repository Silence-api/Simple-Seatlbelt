print('Loaded Anschnallen')
SetFlyThroughWindscreenParams(Config_Anschnallen.Settings['ejectVelocity'], Config_Anschnallen.Settings['unknownEjectVelocity'], Config_Anschnallen.Settings['unknownModifier'], Config_Anschnallen.Settings['minDamage']);
local seatbeltOn = false
local ped = nil

Citizen.CreateThread(function()
    while true do
        ped = PlayerPedId()
        Citizen.Wait(500)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        if IsPedInAnyVehicle(ped) then
            local class = GetVehicleClass(GetVehiclePedIsIn(ped))
            if class == 8 then
                if seatbeltOn then
                    if Config_Anschnallen.Settings['fixedWhileBuckled'] then
                        DisableControlAction(0, 75, true) -- Disable exit vehicle when stop
                        DisableControlAction(27, 75, true) -- Disable exit vehicle when Driving
                    end
                    SetPedCanBeKnockedOffVehicle(ped, 1) -- 0 = DEFAULT, 1 = NEVER, 2 = EASY, 3 = HARD
                else
                    SetPedCanBeKnockedOffVehicle(ped, 0)
                end
            end
        else
            if seatbeltOn then
                seatbeltOn = false
                aschnallen(false, false)
            end
            Citizen.Wait(1000)
        end
    end
end)


function aschnallen(makeSound, toggle)
    if toggle == nil then
        if seatbeltOn then
            Config_Anschnallen.AbschnallNotify()
            SetFlyThroughWindscreenParams(Config_Anschnallen.Settings['ejectVelocity'], Config_Anschnallen.Settings['unknownEjectVelocity'], Config_Anschnallen.Settings['unknownModifier'], Config_Anschnallen.Settings['minDamage'])
        else
            Config_Anschnallen.AnschnallNotify()
            SetFlyThroughWindscreenParams(10000.0, 10000.0, 17.0, 500.0);
        end
        seatbeltOn = not seatbeltOn
    else
        if toggle then
            SetFlyThroughWindscreenParams(10000.0, 10000.0, 17.0, 500.0);
        else
            SetFlyThroughWindscreenParams(Config_Anschnallen.Settings['ejectVelocity'], Config_Anschnallen.Settings['unknownEjectVelocity'], Config_Anschnallen.Settings['unknownModifier'], Config_Anschnallen.Settings['minDamage'])
        end
        seatbeltOn = toggle
    end
end


RegisterCommand(Config_Anschnallen.Settings['toggleCommand'], function(source, args, rawCommand)
    if IsPedInAnyVehicle(ped, false) then
        local class = GetVehicleClass(GetVehiclePedIsIn(ped))
        if class == 8 then
            aschnallen(true)
        end
    end
end, false)

RegisterKeyMapping(Config_Anschnallen.Settings['toggleCommand'], 'Anschnallen (BF400)', 'keyboard', Config_Anschnallen.Settings['anschnallTaste'])
