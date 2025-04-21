QBCore = exports['qb-core']:GetCoreObject()


local currentmotel = nil
local inroom = false

local pinkcagecoord = vector3(-1710.3223876953, -1110.9063720703, 13.152285575867)

local roomCoord = vector3(291.0, -925.24, -23.0)
local roomHeading = 173.76
local stashCoord = vector3(283.4, -925.48, -23.0)
local clotheCoord = vector3(285.72, -922.56, -23.0)
local PlayerData = {}

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    ilkgiris()
end)


function ilkgiris()
    PlayerData = QBCore.Functions.GetPlayerData()
    if PlayerData.metadata['inmotel'] then
        TriggerServerEvent('emin-motel:server:enterMotelRoom')
    end
end


RegisterNetEvent('emin-motel:client:enterMotelRoom')
AddEventHandler('emin-motel:client:enterMotelRoom', function()
    local player = PlayerPedId()
    DoScreenFadeOut(500)
    Wait(600)
    FreezeEntityPosition(player, true)
    SetEntityCoords(player, roomCoord.x, roomCoord.y, roomCoord.z-1.0)
    SetEntityHeading(player, roomHeading)
    Wait(1400)
    inroom = true
    DoScreenFadeIn(1000)
    repeat
        Wait(10)
	until (IsControlJustPressed(0, 32) or IsControlJustPressed(0, 33) or IsControlJustPressed(0, 34) or IsControlJustPressed(0, 35))

    FreezeEntityPosition(player, false)
end)


RegisterNetEvent('emin-motel:client:exitMotelRoom')
AddEventHandler('emin-motel:client:exitMotelRoom', function()
    local player = PlayerPedId()
    DoScreenFadeOut(500)
    Wait(1500)
    SetEntityCoords(player, pinkcagecoord.x, pinkcagecoord.y, pinkcagecoord.z-1)
    Wait(500)
    inroom = false
    DoScreenFadeIn(1000)
end)

AddEventHandler('moteldepo' , function()
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "Motel_"..tostring(PlayerData.citizenid), {maxweight = 2000000, slots = 400,})
    TriggerEvent("inventory:client:SetCurrentStash","Motel_"..tostring(PlayerData.citizenid))
end)

AddEventHandler('motel' , function()
    TriggerServerEvent("emin-motel:server:enterMotelRoom", source)
end)

AddEventHandler('motelexit' , function()
    TriggerServerEvent("emin-motel:server:exitMotelRoom", source)
end)



CreateThread(function()
exports['qb-target']:AddBoxZone("motel", vector3(-1710.32, -1110.90, 13.15), 2, 2, {
    name="motel",
    heading=0,
    debugPoly=false,
}, {
    options = {
        {
            event = "motel",
            icon = "fas fa-hotel",
            label = "Motele Gir",
        }
    },
    distance = 3.0,
})

exports['qb-target']:AddBoxZone("dolap", vector3(283.44, -924.35, -23.0), 2, 2, {
    name="dolap",
    debugPoly=false,
}, {
    options = {
        {
            event = "moteldepo",
            icon = "fas fa-toolbox",
            label = "Depoyu Aç",
        }
    },
    distance = 3.0,
})

exports['qb-target']:AddBoxZone("exit", vector3(291.22, -923.97, -22.99), 2, 2, {
    name="exit",
    debugPoly=false,
}, {
    options = {
        {
            event = "motelexit",
            icon = "fas fa-door-closed",
            label = "Odadan Çık",
        }
    },
    distance = 3.0,
})


exports['qb-target']:AddBoxZone("kiyafet", vector3(286.57235717773, -922.71356201172, -23.001815795898), 2, 2, {
    name="exit",
    debugPoly=false,
}, {
    options = {
        {
            event = "qb-clothing:client:openOutfitMenu",
            icon = "fas fa-door-closed",
            label = "Kıyafet Menüsü",
        }
    },
    distance = 3.0,
})
end)

--