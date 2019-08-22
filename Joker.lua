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
  categories                = { -- Shipped categories
    "Burns", "Cat", "Dad", "Edgy", "ESO", "GameOfThrones", "HarryPotter", "LordOfTheRings", "Norris", "PickupLines", "PickupLinesXXX", "PickupLinesHP", "PickupLinesPokemon", "Pokemon", "ReadyChecks", "StarWars", "Twisters", "Wisdom"
  },
  categoriesDeprecated      = { -- Deprecated categories no longer used
  },
  pickupPrefixes                  = {
    "Hey, jTarget, ",
    "Yo, jTarget, ",
    "jTarget, ",
    "jTarget! "
  },
  utility                   = {}, -- Placeholder for utility functions
  data                      = {}, -- Placeholder for data functions
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
    lastUpdate = Joker.versionESO, -- keep track of last update
    countJokes = 0, -- total count of loaded jokes
    countSeenJokes = 0, -- total count of seen jokes
    periodicJokes = true, -- Periodically show jokes to user in console (chat)
    periodicFrequency = 1, -- Number of zones between jokes
    periodSince = 0, -- Number of zones since joke last shown
    firstLoad = true,
    randomPoolAvailable = Util.toCSV(Joker.categories),
    randomPoolDefault = 'Cat, Dad, ESO, GameOfThrones, Norris, Pokemon, StarWars, Twisters, Wisdom', -- Set as string because ZOS does weird things with nested objects.
    randomPool = '',
  }

  if Joker.savedVariables then
    if Util.isEmpty(Joker.savedVariables.randomPool) then defaultValues.randomPool = defaultValues.randomPoolDefault end
  else
    defaultValues.randomPool = defaultValues.randomPoolDefault
  end

  local categoryTemplate = {
    count = 0, -- total number of jokes in this category
    seenCount = 0, -- number of jokes seen
    seenJokes = {}, -- record of jokes seen
    usePrefix = false, -- whether or this joke might use a prefix
    firstLoad = true,
    ignoreContext = false, -- whether or not this joke always ignores any given context
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

-- isEmpty()
-- Utility; Checks if given string is empty/nil
function Util.isEmpty(s)
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
    if not Util.isEmpty(s) then
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
    v = Util.trim(v)
    if not Util.isEmpty(s) then
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

-- Util.setContains()
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

  if Util.setContains(Joker.savedVariables.categories[jokeCategory].seenJokes, tonumber(jokeIndex)) then
    return true
  end

  return nil

end

-- addSeen()
-- Utility; Add a specific joke to corresponding seen
function Util.addSeen(jokeCategory, jokeIndex)

  Util.addToSet(Joker.savedVariables.categories[jokeCategory].seenJokes, tonumber(jokeIndex))

  Joker.savedVariables.categories[jokeCategory].seenCount = Joker.savedVariables.categories[jokeCategory].seenCount + 1
  Joker.savedVariables.countSeenJokes = Joker.savedVariables.countSeenJokes + 1
  return true

end

-- resetSeen()
-- Utility; Rests seen object & count for given jokeCategory
function Util.resetSeen(jokeCategory)
  -- d("Nice! You've seen everything in the ".. jokeCategory .. " category! We're always adding more content, but in the meantime - we've reset this category. You may see a few duplicates, but make sure to check every day for updates - new content is added almost daily!")
  Joker.savedVariables.categories[jokeCategory].seenCount = 0
  Joker.savedVariables.categories[jokeCategory].seenJokes = {}
  return true
end

-- formatNumber()
-- Utility; Returns US-formatted (comma thousands, period decimals) number
function Util.formatNumber(amount)
  return zo_strformat("<<1>>", ZO_LocalizeDecimalNumber(amount))
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

-- colorize()
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

  if Joker.savedVariables.periodSince < frequency then
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

function Data.getRandomPool()
  
  if Joker.savedVariables then
    if Util.isEmpty(Joker.savedVariables.randomPool) then Joker.savedVariables.randomPool = Joker.savedVariables.randomPoolDefault end
  else
    Joker.savedVariables.randomPool = Joker.savedVariables.randomPoolDefault
  end

  return Joker.savedVariables.randomPool

end

-- setRandomPool()
-- Utility; Updates random pool with user settings, but checks to make sure values are allowed
function Data.setRandomPool(poolCSV)

  local newPool = {}
  local disallowed = ""

  local givenPool = Util.fromCSV(poolCSV)
  for k, v in pairs(givenPool) do
    v = Util.trim(v)
    if Util.setContains(Joker.savedVariables.categories, v) and not Util.isEmpty(v) and not Util.setContains(newPool, v) then
      table.insert(newPool, v)
    else
      if not Util.isEmpty(disallowed) then
        disallowed = disallowed .. ', '
      end
      disallowed = disallowed .. v
    end
  end

  Joker.savedVariables.randomPool = Util.toCSV(newPool)

  if not Util.isEmpty(disallowed) and not Util.isEmpty(Joker.savedVariables.randomPool) then
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
  elseif jokeType == 'PickupLines' then
    jokes = JokerData.PickupLines
  elseif jokeType == 'PickupLinesXXX' then
    jokes = JokerData.PickupLinesXXX
  elseif jokeType == 'PickupLinesHP' then
    jokes = JokerData.PickupLinesHP
  elseif jokeType == 'PickupLinesPokemon' then
    jokes = JokerData.PickupLinesPokemon
  elseif jokeType == 'Norris' then
    jokes = JokerData.Norris
  elseif jokeType == 'ESO' then
    jokes = JokerData.ESO
  elseif jokeType == 'Burn' then
    jokes = JokerData.Burns
  elseif jokeType == 'Cat' then
    jokes = JokerData.CatFacts
  elseif jokeType == 'ReadyChecks' then
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
function Data.getJoke(jokeCategory, returnAll) 

  -- Defaults
  local jokeCategory = jokeCategory or "Dad" -- Set Dad as default category
  local jokes = JokerData[jokeCategory]
  local joke = ""
  local index = 0
  local loops = 0
  local loopLimit = 1500

  -- If @param "all" was passed, return all jokes
  if returnAll then
    return jokes
  end

  -- Before we loop, see if we need to reset seenJokes for this type
  if Joker.savedVariables.categories[jokeCategory].seenCount > 0 and Joker.savedVariables.categories[jokeCategory].seenCount >= Joker.savedVariables.categories[jokeCategory].count then
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

end






--[[
  *****************************
  ** Joker Display Handlers
  PURPOSE: These functions display Joker data.
  *****************************
]]

-- Joke()
-- Display; Doctor up any retrieved joke as needed, based on context
function Joker.Joke(jokeCategory, context, returnOnly)

  local joke = Data.getJoke(jokeCategory)

  -- See if we should apply a prefix or suffix
  -- if Joker.savedVariables.categories[jokeCategory].usePrefix then
  --   joke = Data.getPrefix() .. joke
  -- end

  -- If adding context
  if not Util.isEmpty(context) and not Joker.savedVariables.categories[jokeCategory].ignoreContext and type(context) == "string" then
    joke = string.gsub(Data.getPrefix(), "jTarget", context) .. joke:sub(1,1):lower() .. joke:sub(2)
  end

  if (returnOnly) then
    return joke
  end

  -- Send to active chatbox
  StartChatInput(joke, CHAT_CHANNEL)

end

-- AnyJoke()
-- Display; Randomly chooses a type of joke, returns. Optionals and context passed along.
function Joker.AnyJoke(context, console)

  local jokePool = Util.fromCSV(Joker.savedVariables.randomPool)

  if (#jokePool < 1) then
    d('Setting random pool to default')
    Joker.savedVariables.randomPool = Joker.savedVariables.randomPoolDefault
  end
  
  -- Sources for /joke random pool.
  -- Includes most, but not all, topics. Edgy/explicit should never be included
  local jokeCategory = Util.trim(jokePool[math.random(#jokePool)])

  -- Grab joke based on chosen category and context
  local joke = Joker.Joke(jokeCategory, context)

  if console then
    -- Log to console instead of chat
    d('Joker: ' .. joke)
  else
    -- Send to active chatbox
    StartChatInput(joke, CHAT_CHANNEL)
  end
  
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
  if not Util.isEmpty(question) and question.type == 'string' then
    d('You asked: "' .. question ..'" ...')
  end

  d(prefix .. answer)
end

-- Roll()
-- Display; Rolls between given floor, ceiling and includes memo (if provided). Space delimited: /roll floor ceiling memo
function Joker.Roll(context)
  local floor = 1
  local ceiling = 10
  local contextObj = Util.split(context, ' ')
  local memo = ''

  -- Determine floor & ceiling for roll
  if contextObj[2] and not Util.isEmpty(contextObj[2]) then
    ceiling = contextObj[2]
    floor = contextObj[1]
  elseif not Util.isEmpty(contextObj[1]) then
    ceiling = contextObj[1]
  end

  local random = math.random(floor, ceiling)

  -- Determine if memo is provided (for now, must include explicit floor and ceiling)
  if contextObj[3] and not Util.isEmpty(Util.trim(contextObj[3])) then
    memo = string.gsub(context, contextObj[1], '')
    memo = string.gsub(memo, contextObj[2], '')
    memo = '(Memo: ' .. Util.trim(memo) .. ')'
  end

  -- If we include a memo, publish to chat; otherwise, publish to console
  if contextObj[3] then
    StartChatInput('Rolling a ' .. (ceiling - floor) + 1 .. '-sided die (from ' .. floor .. ' through ' .. ceiling .. ') ... and ' .. random .. ' is rolled! ' .. memo, CHAT_CHANNEL)
  else
    d('Joker: Rolling a ' .. (ceiling - floor) + 1 .. '-sided die (from ' .. floor .. ' through ' .. ceiling .. ') ... and ' .. Util.colorize(random) .. ' is rolled! ' .. Util.colorize(memo))
  end

end

-- Choose()
-- Display; Choose between any number of items/users (space delimited)
function Joker.Choose(context)
  local choices = {}
  local itemsWon = {}

  choices = Util.split(context, " ")
  for thisChoiceIndex, thisChoiceContent in ipairs(choices) do
    if Util.starts(thisChoiceContent, '|H') or Util.starts(thisChoiceContent, '|h') then
      table.insert(itemsWon, thisChoiceContent)
      -- Deleting here would upset the table index and the loop (Lua shifts down instead of temp maintaining), so need to delete in separate loop
      -- Could alternatively keep track of items to remove, but copy/paste is easier ;P
    end
  end

  -- Running a separate loop for deletion, see above comment
  for thisChoiceIndex, thisChoiceContent in pairs(choices) do
    if Util.starts(thisChoiceContent, '|H') or Util.starts(thisChoiceContent, '|h') then
      table.remove(choices, thisChoiceIndex)
    end
  end

  if Util.starts(context, 'party') or context == 'party' then
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
      local random = Util.trim(partyMembers[math.random(#partyMembers)])
      local partyContext = context:gsub("party ", "", 1)

      if partyContext then
        StartChatInput('Choosing from ' .. partySize .. ' party members ... and ' .. random .. ' wins ' .. Util.trim(partyContext) .. '! Congrats!', CHAT_CHANNEL)
      else
        StartChatInput('Choosing from ' .. partySize .. ' party members ... and ' .. random .. ' wins! Congrats!', CHAT_CHANNEL)
      end
    else
      d('Joker: There\'s noone in your party, so can\'t choose from your party!')
    end

  elseif Util.starts(context, 'guild') or context == 'guild' then
    d('Support for choosing among both online & offline guild members will be coming soon!')
  elseif #choices > 1 then
    local random = Util.trim(choices[math.random(#choices)])
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


  if not Util.isEmpty(target) then
    -- Custom ready check prompt.

    -- Check for explicit election type
    if Util.starts(target, 'unan ') then
      checkType = 2
      checkPrompt = target:gsub('unan ', '')
    elseif Util.starts(target, 'simple ') then
      checkType = 0
      checkPrompt = target:gsub('simple ', '')
    elseif Util.starts(target, 'super ') then
      checkType = 1
      checkPrompt = target:gsub('super ', '')
    else
      checkType = 2
      checkPrompt = target
    end

  else
    -- Choose random prompt
    repeat
      checkPrompt = Joker.Joke('ReadyChecks', '', 1)
      local promptLength = string.len(checkPrompt)
    until (promptLength < 350)
  
    -- First-Usage: Display intro message
    if Joker.savedVariables.categories['ReadyChecks'].firstLoad then
      Joker.savedVariables.categories['ReadyChecks'].firstLoad = false
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
    allJokes[categoryName] = Data.getJoke(categoryName, true)
  end

  -- Iterate over jokes
  Joker.savedVariables.countJokes = 0 -- reset count
  for jokeType, thisJokes in pairs(allJokes) do
    -- Reset count
    Joker.savedVariables.categories[jokeType].count = 0
    -- Iterate over this type's jokes and count
    for thisJokeIndex, thisJokeText in pairs(thisJokes) do
      Joker.savedVariables.categories[jokeType].count = Joker.savedVariables.categories[jokeType].count + 1
      Joker.savedVariables.countJokes = Joker.savedVariables.countJokes + 1
    end
    -- d(jokeType .. ': loaded ' .. Joker.savedVariables.categories[jokeType].count .. ' jokes.') -- load debugging
  end

  -- Iterate over seenJokes
  Joker.savedVariables.countSeenJokes = 0 -- reset count
  for jokeType, thisJokes in pairs(allJokes) do
    -- Reset count
    Joker.savedVariables.categories[jokeType].Seen = 0
    -- Iterate over this type's seenJokes and count
    for thisJokeIndex, thisJokeText in pairs(Joker.savedVariables.categories[jokeType].seenJokes) do
      Joker.savedVariables.categories[jokeType].seenCount = Joker.savedVariables.categories[jokeType].seenCount + 1
      Joker.savedVariables.countSeenJokes = Joker.savedVariables.countSeenJokes + 1
    end
  end

  -- Legacy: Update Periodic Jokes
  if (Joker.savedVariables.periodicJokes == 'Enabled') then
    Joker.savedVariables.periodicJokes = true
  elseif (Joker.savedVariables.periodicJokes == 'Disabled') then
    Joker.savedVariables.periodicJokes = false
  end

  -- Settings menu in Settings.lua.
  Joker.LoadSettings()

  -- NOTE: Slash commands must be lowercase!
  SLASH_COMMANDS["/joke"] = function (context) Joker.AnyJoke(context) end
  SLASH_COMMANDS["/joke-norris"] = function (context) Joker.Joke('Norris', context) end
  SLASH_COMMANDS["/joke-eso"] = function (context) Joker.Joke('ESO', context) end
  SLASH_COMMANDS["/joke-dad"] = function (context) Joker.Joke('Dad', context) end
  SLASH_COMMANDS["/joke-edgy"] = function (context) Joker.Joke('Edgy', context) end
  SLASH_COMMANDS["/joke-wisdom"] = function (context) Joker.Joke('Wisdom', context) end
  SLASH_COMMANDS["/joke-pickup"] = function (context) Joker.Joke('Pickup', context) end
  SLASH_COMMANDS["/joke-twister"] = function (context) Joker.Joke('Twisters', context) end
  SLASH_COMMANDS["/joke-burn"] = function (context) Joker.Joke('Burns', context) end
  SLASH_COMMANDS["/joke-got"] = function (context) Joker.Joke('GameOfThrones', context) end
  SLASH_COMMANDS["/joke-pokemon"] = function (context) Joker.Joke('Pokemon', context) end
  SLASH_COMMANDS["/joke-starwars"] = function (context) Joker.Joke('StarWars', context) end
  -- Other joke command aliases:
  SLASH_COMMANDS["/wisdom"] = function (context) Joker.Joke('Wisdom', context) end
  SLASH_COMMANDS["/dad"] = function (context) Joker.Joke('Dad', context) end
  SLASH_COMMANDS["/norris"] = function (context) Joker.Joke('Norris', context) end
  SLASH_COMMANDS["/8ball"] = Joker.EightBall
  SLASH_COMMANDS["/catfact"] = function (context) Joker.Joke('Cat', context) end
  SLASH_COMMANDS["/pickup"] = function (context) Joker.Joke('PickupLines', context) end
  SLASH_COMMANDS["/pickup-xxx"] = function (context) Joker.Joke('PickupLinesXXX', context) end
  SLASH_COMMANDS["/pickup-hp"] = function (context) Joker.Joke('PickupLinesHP', context) end
  SLASH_COMMANDS["/pickup-poke"] = function (context) Joker.Joke('PickupLinesPoke', context) end
  SLASH_COMMANDS["/twister"] = function (context) Joker.Joke('Twisters', context) end
  SLASH_COMMANDS["/burn"] = function (context) Joker.Joke('Burns', context) end
  SLASH_COMMANDS["/starwars"] = function (context) Joker.Joke('StarWars', context) end
  SLASH_COMMANDS["/pokemon"] = function (context) Joker.Joke('Pokemon', context) end
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
  if Joker.savedVariables.periodicJokes and Data.checkPeriodicDue() then
    d('Random joke!')
    Joker.AnyJoke('', 1)
    -- zo_callLater(Joker.AnyJoke('', 1), 2500)
  end
end

-- When any addon is loaded, but before UI (Chat) is loaded.
EVENT_MANAGER:RegisterForEvent(Joker.name, EVENT_ADD_ON_LOADED, Joker.OnAddOnLoaded)
