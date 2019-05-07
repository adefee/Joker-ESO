--[[----------------------------------------------------------
	Joker - Jokes, Riddles, Fun Facts, & Other Tomfoolery
	----------------------------------------------------------
	*
	* Authors:
	* Lent (@CallMeLent, Github @adefee)
	*
	*
]]--
JokerData = JokerData or {}
JokerL = JokerL or {}

Joker = {
    name            = "Joker",                                -- Matches folder and Manifest file names.
    version         = "2.2.0",                                -- Joker internal versioning: Release.Major.Minor
    versionMajor    = 2,                                      -- Will increment variable versioning, only occurs on major updates.
    author          = "Lent (IGN @CallMeLent, Github @adefee)",
    color           = "D66E4A",                               -- Primary addon color
    -- Default settings:
    savedVariables = {
      FirstLoad = true,      
      CountJokesTotal = 0,
      CountSeenJokesTotal = 0,
      PeriodicJokes = true, -- Periodically show jokes to user in console (chat)
      PeriodicFrequency = 3,
      PeriodSince = 0,
      RandomPool = {  -- Current pool sets, each should match function name (Joker.<PoolName>())
        "Cat",
        "Dad",
        "ESO",
        "Norris",
        "StarWars",
        "Twister",
        "Wisdom"
      },
      RandomPoolDefault = { -- Default pool sets, should match function name (Joker.<PoolName>)
        "Cat",
        "Dad",
        "ESO",
        "Norris",
        "StarWars",
        "Twister",
        "Wisdom"
      },  
      RandomPool_Allowed = { -- All possible vals allowed in pool. Each should match function name (Joker.<PoolName>); this list is checked against when user modifies random pool.
        ["Burns"] = "Burns",
        ["Cat"] = "Cat",
        ["Dad"] = "Dad",
        ["Edgy"] = "Edgy",
        ["ESO"] = "ESO",
        ["GoT"] = "GoT",
        ["Norris"] = "Norris",
        ["Pickup"] = "Pickup",
        ["PickupXXX"] = "PickupXXX",
        ["PickupHP"] = "PickupHP",
        ["StarWars"] = "StarWars",
        ["Twister"] = "Twister",
        ["Wisdom"] = "Wisdom",
      },
      pickupPrefixes = {
        "Hey, jTarget, ",
        "Yo, jTarget, ",
        "jTarget, ",
        "jTarget! "
      },
      FirstJokes = {
        Dad = true,
        Edgy = true,
        Wisdom = true,
        Pickup = true,
        PickupXXX = true,
        PickupHP = true,
        Norris = true,
        ESO = true,
        Burn = true,
        Cat = true,
        Ready = true,
        Twister = true,
        Riddle = true,
        GoT = true,
        StarWars = true
      },
      SeenJokes = {
        Dad = {},
        Edgy = {},
        Wisdom = {},
        Pickup = {},
        PickupXXX = {},
        PickupHP = {},
        Norris = {},
        ESO = {},
        Burn = {},
        Cat = {},
        Ready = {},
        Twister = {},
        Riddle = {},
        GoT = {},
        StarWars = {}
      },
      CountJokes = {
        Dad = 0,
        Edgy = 0,
        Wisdom = 0,
        Pickup = 0,
        PickupXXX = 0,
        PickupHP = 0,
        Norris = 0,
        ESO = 0,
        Burn = 0,
        Cat = 0,
        Ready = 0,
        Twister = 0,
        Riddle = 0,
        GoT = 0,
        StarWars = 0
      },
      CountSeenJokes = {
        Dad = 0,
        Edgy = 0,
        Wisdom = 0,
        Pickup = 0,
        PickupXXX = 0,
        PickupHP = 0,
        Norris = 0,
        ESO = 0,
        Burn = 0,
        Cat = 0,
        Ready = 0,
        Twister = 0,
        Riddle = 0,
        GoT = 0,
        StarWars = 0
      }
    },
    locale = JokerL:GetLanguage()                            -- Import locale from JokerL container
}

local L = Joker.locale
local jokeLengthMax = 325 -- Set max joke length. Max chatbox length is 350 chars. Set a little less so we can prepend prefixes if needed.

--[[
  ** Utilities
  PURPOSE: These functions provide basic utility for frequent needs.
]]
-- isempty()
-- Utility; Checks if given string is empty/nil
function Joker.isempty(s)
  return s == nil or s == ''
end

-- trim()
-- Utility; Trims extraneous whitespace from string
function Joker.trim(s)
  return (s:gsub("^%s*(.-)%s*$", "%1"))
end

-- fromCSV()
-- Utility; Converts given comma-delimited list to table
function Joker.fromCSV(s)
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
function Joker.toCSV(tt)
  local s = "";
  for k, v in pairs(tt) do
    v = Joker.trim(v)
    if not Joker.isempty(s) then
      s = s .. ", "
    end
    s = s .. v
  end
  return s
end

-- toCSVi()
function Joker.toCSV(tt)
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
-- Utility; Add to set
function addToSet(set, key)
  set[key] = true
end

-- setContains()
-- Utility; Determines if a set contains a key
function setContains(set, key)
  return set[key] ~= nil
end

-- isSeen()
-- Utility; Determines if a specific joke has already been seen
function Joker.isSeen(jokeType, jokeIndex)

  if setContains(Joker.savedVariables.SeenJokes[jokeType], '"' .. jokeIndex .. '"') then
    return true
  end

  return nil

end

-- addSeen()
-- Utility; Add a specific joke to corresponding seen
function Joker.addSeen(jokeType, jokeIndex)

  -- Quotes encompass jokeIndex so that the key is a string instead of looking for an actual index
  -- TODO: Was previously using `addToSet(Joker.savedVariables.SeenJokes[jokeType], '"' .. jokeIndex .. '"')`, but that seems to not work as intended.

  addToSet(Joker.savedVariables.SeenJokes[jokeType], '"' .. jokeIndex .. '"')

  Joker.savedVariables.CountSeenJokes[jokeType] = Joker.savedVariables.CountSeenJokes[jokeType] + 1
  Joker.savedVariables.CountSeenJokesTotal = Joker.savedVariables.CountSeenJokesTotal + 1
  return true

end

-- resetSeen()
-- Utility; Rests seen object & count for given jokeType
function Joker.resetSeen(jokeType)
  -- d("Nice! You've seen everything in the ".. jokeType .. " category! We're always adding more content, but in the meantime - we've reset this category. You may see a few duplicates, but make sure to check every day for updates - new content is added almost daily!")
  Joker.savedVariables.CountSeenJokes[jokeType] = 0
  Joker.savedVariables.SeenJokes[jokeType] = {}
  return true
end

-- formatNumber()
-- Utility; Returns US-formatted (comma thousands, period decimals) number
function Joker.formatNumber(amount)
  local formatted = amount
  while true do  
    formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
    if (k==0) then
      break
    end
  end
  return formatted
end

-- togglePeriodicJokes()
-- Utility; Toggles whether or not jokes are periodically shown to the user in console (d()). Using string instead of bool so we can easily display status in addon settings.
function Joker.togglePeriodicJokes(value)

  Joker.savedVariables.PeriodicJokes = value

  if not Joker.savedVariables.PeriodicJokes then
    d('Joker will no longer share jokes with you. He is very sad.')
  else
    d('Joker will periodically send jokes to you!')
  end
end

-- checkPeriodicDue()
-- Utility; Determines if we're due for a periodic joke.
function Joker.checkPeriodicDue()
  
  --[[
    PeriodSince saves number of zones/reloads since we last displayed a joke,
    with increasing chance to show a joke each load based on user's preferences.
  ]]

  local showJoke = false
  local frequency = Joker.savedVariables.PeriodicFrequency or 10

  if Joker.savedVariables.PeriodSince <= frequency then
    if Joker.savedVariables.PeriodSince < math.floor(frequency / 3) then
      if (math.random(0, 25) <= math.floor(frequency / 3)) then
        showJoke = true
      end
    elseif Joker.savedVariables.PeriodSince < math.floor(frequency / 2) then
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
    Joker.savedVariables.PeriodSince = 0
    return true
  else
    Joker.savedVariables.PeriodSince = Joker.savedVariables.PeriodSince + 1
    return false
  end

end

-- accumulateTypes()
-- Utility; Count total jokes across array of given types, e.g. {'Dad', 'Wisdom'}. Count determines how many of the elements to count
function Joker.accumulateTypes(arrayOfTypes, count)
  local total = 0
  local loops = 1
  count = count or 1

  repeat
    local jokeType = arrayOfTypes[loops]
    total = total + Joker.savedVariables.CountJokes[jokeType]
    loops = loops + 1
  until (loops >= count)

  return total
end

-- setRandomPool()
-- Utility; Updates random pool with user settings, but checks to make sure values are allowed
function Joker.setRandomPool(poolCSV)

  local newPool = {}
  local disallowed = ""

  local givenPool = Joker.fromCSV(poolCSV)
  for k, v in pairs(givenPool) do
    v = Joker.trim(v)
    if setContains(Joker.savedVariables.RandomPool_Allowed, v) and not Joker.isempty(v) then
      table.insert(newPool, v)
    else
      if not Joker.isempty(disallowed) then
        disallowed = disallowed .. ', '
      end
      disallowed = disallowed .. v
    end
  end

  if not Joker.isempty(disallowed) then
    d('There was an issue with one or more of your changes to Joker\'s random pool. Any invalid options are omitted. Try checking near "' .. disallowed ..'", and make sure each option is separated by a comma. Items are case-sensitive!')
  else
    d('Joker\'s random pool has been updated! Don\'t forget that new categories and content are always being added - you might want to update this setting later to include new stuff!')
  end

  Joker.savedVariables.RandomPool = newPool

end

-- string.starts()
-- Utility; bool if string starts with string
function string.starts(String,Start)
  return string.sub(String,1,string.len(Start))==Start
end

function Joker.split(inputstr, sep)
  if sep == nil then
    sep = "%s"
  end
  local t={}
  for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
    table.insert(t, str)
  end
  return t
end

--[[
  ** Data Grabs
  PURPOSE: These functions just return data
]]

function Joker.GetJokeType(jokeType)
  -- Jokes Lists
  local jokes = JokerData.Dad -- default to Dad jokes

  -- jokeType Definitions
  if jokeType == 'Edgy' then
    jokes = JokerData.Edgy
  elseif jokeType == 'Wisdom' then
    jokes = JokerData.Wisdom
  elseif jokeType == 'Pickup' then
    jokes = JokerData.PickupLines
  elseif jokeType == 'PickupXXX' then
    jokes = JokerData.PickupLinesXXX
  elseif jokeType == 'PickupHP' then
    jokes = JokerData.PickupLinesHP
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

-- GetJokes()
-- Data; Returns random joke from jokeType
function Joker.GetJoke(givenJokeType, returnAll)

  -- Defaults
  local jokeType = givenJokeType or "Dad" -- Set Dad as default type
  local jokes = Joker.GetJokeType(givenJokeType)
  local joke = ""
  local index = 0
  local loops = 0
  local loopLimit = 1500

  -- If @param "all" was passed, return all jokes
  if returnAll then
    return jokes
  end

  -- Before we loop, see if we need to reset seenJokes for this type
  if Joker.savedVariables.CountSeenJokes[jokeType] > 0 and Joker.savedVariables.CountSeenJokes[jokeType] >= Joker.savedVariables.CountJokes[jokeType] then
    Joker.resetSeen(jokeType)
  end

  -- Loop until we find a joke we haven't yet seen. If we hit loopLimit, we'll just use what we have 
  repeat
    local random = math.random() * #jokes
    loops = loops + 1
    index = 1 + math.floor(random)
    joke = jokes[index]
  -- until (loops >= 5 or Joker.notSeen(jokeType, index))
  until (not Joker.isSeen(jokeType, index) or loops >= loopLimit)

  -- Add to seenJokes so we don't pull again
  Joker.addSeen(jokeType, index)

  -- Finally, return joke
  return joke
end

-- getPrefix()
-- Data; Retrieve random prefix for customizing jokes (burn, pickups, etc)
function Joker.getPrefix()
  return Joker.savedVariables.pickupPrefixes[(1 + math.floor((math.random() * #Joker.savedVariables.pickupPrefixes)))]
end


--[[
  ** Data Displays
  PURPOSE: These functions parse and init data display.
  NOTE: Each jokeType has its own function
    - ZO Slashcommands only pass a single param (the string after the /<cmd>),  making it harder to pass jokeType,
    - Some jokeTypes post-process or display the data differently than normal
]]

-- Colorize()
-- Display; Wraps text with a color.
-- Credit: @Phuein
function Joker.Colorize(text, color)
  -- Default to addon's .color.
  if not color then color = Joker.color end
  text = "|c" .. color .. text .. "|r"
  return text
end

-- Norris()
-- Display; Returns Norris joke. Optionals: <me> or <target>, <useConsole: displays in d()>
function Joker.Norris(useConsole)
  local joke = ""

  -- v1.1.2: For now, if joke is longer than 350 chars, fetch again
  repeat
    joke = Joker.GetJoke('Norris')
    jokeLength = string.len(joke)
  until (jokeLength < jokeLengthMax)

  -- First-Usage: Display intro message
  if Joker.savedVariables.FirstJokes.Norris then
    Joker.savedVariables.FirstJokes.Norris = false
    d('Like Chuck Norris jokes? Get more with /norris!')
  end

  -- Send
  if useConsole == "log" then
    d('Joker: ' .. joke)
  else
    StartChatInput(joke, CHAT_CHANNEL)
  end
end

-- ESO()
-- Display; Returns ESO joke. Optionals: <useConsole: displays in d()>
function Joker.ESO(useConsole)
  local joke = ""
  local jokeLength = jokeLengthMax  -- Max length for a chat message

  -- v1.1.2: For now, if joke is longer than 350 chars, fetch again
  repeat
    joke = Joker.GetJoke('ESO')
    jokeLength = string.len(joke)
  until (jokeLength < jokeLengthMax)

  -- First-Usage: Display intro message
  if Joker.savedVariables.FirstJokes.ESO then
    Joker.savedVariables.FirstJokes.ESO = false
    d('Like teasing Argonians? Get more with /joke-eso!')
  end

  -- Send
  if useConsole == "log" then
    d('Joker: ' .. joke)
  else
    StartChatInput(joke, CHAT_CHANNEL)
  end
end

-- Twister()
-- Display; Returns random tongue twister
function Joker.Twister(useConsole)
  local joke = ""
  local jokeLength = jokeLengthMax  -- Max length for a chat message

  -- v1.1.2: For now, if joke is longer than 350 chars, fetch again
  repeat
    joke = Joker.GetJoke('Twister')
    jokeLength = string.len(joke)
  until (jokeLength < jokeLengthMax)

  -- First-Usage: Display intro message
  if Joker.savedVariables.FirstJokes.Twister then
    Joker.savedVariables.FirstJokes.Twister = false
    d('Like tongue twisters? Get more with /twister!')
  end

  -- Send
  if useConsole == "log" then
    d('Joker Tongue Twister: ' .. joke)
  else
    StartChatInput('Tongue Twister: ' ..joke, CHAT_CHANNEL)
  end
end

-- Dad()
-- Display; Returns Dad joke. Optionals: <useConsole: displays in d()>
function Joker.Dad(useConsole)
  local joke = ""
  local jokeLength = jokeLengthMax  -- Max length for a chat message

  -- v1.1.2: For now, if joke is longer than 350 chars, fetch again
  repeat
    joke = Joker.GetJoke('Dad')
    jokeLength = string.len(joke)
  until (jokeLength < jokeLengthMax)

  -- First-Usage: Display intro message
  if Joker.savedVariables.FirstJokes.Dad then
    Joker.savedVariables.FirstJokes.Dad = false
    d('Hi, Dad! Like these types of jokes? Get more with /dad!')
  end

  -- Send
  if useConsole == "log" then
    d('Joker: ' .. joke)
  else
    StartChatInput(joke, CHAT_CHANNEL)
  end
end

-- GoT()
-- Display; Returns Game of Thrones joke. Optionals: <useConsole: displays in d()>
function Joker.GoT(useConsole)
  local joke = ""
  local jokeLength = jokeLengthMax  -- Max length for a chat message

  -- v1.1.2: For now, if joke is longer than 350 chars, fetch again
  repeat
    joke = Joker.GetJoke('GoT')
    jokeLength = string.len(joke)
  until (jokeLength < jokeLengthMax)

  -- First-Usage: Display intro message
  if Joker.savedVariables.FirstJokes.GoT then
    Joker.savedVariables.FirstJokes.GoT = false
    d('Want more Game of Thrones jokes? Get more with /joke-got!')
  end

  -- Send
  if useConsole == "log" then
    d('Joker: ' .. joke)
  else
    StartChatInput(joke, CHAT_CHANNEL)
  end
end

-- StarWars()
-- Display; Returns StarWars joke. Optionals: <useConsole: displays in d()>
function Joker.StarWars(useConsole)
  local joke = ""
  local jokeLength = jokeLengthMax  -- Max length for a chat message

  -- v1.1.2: For now, if joke is longer than 350 chars, fetch again
  repeat
    joke = Joker.GetJoke('StarWars')
    jokeLength = string.len(joke)
  until (jokeLength < jokeLengthMax)

  -- First-Usage: Display intro message
  if Joker.savedVariables.FirstJokes.StarWars then
    Joker.savedVariables.FirstJokes.StarWars = false
    d('Want more Star Wars jokes? Get more with /starwars!')
  end

  -- Send
  if useConsole == "log" then
    d('Joker: ' .. joke)
  else
    StartChatInput(joke, CHAT_CHANNEL)
  end
end

-- Wisdom()
-- Display; Returns Wisdom tidbit. Optionals: <useConsole: displays in d()>
function Joker.Wisdom(useConsole)
  local joke = ""
  local jokeLength = jokeLengthMax  -- Max length for a chat message

  -- v1.1.2: For now, if joke is longer than 350 chars, fetch again
  repeat
    joke = Joker.GetJoke('Wisdom')
    jokeLength = string.len(joke)
  until (jokeLength < jokeLengthMax)

  -- First-Usage: Display intro message
  if Joker.savedVariables.FirstJokes.Wisdom then
    Joker.savedVariables.FirstJokes.Wisdom = false
    d('Seeking the profound? Get more like this with /wisdom!')
  end

  -- Send
  if useConsole == "log" then
    d('Joker: ' .. joke)
  else
    StartChatInput(joke, CHAT_CHANNEL)
  end
end

-- Edgy()
-- Display; Returns Edgy/Explicit joke. Optionals: <useConsole: displays in d()>
function Joker.Edgy(useConsole)
  local joke = ""
  local jokeLength = jokeLengthMax  -- Max length for a chat message

  -- v1.1.2: For now, if joke is longer than 350 chars, fetch again
  repeat
    joke = Joker.GetJoke('Edgy')
    jokeLength = string.len(joke)
  until (jokeLength < jokeLengthMax)

  -- First-Usage: Display intro message
  if Joker.savedVariables.FirstJokes.Edgy then
    Joker.savedVariables.FirstJokes.Edgy = false
    d('NOTE: Edgy jokes have been flagged as particularly inappropriate, edgy, or explicit and may not be suitable for all audiences. Please be considerate in your usage. This message only displays on your first usage.')
  end  

  -- Send
  if useConsole == "log" then
    d('Joker: ' .. joke)
  else
    StartChatInput(joke, CHAT_CHANNEL)
  end
end

-- Cat()
-- Display; Returns random cat fact. Optionals: <useConsole: displays in d()>
function Joker.Cat(useConsole)
  local fact = ""
  local factLength = jokeLengthMax -- Max length for a chat message

  -- v1.1.2: For now, if joke is longer than 350 chars, fetch again
  repeat
    fact = Joker.GetJoke('Cat')
    factLength = string.len(fact)
  until (factLength < jokeLengthMax)

  -- First-Usage: Display intro message
  if Joker.savedVariables.FirstJokes.Cat then
    Joker.savedVariables.FirstJokes.Cat = false
    d('Meow? Get more like this with /catfact!')
  end

  -- Send
  if useConsole == "log" then
    d('Joker: ' .. fact)
  else
    StartChatInput(fact, CHAT_CHANNEL)
  end
end

-- Pickup()
-- Display; Returns cheesy pickup line. Optionals: <target: Text following the /cmd>, <useConsole: displays in d()>
function Joker.Pickup(target, useConsole)
  local joke = ""
  local jokeLength = jokeLengthMax  -- Max length for a chat message

  -- v1.1.2: For now, if joke is longer than 350 chars, fetch again
  repeat
    joke = Joker.GetJoke('Pickup')
    jokeLength = string.len(joke)
  until (jokeLength < jokeLengthMax)

  -- Optional target
  if not Joker.isempty(target) and type(target) == "string" then
    -- Prepend prefix, replace target with target if given
    joke = string.gsub(Joker.getPrefix(), "jTarget", target) .. joke:sub(1,1):lower() .. joke:sub(2)
  end

  -- First-Usage: Display intro message
  if Joker.savedVariables.FirstJokes.Pickup then
    Joker.savedVariables.FirstJokes.Pickup = false
    d('Need a date? Get more like this with /pickup, /pickup-xxx (for adults!), and /pickup-hp (Harry Potter!)...')
  end

  -- Send
  if useConsole == "log" then
    d('Joker: ' .. joke)
  else
    StartChatInput(joke, CHAT_CHANNEL)
  end
end

-- Burn()
-- Display; Returns cheesy pickup line. Optionals: <target: Text following the /cmd>, <useConsole: displays in d()>
function Joker.Burn(target, useConsole)
  local joke = ""
  local jokeLength = jokeLengthMax 

  -- v1.1.2: For now, if joke is longer than 350 chars, fetch again
  repeat
    joke = Joker.GetJoke('Burn')
    jokeLength = string.len(joke)
  until (jokeLength < jokeLengthMax)

  -- Optional target
  if not Joker.isempty(target) and type(target) == "string" then
    -- Prepend prefix, replace target with target if given
    joke = string.gsub(Joker.getPrefix(), "jTarget", target) .. joke:sub(1,1):lower() .. joke:sub(2)
  end

  -- First-Usage: Display intro message
  if Joker.savedVariables.FirstJokes.Burn then
    Joker.savedVariables.FirstJokes.Burn = false
    d('Obssessed with fire? Get more burns with /pickup-burn or /burn...')
  end

  -- Send
  if useConsole == "log" then
    d('Joker: ' .. joke)
  else
    StartChatInput(joke, CHAT_CHANNEL)
  end
end

-- PickupXXX()
-- Display; Returns cheesy pickup line. Optionals: <target: Text following the /cmd>, <useConsole: displays in d()>
function Joker.PickupXXX(target, useConsole)
  local joke = ""
  local jokeLength = jokeLengthMax  -- Max length for a chat message

  -- v1.1.2: For now, if joke is longer than 350 chars, fetch again
  repeat
    joke = Joker.GetJoke('PickupXXX')
    jokeLength = string.len(joke)
  until (jokeLength < jokeLengthMax)

  -- Optional target
  if not Joker.isempty(target) and type(target) == "string" then
    -- Prepend prefix, replace target with target if given
    joke = string.gsub(Joker.getPrefix(), "jTarget", target) .. joke:sub(1,1):lower() .. joke:sub(2)
  end

  -- First-Usage: Display intro message
  if Joker.savedVariables.FirstJokes.Pickup then
    Joker.savedVariables.FirstJokes.Pickup = false
    d('Need a date? Get more like this with /pickup, /pickup-xxx (for adults!), and /pickup-hp (Harry Potter!)...')
  end

  -- Send
  if useConsole == "log" then
    d('Joker: ' .. joke)
  else
    StartChatInput(joke, CHAT_CHANNEL)
  end
end

-- PickupHP()
-- Display; Returns cheesy pickup line. Optionals: <target: Text following the /cmd>, <useConsole: displays in d()>
function Joker.PickupHP(target, useConsole)
  local joke = ""
  local jokeLength = jokeLengthMax  -- Max length for a chat message

  -- v1.1.2: For now, if joke is longer than 350 chars, fetch again
  repeat
    joke = Joker.GetJoke('PickupHP')
    jokeLength = string.len(joke)
  until (jokeLength < jokeLengthMax)

  -- Optional target
  if not Joker.isempty(target) and type(target) == "string" then
    -- Prepend prefix, replace target with target if given
    joke = string.gsub(Joker.getPrefix(), "jTarget", target) .. joke:sub(1,1):lower() .. joke:sub(2)
  end

  -- First-Usage: Display intro message
  if Joker.savedVariables.FirstJokes.Pickup then
    Joker.savedVariables.FirstJokes.Pickup = false
    d('Need a date? Get more like this with /pickup, /pickup-xxx (for adults!), and /pickup-hp (Harry Potter!)...')
  end

  -- Send
  if useConsole == "log" then
    d('Joker: ' .. joke)
  else
    StartChatInput(joke, CHAT_CHANNEL)
  end
end

-- eightBall()
-- Display; Show a yes, no, neutral status. Optionals: <question>
function Joker.eightBall(question)
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
  local contextObj = Joker.split(context, ',')

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

  choices = Joker.split(context, " ")
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

    local random = Joker.trim(partyMembers[math.random(#partyMembers)])
    local partyContext = context:gsub("party ", "", 1)

    if partyContext then
      StartChatInput('Choosing from ' .. partySize .. ' party members ... and ' .. random .. ' wins ' .. Joker.trim(partyContext) .. '! Congrats!', CHAT_CHANNEL)
    else
      StartChatInput('Choosing from ' .. partySize .. ' party members ... and ' .. random .. ' wins! Congrats!', CHAT_CHANNEL)
    end

    
  elseif #choices > 1 then
    local random = Joker.trim(choices[math.random(#choices)])
    StartChatInput('Choosing from ' .. #choices .. ' options ... and ' .. random .. ' wins! Congrats!', CHAT_CHANNEL)    
  else
    d('Joker chose ... you! Try adding some other options for Joker to choose from!')
  end


end

-- --------------
-- AnyJoke()
-- Display; Randomly chooses a type of joke, returns. Optionals passed along as needed.
function Joker.AnyJoke(target)
  
  -- Sources for /joke random pool.
  -- Includes most, but not all, topics. Edgy/explicit should never be included
  local sourceIndex = Joker.trim(Joker.savedVariables.RandomPool[math.random(#Joker.savedVariables.RandomPool)])
  
  -- Grab appropriate joke.
  Joker[sourceIndex]()

  -- Send
  StartChatInput(joke, CHAT_CHANNEL)
end

-- AnyJokeToLog()
-- Display; Randomly chooses a type of joke, returns *into console*. This gets called in new zones, if user has enabled.
function Joker.AnyJokeToLog(target)

  -- Sources for /joke random pool.
  -- Includes most, but not all, topics. Edgy/explicit should never be included
  local jokeSources = { 
    "Norris",
    "ESO",
    "Dad",
    "Wisdom",
    "Twister",
    "GoT"
  }
  local random = math.random(0, Joker.savedVariables.CountJokesTotal)

  --[[
    RNJesus: Decided which category to pull from.
    Weighted as a true democracy - each joke gets a vote!
    TODO: Maybe bias towards newer categories (or newer jokes after updates)
  ]]
  if random < Joker.accumulateTypes(jokeSources, 1) then
    local joke = Joker.Norris('', "log")
  elseif random >= Joker.accumulateTypes(jokeSources, 1) and random < Joker.accumulateTypes(jokeSources, 2) then
    local joke = Joker.ESO("log")
  elseif random >= Joker.accumulateTypes(jokeSources, 2) and random < Joker.accumulateTypes(jokeSources, 3) then
    local joke = Joker.Dad("log")
  elseif random >= Joker.accumulateTypes(jokeSources, 3) and random <= Joker.accumulateTypes(jokeSources, 4) then
    local joke = Joker.Wisdom("log")
  elseif random >= Joker.accumulateTypes(jokeSources, 4) and random <= Joker.accumulateTypes(jokeSources, 5) then
    local joke = Joker.Twister("log")
  elseif random >= Joker.accumulateTypes(jokeSources, 5) and random <= Joker.accumulateTypes(jokeSources, 6) then
    local joke = Joker.GoT("log")
  else
    local joke = Joker.Dad("log") -- This should never happen, but better to show Dad than nothing.
  end
end

-- readyCheck()
-- Display; Randomly choose a ready-check message, then trigger ready check. Optionals: <target: any prompt>
function Joker.readyCheck(target)

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
  ** Addon Instantiation
]]

-- Only show the loading message on first load ever. Displays a random message
function Joker.Activated(e)
  EVENT_MANAGER:UnregisterForEvent(Joker.name, EVENT_PLAYER_ACTIVATED)

  if Joker.savedVariables.FirstLoad then
      Joker.savedVariables.FirstLoad = false

      d(Joker.name .. GetString(SI_NEW_ADDON_MESSAGE)) -- Prints to chat.
      ZO_AlertNoSuppression(UI_ALERT_CATEGORY_ALERT, nil, Joker.name .. GetString(SI_NEW_ADDON_MESSAGE)) -- Top-right alert.
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
  Joker.savedVariables = ZO_SavedVars:NewAccountWide("JokerSavedVariables", Joker.versionMajor, nil, Joker.savedVariables)

  -- Legacy versions used CSV, force conversion to table instead
  Joker.savedVariables.RandomPool = Joker.savedVariables.RandomPool or {}
  Joker.savedVariables.RandomPool_Allowed = Joker.savedVariables.RandomPool_Allowed or {}
  if not type(Joker.savedVariables.RandomPool) == 'table' then
    Joker.savedVariables.RandomPool = Joker.savedVariables.RandomPoolDefault
  end
  if not type(Joker.savedVariables.RandomPool_Allowed) == 'table' then
    Joker.savedVariables.RandomPool = {
      "Burns",
      "Cat",
      "Dad",
      "Edgy",
      "ESO",
      "GoT",
      "Norris",
      "Pickup",
      "PickupXXX",
      "PickupHP",
      "StarWars",
      "Twister",
      "Wisdom",
    }
  end
  

  --[[
    Iterate over all jokes and get total counts of both jokes and seenJokes
  ]]
  local allJokes = {}
  allJokes['Dad'] = Joker.GetJoke('Dad', true)
  allJokes['Edgy'] = Joker.GetJoke('Edgy', true)
  allJokes['Wisdom'] = Joker.GetJoke('Wisdom', true)
  allJokes['Twister'] = Joker.GetJoke('Twister', true)
  allJokes['Pickup'] = Joker.GetJoke('Pickup', true)
  allJokes['PickupXXX'] = Joker.GetJoke('PickupXXX', true)
  allJokes['PickupHP'] = Joker.GetJoke('PickupHP', true)
  allJokes['Norris'] = Joker.GetJoke('Norris', true)
  allJokes['ESO'] = Joker.GetJoke('ESO', true)
  allJokes['Cat'] = Joker.GetJoke('Cat', true)
  allJokes['Ready'] = Joker.GetJoke('Ready', true)
  allJokes['Burn'] = Joker.GetJoke('Burn', true)
  allJokes['GoT'] = Joker.GetJoke('GoT', true)
  allJokes['Burn'] = Joker.GetJoke('Burn', true)
  allJokes['StarWars'] = Joker.GetJoke('StarWars', true)
  

  -- Iterate over jokes
  Joker.savedVariables.CountJokesTotal = 0 -- reset count
  for jokeType, thisJokes in pairs(allJokes) do
    -- Reset count
    Joker.savedVariables.CountJokes[jokeType] = 0
    -- Iterate over this type's jokes and count
    for thisJokeIndex, thisJokeText in pairs(thisJokes) do
      Joker.savedVariables.CountJokes[jokeType] = Joker.savedVariables.CountJokes[jokeType] + 1
      Joker.savedVariables.CountJokesTotal = Joker.savedVariables.CountJokesTotal + 1
    end
    -- d(jokeType .. ': loaded ' .. Joker.savedVariables.CountJokes[jokeType] .. ' jokes.') -- load debugging
  end

  -- Iterate over seenJokes
  Joker.savedVariables.CountSeenJokesTotal = 0 -- reset count
  for jokeType, thisJokes in pairs(allJokes) do
    -- Reset count
    Joker.savedVariables.CountSeenJokes[jokeType] = 0
    -- Iterate over this type's seenJokes and count
    for thisJokeIndex, thisJokeText in pairs(Joker.savedVariables.SeenJokes[jokeType]) do
      Joker.savedVariables.CountSeenJokes[jokeType] = Joker.savedVariables.CountSeenJokes[jokeType] + 1
      Joker.savedVariables.CountSeenJokesTotal = Joker.savedVariables.CountSeenJokesTotal + 1
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
  SLASH_COMMANDS["/joke"] = Joker.AnyJoke -- Does not include edgy or pickup lines!
  SLASH_COMMANDS["/joke-norris"] = Joker.Norris
  SLASH_COMMANDS["/joke-eso"] = Joker.ESO
  SLASH_COMMANDS["/joke-dad"] = Joker.Dad
  SLASH_COMMANDS["/joke-edgy"] = Joker.Edgy
  SLASH_COMMANDS["/joke-wisdom"] = Joker.Wisdom
  SLASH_COMMANDS["/joke-pickup"] = Joker.Pickup
  SLASH_COMMANDS["/joke-twister"] = Joker.Twister
  SLASH_COMMANDS["/joke-burn"] = Joker.Burn
  SLASH_COMMANDS["/joke-got"] = Joker.GoT
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
  SLASH_COMMANDS["/twister"] = Joker.Twister
  SLASH_COMMANDS["/burn"] = Joker.Burn
  SLASH_COMMANDS["/starwars"] = Joker.StarWars
  -- Other fun commands:
  SLASH_COMMANDS["/ready"] = Joker.readyCheck
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
