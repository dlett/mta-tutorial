function getWindowPosition(width, height)
    local screenWidth, screenHeight = guiGetScreenSize()
    local x = (screenWidth / 2) - (width / 2)
    local y = (screenHeight / 2) - (height / 2)

    return x, y, width, height
end

function isUsernameValid(username)
    return type(username) == 'string' and string.len(username) > 1
end

function isPasswordValid(password)
    return type(password) == 'string' and string.len(password) > 1
end