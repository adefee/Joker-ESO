JokerData = JokerData or {} -- content
JokerData.Config = JokerData.Config or {} -- content-specific config (commands, etc)
JokerL = JokerL or {} -- i18n
Joker = Joker or {} -- vars, defaults

local L = Joker.locale -- sets our locale
local Util = JokerUtilityFn or {} -- utility functions used throughout
local Data = JokerDataFn or {} -- data and content processing & display

local panelOptions = {}
local optionIndent = "   " -- Spacer/indent for submenu options
local optionIndent_Title = " " -- Spacer/indent for submenu titles
local optionIndent_Button = "" -- Spacer/indent for buttons

-- Display NSFW
-- Data; Display NSFW

-- settingsPanelMain
-- Data; Creates series of controls for main/basic options
function Data.settingsPanelMain()
  
  local thisPanelSettings = {
    {
      type			  = "checkbox",
      name			  = optionIndent .. L.Joker_Options_Periodic, -- Toggles Periodic Jokes
      tooltip			= L.Joker_Options_Periodic_Tip,
      getFunc			= function() return Joker.saved.periodic.jokes_enable > 0 end,
      setFunc			= function() 
                      Data.togglePeriodicEvents('jokes')
                      Data.runPeriodicEvents('jokes', {
                        joke = function() Joker.AnyJoke('', 1) end
                        }, 1)
                    end,
      width			  = "full",
      default			= function() return Joker.saved.periodic.jokes_enable > 0 end,
    },
    {
      type			  = "slider",
      name			  = optionIndent .. L.Joker_Options_PeriodicFrequency,
      tooltip			= L.Joker_Options_PeriodicFrequency_Tip,
      min         = 1,
      max         = 25,
      step        = 1,
      getFunc			= function() return Joker.saved.periodic.jokes_frequency end,
      setFunc			= function(value) Joker.saved.periodic.jokes_frequency = value end,
      width			  = "full",
      default			= Joker.saved.periodic.jokes_frequency,
      disabled    = function() return not Joker.saved.periodic.jokes_enable end,
    },
    {
      type			  = "checkbox",
      name			  = optionIndent .. L.Joker_Options_Periodic_Health, -- Toggles Periodic Health Reminders
      tooltip			= L.Joker_Options_Periodic_Health_Tip,
      getFunc			= function() return Joker.saved.periodic.health_enable end,
      setFunc			= function() Data.togglePeriodicEvents('health') end,
      width			  = "full",
      default			= Joker.saved.periodic.health_enable,
      disabled    = function() return true end,
    },
    {
      type			  = "checkbox",
      name			  = optionIndent .. L.Joker_Options_Rolls_PostToChat, -- Toggles Rolls being posted to chat
      tooltip			= L.Joker_Options_Rolls_PostToChat_Tooltip,
      getFunc			= function() return Joker.saved.rolls.postToChat > 0 end,
      setFunc			= function() Data.toggleRollsToChat() end,
      width			  = "full",
      default			= Joker.saved.rolls.postToChat
    }
  }

  return thisPanelSettings
end

-- generateRandomPoolOptions
-- Data; Creates series of controls for random pool (auto-gens based on available options)
function Data.settingsPanelPool()
  
  local thisPanelSettings = {
  }

  -- Description Part A
  table.insert(thisPanelSettings, {
    type = "description",
    text = L.Joker_Options_Categories_Description_A,
    width = "full",
  })

  -- Divider
  table.insert(thisPanelSettings, {
    type = "divider",
    width = "full",
  })

  -- Description Part B
  table.insert(thisPanelSettings, {
    type = "description",
    text = L.Joker_Options_Categories_Description_B,
    width = "full",
  })

  -- Sort pool alphabetically
  table.sort(Joker.saved.randomPool.enabled, function(a,b) return a < b end)

  for i,v in ipairs(Joker.saved.randomPool.enabled) do
    -- Don't add specific things
    if v ~= 'ReadyChecks' and v ~= 'CustomReadyChecks' and v ~= 'CustomJokes' then
      table.insert(thisPanelSettings, {
        type			  = "checkbox",
        name			  = optionIndent .. Util.colorize((Joker.saved.activeJokes[v] or 'Unknown Category')) .. Data.isNSFW(v, true) .. ' (' .. Joker.saved.count.categories[v] ..' ' .. L.Joker_Items .. ')', -- Category name + number of items in category
        tooltip			= L.Joker_Options_Categories_ItemTooltip .. JokerData.Config[v].command,
        getFunc			= function() return Data.randomPoolGet(v) end,
        setFunc			= function() Data.randomPoolSet(v) end,
        width			  = "full",
        default			= function() return Util.setContainsValue(Joker.defaults.randomPool.enabled, v) and not Util.setContainsValue(Joker.defaults.randomPool.blacklist, v) end,
        disabled    = function() return not Joker.saved.activeJokes[v] end,
      })
    end
    
  end

  table.insert(thisPanelSettings, {
    type			  = "button",
    name			  = optionIndent_Button .. "Reset to defaults", -- Reset random pool blacklist to default
    func			  = function () Data.randomPoolSetDefault() end,
    width			  = "half",
  })

  return thisPanelSettings
end


-- Compile Addon Settings menu.
function Joker.LoadSettings()
    local LAM = LibAddonMenu2 or LibStub("LibAddonMenu-2.0")

    local panelData = {
        type = "panel",
        name = L.Joker_Title,
        displayName = Util.colorize(L.Joker_Title),
        author = Util.colorize(Joker.author, "AA00FF"),
        version = Util.colorize(Joker.version, "AA00FF"),
        slashCommand = "/joker",
        registerForRefresh = true,
        registerForDefaults = true,
    }

    --[[
      Intro Section
    ]]
    table.insert(panelOptions, {
      type = "description",
      text = L.Joker_Intro_Status_Prefix .. " " .. Util.colorize(Util.formatNumber(Joker.saved.count.loaded)) .. " " .. L.Joker_Intro_Status_Suffix,
      width = "full",
    })


    --[[
      Main Settings: Periodic Events, Toggle NSFW, & Other Options
    ]]
    local settingsPanelMain = Data.settingsPanelMain()
    table.insert(panelOptions, {
      type = "submenu",
      name = optionIndent_Title .. L.Joker_Options_Title,
      tooltip = L.Joker_Options_Title_Tooltip,
      controls = settingsPanelMain
    })


    --[[
      Random Pool Settings: Periodic Events, Toggle NSFW, & Other Options
    ]]
    local settingsPanelPool = Data.settingsPanelPool()
    table.insert(panelOptions, {
      type = "submenu",
      name = optionIndent_Title .. L.Joker_Options_Categories,
      controls = settingsPanelPool
    })

    -- Quick Commands Submenu
    table.insert(panelOptions, {
      type = "submenu",
      name = optionIndent_Title .. L.Joker_Quick_Title,
      tooltip	= "",
      controls		= {
        {
          type			  = "header",
          name			  = optionIndent .. L.Joker_Quick_Subtitle, 
          width			  = "full",
        },
        {
          type			  = "description",
          text			  = optionIndent .. L.Joker_Quick_Desc, 
          width			  = "full",
        },
        {
          type			  = "button",
          name			  = optionIndent_Button .. L.Joker_Quick_Btn_Joke, -- Random /joke
          tooltip			= L.Joker_Quick_Btn_Joke_Tip,
          func			  = function (context) Joker.AnyJoke() end,
          width			  = "half",
        },
        {
          type			  = "button",
          name			  = optionIndent_Button .. L.Joker_Quick_Btn_JokeESO, -- Random ESO
          tooltip			= L.Joker_Quick_Btn_JokeESO_Tip,
          func			  = function (context) Joker.Joke('ESO') end,
          width			  = "half",
        },
        {
          type			  = "button",
          name			  = optionIndent_Button .. L.Joker_Quick_Btn_JokeDad, -- Random Dad
          tooltip			= L.Joker_Quick_Btn_JokeDad_Tip,
          func			  = function (context) Joker.Joke('Dad') end,
          width			  = "half",
        },
        {
          type			  = "button",
          name			  = optionIndent_Button .. L.Joker_Quick_Btn_JokeEdgy, -- Random Edgy
          tooltip			= L.Joker_Quick_Btn_JokeEdgy_Tip,
          func			  = function (context) Joker.Joke('Edgy') end,
          width			  = "half",
        },
        {
          type			  = "button",
          name			  = optionIndent_Button .. L.Joker_Quick_Btn_JokeWisdom, -- Random Wisdom
          tooltip			= L.Joker_Quick_Btn_JokeWisdom_Tip,
          func			  = function (context) Joker.Joke('Wisdom') end,
          width			  = "half",
        },
        {
          type			  = "button",
          name			  = optionIndent_Button .. L.Joker_Quick_Btn_JokeNews, -- Random News
          tooltip			= L.Joker_Quick_Btn_JokeNews_Tip,
          func			  = function (context) Joker.Joke('News') end,
          width			  = "half",
        },
        {
          type			  = "button",
          name			  = optionIndent_Button .. L.Joker_Quick_Btn_JokeNorris, -- Random Norris
          tooltip			= L.Joker_Quick_Btn_JokeNorris_Tip,
          func			  = function (context) Joker.Joke('Norris') end,
          width			  = "half",
        },
        {
          type			  = "button",
          name			  = optionIndent_Button .. L.Joker_Quick_Btn_JokePokemon, -- Random Pokemon
          tooltip			= L.Joker_Quick_Btn_JokePokemon_Tip,
          func			  = function (context) Joker.Joke('Pokemon') end,
          width			  = "half",
        },
        {
          type			  = "button",
          name			  = optionIndent_Button .. L.Joker_Quick_Btn_JokePickup, -- Random pickup
          tooltip			= L.Joker_Quick_Btn_JokePickup_Tip,
          func			  = function (context) Joker.Joke('PickupLines') end,
          width			  = "half",
        },
        {
          type			  = "button",
          name			  = optionIndent_Button .. L.Joker_Quick_Btn_JokePickupHP, -- Random HP pickup
          tooltip			= L.Joker_Quick_Btn_JokePickupHP_Tip,
          func			  = function (context) Joker.Joke('PickupLinesHP') end,
          width			  = "half",
        },
        {
          type			  = "button",
          name			  = optionIndent_Button .. L.Joker_Quick_Btn_JokePickupPokemon, -- Random Pokemon pickup
          tooltip			= L.Joker_Quick_Btn_JokePickupPokemon_Tip,
          func			  = function (context) Joker.Joke('PickupLinesPokemon') end,
          width			  = "half",
        },
        {
          type			  = "button",
          name			  = optionIndent_Button .. L.Joker_Quick_Btn_JokePickupXXX, -- Random adult pickup
          tooltip			= L.Joker_Quick_Btn_JokePickupXXX_Tip,
          func			  = function (context) Joker.Joke('PickupLinesXXX') end,
          width			  = "half",
        },
        {
          type			  = "button",
          name			  = optionIndent_Button .. L.Joker_Quick_Btn_JokeBurn, -- Random burn
          tooltip			= L.Joker_Quick_Btn_JokeBurn_Tip,
          func			  = function (context) Joker.Joke('Burns') end,
          width			  = "half",
        },
        {
          type = "divider"
        },
        {
          type			  = "description",
          text			  = optionIndent .. L.Joker_QuickPop_Desc,
          width			  = "full",
        },
        {
          type			  = "button",
          name			  = optionIndent_Button .. L.Joker_Quick_Btn_JokeGoT, -- Random GoT
          tooltip			= L.Joker_Quick_Btn_JokeGoT_Tip,
          func			  = function (context) Joker.Joke('GameOfThrones') end,
          width			  = "half",
        },
        {
          type			  = "button",
          name			  = optionIndent_Button .. L.Joker_Quick_Btn_JokeStarWars, -- Random StarWars
          tooltip			= L.Joker_Quick_Btn_JokeStarWars_Tip,
          func			  = function (context) Joker.Joke('StarWars') end,
          width			  = "half",
        },
        {
          type = "divider"
        },
        {
          type			  = "description",
          text			  = optionIndent .. L.Joker_QuickUtil_Desc,
          width			  = "full",
        },
        {
          type			  = "button",
          name			  = optionIndent_Button .. L.Joker_Quick_Btn_Joke8Ball, -- 8ball
          tooltip			= L.Joker_Quick_Btn_Joke8Ball_Tip,
          func			  = function () Data.eightBall() end,
          width			  = "half",
        },
        {
          type			  = "button",
          name			  = optionIndent_Button .. L.Joker_Quick_Btn_JokeTwister, -- Random Twister
          tooltip			= L.Joker_Quick_Btn_JokeTwister_Tip,
          func			  = function (context) Joker.Joke('Twisters') end,
          width			  = "half",
        },
        {
          type			  = "button",
          name			  = optionIndent_Button .. L.Joker_Quick_Btn_JokeCatFact, -- Random CatFact
          tooltip			= L.Joker_Quick_Btn_JokeCatFact_Tip,
          func			  = function (context) Joker.Joke('Cat') end,
          width			  = "half",
        },
        {
          type			  = "button",
          name			  = optionIndent_Button .. L.Joker_Quick_Btn_JokeReady, -- Random /joke
          tooltip			= L.Joker_Quick_Btn_JokeReady_Tip,
          func			  = function () Data.readyCheck() end,
          width			  = "half",
        },
        {
          type = "divider",
        },
        {
          type = "description",
          text = L.Joker_More_Desc,
          title = Util.colorize(L.Joker_More_Title),
        }
      }
    })

    -- Legal
    table.insert(panelOptions, {
      type = "submenu",
      name = optionIndent_Title .. L.Joker_Legal_Title,
      tooltip	= "",
      controls		= {
        [1] = {
          type			  = "description",
          text			  = L.Joker_Legal_Desc
        }
      }
    })
    
    LAM:RegisterAddonPanel("Joker_Panel", panelData)
    LAM:RegisterOptionControls("Joker_Panel", panelOptions)
end
