ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('swayxs:BuyVeh')
AddEventHandler('swayxs:BuyVeh', function(item,prix)

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.getAccount('cash').money >= prix then

        xPlayer.removeAccountMoney('cash', prix)
        xPlayer.addInventoryItem(item, 1)
        TriggerClientEvent('esx:showNotification', source, "~g~Achat~w~ effectué !")
    else
         TriggerClientEvent('esx:showNotification', source, "Vous n'avez assez ~r~d\'argent")
    end
end)