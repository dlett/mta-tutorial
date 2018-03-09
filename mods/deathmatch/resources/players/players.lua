-- when a player joins run some code

setTime(12,0)
setMinuteDuration(10000000000)

addCommandHandler('clearchat', function (player)
    for i = 1, 16 do
        outputChatBox(' ', player)
    end
end, false, false)

addEventHandler('onPlayerJoin', root, function ()
    -- spawn the player
    spawnPlayer(source, 0, 0, 5)

    -- fade their camera in
    fadeCamera(source, true)

    -- set the camera target to be the spawned player.
    setCameraTarget(source, source)
end)
