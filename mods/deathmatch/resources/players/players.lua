-- when a player joins run some code

setTime(12,0)
setMinuteDuration(10000000000)

addCommandHandler('clearchat', function (player)
    for i = 1, 16 do
        outputChatBox(' ', player)
    end
end, false, false)

addEventHandler('onPlayerJoin', root, function ()
    triggerClientEvent(source, 'login-menu:open', source)
end)
