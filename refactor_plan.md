# Joker Addon Refactoring Plan

This document outlines potential refactorings for the Joker addon, focused on improvements that provide real value within ESO's Lua environment.

## High Priority Refactorings

### 1. Extract Duplicate Output Logic (Lines 52-62, 66-76)
**Issue**: `Joker.Joke()` and `Joker.AnyJoke()` both contain identical logic for determining whether to output to console or chat.

**Current Code Pattern**:
```lua
if logToConsole or Joker.saved.enable.consoleOnly then
  d(joke)
else
  StartChatInput(joke, CHAT_CHANNEL)
end
```

**Proposed Solution**: Create a helper function `Joker.OutputJoke(joke, logToConsole)` that encapsulates this logic.

**Benefit**: Reduces duplication, makes future changes easier (e.g., adding more output channels).

---

### 2. Eliminate Duplicate `runtime_updates()` Call (Lines 138, 236)
**Issue**: `runtime_updates()` is called in both `runtime_onload()` (line 138) and `Joker.Activated()` (line 236).

**Analysis**: This appears redundant since both functions run during the addon lifecycle. Review the execution order to determine if both calls are necessary.

**Proposed Solution**: Either:
- Remove one of the duplicate calls if unnecessary
- Add comments explaining why both are needed if intentional

**Benefit**: Prevents potential double-execution of update logic, reduces confusion.

---

### 3. Extract Slash Command Registration Logic (Lines 164-169)
**Issue**: Slash command registration in the joke loading loop contains nested conditional logic that's hard to follow.

**Current Structure**:
```lua
SLASH_COMMANDS["/joke-" .. JokerData.Config[i].command] = function (context) Joker.Joke(i, context) end

if JokerData.Config[i].whitelistSlashCommand then
  SLASH_COMMANDS["/" .. JokerData.Config[i].command] = function (context) Joker.Joke(i, context) end
end
```

**Proposed Solution**: Create a helper function:
```lua
local function registerJokeCommand(category, config)
  SLASH_COMMANDS["/joke-" .. config.command] = function(context) 
    Joker.Joke(category, context) 
  end
  
  if config.whitelistSlashCommand then
    SLASH_COMMANDS["/" .. config.command] = function(context) 
      Joker.Joke(category, context) 
    end
  end
end
```

**Benefit**: Improves readability of the main loading loop, makes command registration logic reusable.

---

### 4. Extract Joke Category Loading Loop (Lines 140-180)
**Issue**: The `runtime_onload()` function contains a large, complex loop that handles multiple responsibilities (counting, validating, registering commands).

**Proposed Solution**: Extract to a separate function like `local function loadJokeCategories()` that returns `loadedJokes` and `countAllJokes`.

**Benefit**: 
- Reduces complexity of `runtime_onload()`
- Makes the loading logic testable/debuggable independently
- Improves code readability

---

## Medium Priority Refactorings

### 5. Consolidate Debug Output Pattern
**Issue**: Debug mode checks are scattered throughout with inconsistent patterns:
- Line 110: `if Joker.saved.internal.showDebug > 0 then d('...') end`
- Line 120: Same pattern repeated
- Line 174: Same pattern repeated

**Proposed Solution**: Create a helper function:
```lua
local function debugLog(message)
  if Joker.saved.internal.showDebug > 0 then
    d('Joker: ' .. message)
  end
end
```

**Benefit**: Consistent debug output, easier to add features like log levels or file output later.

---

### 6. Replace Magic Numbers with Named Constants
**Issue**: Magic numbers appear throughout the code:
- Line 250: `ZO_SavedVars:NewAccountWide('JokerSavedVars', 2, nil, Joker.defaults)` - what is `2`?
- Lines 41-46: Using `0` and `1` as boolean flags
- Lines 109, 119: Version numbers like `402000`, `403000`

**Proposed Solution**: Define constants at the top of the file:
```lua
local SAVED_VARS_VERSION = 2
local ENABLED = 1
local DISABLED = 0
```

**Benefit**: Self-documenting code, easier to understand intent.

---

### 7. Standardize Function Naming Convention
**Issue**: Mixed naming conventions exist:
- `runtime_maiden()` - snake_case
- `Joker.Joke()` - PascalCase
- `Joker.ToggleDebug()` - PascalCase
- `Data.GetJoke()` - PascalCase
- `runtime_onload()` - snake_case

**Current Pattern**: 
- Public/API functions use PascalCase
- Local functions use snake_case

**Proposed Solution**: Keep the current pattern but document it explicitly in comments. This is actually a good convention.

**Benefit**: Clarity on function scope and usage.

---

### 8. Extract Update Migration Logic (Lines 103-128)
**Issue**: The `runtime_updates()` function will grow with every version update, making it harder to maintain.

**Proposed Solution**: Consider extracting individual migration functions:
```lua
local function migrate_to_402000()
  table.insert(Joker.saved.randomPool.blacklist, 'Curse')
  Util.sortSet(Joker.saved.randomPool.blacklist)
  Joker.saved.internal.lastUpdate = 402000
end

local function migrate_to_403000()
  Joker.saved.rolls.postToChat = 0
  Joker.saved.internal.lastUpdate = 403000
end
```

**Benefit**: Each migration is self-contained, easier to understand historical changes.

---

## Low Priority / Nice-to-Have

### 9. Add Guard Clauses for Early Returns
**Issue**: Some functions have deep nesting that could be flattened.

**Example**: Lines 242-258 in `Joker.OnAddOnLoaded()`:
```lua
function Joker.OnAddOnLoaded(event, addonName)
  if addonName ~= Joker.name then return end
  -- Rest of function
end
```

This is already good! But similar patterns could be applied elsewhere.

**Benefit**: Reduced nesting, improved readability.

---

### 10. Document Event Lifecycle
**Issue**: The interaction between `EVENT_PLAYER_ACTIVATED` and `EVENT_ADD_ON_LOADED` is not immediately clear.

**Proposed Solution**: Add comprehensive comments explaining:
- When each event fires
- What should be initialized in each
- Why `runtime_updates()` might be called in both (if intentional)

**Benefit**: Easier onboarding for future maintainers, reduces confusion.

---

### 11. Comment Unclear Variable Names
**Issue**: Some variable names could be clearer:
- Line 143: `Joker.saved.randomPool.enabled` - is this enabled categories?
- Line 144: Loop variables `i,v` - could be `categoryKey, categoryData`

**Proposed Solution**: Either rename variables or add inline comments explaining their purpose.

**Benefit**: Self-documenting code.

---

## Not Recommended

### ❌ Create Separate Config/Constants File
**Why Not**: ESO's addon loading order can be tricky, and splitting files doesn't provide significant benefit given the current size. The existing three-file structure (Joker.lua, Joker-Util.lua, Joker-Data.lua) is appropriate.

### ❌ Use Object-Oriented Patterns
**Why Not**: ESO's Lua environment doesn't benefit from OOP patterns. The current functional/namespace approach is idiomatic for ESO addons.

### ❌ Add Unit Testing
**Why Not**: ESO doesn't have a standard unit testing framework, and the addon is UI/game-dependent. Manual testing is the norm.

### ❌ Use Module System (require/module)
**Why Not**: ESO uses its own manifest system (Joker.txt) for loading files. The current approach is correct for ESO.

---

## Implementation Notes

**Priority Order**: 
1. Start with #1 (Extract Duplicate Output Logic) - quick win
2. Then #2 (Eliminate Duplicate Call) - prevents potential bugs
3. Then #4 (Extract Loading Loop) - biggest code quality improvement
4. Tackle medium priority items as needed

**Testing Strategy**:
- After each refactoring, reload UI in-game (`/rl`)
- Test all slash commands (`/joke`, `/8ball`, `/ready`, etc.)
- Test settings menu
- Enable debug mode and check for errors

**Backward Compatibility**:
All refactorings preserve the existing API and saved variables structure, so no migration is needed.
