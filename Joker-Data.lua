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

  d('Grabbing a joke from ' .. jokeCategory)

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
  if searchFilter and not Util.isEmpty(searchFilter) then
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

JokerDataFn = Data or {}
