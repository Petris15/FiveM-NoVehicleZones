function IsEntityInArea(coords)
    for k,v in ipairs(PetrisConfig.Zones) do
        local vector = vector3(v.x, v.y, v.z)
        if not (#(coords - vector) > v.radius) then
            return true
        end
    end
    return false
end

AddEventHandler('entityCreating', function(entity)
    if GetEntityType(entity) == 2 then
        local model = GetEntityModel(entity)
        local owner = NetworkGetEntityOwner(entity)
        local coords = GetEntityCoords(entity)
        local plate = GetVehicleNumberPlateText(entity)
        local steamid = "Not Found"
        if IsEntityInArea(coords) then
            CancelEvent()
            if owner then
                local ownername = GetPlayerName(owner)
                for k,v in pairs(GetPlayerIdentifiers(owner))do
                    if string.sub(v, 1, string.len("steam:")) == "steam:" then
                        steamid = v
                    end
                end
                print('^1[Petris No-Vehicle Zones]: ^2Vehicle Spawning In Blacklisted Area Has Been Detected & Cancelled Successfully!\n^0Vehicle Owner: ^5'..ownername..' ^6[Server ID: '..owner..'] ^6[Identifier: '..steamid..']\n^0Vehicle Model: ^5'..model..'\n^0Vehicle Plate: ^5'..plate..'\n^0Vehicle Location: ^5'..coords.x, coords.y, coords.z..'')
            end
        end
    else
        return
    end
end)