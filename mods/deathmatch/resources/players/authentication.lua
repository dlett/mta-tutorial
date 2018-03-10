local MINIMUM_PASSWORD_LENGTH = 6

local function isPasswordValid(password)
    return string.len(password) >= MINIMUM_PASSWORD_LENGTH
end

-- create an account
addCommandHandler('register', function (player, command, username, password)
    if not username or not password then
        return outputChatBox('SYNTAX: /' .. command .. ' [username] [password]', player, 255, 255, 255)
    end

    -- check if an account with that username already exists
    if getAccount(username) then
        return outputChatBox('An account already exists with that name.', player, 255, 100, 100)
    end

    -- is the password valid?
    if not isPasswordValid(password) then
        return outputChatBox('The password supplied was not valid.', player, 255, 100, 100)
    end

    -- create a hash of the password
    passwordHash(password, 'bcrypt', {}, function (hashedPassword)
        -- create the account
        local account = addAccount(username, hashedPassword)
        setAccountData(account, 'hashed_password', hashedPassword)

        -- let the user know of our success
        outputChatBox('Your account has been successfully created! You may now login with /accountLogin', player, 100, 255, 100)
    end)
end, false, false)

-- login to their account
addEvent('auth:login-attempt', true)
addEventHandler('auth:login-attempt', root, function (username, password)

    local account = getAccount(username)
    if not account then
        return outputChatBox('No such account could be found with that username or password.', source, 255, 100, 100)
    end

    local hashedPassword = getAccountData(account, 'hashed_password')
    local player = source
    passwordVerify(password, hashedPassword, function (isValid)
        if not isValid then
            return outputChatBox('No such account could be found with that username or password.', player, 255, 100, 100)
        end

        if logIn(player, account, hashedPassword) then
            spawnPlayer(player, 0, 0, 10)
            setCameraTarget(player, player)
           return triggerClientEvent(player, 'login-menu:close', player)
        end

        return outputChatBox('An unknown error occured while attempting to authenticate.', player, 255, 100, 100)
    end)

end)

-- logout of their account
addCommandHandler('accountLogout', function (player)
    logOut(player)
end)