local window

addEvent('register-menu:open', true)
addEventHandler('register-menu:open', root, function ()
    -- initialize the cursor
    showCursor(true, true)
    guiSetInputMode('no_binds')

    -- open our menu
    local x, y, width, height = getWindowPosition(400, 230)
    window = guiCreateWindow(x, y, width, height, 'Login to Our Server', false)
    guiWindowSetMovable(window, false)
    guiWindowSetSizable(window, false)

    local usernameLabel = guiCreateLabel(15, 30, width - 30, 20, 'Username:', false, window)

    local usernameErrorLabel = guiCreateLabel(width - 130, 30, 140, 20, 'Username is required', false, window)
    guiLabelSetColor(usernameErrorLabel, 255, 100, 100)
    guiSetVisible(usernameErrorLabel, false)

    local usernameInput = guiCreateEdit(10, 50, width - 20, 30, '', false, window)

    local passwordLabel = guiCreateLabel(15, 90, width - 30, 20, 'Password:', false, window)

    local passwordErrorLabel = guiCreateLabel(width - 125, 90, 140, 20, 'Password is required', false, window)
    guiLabelSetColor(passwordErrorLabel, 255, 100, 100)
    guiSetVisible(passwordErrorLabel, false)

    local passwordInput = guiCreateEdit(10, 110, width - 20, 30, '', false, window)
    guiEditSetMasked(passwordInput, true)

    local registerButton = guiCreateButton(10, 150, width - 20, 30, 'Sign Up', false, window)
    addEventHandler('onClientGUIClick', registerButton, function (button, state)
        if button ~= 'left' or state ~= 'up' then
            return
        end

        local username = guiGetText(usernameInput)
        local password = guiGetText(passwordInput)
        local inputValid = true

        if not isUsernameValid(username) then
            guiSetVisible(usernameErrorLabel, true)
            inputValid = false
        else
            guiSetVisible(usernameErrorLabel, false)
        end

        if not isPasswordValid(password) then
            guiSetVisible(passwordErrorLabel, true)
            inputValid = false
        else
            guiSetVisible(passwordErrorLabel, false)
        end

        if not inputValid then
            return
        end

        triggerServerEvent('auth:register-attempt', localPlayer, username, password)
    end, false)

    local cancelButton = guiCreateButton(10, 190, width - 20, 30, 'Cancel', false, window)
    addEventHandler('onClientGUIClick', cancelButton, function (button, state)
        if button ~= 'left' or state ~= 'up' then
            return
        end

        triggerEvent('register-menu:close', localPlayer)
        triggerEvent('login-menu:open', localPlayer)
    end, false)
end)

addEvent('register-menu:close', true)
addEventHandler('register-menu:close', root, function ()
    destroyElement(window)
    showCursor(false)
    guiSetInputMode('allow_binds')
end)