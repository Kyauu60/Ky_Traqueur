ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('traqueur', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('ky:traqueur:pose', source)
end)

RegisterNetEvent('ky:traqueur:accept')
AddEventHandler('ky:traqueur:accept', function()
    local source = source 
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem('traqueur', 1)
end)