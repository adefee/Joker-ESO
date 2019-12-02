-- * _JOKER_VERSION: 0.0.1 ** Please do not modify this line.
--[[----------------------------------------------------------
  Data Operation Functions
  - Handle & manipulate data related to Joker operations
  - Imported from Joker.lua

  CONTENTS:
  - 
  ----------------------------------------------------------
]]--

local Data = JokerDataFn or {}
local Util = JokerUtilityFn or {}


-- getJokeSeen()
-- Data; Determines if joke is seen
function Data.getJokeSeen(category, index)
  if not Util.setContains(Joker.saved.seenJokes, category) then
    return false
  end

  return Util.setContainsValue(Joker.saved.seenJokes[category], index)
end

-- setJokeSeen()
-- Data; Set joke as seen
function Data.setJokeSeen(category, index)

  if not Util.setContains(Joker.saved, 'seenJokes') then
    Joker.saved.seenJokes = {}
  end

  if not Util.setContains(Joker.saved.seenJokes, category) then
    Joker.saved.seenJokes[category] = {}
  end

  table.insert(Joker.saved.seenJokes[category], index)
  Joker.saved.count.seen = tonumber(Joker.saved.count.seen) + 1
end

-- getMessage()
-- Data; Returns mood message from Joker
-- @param mood, string, happy|sad
function Data.GetMessage(mood)
  mood = string.lower(Util.trim(mood))
  
  local message = ""
  if (mood == 'happy') and Joker.happyMessages then
    message = Joker.happyMessages[1 + math.floor(math.random() * Util.countSet(Joker.happyMessages))]
  elseif mood == 'sad' and Joker.sadMessages then
    message = Joker.sadMessages[1 + math.floor(math.random() * Util.countSet(Joker.sadMessages))]
  end

  return message
end

-- getPrefix()
-- Data; Returns a prefix
function Data.getPrefix()
  return Joker.saved.activeIntros[(1 + math.floor((math.random() * #Joker.saved.activeIntros)))]
end

-- getJoke()
-- Data; Returns random joke from given category
-- @param jokeCategory, string, Category to pull from
-- @param searchFilter, string, Filter results by this text  
-- @param console, bool, log to console instead of chat  
function Data.GetJoke(jokeCategory, context)

  -- Defaults
  local jokeCategory = jokeCategory or "Dad" -- Set Dad as default category
  local jokes = {}
  local jokeCount = 0
  local joke = ""
  local index = 0
  local usePrefix = false
  local useSuffix = false
  local suffixTarget = false -- If suffix is targeted
  local searchFilter = ""

  if not JokerData[jokeCategory] then
    return ""
  end

  if JokerData.Config[jokeCategory].useSuffix then
    useSuffix = true
  end

  if context and not Util.isEmpty(context) then
    if JokerData.Config[jokeCategory].usePrefix then
      usePrefix = true
    elseif JokerData.Config[jokeCategory].useSuffix then
      suffixTarget = true
    else
      searchFilter = Util.trim(context)
    end
  end

  -- Later: when tracking seen jokes, loop until we find a joke we haven't seen
  local loops = 0
  local loopLimit = 1500

  -- If we have a search keyword, iterate over that first
  if searchFilter and not usePrefix and not useSuffix and not Util.isEmpty(searchFilter) then
    for i,v in pairs(JokerData[jokeCategory]) do
      if string.match(v, searchFilter) then
        table.insert(jokes, v)
      end
    end
  else
    jokes = JokerData[jokeCategory]
  end

  -- Update count
  jokeCount = Util.countSet(jokes)

  if jokeCount < 1 and not Util.isEmpty(searchFilter) then
    d('Unable to find any jokes matching your search for "'.. searchFilter ..'". ' .. Data.GetMessage('sad'))
  elseif jokeCount > 0 and not Util.isEmpty(searchFilter) then
    d('Randomly choosing from ' .. jokeCount .. ' jokes, based on your search...')
  end
  

  -- Before we loop, see if we need to reset seenJokes for this type
  -- if Joker.savedVariables.categories[jokeCategory].seenCount > 0 and Joker.savedVariables.categories[jokeCategory].seenCount >= Joker.savedVariables.categories[jokeCategory].count then
  --   Util.resetSeen(jokeCategory)
  -- end

  -- Loop until we find a joke we haven't yet seen. If we hit loopLimit, we'll just use what we have 
  repeat
    local random = math.random() * jokeCount
    loops = loops + 1
    index = 1 + math.floor(random)
    joke = jokes[index]
  -- until (not Data.isSeen(jokeCategory, index) or loops >= loopLimit)
  until (loops > 0 or loops >= loopLimit)

  if usePrefix then
    joke = string.gsub(Data.getPrefix(), "jTarget", context) .. joke:sub(1,1):lower() .. joke:sub(2)
  elseif useSuffix then
    if suffixTarget then
      joke = joke:sub(1,1) .. joke:sub(2) .. ', ' .. context .. '!'
    else
      joke = joke:sub(1,1) .. joke:sub(2) .. '!'
    end
    
  end

  -- Add to seenJokes so we don't pull again
  -- Data.addSeen(jokeCategory, index)

  -- Finally, return joke
  return joke

end

-- getJoke()
-- Data; Returns random joke from given category
-- @param jokeCategory, string, Category to pull from
-- @param searchFilter, string, Filter results by this text  
-- @param console, bool, log to console instead of chat  
function Data.GetRandomJoke(context)

  -- Defaults
  local jokes = {}
  local jokeCount = 0
  local joke = ""
  local index = 0
  local usePrefix = false
  local useSuffix = false
  local searchFilter = ""

  if context and not Util.isEmpty(context) then
    searchFilter = string.lower(Util.trim(context)) -- Convert both content and searchFilter to lowercase
  end

  -- Later: when tracking seen jokes, loop until we find a joke we haven't seen
  local loops = 0
  local loopLimit = 1500

  -- If we have a search keyword, iterate over that first
  if searchFilter and not Util.isEmpty(searchFilter) then
    -- For each category, if it's not blacklisted, loop over and pull available jokes
    -- Joker.saved.activeJokes has all jokes
    -- Joker.saved.randomPool.blacklist has keys to avoid
    for i,v in pairs(Joker.saved.randomPool.enabled) do
      if not Util.setContainsValue(Joker.saved.randomPool.blacklist, v) then
        for j,w in pairs(JokerData[v]) do
          local jokeContent = string.lower(w) -- Convert both content and searchFilter to lowercase
          if string.match(jokeContent, searchFilter) then
            table.insert(jokes, v .. ':::' .. j .. ':::' .. w)
          end
        end
      end
    end

    -- Before we loop, see if we need to reset seenJokes for this type
    -- if Joker.savedVariables.categories[jokeCategory].seenCount > 0 and Joker.savedVariables.categories[jokeCategory].seenCount >= Joker.savedVariables.categories[jokeCategory].count then
    --   Util.resetSeen(jokeCategory)
    -- end

    -- Update count
    jokeCount = Util.countSet(jokes)

    -- Loop until we find a joke we haven't yet seen. If we hit loopLimit, we'll just use what we have 
    if (jokeCount > 0) then
      repeat
        local random = math.random() * jokeCount
        loops = loops + 1
        index = 1 + math.floor(random)
        joke = jokes[index]
        thisJokeCategory, thisJokeIndex, thisJokeContent = joke:match("(.+):::(.+):::(.+)")
        joke = thisJokeContent
      until (not Data.getJokeSeen(thisJokeCategory, thisJokeIndex) or loops >= loopLimit)
      -- until (loops > 0 or loops >= loopLimit)

      -- Add to seenJokes so we don't pull again
      Data.setJokeSeen(thisJokeCategory, thisJokeIndex)
    end


    if jokeCount < 1 and not Util.isEmpty(searchFilter) then
      d('Unable to find any jokes matching your search for "'.. searchFilter ..'". ' .. Data.GetMessage('sad'))
    elseif jokeCount > 0 and not Util.isEmpty(searchFilter) then
      d('Randomly choosing from ' .. jokeCount .. ' jokes, based on your search...')
    end

    -- Finally, return joke
    return joke

  else
    -- Get a random joke from any available category
    availableCategories = {}
    for i,v in pairs(Joker.saved.randomPool.enabled) do
      if not Util.setContainsValue(Joker.saved.randomPool.blacklist, v) then
        table.insert(availableCategories, v)
      end
    end

    if Util.isSetEmpty(availableCategories) then
      table.insert(availableCategories, 'Dad')
    end

    repeat
      randomCategoryIndex = 1 + math.floor(math.random() * #availableCategories)
      randomCategory = availableCategories[randomCategoryIndex]
      randomJokeIndex = 1 + math.floor(math.random() * #JokerData[randomCategory])
      joke = JokerData[randomCategory][randomJokeIndex]
    until (not Data.getJokeSeen(randomCategory, randomJokeIndex) or loops >= loopLimit)

    Data.setJokeSeen(randomCategory, randomJokeIndex)

    return joke
  end

end


-- runPeriodicEvents()
-- Data; Determines if a specific periodic event is due to occur
function Data.runPeriodicEvents(target, callbacks, skipIncrement)
  
  if not skipIncrement or skipIncrement < 1 then
    -- Increment all available events
    Data.updatePeriodicSeen('health') -- TODO: updatePeriodicSeen doesn't currently account for health
    Data.updatePeriodicSeen('jokes')
  end

  -- To avoid spam, if both a health reminder and joke are due in same load, show only the reminder.

  if target == 'health' or Util.isEmpty(target) then  -- Periodically show a mental health reminder to the user. Frequency is integer X hours.
    if Joker.saved.periodic.health_enable > 0 then
      d('timestamp' .. GetTimeStamp()) -- Log our last seen
      d('Health check here')
      Data.resetPeriodicSeen('health')
    end 
  elseif target == 'joke' then -- Periodically show a joke to the user
    if Joker.saved.periodic.jokes_enable > 0 and Joker.saved.periodic.jokes_lastSeen >= Joker.saved.periodic.jokes_frequency then
      -- Increment our last seen
      Data.resetPeriodicSeen('jokes')
      zo_callLater(function() return callbacks['joke']() end, 3000)
    end
  end

  return false
end

-- togglePeriodicEvents
-- Data; Updates lastSeen timestamp for a periodic event
function Data.togglePeriodicEvents(target)
  if Joker.saved.periodic[target .. '_enable'] > 0 then
    Joker.saved.periodic[target .. '_enable'] = 0
  else
    Joker.saved.periodic[target .. '_enable'] = 1
  end
end

-- updatePeriodicSeen
-- Data; Updates lastSeen timestamp for a periodic event
function Data.updatePeriodicSeen(target)
  if target == 'jokes' then
    Joker.saved.periodic.jokes_lastSeen = (Joker.saved.periodic.jokes_lastSeen + 1)
  end
end

-- resetPeriodicSeen
-- Data; Resets lastSeen timestamp for a periodic event
function Data.resetPeriodicSeen(target)
  Joker.saved.periodic[target .. '_lastSeen'] = 0
end

-- isNSFW
-- Data; Returns bool (or string if display is passed) whether or not a given [target] category is NSFW.
function Data.isNSFW(target, display)
  if display then
    if JokerData.Config[target].nsfw then
      return Util.colorize(' (NSFW) ', "AA00FF")
    else
      return ''
    end
  else
    return JokerData.Config[target].nsfw or false
  end
  
end

-- randomPoolGet
-- Data; Returns bool based on whether or not a [target] category is enabled and not blacklisted
function Data.randomPoolGet(target)
  return Util.setContainsValue(Joker.saved.randomPool.enabled, target) and not Util.setContainsValue(Joker.saved.randomPool.blacklist, target)
end

-- randomPoolSet
-- Data; Toggles a [target] category in randomPool based on its current status
function Data.randomPoolSet(target)

  if Data.randomPoolGet(target) then
    -- Target category is enabled, disable it
    if Joker.saved.internal.showDebug > 0 then
      d('Joker: The category "' .. target .. '" is being toggled off.')
    end
    table.insert(Joker.saved.randomPool.blacklist, target)
    Util.sortSet(Joker.saved.randomPool.blacklist)
  else
    if Joker.saved.internal.showDebug > 0 then
      d('Joker: The category "' .. target .. '" is being toggled ON.')
    end
    -- Target category is disabled (should have an entry in blacklist), enable it by removing from blacklist
    local indexToRemove = 0
    for i,v in ipairs(Joker.saved.randomPool.blacklist, target) do
      if v == target then
        indexToRemove = i
      end
    end
    
    if indexToRemove > 0 then
      if Joker.saved.internal.showDebug > 0 then
        d('Joker: Found index, removing index ' .. indexToRemove)
      end
      table.remove(Joker.saved.randomPool.blacklist, indexToRemove)
      Util.sortSet(Joker.saved.randomPool.blacklist)
    end
  end
end

-- randomPoolSetDefault()
-- Data; Return randomPool blacklist to default settings
function Data.randomPoolSetDefault()
  Joker.saved.randomPool.blacklist = Joker.defaults.randomPool.blacklist
end

-- EightBall()
-- Display; Show a yes, no, neutral status. Optionals: <question>
function Data.eightBall(question)
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
  local prefix = "Joker's 8ball says: "

  -- Question provided, so repeat back before giving answer.
  if not Util.isEmpty(question) then
    d('You asked the 8ball: "' .. question ..'" ...')
  end

  d(prefix .. answer)
end


-- readyCheck()
-- Display; Randomly choose a ready-check message, then trigger ready check. Optionals: <target: any prompt>
function Data.readyCheck(target)

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
    if Util.startsWith(target, 'unan ') then
      checkType = 2
      checkPrompt = target:gsub('unan ', '')
    elseif Util.startsWith(target, 'simple ') then
      checkType = 0
      checkPrompt = target:gsub('simple ', '')
    elseif Util.startsWith(target, 'super ') then
      checkType = 1
      checkPrompt = target:gsub('super ', '')
    else
      checkType = 2
      checkPrompt = target
    end

  else
    -- Choose random prompt
    repeat
      checkPrompt = Data.GetJoke('ReadyChecks')
      local promptLength = string.len(checkPrompt)
    until (promptLength < 350)
  
    -- First-Usage: Display intro message
    if Joker.saved.internal.firstReadyCheck then
      Joker.saved.internal.firstReadyCheck = false
    end
    
  end

  d('Ready checking with: ' .. checkPrompt)
  BeginGroupElection(checkType, checkPrompt)

end


-- choose()
-- Display; Choose between any number of items/users (space delimited)
function Data.choose(context)
  local choices = {}
  local itemsWon = {}

  choices = Util.split(context, " ")
  for thisChoiceIndex, thisChoiceContent in ipairs(choices) do
    if Util.startsWith(thisChoiceContent, '|H') or Util.startsWith(thisChoiceContent, '|h') then
      table.insert(itemsWon, thisChoiceContent)
      -- Deleting here would upset the table index and the loop (Lua shifts down instead of temp maintaining), so need to delete in separate loop
      -- Could alternatively keep track of items to remove, but copy/paste is easier ;P
    end
  end

  -- Running a separate loop for deletion, see above comment
  for thisChoiceIndex, thisChoiceContent in pairs(choices) do
    if Util.startsWith(thisChoiceContent, '|H') or Util.startsWith(thisChoiceContent, '|h') then
      table.remove(choices, thisChoiceIndex)
    end
  end

  if Util.startsWith(context, 'party') or context == 'party' then
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

  elseif Util.startsWith(context, 'guild') or context == 'guild' then
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


-- roll()
-- Display; Rolls with given ceiling and includes memo (if provided). Space delimited: /roll floor ceiling memo
function Data.roll(context)
  local floor = 1
  local ceiling = 10
  local contextObj = Util.split(context, ' ')
  local memo = ''
  local maxNumber = 999999999 -- ESO will error out if we roll higher than this number

  -- Determine floor & ceiling for roll
  if not Util.isEmpty(contextObj[1]) then
    ceiling = tonumber(contextObj[1]) or ceiling
  end

  if (ceiling > maxNumber or floor > maxNumber) then
    d("Joker: " .. Joker_Quick_Btn_JokeRolls_Max .. ' ' .. Util.formatNumber(maxNumber))
    return false
  end

  local random = math.random(floor, ceiling)

  -- Determine if memo is provided (for now, must include explicit floor and ceiling)
  if contextObj[2] and not Util.isEmpty(Util.trim(contextObj[2])) then
    memo = string.gsub(context, contextObj[1], '')
    memo = '(Memo: ' .. Util.trim(memo) .. ')'
  end

  local percentChance = '~' .. Util.roundNumber((100 / ceiling), 4) .. '% chance per 1'

  -- If we include a memo, publish to chat; otherwise, publish to console
  if contextObj[2] then
    StartChatInput('Rolling a ' .. Util.formatNumber(((ceiling - floor) + 1)) .. '-sided die (' .. percentChance .. ') ... and ' .. Util.formatNumber(random) .. ' is rolled! ' .. memo, CHAT_CHANNEL)
  else
    d('Joker: Rolling a ' .. Util.formatNumber(((ceiling - floor) + 1)) .. '-sided die (' .. percentChance .. ') ... and ' .. Util.colorize(Util.formatNumber(random)) .. ' is rolled! ' .. Util.colorize(memo))
    StartChatInput('Joker: Rolling a ' .. Util.formatNumber(((ceiling - floor) + 1)) .. '-sided die (' .. percentChance .. ') ... and ' .. Util.formatNumber(random) .. ' is rolled! ' .. memo, CHAT_CHANNEL)
  end

end

JokerDataFn = Data or {}
