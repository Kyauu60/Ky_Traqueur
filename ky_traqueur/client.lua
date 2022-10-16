ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('ky:traqueur:pose')
AddEventHandler('ky:traqueur:pose', function()
    local activate, activate2 = true, true
    local target = GetClosestVehicle(GetEntityCoords(PlayerPedId()), 4.0, 0, 71)

    if target ~= 0 then 
        ESX.ShowNotification("Vous placez actuellement un ~r~traqueur~s~.")
        TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
        while activate2 do
            local cotarget = GetEntityCoords(target)
            local distance = Vdist2(cotarget, GetEntityCoords(PlayerPedId()))
                if distance > Config.DistancePose then 
                    activate, activate2 = false
                    ESX.ShowNotification("Véhicule trop loin.")
                    ClearPedTasks(PlayerPedId())
                else 
                    SetTimeout(Config.DureePose, function() 
                        activate2 = false
                        ClearPedTasks(PlayerPedId())
                    end)
                end
            Wait(5)
        end
        TriggerServerEvent('ky:traqueur:accept')
        SetTimeout(Config.TempsTraqueur, function() 
            activate = false 
            RemoveBlip(postarget)
            ESX.ShowNotification("~r~Traqueur~s~ terminé.")
        end)
        while activate do 
            local interval = Config.Interval1
            local cotarget = GetEntityCoords(target)
            local dst = Vdist2(cotarget, GetEntityCoords(PlayerPedId()))
                if dst < 540000 then 
                    interval = Config.Interval1
                elseif dst < 2700000 and dst > 540000 then 
                    interval = Config.Interval2
                elseif dst > 2700000 then 
                    interval = Config.Interval3
                elseif cotarget == "vector3(0, 0, 0)" then 
                    activate = false 
                RemoveBlip(postarget)
                ESX.ShowNotification("~r~Traqueur~s~ terminé.")
                end
            postarget = AddBlipForCoord(cotarget)
            SetBlipSprite(postarget, 225)
            SetBlipDisplay(postarget, 4)
            SetBlipScale(postarget, 0.75)
            SetBlipColour(postarget, 59)
            SetBlipAsShortRange(postarget, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('Véhicule ~r~Cible')
            EndTextCommandSetBlipName(postarget)
            
            Wait(interval)
            RemoveBlip(postarget)
            Wait(5)
        end
    else
        ESX.ShowNotification("Aucun véhicule proche.")
    end
end)