ESX = {};

TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)

voitures = {
    {Nom = 'Fiat 600', label = 'fiat600', prix = 0},
    {Nom = 'Renaut Zoe', label = 'zoe', prix = 0}
}

motos = {
    {Nom = 'Scooter', label = 'faggio', prix = 0}
}

touches = {
    {Nom = 'F1', desc = 'Boutique'},
    {Nom = 'F2', desc = 'Clés véhicules'},
    {Nom = 'F3', desc = 'Portée de la voie'},
    {Nom = 'F5', desc = 'Menu Personnel'},
    {Nom = 'F6', desc = 'Menu Metier'},
    {Nom = 'F7', desc = 'Menu Gang'},
    {Nom = 'X', desc = 'Ceinture'},
    {Nom = '²', desc = 'Lever les bras'},
    {Nom = 'B', desc = 'Pointer du doigt'},
    {Nom = 'G', desc = 'Téléphone'},
    {Nom = 'K', desc = 'Menu emotes'},
    {Nom = 'ALT', desc = 'Menu rapide'},
}

local open = false 
local mainMenu = RageUI.CreateMenu('Location', '~b~NomDuServer')
mainMenu:SetRectangleBanner(0, 0, 200, 160)
local voitureSwayxs = RageUI.CreateSubMenu(mainMenu, "Voitures", '~b~NomDuServer')
voitureSwayxs:SetRectangleBanner(0, 0, 200, 160)
local motoSwayxs = RageUI.CreateSubMenu(mainMenu, "Motos", '~b~NomDuServer')
motoSwayxs:SetRectangleBanner(0, 0, 200, 160)
local infoSwayxs = RageUI.CreateSubMenu(mainMenu, "Information ville", '~b~NomDuServer')
infoSwayxs:SetRectangleBanner(0, 0, 200, 160)
mainMenu.Display.Header = true 
mainMenu.Closed = function()
  open = false
end

function OpenLocaSwayxs()
	if open then 
		open = false
		RageUI.Visible(mainMenu, false)
		return
	else
		open = true 
		RageUI.Visible(mainMenu, true)
		CreateThread(function()
		while open do 
		   RageUI.IsVisible(mainMenu,function()

            RageUI.Button("~b~→ ~s~Voitures", nil, {RightLabel = "→→"}, true , {
                onSelected = function()
                end
            }, voitureSwayxs)

            RageUI.Button("~b~→ ~s~Motos", nil, {RightLabel = "→→"}, true , {
                onSelected = function()
                end
            }, motoSwayxs)

            RageUI.Separator('~b~↓ Informations ↓')

            RageUI.Button('~b~→ ~s~Touches du serveur', nil, {RightLabel = "→→"}, true, {
                onSelected = function()
                end
            }, infoSwayxs)

        end)

        RageUI.IsVisible(voitureSwayxs,function()

            RageUI.Separator('~b~↓ Voitures ↓')

            for k,v in pairs(voitures) do
                RageUI.Button(v.Nom, nil, {RightLabel = "~g~"..(v.prix).."$"}, true, {
                    onSelected = function()
                        RageUI.CloseAll()
                        local model = GetHashKey(v.label)
                        RequestModel(model)
                        while not HasModelLoaded(model) do Citizen.Wait(10) end
                        local pos = vector3(-944.1, -2320.14, 6.71)
                        local vehicle = CreateVehicle(model, pos.x, pos.y, pos.z, 235.1, true, false)
                        TriggerServerEvent('swayxs:BuyVeh', v.label, v.prix)
                        local newPlate = exports['esx_vehicleshop']:GenerateSocietyPlate('LOCA')
                        SetVehicleNumberPlateText(vehicle, newPlate)
                        TriggerServerEvent('esx_vehiclelock:givekey', 'no', newPlate)
                    end
                })
            end

		   end)

           RageUI.IsVisible(motoSwayxs,function()

            RageUI.Separator('~b~↓ Motos ↓')

            for k,v in pairs(motos) do
                RageUI.Button(v.Nom, nil, {RightLabel = "~g~"..(v.prix).."$"}, true, {
                    onSelected = function()
                        RageUI.CloseAll()
                        local model = GetHashKey(v.label)
                        RequestModel(model)
                        while not HasModelLoaded(model) do Citizen.Wait(10) end
                        local pos = vector3(-944.1, -2320.14, 6.71)
                        local vehicle = CreateVehicle(model, pos.x, pos.y, pos.z, 235.1, true, false)
                        TriggerServerEvent('swayxs:BuyVeh', v.label, v.prix)
                        local newPlate = exports['esx_vehicleshop']:GenerateSocietyPlate('LOCA')
                        SetVehicleNumberPlateText(vehicle, newPlate)
                        TriggerServerEvent('esx_vehiclelock:givekey', 'no', newPlate)
                    end
                })
            end

		   end)

           RageUI.IsVisible(infoSwayxs,function()

            RageUI.Separator('~b~↓ Touches du serveur ↓')

            for k,v in pairs(touches) do
                RageUI.Button("~b~"..v.Nom.."", nil, {RightLabel = ""..(v.desc)..""}, true, {
                    onSelected = function()
                    end
                })
            end

		   end)

		 Wait(0)
		end
	 end)
  end
end

local loca = {
    {x = -944.99, y = -2327.32, z = 6.71}
}

zone = {
	Ped = vector3(-944.99, -2327.32, 6.71),
}

Citizen.CreateThread(function()
    local blip = AddBlipForCoord(-944.99, -2327.32, 6.71)
    SetBlipSprite(blip, 494)
    SetBlipScale (blip, 0.8)
    SetBlipColour(blip, 3)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName('Location de véhicules')
    EndTextCommandSetBlipName(blip)
    ESX.Game.SpawnLocalPed(2, pedHash, zone.Ped, pedHeading, function(ped)
        FreezeEntityPosition(ped, true)
        TaskStartScenarioInPlace(ped, "WORLD_HUMAN_CLIPBOARD", 0, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
    end)
end)

Citizen.CreateThread(function()
    while true do
        local opti = 500
            for k in pairs(loca) do
                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, loca[k].x, loca[k].y, loca[k].z)
		if dist <= 10.0 then
		DrawMarker(22, -944.99, -2327.32,6.71, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255, 0, 0, 255, 55555, false, true, 2, false, false, false, false)
                    opti = 0
                    if dist <= 2.0 then
                    opti = 0
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_TALK~ pour parler à la personne")
                    if IsControlJustPressed(1,51) then
                        OpenLocaSwayxs()
                    end
                end
            end
        Citizen.Wait(opti)
    end
end)