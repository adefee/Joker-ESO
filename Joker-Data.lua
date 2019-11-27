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
  local searchFilter = ""

  if not JokerData[jokeCategory] or Util.setContains(Joker.saved.randomPool.blacklist, jokeCategory) then
    return ""
  end

  if context and not Util.isEmpty(context) then
    if JokerData.Config[jokeCategory].usePrefix then
      usePrefix = true      

    else
      searchFilter = Util.trim(context)
    end
  end

  -- Later: when tracking seen jokes, loop until we find a joke we haven't seen
  local loops = 0
  local loopLimit = 1500

  -- If we have a search keyword, iterate over that first
  if searchFilter and not usePrefix and not Util.isEmpty(searchFilter) then
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
            table.insert(jokes, w)
          end
        end
      end
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

    -- Add to seenJokes so we don't pull again
    -- Data.addSeen(jokeCategory, index)

    -- Update count
    jokeCount = Util.countSet(jokes)

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

    local randomCategoryIndex = 1 + math.floor(math.random() * #availableCategories)
    local randomCategory = availableCategories[randomCategoryIndex]
    local randomJokeIndex = 1 + math.floor(math.random() * #JokerData[randomCategory])
    local randomJoke = JokerData[randomCategory][randomJokeIndex]
    return randomJoke
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
    table.sort(Joker.saved.randomPool.blacklist, function(a,b) return a < b end)
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
      table.sort(Joker.saved.randomPool.blacklist, function(a,b) return a < b end)
    end
  end
end

function Data.randomPoolSetDefault()
  Joker.saved.randomPool.blacklist = Joker.defaults.randomPool.blacklist
end

JokerDataFn = Data or {}
