-- * _JOKER_VERSION: 8.0.0 ** Please do not modify this line.
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

--[[----------------------------------------------------------
  Constants
  ----------------------------------------------------------
]]--
local ENABLED = 1
local DISABLED = 0
local SAVED_VARS_VERSION = 2
local VERSION_4_2_0 = 402000
local VERSION_4_3_0 = 403000

--[[----------------------------------------------------------
  Helper Functions
  ----------------------------------------------------------
]]--

-- debugLog()
-- Helper; Outputs debug message to console if debug mode is enabled
local function debugLog(message)
  if Joker.saved.internal.showDebug > DISABLED then
    d('Joker: ' .. message)
  end
end

-- Joker.ToggleDebug()
function Joker.ToggleDebug()
  if Joker.saved.internal.showDebug > DISABLED then
    d('Disabling Joker debug mode.')
    Joker.saved.internal.showDebug = DISABLED
  else
    d('Enabling Joker debug mode.')
    Joker.saved.internal.showDebug = ENABLED
  end
end

-- Joker.OutputJoke()
-- Display; Output a joke to either console or chat based on settings
local function OutputJoke(joke, logToConsole)
  if joke and not Util.isEmpty(joke) then
    if logToConsole or Joker.saved.enable.consoleOnly then
      d(joke)
    else
      StartChatInput(joke, CHAT_CHANNEL)
    end
  end
end

-- Joker.Joke()
-- Display; Retrieve and display a joke (either in chatbox or in console). We aren't allowed to send on user's behalf.
function Joker.Joke(category, context, logToConsole)
  local joke = Data.GetJoke(category, context)
  OutputJoke(joke, logToConsole)
end

-- Joker.AnyJoke()
-- Display; Retrieve and display a random joke based on context
function Joker.AnyJoke(context, logToConsole)
  local joke = Data.GetRandomJoke(context)
  OutputJoke(joke, logToConsole)
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
-- Specifically snake_case because it's a runtime function
local function runtime_maiden()
  d('Joker ' .. Joker.version .. ' is now active! Type /joker at any time to view and customize Joker commands & settings.')
  Joker.saved.internal.firstLoad = DISABLED
end

--[[----------------------------------------------------------
  Version Migration Functions
  ----------------------------------------------------------
]]--

-- migrate_to_4_2_0()
-- Migration; Update 4.2.0 added curses, needs to not be default
local function migrate_to_4_2_0()
  debugLog('Housekeeping for update to version 4.2.0')
  table.insert(Joker.saved.randomPool.blacklist, 'Curse')
  Util.sortSet(Joker.saved.randomPool.blacklist)
  Joker.saved.internal.lastUpdate = VERSION_4_2_0
end

-- migrate_to_4_3_0()
-- Migration; Update 4.3.0 updates settings to toggle rolls being posted to chat, adds new savedVar option
local function migrate_to_4_3_0()
  debugLog('Housekeeping for update to version 4.3.0')
  Joker.saved.rolls.postToChat = DISABLED
  Joker.saved.internal.lastUpdate = VERSION_4_3_0
end

-- Run any updates needed if addon has been updated
local function runtime_updates()
  if Joker.saved.internal.lastUpdate < Joker.versionESO then
    local oldVersion = Joker.saved.internal.lastUpdate
    
    -- Run migrations in order
    if oldVersion < VERSION_4_2_0 then
      migrate_to_4_2_0()
    end

    if oldVersion < VERSION_4_3_0 then
      migrate_to_4_3_0()
    end
  end
end

-- registerJokeCommand()
-- Helper; Register slash commands for a joke category
local function registerJokeCommand(category, config)
  -- Register primary command: /joke-<command>
  SLASH_COMMANDS["/joke-" .. config.command] = function(context) 
    Joker.Joke(category, context) 
  end
  
  -- Optionally register shorthand command: /<command>
  if config.whitelistSlashCommand then
    SLASH_COMMANDS["/" .. config.command] = function(context) 
      Joker.Joke(category, context) 
    end
  end
end

-- loadJokeCategories()
-- Helper; Load and register all joke categories, returns total joke count
local function loadJokeCategories()
  local countAllJokes = 0
  Joker.saved.randomPool.enabled = {}
  
  for i,v in pairs(JokerData) do
    if i == 'Config' then
      -- Metadata entries, ignore
    else
      if Util.setContains(JokerData.Config, i) and JokerData.Config[i].label and JokerData.Config[i].command then
        if not JokerData.Config[i].disable then
          -- Load & count all the jokes for this category
          local categoryJokeCount = Util.countSet(JokerData[i])
          countAllJokes = countAllJokes + categoryJokeCount
          Joker.saved.count.categories[i] = categoryJokeCount
          Joker.saved.activeJokes = Joker.saved.activeJokes or {}
          Joker.saved.activeJokes[i] = JokerData.Config[i].label

          -- If there are jokes (> 0), enable:
          if categoryJokeCount > 0 then

            -- Add joke to list of enabled
            table.insert(Joker.saved.randomPool.enabled, i);

            -- Register slash commands for this category
            registerJokeCommand(i, JokerData.Config[i])
          else
            d('Joker: The category "' .. i .. '" was enabled but contains no jokes. It has not been loaded (uhhh ... there\'s nothing to load!).')
          end
        else
          debugLog('The category "' .. i .. '" is available, but is disabled. It has not been loaded.')
        end
      end
    end
  end
  
  return countAllJokes
end

-- Runs each load
-- Specifically snake_case because it's a runtime function
local function runtime_onload()

  -- Tell the user if debug mode is enabled, which may result in lots of chat spam.
  if Joker.saved.internal.showDebug > DISABLED then
    d('Joker: debug mode enabled. Run /_joker-debug to toggle off.')
  end

  runtime_updates()

  -- Load and register all joke categories
  local countAllJokes = loadJokeCategories()

  -- Update savedVars
  Joker.saved.count.loaded = countAllJokes


  --[[
    Periodic Events
    > Jokes
    > Mental Health / Excercise Reminders
  ]]
  Data.runPeriodicEvents('joke', {
    joke = function() Joker.AnyJoke('', 1) end
  })


  --[[
    Additional Slash Commands
  ]]

  SLASH_COMMANDS["/joke"] = Joker.AnyJoke -- Add cmd: random joke
  SLASH_COMMANDS["/8ball"] = Data.eightBall -- Add cmd: 8ball
  SLASH_COMMANDS["/ready"] = Data.readyCheck -- Add cmd: ready checks
  SLASH_COMMANDS["/choose"] = Data.choose -- Add cmd: choose
  SLASH_COMMANDS["/roll"] = Data.roll -- Add cmd: roll

  -- Add cmd: attribution
  -- SLASH_COMMANDS["/joker-guild"] = function (context) 
  --   d(L.Joker_Guild_A .. Joker.attribution.guildNameLink .. L.Joker_Guild_B .. Joker.attribution.guildDiscord .. L.Joker_Guild_C)
  -- end
  SLASH_COMMANDS["/joker-author"] = function (context) 
    d(L.Joker_Author_A .. Joker.attribution.authorIGN .. L.Joker_Author_B .. Joker.attribution.authorDiscord .. ' :)')
  end

  -- Add cmd: debug & misc utilities
  SLASH_COMMANDS["/_joker-debug"] = function () Joker.ToggleDebug() end
  SLASH_COMMANDS["/rl"] = function() ReloadUI("ingame") end

end


--[[
  *****************************
  ** Addon Instantiation, Hook to Ingame Events
  *****************************
]]

-- Only show the loading message on first load ever. Displays a random message
function Joker.Activated(e)
  EVENT_MANAGER:UnregisterForEvent(Joker.name, EVENT_PLAYER_ACTIVATED)

  if Joker.saved then
    if Joker.saved.internal.firstLoad > DISABLED then
      runtime_maiden()
    end

    runtime_updates()
  end
end
EVENT_MANAGER:RegisterForEvent(Joker.name, EVENT_PLAYER_ACTIVATED, Joker.Activated) -- When player is ready, only after everything is loaded.


function Joker.OnAddOnLoaded(event, addonName)
  if addonName ~= Joker.name then return end
  EVENT_MANAGER:UnregisterForEvent(Joker.name, EVENT_ADD_ON_LOADED)

  -- Keybinds
  ZO_CreateStringId('SI_BINDING_NAME_JOKER_READYCHECK', L.Joker_Quick_Btn_JokeReady_Label)

  -- Load Saved Variables
  Joker.saved = ZO_SavedVars:NewAccountWide('JokerSavedVars', SAVED_VARS_VERSION, nil, Joker.defaults)

  -- Init our primary runtime (runs each load)
  runtime_onload()

  -- Settings menu in Settings.lua.
  Joker.LoadSettings()

end

EVENT_MANAGER:RegisterForEvent(Joker.name, EVENT_ADD_ON_LOADED, Joker.OnAddOnLoaded) -- Press Start.
