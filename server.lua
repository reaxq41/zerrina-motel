QBCore = exports['qb-core']:GetCoreObject()

motels = {}

RegisterServerEvent('emin-motel:server:enterMotelRoom')
AddEventHandler('emin-motel:server:enterMotelRoom', function()
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    local bucket = getFirstBucket()

    if bucket < 256 then
        motels[src] = bucket
        SetPlayerRoutingBucket(src, motels[src])
        TriggerClientEvent('emin-motel:client:enterMotelRoom', src)
        player.Functions.SetMetaData('inmotel', true)
    else
        TriggerClientEvent('emin-notify:Alert', src, 'Sistem', 'Hotel Rooms Full!', 2000, 'error')
    end
end)

function getFirstBucket()
    local i = 1
    repeat
        local founded = false
        for k, v in pairs(motels) do
            if motels[k] == i then
                founded = true
                i=i+1
                break
            end
        end
    until not founded
    return i
end

RegisterServerEvent('emin-motel:server:exitMotelRoom')
AddEventHandler('emin-motel:server:exitMotelRoom', function()
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    motels[src] = nil
    SetPlayerRoutingBucket(src, 0)
    TriggerClientEvent('emin-motel:client:exitMotelRoom', src)
    player.Functions.SetMetaData('inmotel', false)
end)

AddEventHandler('playerDropped', function(source)
    motels[source] = nil
end)