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
    d('Joker: ' .. i .. ', ' .. v)

    -- Don't add specific things
    if v ~= 'ReadyChecks' and v ~= 'MyCustomJokes' then
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
      text = Util.colorize(Util.formatNumber(Joker.saved.count.loaded)) .. " " .. L.Joker_Intro_Status_Suffix,
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


     -- Joker Options
    -- table.insert(panelOptions, {
    --   type = "submenu",
    --   name = optionIndent_Title .. L.Joker_Options_Title,
    --   tooltip	= "",
    --   controls		= {
    --     [1] = {
    --       type			  = "checkbox",
    --       name			  = optionIndent .. L.Joker_Options_Periodic, -- Toggles Periodic Jokes
    --       tooltip			= L.Joker_Options_Periodic_Tip,
    --       getFunc			= function() return Joker.savedVariables.periodicJokes end,
    --       setFunc			= function(value) Data.togglePeriodicJokes(value) end,
    --       width			  = "full",
    --       default			= Joker.savedVariables.periodicJokes,
    --     },
    --     [2] = {
    --       type			  = "slider",
    --       name			  = optionIndent .. L.Joker_Options_PeriodicFrequency,
    --       tooltip			= L.Joker_Options_PeriodicFrequency_Tip,
    --       min         = 1,
    --       max         = 25,
    --       step        = 1,
    --       getFunc			= function() return Joker.savedVariables.periodicFrequency end,
    --       setFunc			= function(value) Joker.savedVariables.periodicFrequency = value end,
    --       width			  = "full",
    --       default			= Joker.savedVariables.periodicFrequency,
    --       disabled    = function() return not Joker.savedVariables.periodicJokes end,
    --     },
    --     [3] = {
    --       type = "divider",
    --     },
    --     [4] = {
    --       type			  = "editbox",
    --       name			  = optionIndent .. L.Joker_Options_RandomPool,
    --       tooltip			= L.Joker_Options_RandomPool_Tip,
    --       getFunc     = function() return Data.getRandomPool() end,
    --       setFunc     = function(value) Data.setRandomPool(value) end,
    --       warning     = L.Joker_Options_RandomPool_Warning,
    --       -- default     = Joker.savedVariables.randomPoolDefault,
    --       -- disabled    = function() return true end
    --     },
    --     [5] = {
    --       type			  = "description",
    --       title       = optionIndent .. Util.colorize(L.Joker_Options_RandomPool_Types .. ":"),
    --     },
    --     [6] = {
    --       type			  = "description",
    --       text			  = optionIndent .. Util.colorize(L.Joker_Options_RandomPool_Types_Default .. ": ", "AA00FF") .. Joker.savedVariables.randomPoolDefault,
    --     },
    --     [7] = {
    --       type			  = "description",
    --       text			  = optionIndent .. Util.colorize(L.Joker_Options_RandomPool_Types_Available .. ": ") .. Joker.savedVariables.randomPoolAvailable,
    --       tooltip     = L.Joker_Options_RandomPool_Types_Available_Tip
    --     }
    --   }
    -- })

    -- /Slash Command Reference
    -- table.insert(panelOptions, {
    --   type = "submenu",
    --   name = Util.colorize(optionIndent_Title .. L.Joker_Commands_Title),
    --   tooltip	= "",
    --   controls		= {
    --     {
    --       type = "header",
    --       name = optionIndent .. L.Joker_Quick_Btn_Joke_Slash, 
    --     },
    --     {
    --       type = "description",
    --       text = optionIndent .. Util.colorize('/joker ') .. L.Joker_Quick_Btn_Joker
    --     },
    --     {
    --       type = "description",
    --       text = optionIndent .. Util.colorize('/joke ') .. L.Joker_Quick_Btn_Joke_Tip
    --     },
    --     {
    --       type = "description",
    --       text = optionIndent .. Util.colorize('/joke-eso ') .. L.Joker_Quick_Btn_JokeESO_Tip
    --     },
    --     {
    --       type = "description",
    --       text = optionIndent .. Util.colorize('/joke-dad ' .. L.Joker_Or ..' /dad ') .. L.Joker_Quick_Btn_JokeDad_Tip
    --     },
    --     {
    --       type = "description",
    --       text = optionIndent .. Util.colorize('/joke-got ') .. L.Joker_Quick_Btn_JokeGoT_Tip
    --     },
    --     {
    --       type = "description",
    --       text = optionIndent .. Util.colorize('/joke-starwars ' .. L.Joker_Or ..' /starwars ') .. L.Joker_Quick_Btn_JokeStarWars_Tip
    --     },
    --     {
    --       type = "description",
    --       text = optionIndent .. Util.colorize('/joke-burn ' .. L.Joker_Or ..' /burn <target>') .. L.Joker_Quick_Btn_JokeBurn_Tip_Advanced
    --     },
    --     {
    --       type = "description",
    --       text = optionIndent .. Util.colorize('/joke-wisdom ' .. L.Joker_Or ..' /wisdom ') .. L.Joker_Quick_Btn_JokeWisdom_Tip
    --     },
    --     {
    --       type = "description",
    --       text = optionIndent .. Util.colorize('/joke-pokemon ' .. L.Joker_Or ..' /pokemon ') .. L.Joker_Quick_Btn_JokePokemon_Tip
    --     },
    --     {
    --       type = "description",
    --       text = optionIndent .. Util.colorize('/joke-edgy ') .. L.Joker_Quick_Btn_JokeEdgy_Tip
    --     },
    --     {
    --       type = "description",
    --       text = optionIndent .. Util.colorize('/joke-norris ' .. L.Joker_Or ..' /norris ') .. L.Joker_Quick_Btn_JokeNorris_Tip
    --     },
    --     {
    --       type = "header",
    --       name = optionIndent .. L.Joker_Quick_Btn_JokePickup_Slash, 
    --     },
    --     {
    --       type = "description",
    --       text = optionIndent .. Util.colorize('/joke-pickup ' .. L.Joker_Or ..' /pickup <target> ') .. L.Joker_Quick_Btn_JokePickup_Tip_Advanced,
    --     },
    --     {
    --       type = "description",
    --       text = optionIndent .. Util.colorize('/pickup-xxx <target> ') .. L.Joker_Quick_Btn_JokePickupXXX_Tip_Advanced,
    --     },
    --     {
    --       type = "description",
    --       text = optionIndent .. Util.colorize('/pickup-hp <target> ') .. L.Joker_Quick_Btn_JokePickupHP_Tip_Advanced,
    --     },
    --     {
    --       type = "description",
    --       text = optionIndent .. Util.colorize('/pickup-poke <target> ') .. L.Joker_Quick_Btn_JokePickupPokemon_Tip_Advanced,
    --     },
    --     {
    --       type = "header",
    --       name = optionIndent .. L.Joker_Quick_Btn_Other_Slash, 
    --     },
    --     {
    --       type = "description",
    --       text = optionIndent .. Util.colorize('/8ball <question> ') .. L.Joker_Quick_Btn_Joke8Ball_Tip,
    --     },
    --     {
    --       type = "description",
    --       text = optionIndent .. Util.colorize('/catfact ') .. L.Joker_Quick_Btn_JokeCatFact_Tip,
    --     },
    --     {
    --       type = "header",
    --       name = optionIndent .. L.Joker_Quick_Btn_JokeReady_Slash, 
    --     },
    --     {
    --       type = "description",
    --       text = optionIndent .. Util.colorize('/ready ') .. L.Joker_Quick_Btn_JokeReady_Tip,
    --     },
    --     {
    --       type = "description",
    --       text = optionIndent .. Util.colorize('/ready <message> ') .. L.Joker_Quick_Btn_JokeReady_Tip_Advanced,
    --     },
    --     {
    --       type = "description",
    --       text = optionIndent .. Util.colorize('/ready <voteType> <message> ') .. L.Joker_Quick_Btn_JokeReady_Tip_Advanced_Vote,
    --     },
    --     {
    --       type = "header",
    --       name = optionIndent .. L.Joker_Quick_Btn_JokeRolls_Title, 
    --     },
    --     {
    --       type = "description",
    --       text = optionIndent .. Util.colorize('/roll <options> ') .. L.Joker_Quick_Btn_JokeRolls_Tip,
    --     },
    --     {
    --       type = "description",
    --       text = optionIndent .. Util.colorize('/choose <options> ') .. L.Joker_Quick_Btn_JokeChoose_Tip,
    --     },
    --     {
    --       type = "divider",
    --     },
    --     {
    --       type = "description",
    --       text = optionIndent .. Util.colorize('More tomfoolery coming soon!'),
    --     }
    --   }
    -- })

    -- -- Quick Commands Submenu
    -- table.insert(panelOptions, {
    --   type = "submenu",
    --   name = optionIndent_Title .. L.Joker_Quick_Title,
    --   tooltip	= "",
    --   controls		= {
    --     {
    --       type			  = "header",
    --       name			  = optionIndent .. L.Joker_Quick_Subtitle, 
    --       width			  = "full",
    --     },
    --     {
    --       type			  = "description",
    --       text			  = optionIndent .. L.Joker_Quick_Desc, 
    --       width			  = "full",
    --     },
    --     {
    --       type			  = "button",
    --       name			  = optionIndent_Button .. L.Joker_Quick_Btn_Joke, -- Random /joke
    --       tooltip			= L.Joker_Quick_Btn_Joke_Tip,
    --       func			  = function (context) Joker.AnyJoke() end,
    --       width			  = "half",
    --     },
    --     {
    --       type			  = "button",
    --       name			  = optionIndent_Button .. L.Joker_Quick_Btn_JokeESO, -- Random ESO
    --       tooltip			= L.Joker_Quick_Btn_JokeESO_Tip,
    --       func			  = function (context) Joker.Joke('ESO') end,
    --       width			  = "half",
    --     },
    --     {
    --       type			  = "button",
    --       name			  = optionIndent_Button .. L.Joker_Quick_Btn_JokeDad, -- Random Dad
    --       tooltip			= L.Joker_Quick_Btn_JokeDad_Tip,
    --       func			  = function (context) Joker.Joke('Dad') end,
    --       width			  = "half",
    --     },
    --     {
    --       type			  = "button",
    --       name			  = optionIndent_Button .. L.Joker_Quick_Btn_JokeEdgy, -- Random Edgy
    --       tooltip			= L.Joker_Quick_Btn_JokeEdgy_Tip,
    --       func			  = function (context) Joker.Joke('Edgy') end,
    --       width			  = "half",
    --     },
    --     {
    --       type			  = "button",
    --       name			  = optionIndent_Button .. L.Joker_Quick_Btn_JokeWisdom, -- Random Wisdom
    --       tooltip			= L.Joker_Quick_Btn_JokeWisdom_Tip,
    --       func			  = function (context) Joker.Joke('Wisdom') end,
    --       width			  = "half",
    --     },
    --     {
    --       type			  = "button",
    --       name			  = optionIndent_Button .. L.Joker_Quick_Btn_JokeNorris, -- Random Norris
    --       tooltip			= L.Joker_Quick_Btn_JokeNorris_Tip,
    --       func			  = function (context) Joker.Joke('Norris') end,
    --       width			  = "half",
    --     },
    --     {
    --       type			  = "button",
    --       name			  = optionIndent_Button .. L.Joker_Quick_Btn_JokePokemon, -- Random Pokemon
    --       tooltip			= L.Joker_Quick_Btn_JokePokemon_Tip,
    --       func			  = function (context) Joker.Joke('Pokemon') end,
    --       width			  = "half",
    --     },
    --     {
    --       type			  = "button",
    --       name			  = optionIndent_Button .. L.Joker_Quick_Btn_JokePickup, -- Random pickup
    --       tooltip			= L.Joker_Quick_Btn_JokePickup_Tip,
    --       func			  = function (context) Joker.Joke('PickupLines') end,
    --       width			  = "half",
    --     },
    --     {
    --       type			  = "button",
    --       name			  = optionIndent_Button .. L.Joker_Quick_Btn_JokePickupHP, -- Random HP pickup
    --       tooltip			= L.Joker_Quick_Btn_JokePickupHP_Tip,
    --       func			  = function (context) Joker.Joke('PickupLinesHP') end,
    --       width			  = "half",
    --     },
    --     {
    --       type			  = "button",
    --       name			  = optionIndent_Button .. L.Joker_Quick_Btn_JokePickupPokemon, -- Random Pokemon pickup
    --       tooltip			= L.Joker_Quick_Btn_JokePickupPokemon_Tip,
    --       func			  = function (context) Joker.Joke('PickupLinesPokemon') end,
    --       width			  = "half",
    --     },
    --     {
    --       type			  = "button",
    --       name			  = optionIndent_Button .. L.Joker_Quick_Btn_JokePickupXXX, -- Random adult pickup
    --       tooltip			= L.Joker_Quick_Btn_JokePickupXXX_Tip,
    --       func			  = function (context) Joker.Joke('PickupLinesXXX') end,
    --       width			  = "half",
    --     },
    --     {
    --       type			  = "button",
    --       name			  = optionIndent_Button .. L.Joker_Quick_Btn_JokeBurn, -- Random burn
    --       tooltip			= L.Joker_Quick_Btn_JokeBurn_Tip,
    --       func			  = function (context) Joker.Joke('Burns') end,
    --       width			  = "half",
    --     },
    --     {
    --       type = "divider"
    --     },
    --     {
    --       type			  = "description",
    --       text			  = optionIndent .. L.Joker_QuickPop_Desc,
    --       width			  = "full",
    --     },
    --     {
    --       type			  = "button",
    --       name			  = optionIndent_Button .. L.Joker_Quick_Btn_JokeGoT, -- Random GoT
    --       tooltip			= L.Joker_Quick_Btn_JokeGoT_Tip,
    --       func			  = function (context) Joker.Joke('GameOfThrones') end,
    --       width			  = "half",
    --     },
    --     {
    --       type			  = "button",
    --       name			  = optionIndent_Button .. L.Joker_Quick_Btn_JokeStarWars, -- Random StarWars
    --       tooltip			= L.Joker_Quick_Btn_JokeStarWars_Tip,
    --       func			  = function (context) Joker.Joke('StarWars') end,
    --       width			  = "half",
    --     },
    --     {
    --       type = "divider"
    --     },
    --     {
    --       type			  = "description",
    --       text			  = optionIndent .. L.Joker_QuickUtil_Desc,
    --       width			  = "full",
    --     },
    --     {
    --       type			  = "button",
    --       name			  = optionIndent_Button .. L.Joker_Quick_Btn_Joke8Ball, -- 8ball
    --       tooltip			= L.Joker_Quick_Btn_Joke8Ball_Tip,
    --       func			  = Joker.EightBall,
    --       width			  = "half",
    --     },
    --     {
    --       type			  = "button",
    --       name			  = optionIndent_Button .. L.Joker_Quick_Btn_JokeTwister, -- Random Twister
    --       tooltip			= L.Joker_Quick_Btn_JokeTwister_Tip,
    --       func			  = function (context) Joker.Joke('Twisters') end,
    --       width			  = "half",
    --     },
    --     {
    --       type			  = "button",
    --       name			  = optionIndent_Button .. L.Joker_Quick_Btn_JokeCatFact, -- Random CatFact
    --       tooltip			= L.Joker_Quick_Btn_JokeCatFact_Tip,
    --       func			  = function (context) Joker.Joke('Cat') end,
    --       width			  = "half",
    --     },
    --     {
    --       type			  = "button",
    --       name			  = optionIndent_Button .. L.Joker_Quick_Btn_JokeReady, -- Random /joke
    --       tooltip			= L.Joker_Quick_Btn_JokeReady_Tip,
    --       func			  = Joker.ReadyCheck,
    --       width			  = "half",
    --     },
    --     {
    --       type = "divider",
    --     },
    --     {
    --       type = "description",
    --       text = L.Joker_More_Desc,
    --       title = Util.colorize(L.Joker_More_Title),
    --     }
    --   }
    -- })

    -- -- Legal
    -- table.insert(panelOptions, {
    --   type = "submenu",
    --   name = optionIndent_Title .. L.Joker_Legal_Title,
    --   tooltip	= "",
    --   controls		= {
    --     [1] = {
    --       type			  = "description",
    --       text			  = L.Joker_Legal_Desc
    --     }
    --   }
    -- })
    
    LAM:RegisterAddonPanel("Joker_Panel", panelData)
    LAM:RegisterOptionControls("Joker_Panel", panelOptions)
end
