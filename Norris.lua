Norris = {
    name            = "Norris",           -- Matches folder and Manifest file names.
    -- version         = "1.0",                -- A nuisance to match to the Manifest.
    author          = "Lent (@CallMeLent, Git @adefee)",
    color           = "DDFFEE",             -- Used in menu titles and so on.
    menuName        = "Norris Jokes",          -- A UNIQUE identifier for menu object.
    -- Default settings.
    savedVariables = {
        FirstLoad = true,                   -- First time the addon is loaded ever.
        DefaultExplicit = false             -- Should /norris include explicit jokes in pool by default?
    },
}

-- Wraps text with a color.
function Norris.Colorize(text, color)
    -- Default to addon's .color.
    if not color then color = Norris.color end

    text = "|c" .. color .. text .. "|r"

    return text
end

function Norris.AnimateText()
    -- Avoid playing the animation over itself.
    if not NorrisActive:IsHidden() then return end

    local animation, timeline = CreateSimpleAnimation(ANIMATION_ALPHA, NorrisActive)

    NorrisActive:SetHidden(false)
    animation:SetAlphaValues(NorrisActive:GetAlpha(), 1)
    animation:SetDuration(3000)

    -- Fade-out after fade-in.
    timeline:SetHandler('OnStop', function()
        local animation, timeline = CreateSimpleAnimation(ANIMATION_ALPHA, NorrisActive)

        animation:SetAlphaValues(NorrisActive:GetAlpha(), 0)
        animation:SetDuration(3000)

        timeline:SetHandler('OnStop', function()
            NorrisActive:SetHidden(true)
        end)

        timeline:PlayFromStart()
    end)

    timeline:PlayFromStart()
end

-- Only show the loading message on first load ever.
function Norris.Activated(e)
    EVENT_MANAGER:UnregisterForEvent(Norris.name, EVENT_PLAYER_ACTIVATED)

    if Norris.savedVariables.FirstLoad then
        Norris.savedVariables.FirstLoad = false

        d(Norris.name .. GetString(SI_NEW_ADDON_MESSAGE)) -- Prints to chat.

        ZO_AlertNoSuppression(UI_ALERT_CATEGORY_ALERT, nil,
            Norris.name .. GetString(SI_NEW_ADDON_MESSAGE)) -- Top-right alert.

        -- Animate the xml UI center text, after a delay.
        zo_callLater(Norris.AnimateText, 3000)
    end
end

-- When player is ready, after everything has been loaded.
EVENT_MANAGER:RegisterForEvent(Norris.name, EVENT_PLAYER_ACTIVATED, Norris.Activated)

function Norris.OnAddOnLoaded(event, addonName)
    if addonName ~= Norris.name then return end
    EVENT_MANAGER:UnregisterForEvent(Norris.name, EVENT_ADD_ON_LOADED)

    Norris.savedVariables = ZO_SavedVars:New("NorrisSavedVariables", 1, nil, Norris.savedVariables)

    -- Settings menu in Settings.lua.
    Norris.LoadSettings()

    -- Slash commands must be lowercase!!! Set to nil to disable.
    SLASH_COMMANDS["/norris"] = Norris.AnimateText
    -- Reset autocomplete cache to update it.
    SLASH_COMMAND_AUTO_COMPLETE:InvalidateSlashCommandCache()
end
-- When any addon is loaded, but before UI (Chat) is loaded.
EVENT_MANAGER:RegisterForEvent(Norris.name, EVENT_ADD_ON_LOADED, Norris.OnAddOnLoaded)
