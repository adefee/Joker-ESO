--[[----------------------------------------------------------
	Joker - Jokes, Riddles, Fun Facts, & Other Tomfoolery
  ----------------------------------------------------------
  * VERSION: --0.0.1 ** Please do not modify this line.
  *
	* Authors:
	* - Lent (IGN @CallMeLent, Github @adefee)
  *
  * Contributors & Special Thanks:
  * - Sirinsidiator (IGN, Github @Sirinsidiator)
  * - Baertram (IGN, Github @Baertram)
  * - Manavortex (IGN, Github @Baertram)
  *
  * Contents:
  * - Core & Default Values
  * - Utility
  * - Addon Instantiation
  *
]]--

-- Handle includes
JokerData = JokerData or {} -- content
JokerL = JokerL or {} -- i18n
Joker = Joker or {} -- vars, defaults

local L = Joker.locale -- sets our locale
local Util = JokerUtilityFn or {} -- utility functions used throughout
local Data = JokerDataFn or {} -- data and content processing & display

local jokeLengthMax = 325 -- Max safe length of a message in ESO chatbox before it risks being snipped.


-- Runs only the first time load
local function runtime_maiden()
  d('Maiden load')
  Joker.saved.internal.firstLoad = 0
end


-- Runs each load
local function runtime_onload()
  d('Joker (' .. Joker.version .. ') loaded.')
end


--[[
  *****************************
  ** Addon Instantiation, Hook to Ingame Events
  *****************************
]]

-- Only show the loading message on first load ever. Displays a random message
function Joker.Activated(e)
  EVENT_MANAGER:UnregisterForEvent(Joker.name, EVENT_PLAYER_ACTIVATED)

  if Joker.saved and Joker.saved.internal.firstLoad > 0 then
    runtime_maiden()
  end
end
EVENT_MANAGER:RegisterForEvent(Joker.name, EVENT_PLAYER_ACTIVATED, Joker.Activated) -- When player is ready, only after everything is loaded.


function Joker.OnAddOnLoaded(event, addonName)
  if addonName ~= Joker.name then return end
  EVENT_MANAGER:UnregisterForEvent(Joker.name, EVENT_ADD_ON_LOADED)

  -- Keybinds
  ZO_CreateStringId('SI_BINDING_NAME_JOKER_READYCHECK', 'Random Ready Check')

  -- Load Saved Variables
  Joker.saved = ZO_SavedVars:NewAccountWide('JokerSavedVars', 1, nil, Joker.defaults)

  -- Init our primary runtime (runs each load)
  runtime_onload()

end

EVENT_MANAGER:RegisterForEvent(Joker.name, EVENT_ADD_ON_LOADED, Joker.OnAddOnLoaded) -- Press Start.