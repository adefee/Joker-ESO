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
  * - Core & Default Values
  * - Utility
  * - Addon Instantiation
  *

]]--
JokerData = JokerData or {}
JokerL = JokerL or {}

--[[
  *****************************
  ** Core & Default Values
  PURPOSE: Setup Joker core, define default values.
  *****************************
]]
Joker = {
  name                      = "Joker",                                    -- Matches folder and Manifest file names.
  version                   = "3.0.0",                                    -- Joker internal versioning: Release.Major.Minor
  versionESO                = 300000,                                     -- ESO internal versioning: [Release*10][Major*10][Minor*10]
  forceNewVariables         = 2,                                          -- Incrementing forces a new variable set (so we lose our savedVars)
  author                    = "Lent (IGN @CallMeLent, Github @adefee)",   
  color                     = "D66E4A",                                   
  locale                    = JokerL:GetLanguage(),
  categories                = { -- Active categories
    "Burns", "Cat", "Dad", "Edgy", "ESO", "GameOfThrones", "HarryPotter", "LordOfTheRings", "Norris", "Pickup", "PickupXXX", "PickupHP", "PickupPokemon", "StarWars", "Twister", "Wisdom"
  },
  categoriesDeprecated      = { -- Deprecated categories no longer used
  },
  utility                   = {} -- Placeholder for utility functions
  data                      = {} -- Placeholder for data functions
}

local L = Joker.locale
local Util = Joker.utility
local Data = Joker.data
local jokeLengthMax = 325 -- Set max joke length. Max chatbox length is 350 chars. Set a little less so we can prepend prefixes if needed.


-- Joker.getDefaults()
-- Utility; Returns default values obj
function Joker.getDefaults()

  local defaultValues = {
    categories = {},
    lastUpdate = Joker.versionESO -- keep track of last update
    countJokes = 0, -- total count of loaded jokes
    countSeenJokes = 0, -- total count of seen jokes
    periodicJokes = true, -- Periodically show jokes to user in console (chat)
    periodicFrequency = 3, -- Number of zones between jokes
    periodSince = 0, -- Number of zones since joke last shown
    firstLoad = true,
    randomPoolDefault = 'Cat, Dad, ESO, GameOfThrones, Norris, Pokemon, StarWars, Twister, Wisdom' -- Set as string because ZOS does weird things with nested objects.
    randomPool = randomPoolDefault
  }

  local categoryTemplate = {
    count = 0, -- total number of jokes in this category
    seenCount = 0, -- number of jokes seen
    seenJokes = {} -- record of jokes seen
  }

  for i = 1, #Joker.categories do
    local categoryName = Joker.categories[i]
    defaultValues.categories[categoryName] = ZO_DeepTableCopy(categoryTemplate)
  end

  return defaultValues

end





--[[
  *****************************
  ** Utility Functions
  PURPOSE: These functions provide basic utility for frequent needs.
  *****************************
]]

-- isempty()
-- Utility; Checks if given string is empty/nil
function Util.isempty(s)
  return s == nil or s == ''
end

-- trim()
-- Utility; Trims extraneous whitespace from string
function Util.trim(s)
  return (s:gsub("^%s*(.-)%s*$", "%1"))
end

-- fromCSV()
-- Utility; Converts given comma-delimited list to table
function Util.fromCSV(s)
  s = s .. ','        -- ending comma
  local t = {}        -- table to collect fields
  local fieldstart = 1
  repeat
    -- next field is quoted? (start with `"'?)
    if string.find(s, '^"', fieldstart) then
      local a, c
      local i  = fieldstart
      repeat
        -- find closing quote
        a, i, c = string.find(s, '"("?)', i+1)
      until c ~= '"'    -- quote not followed by quote?
      if not i then error('unmatched "') end
      local f = string.sub(s, fieldstart+1, i-1)
      table.insert(t, (string.gsub(f, '""', '"')))
      fieldstart = string.find(s, ',', i) + 1
    else                -- unquoted; find next comma
      local nexti = string.find(s, ',', fieldstart)
      table.insert(t, string.sub(s, fieldstart, nexti-1))
      fieldstart = nexti + 1
    end
  until fieldstart > string.len(s)
  return t
end

-- toCSV()
-- Utility; Converts given table to comma-delimited list (via pairs)
function Util.toCSV(tt)
  local s = "";
  for k, v in pairs(tt) do
    v = Util.trim(v)
    if not Util.isempty(s) then
      s = s .. ", "
    end
    s = s .. v
  end
  return s
end

-- toCSVi()
-- Utility; Converts given table to comma-delimited list (via ipairs)
function Util.toCSVi(tt)
  local s = "";
  for k, v in ipairs(tt) do
    v = Joker.trim(v)
    if not Joker.isempty(s) then
      s = s .. ", "
    end
    s = s .. v
  end
  return s
end

-- addToSet()
-- Utility; Add given key to set with int 1
function Util.addToSet(set, key)
  set[key] = 1
end

-- setContains()
-- Utility; Determines if a set contains a key
function Util.setContains(set, key)
  return set[key] ~= nil
end

-- difference()
-- Utility; Returns table of differences between two given tables
function Util.difference(a, b)
  local aa = {}
  for k,v in pairs(a) do aa[v]=true end
  for k,v in pairs(b) do aa[v]=nil end
  local ret = {}
  local n = 0
  for k,v in pairs(a) do
      if aa[v] then n=n+1 ret[n]=v end
  end
  return ret
end

-- isSeen()
-- Utility; Determines if a specific joke has already been seen
function Util.isSeen(jokeCategory, jokeIndex)

  if setContains(Joker.savedVariables[jokeCategory].seenJokes, tonumber(jokeIndex)) then
    return true
  end

  return nil

end

-- addSeen()
-- Utility; Add a specific joke to corresponding seen
function Util.addSeen(jokeCategory, jokeIndex)

  addToSet(Joker.savedVariables[jokeCategory].seenJokes, tonumber(jokeIndex))

  Joker.savedVariables[jokeCategory].seenCount = Joker.savedVariables[jokeCategory].seenCount + 1
  Joker.savedVariables.countSeenJokes = Joker.savedVariables.countSeenJokes + 1
  return true

end

-- resetSeen()
-- Utility; Rests seen object & count for given jokeCategory
function Util.resetSeen(jokeCategory)
  -- d("Nice! You've seen everything in the ".. jokeCategory .. " category! We're always adding more content, but in the meantime - we've reset this category. You may see a few duplicates, but make sure to check every day for updates - new content is added almost daily!")
  Joker.savedVariables[jokeCategory].seenCount = 0
  Joker.savedVariables[jokeCategory].seenJokes = {}
  return true
end

-- formatNumber()
-- Utility; Returns US-formatted (comma thousands, period decimals) number
function Util.formatNumber(amount)
  return zo_strformat("<<1>>", ZO_LocalizeDecimalNumber(amount)
end

-- starts()
-- Utility; bool if string starts with string
function Util.starts(String,Start)
  return string.sub(String,1,string.len(Start))==Start
end

-- split()
-- Utility; split string based on given string & delimiter
function Util.split(inputstr, sep)
  if sep == nil then
    sep = "%s"
  end
  local t={}
  for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
    table.insert(t, str)
  end
  return t
end

-- Colorize()
-- Display; Wraps text with a color. Credit: @Phuein
function Util.colorize(text, color)
  -- Default to addon's .color.
  if not color then color = Joker.color end
  text = "|c" .. color .. text .. "|r"
  return text
end





--[[
  *****************************
  ** Joker Data Handlers
  PURPOSE: These functions just handle/process Joker data
  *****************************
]]

-- togglePeriodicJokes()
-- Data; Toggles whether or not jokes are periodically shown to the user in console (d()). Using string instead of bool so we can easily display status in addon settings.
function Data.togglePeriodicJokes(value)

  Joker.savedVariables.periodicJokes = value

  if not Joker.savedVariables.periodicJokes then
    d('Joker will no longer share jokes with you. He is very sad.')
  else
    d('Joker will periodically send jokes to you! Hurrah!')
  end
end

-- checkPeriodicDue()
-- Data; Determines if we're due for a periodic joke.
function Data.checkPeriodicDue()
  
  --[[
    periodSince saves number of zones/reloads since we last displayed a joke,
    with increasing chance to show a joke each load based on user's preferences.
  ]]

  local showJoke = false
  local frequency = Joker.savedVariables.periodicFrequency or 10

  if Joker.savedVariables.periodSince <= frequency then
    if Joker.savedVariables.periodSince < math.floor(frequency / 3) then
      if (math.random(0, 25) <= math.floor(frequency / 3)) then
        showJoke = true
      end
    elseif Joker.savedVariables.periodSince < math.floor(frequency / 2) then
      if (math.random(0, 25) <= math.floor(frequency / 2)) then
        showJoke = true
      end
    else
      if (math.random(0, 25) <= frequency) then
        showJoke = true
      end
    end
  else
    showJoke = true
  end


  if showJoke then
    Joker.savedVariables.periodSince = 0
    return true
  else
    Joker.savedVariables.periodSince = Joker.savedVariables.periodSince + 1
    return false
  end

end

-- setRandomPool()
-- Utility; Updates random pool with user settings, but checks to make sure values are allowed
function Data.setRandomPool(poolCSV)

  local newPool = {}
  local disallowed = ""

  local givenPool = Joker.fromCSV(poolCSV)
  for k, v in pairs(givenPool) do
    v = Joker.trim(v)
    if setContains(Joker.savedVariables.categories, v) and not Joker.isempty(v) and not setContains(newPool, v) then
      table.insert(newPool, v)
    else
      if not Joker.isempty(disallowed) then
        disallowed = disallowed .. ', '
      end
      disallowed = disallowed .. v
    end
  end

  d("New Random Pool:")
  d(newPool)
  newPool = Joker.toCSV(newPool)
  d('Converted to CSV: ' .. newPool)

  Joker.savedVariables.randomPool = newPool

  if not Joker.isempty(disallowed) then
    d('There was an issue with one or more of your changes to Joker\'s random pool. Any invalid options are omitted. Try checking near "' .. disallowed ..'", and make sure each option is separated by a comma. Items are case-sensitive!')
  else
    d('Joker\'s random pool has been updated! Don\'t forget that new categories and content are always being added - you might want to update this setting later to include new stuff!')
  end

end

-- getPrefix()
-- Data; Retrieve random prefix for customizing jokes (burn, pickups, etc)
function Data.getPrefix()
  return Joker.pickupPrefixes[(1 + math.floor((math.random() * #Joker.pickupPrefixes)))]
end

-- getJokeType()
-- Data; Returns corresponding JokerData key based on given category. Should be deprecated as of 3.0.0
function Data.getJokeKey(jokeCategory)
  -- Jokes Lists
  local jokes = JokerData.Dad -- default to Dad jokes

  -- jokeType Definitions
  if jokeType == 'Edgy' then
    jokes = JokerData.Edgy
  elseif jokeType == 'Wisdom' then
    jokes = JokerData.Wisdom
  elseif jokeType == 'Pokemon' then
    jokes = JokerData.Pokemon
  elseif jokeType == 'Pickup' then
    jokes = JokerData.PickupLines
  elseif jokeType == 'PickupXXX' then
    jokes = JokerData.PickupLinesXXX
  elseif jokeType == 'PickupHP' then
    jokes = JokerData.PickupLinesHP
  elseif jokeType == 'PickupPokemon' then
    jokes = JokerData.PickupLinesPokemon
  elseif jokeType == 'Norris' then
    jokes = JokerData.Norris
  elseif jokeType == 'ESO' then
    jokes = JokerData.ESO
  elseif jokeType == 'Burn' then
    jokes = JokerData.Burns
  elseif jokeType == 'Cat' then
    jokes = JokerData.CatFacts
  elseif jokeType == 'Ready' then
    jokes = JokerData.ReadyChecks
  elseif jokeType == 'Twister' then
    jokes = JokerData.TongueTwisters
  elseif jokeType == 'Riddle' then
    jokes = JokerData.Riddles
  elseif jokeType == 'GoT' then
    jokes = JokerData.GoT
  elseif jokeType == 'StarWars' then
    jokes = JokerData.StarWars
  end

  return jokes
end

-- getJoke()
-- Data; Returns random joke from given category, or all jokes from category if returnAll is passed
function Data.getJoke(jokeCategory, returnAll) {

  -- Defaults
  local jokeCategory = jokeCategory or "Dad" -- Set Dad as default category
  local jokes = JokerData[jokeCategory]
  local joke = ""
  local index = 0
  local loops = 0
  local loopLimit = Joker.savedVariables[jokeCategory].count

  -- If @param "all" was passed, return all jokes
  if returnAll then
    return jokes
  end

  -- Before we loop, see if we need to reset seenJokes for this type
  if Joker.savedVariables[jokeCategory].seenCount > 0 and Joker.savedVariables[jokeCategory].seenCount >= Joker.savedVariables[jokeCategory].count then
    Util.resetSeen(jokeCategory)
  end

  -- Loop until we find a joke we haven't yet seen. If we hit loopLimit, we'll just use what we have 
  repeat
    local random = math.random() * #jokes
    loops = loops + 1
    index = 1 + math.floor(random)
    joke = jokes[index]
  until (not Util.isSeen(jokeCategory, index) or loops >= loopLimit)

  -- Add to seenJokes so we don't pull again
  Util.addSeen(jokeCategory, index)

  -- Finally, return joke
  return joke

}





--[[
  *****************************
  ** Joker Display Handlers
  PURPOSE: These functions display Joker data.
  *****************************
]]

-- AnyJoke()
-- Display; Randomly chooses a type of joke, returns. Optionals and context passed along.
function Joker.AnyJoke(target)

  if (#Joker.savedVariables.randomPool < 1) then
    d('Setting random pool to default')
    -- Joker.savedVariables.randomPool = Joker.savedVariables.randomPoolDefault
  end

  local jokePool = Util.fromCSV(Joker.savedVariables.RandomPool)
  
  -- Sources for /joke random pool.
  -- Includes most, but not all, topics. Edgy/explicit should never be included
  local sourceIndex = Joker.trim(jokePool[math.random(#jokePool)])
  
  -- Grab appropriate joke.
  Joker[sourceIndex](target)

  -- Send
  StartChatInput(joke, CHAT_CHANNEL)
end

-- EightBall()
-- Display; Show a yes, no, neutral status. Optionals: <question>
function Joker.EightBall(question)
  local yesAnswers = {
    "Signs point to yes!",
    "The outlook is good!",
    "Don't count on it!",
    "Yes!",
    "It is certain.",
    "Without a doubt!",
    "Duh!",
    "Mhm.",
    "Fk yeah! ('Murica)",
    "It is decidedly so.",
  }

  local noAnswers = {
    "My sources say 'no'.",
    "As I see it, no.",
    "You aren't going to like this, but ... no.",
    "Very doubtful.",
    "What?!? No! Are you crazy?",
    "Awwwww, hell naw!",
    "Nah.",
    "Unlikely.",
  }

  local neutAnswers = {
    "I'm neutral, try again.",
    "I dunno.",
    "Ask later.",
    "Reply is a bit hazy, try again!",
    "Hmm, better not tell you now...",
    "Can't predict that right now, sorry. Try again.",
  }

  -- Decide how to answer
  local random = math.random(0, 2)
  local random2 = math.random() * #yesAnswers
  local index = 1 + math.floor(random2)
  local answer = yesAnswers[index]

  if random == 0 then
    answerType = "yes"
  elseif random == 1 then
    answerType = "no"
    random2 = math.random() * #noAnswers
    index = 1 + math.floor(random2)
    answer = noAnswers[index]
  elseif random == 2 then
    answerType = "neut"
    random2 = math.random() * #neutAnswers
    index = 1 + math.floor(random2)
    answer = neutAnswers[index]
  end
  local prefix = "8ball says: "

  -- Question provided, so repeat back before giving answer.
  if not Joker.isempty(question) and question.type == 'string' then
    d('You asked: "' .. question ..'" ...')
  end

  d(prefix .. answer)
end

-- Roll()
-- Display; Rolls between given floor, ceiling and includes memo (if provided). /roll floor,ceiling,memo
function Joker.Roll(context)
  local floor = 1
  local ceiling = 10
  local contextObj = Util.split(context, ' ')

  -- Determine floor & ceiling for roll
  if contextObj[2] and not Joker.isempty(contextObj[2]) then
    ceiling = contextObj[2]
    floor = contextObj[1]
  elseif not Joker.isempty(contextObj[1]) then
    ceiling = contextObj[1]
  end

  local random = math.random(floor, ceiling)

  -- If we include a memo, publish to chat; otherwise, publish to console
  if contextObj[3] then
    StartChatInput('Rolling (' .. floor .. ' - ' .. ceiling .. '):     ' .. random .. ' wins ' .. Joker.trim(contextObj[3]).. '!', CHAT_CHANNEL)
  else
    d('Joker: Rolling (' .. floor .. ' - ' .. ceiling .. '): ' .. Joker.Colorize(random .. ' Wins!'))
  end

end

-- Choose()
-- Display; Choose between any number of items/users (space delimited)
function Joker.Choose(context)
  local choices = {}
  local itemsWon = {}

  choices = Joker.split(context, " ")
  for thisChoiceIndex, thisChoiceContent in ipairs(choices) do
    if string.starts(thisChoiceContent, '|H') or string.starts(thisChoiceContent, '|h') then
      table.insert(itemsWon, thisChoiceContent)
      -- Deleting here would upset the table index and the loop (Lua shifts down instead of temp maintaining), so need to delete in separate loop
      -- Could alternatively keep track of items to remove, but copy/paste is easier ;P
    end
  end

  -- Running a separate loop for deletion, see above comment
  for thisChoiceIndex, thisChoiceContent in pairs(choices) do
    if string.starts(thisChoiceContent, '|H') or string.starts(thisChoiceContent, '|h') then
      table.remove(choices, thisChoiceIndex)
    end
  end

  if string.starts(context, 'party') or context == 'party' then
    local partySize = GetGroupSize()
    local partyMembers = {}
    local partyCount = 0

    repeat
      if (partyCount > 0) then
        table.insert(partyMembers, GetUnitName("group" .. partyCount))
      end
      partyCount = partyCount + 1
    until( partyCount > partySize )

    if (partySize > 0) then
      local random = Joker.trim(partyMembers[math.random(#partyMembers)])
      local partyContext = context:gsub("party ", "", 1)

      if partyContext then
        StartChatInput('Choosing from ' .. partySize .. ' party members ... and ' .. random .. ' wins ' .. Joker.trim(partyContext) .. '! Congrats!', CHAT_CHANNEL)
      else
        StartChatInput('Choosing from ' .. partySize .. ' party members ... and ' .. random .. ' wins! Congrats!', CHAT_CHANNEL)
      end
    else
      d('Joker: There\'s noone in your party, so can\'t choose from your party!')
    end

  elseif string.starts(context, 'guild') or context == 'guild' then
    d('Support for choosing among both online & offline guild members will be coming soon!')
  elseif #choices > 1 then
    local random = Joker.trim(choices[math.random(#choices)])
    if #itemsWon > 0 then
      local itemsWonString = table.concat(itemsWon, ", ")
      StartChatInput('Choosing from ' .. #choices .. ' options ... and ' .. random .. ' wins ' .. itemsWonString .. '! Congrats!', CHAT_CHANNEL) 
    else
      StartChatInput('Choosing from ' .. #choices .. ' options ... and ' .. random .. ' wins! Congrats!', CHAT_CHANNEL) 
    end
       
  else
    d('Joker chose ... you! Try adding some other options for Joker to choose from!')
  end


end

-- ReadyCheck()
-- Display; Randomly choose a ready-check message, then trigger ready check. Optionals: <target: any prompt>
function Joker.ReadyCheck(target)

  --[[
    checkType:
    0: SimpleMajority [51%],
    1: SuperMajority [67%],
    2: Unanimous [100%],
  ]]
  local checkType = 2
  local explicitCheckType = false
  local checkPrompts = JokerData.ReadyChecks
  local checkPrompt = "Are you ready?"


  if not Joker.isempty(target) and target.type == 'string' then
    -- Custom ready check prompt.

    -- Check for explicit election type
    if string.starts(target, 'unan ') then
      checkType = 2
      checkPrompt = target:gsub('unan ', '')
    elseif string.starts(target, 'simple ') then
      checkType = 0
      checkPrompt = target:gsub('simple ', '')
    elseif string.starts(target, 'super ') then
      checkType = 1
      checkPrompt = target:gsub('super ', '')
    else
      checkType = 2
      checkPrompt = target
    end

  else
    -- Choose random prompt
    repeat
      checkPrompt = Joker.GetJoke('Ready')
      local promptLength = string.len(checkPrompt)
    until (promptLength < 350)
  
    -- First-Usage: Display intro message
    if Joker.savedVariables.FirstJokes.Ready then
      Joker.savedVariables.FirstJokes.Ready = false
    end
    
  end

  d('Ready checking with: ' .. checkPrompt)
  BeginGroupElection(checkType, checkPrompt)

end



--[[
  *****************************
  ** Addon Instantiation
  *****************************
]]

-- Only show the loading message on first load ever. Displays a random message
function Joker.Activated(e)
  EVENT_MANAGER:UnregisterForEvent(Joker.name, EVENT_PLAYER_ACTIVATED)

  if Joker.savedVariables.FirstLoad then
      Joker.savedVariables.FirstLoad = false
  end
end

-- When player is ready, after everything has been loaded.
EVENT_MANAGER:RegisterForEvent(Joker.name, EVENT_PLAYER_ACTIVATED, Joker.Activated)

function Joker.OnAddOnLoaded(event, addonName)
  if addonName ~= Joker.name then return end
  EVENT_MANAGER:UnregisterForEvent(Joker.name, EVENT_ADD_ON_LOADED)

  -- Keybinds
  ZO_CreateStringId('SI_BINDING_NAME_JOKER_READYCHECK', 'Random Ready Check')
  

  -- Setup vars
  Joker.savedVariables = ZO_SavedVars:NewAccountWide("JokerSavedVariables", Joker.variableWipeIncrement, nil, Joker.getDefaults())
  

  --[[
    Iterate over all jokes and get total counts of both jokes and seenJokes
  ]]
  local allJokes = {}
  for i = 1, #Joker.categories do
    local categoryName = Joker.categories[i]
    allJokes[categoryName] = Joker.GetJoke(categoryName, true)
  end

  -- Iterate over jokes
  Joker.savedVariables.countJokes = 0 -- reset count
  for jokeType, thisJokes in pairs(allJokes) do
    -- Reset count
    Joker.savedVariables[jokeType].Count = 0
    -- Iterate over this type's jokes and count
    for thisJokeIndex, thisJokeText in pairs(thisJokes) do
      Joker.savedVariables[jokeType].Count = Joker.savedVariables[jokeType].Count + 1
      Joker.savedVariables.countJokes = Joker.savedVariables.countJokes + 1
    end
    d(jokeType .. ': loaded ' .. Joker.savedVariables[jokeType].Count .. ' jokes.') -- load debugging
  end

  -- Iterate over seenJokes
  Joker.savedVariables.countSeenJokes = 0 -- reset count
  for jokeType, thisJokes in pairs(allJokes) do
    -- Reset count
    Joker.savedVariables[jokeType].Seen = 0
    -- Iterate over this type's seenJokes and count
    for thisJokeIndex, thisJokeText in pairs(Joker.savedVariables.SeenJokes[jokeType]) do
      Joker.savedVariables[jokeType].Seen = Joker.savedVariables[jokeType].Seen + 1
      Joker.savedVariables.countSeenJokes = Joker.savedVariables.countSeenJokes + 1
    end
  end

  -- Legacy: Update Periodic Jokes
  if (Joker.savedVariables.PeriodicJokes == 'Enabled') then
    Joker.savedVariables.PeriodicJokes = true
  elseif (Joker.savedVariables.PeriodicJokes == 'Disabled') then
    Joker.savedVariables.PeriodicJokes = false
  end

  -- Settings menu in Settings.lua.
  Joker.LoadSettings()

  -- NOTE: Slash commands must be lowercase!
  SLASH_COMMANDS["/joke"] = Joker.AnyJoke -- By default, does not include edgy or pickup lines!
  SLASH_COMMANDS["/joke-norris"] = Joker.Norris
  SLASH_COMMANDS["/joke-eso"] = Joker.ESO
  SLASH_COMMANDS["/joke-dad"] = Joker.Dad
  SLASH_COMMANDS["/joke-edgy"] = Joker.Edgy
  SLASH_COMMANDS["/joke-wisdom"] = Joker.Wisdom
  SLASH_COMMANDS["/joke-pickup"] = Joker.Pickup
  SLASH_COMMANDS["/joke-twister"] = Joker.Twister
  SLASH_COMMANDS["/joke-burn"] = Joker.Burn
  SLASH_COMMANDS["/joke-got"] = Joker.GoT
  SLASH_COMMANDS["/joke-pokemon"] = Joker.Pokemon
  SLASH_COMMANDS["/joke-starwars"] = Joker.StarWars
  -- Other joke command aliases:
  SLASH_COMMANDS["/wisdom"] = Joker.Wisdom
  SLASH_COMMANDS["/dad"] = Joker.Dad
  SLASH_COMMANDS["/norris"] = Joker.Norris
  SLASH_COMMANDS["/8ball"] = Joker.eightBall
  SLASH_COMMANDS["/catfact"] = Joker.Cat
  SLASH_COMMANDS["/pickup"] = Joker.Pickup
  SLASH_COMMANDS["/pickup-xxx"] = Joker.PickupXXX
  SLASH_COMMANDS["/pickup-hp"] = Joker.PickupHP
  SLASH_COMMANDS["/pickup-poke"] = Joker.PickupPokemon
  SLASH_COMMANDS["/twister"] = Joker.Twister
  SLASH_COMMANDS["/burn"] = Joker.Burn
  SLASH_COMMANDS["/starwars"] = Joker.StarWars
  SLASH_COMMANDS["/pokemon"] = Joker.Pokemon
  -- Other fun commands:
  SLASH_COMMANDS["/ready"] = Joker.ReadyCheck
  SLASH_COMMANDS["/roll"] = Joker.Roll
  SLASH_COMMANDS["/choose"] = Joker.Choose
  -- Other misc & utility commands:
  SLASH_COMMANDS["/rl"] = function() ReloadUI("ingame") end

  -- Reset autocomplete cache to update it.
  SLASH_COMMAND_AUTO_COMPLETE:InvalidateSlashCommandCache()

  -- If the user hasn't disabled periodic jokes in console, show it.
  -- TODO: Allow user to disable, or change frequency (time-based or # of addon loads in between)
  if Joker.savedVariables.PeriodicJokes and Joker.checkPeriodicDue() then
    zo_callLater(Joker.AnyJokeToLog, 3000)
  end
end

-- When any addon is loaded, but before UI (Chat) is loaded.
EVENT_MANAGER:RegisterForEvent(Joker.name, EVENT_ADD_ON_LOADED, Joker.OnAddOnLoaded)
