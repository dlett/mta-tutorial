
-- The database connection
local db

addEventHandler('onResourceStart', resourceRoot, function ()
    db = dbConnect('sqlite', ':/global.db')
end)

function getConnection()
    return db
end
