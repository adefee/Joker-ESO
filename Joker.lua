-- * _JOKER_VERSION: 0.0.1 ** Please do not modify this line.
--[[----------------------------------------------------------
	Joker - Jokes, Riddles, Fun Facts, & Other Tomfoolery
  ----------------------------------------------------------
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
  * - Utility (imported from Joker-Util.lua via Joker.txt)
  * - Data Ops (imported from Joker-Data.lua via Joker.txt)
  * - Core & Default Values
  * - Addon Instantiation
  *
]]--


--[[----------------------------------------------------------
  Core & Default Values
  - Import data, set any additional defaults or overwrites, etc
  ----------------------------------------------------------
]]--

-- Handle includes
JokerData = JokerData or {} -- content
JokerData.Config = JokerData.Config or {} -- content-specific config (commands, etc)
JokerL = JokerL or {} -- i18n
Joker = Joker or {} -- vars, defaults

local L = Joker.locale -- sets our locale
local Util = JokerUtilityFn or {} -- utility functions used throughout
local Data = JokerDataFn or {} -- data and content processing & display



-- Joker.Joke()
-- Display; Retrieve and display a joke (either in chatbox or in console). We aren't allowed to send on user's behalf.
function Joker.Joke(category, context, logToConsole)
  local joke = Data.GetJoke(category, context)
  
  if joke and not Util.isEmpty(joke) then
    if logToConsole or Joker.saved.enable.consoleOnly then
      d(joke)
    else
      StartChatInput(joke, CHAT_CHANNEL)
    end
  end  
end


function Joker.ReadyCheck()
  d('ready check')
end



--[[----------------------------------------------------------
  Addon Instantiation
  - Initialize any runtimes & ESO hooks

  CONTENTS:
  - runtime_maiden()
  - runtime_onload()
  - Joker.Activated()
  - EVENT: event_player_activated
  - Joker.OnAddOnLoaded
  - EVENT: event_add_on_loaded
  ----------------------------------------------------------
]]--



-- Runs only the first time load
local function runtime_maiden()
  d('Joker ' .. Joker.version .. ' is now active! Type /joker at any time to view and customize Joker commands & settings.')
  Joker.saved.internal.firstLoad = 0
end


-- Runs each load
local function runtime_onload()
  d('Joker (' .. Joker.version .. ') loaded.')

  -- Iterate over jokes and enable as we need
  local loadedJokes = {}
  local countAllJokes = 0
  for i,v in pairs(JokerData) do
    if i == 'Config' then
      -- Metadata entries, ignore
    else
      if Util.setContains(JokerData.Config, i) and JokerData.Config[i].label and JokerData.Config[i].command then
        if JokerData.Config[i].joke then
          -- Enable /joke-x slash command for this category
          SLASH_COMMANDS["/joke-" .. JokerData.Config[i].command] = function (context) Joker.Joke(i, context) end

          -- Load & count all the jokes for this category
          local categoryJokeCount = Util.countSet(JokerData[i])
          countAllJokes = countAllJokes + categoryJokeCount
          Joker.saved.count.categories[i] = categoryJokeCount

          -- Optionally add an additional command for that joke (e.g. /dad instead of just /joke-dad)
          if JokerData.Config[i].whitelistSlashCommand then
            SLASH_COMMANDS["/" .. JokerData.Config[i].command] = function (context) Joker.Joke(i, context) end
          end
        end
      end
    end
  end

  -- Update savedVars
  Joker.saved.count.loaded = countAllJokes



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

  -- Settings menu in Settings.lua.
  Joker.LoadSettings()

end

EVENT_MANAGER:RegisterForEvent(Joker.name, EVENT_ADD_ON_LOADED, Joker.OnAddOnLoaded) -- Press Start.