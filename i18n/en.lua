-- Every variable must start with this addon's unique ID, as each is a global.
local localization_strings = {
    SI_JOKER_ACTIVE_MESSAGE = " is active!",
    -- Keybindings.
    SI_BINDING_NAME_JOKER_SETTINGS = "Display the Joker addon",
}

for stringId, stringValue in pairs(localization_strings) do
   ZO_CreateStringId(stringId, stringValue)
   SafeAddVersion(stringId, 1)
end
