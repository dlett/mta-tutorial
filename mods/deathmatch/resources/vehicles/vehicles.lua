
function createVehicleForPlayer(player, command, model)
    local db = exports.db:getConnection()
    local x, y, z = getElementPosition(player)
    y = y + 5

    dbExec(db, 'INSERT INTO vehicles (model, x, y, z) VALUES (?, ?, ?, ?)', model, x, y, z)

    local vehicleObject = createVehicle(model, x, y, z)

    dbQuery(function (queryHandle)
        local results = dbPoll(queryHandle, 0)
        local vehicle = results[1]

        setElementData(vehicleObject, 'id', vehicle.id)

    end, db, 'SELECT id FROM vehicles ORDER BY id DESC LIMIT 1')
end
addCommandHandler('createvehicle', createVehicleForPlayer, false, false)
addCommandHandler('createveh', createVehicleForPlayer, false, false)
addCommandHandler('makeveh', createVehicleForPlayer, false, false)

function loadAllVehicles(queryHandle)
    local results = dbPoll(queryHandle, 0)

    for index, vehicle in pairs(results) do
        local vehicleObject = createVehicle(vehicle.model, vehicle.x, vehicle.y, vehicle.z)

        setElementData(vehicleObject, "id", vehicle.id)
    end
end

addEventHandler('onResourceStart', resourceRoot, function ()
    local db = exports.db:getConnection()

    dbQuery(loadAllVehicles, db, 'SELECT * FROM vehicles')
end)

addEventHandler('onResourceStop', resourceRoot, function ()
    local db = exports.db:getConnection()
    local vehicles = getElementsByType('vehicle')

    for index, vehicle in pairs(vehicles) do
        local id = getElementData(vehicle, 'id')
        local x, y, z = getElementPosition(vehicle)

        dbExec(db, 'UPDATE vehicles SET x = ?, y = ?, z = ? WHERE id = ?', x, y, z, id)
    end
end)