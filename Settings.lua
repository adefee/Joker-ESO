Joker = Joker or {}
local L = Joker.locale

-- Settings menu.
function Joker.LoadSettings()
    local LAM = LibAddonMenu2 or LibStub("LibAddonMenu-2.0")

    local panelData = {
        type = "panel",
        name = L.Joker_Title,
        displayName = Joker.Colorize(L.Joker_Title),
        author = Joker.Colorize(Joker.author, "AA00FF"),
        version = Joker.Colorize(Joker.version, "AA00FF"),
        slashCommand = "/joker",
        registerForRefresh = true,
        registerForDefaults = true,
    }

    local panelOptions = {}
    local optionIndent = "   " -- Spacer/indent for submenu options
    local optionIndent_Title = " " -- Spacer/indent for submenu titles
    local optionIndent_Button = "" -- Spacer/indent for buttons

    --[[
      Intro Section
    ]]

    table.insert(panelOptions, {
      type = "description",
      text = L.Joker_Intro_Status_Prefix .. " " .. Joker.Colorize(Joker.formatNumber(Joker.savedVariables.CountSeenJokesTotal)) .. " " .. L.Joker_Of .. " " .. Joker.Colorize(Joker.formatNumber(Joker.savedVariables.CountJokesTotal)) .. " " .. L.Joker_Intro_Status_Suffix,
      width = "full",
    })


     -- Joker Options
     table.insert(panelOptions, {
      type = "submenu",
      name = optionIndent_Title .. L.Joker_Options_Title,
      tooltip	= "",
      controls		= {
        [1] = {
          type			  = "checkbox",
          name			  = optionIndent .. L.Joker_Options_Periodic, -- Toggles Periodic Jokes
          tooltip			= L.Joker_Options_Periodic_Tip,
          getFunc			= function() return Joker.savedVariables.PeriodicJokes end,
          setFunc			= function(value) Joker.togglePeriodicJokes(value) end,
          width			  = "full",
          default			= Joker.savedVariables.PeriodicJokes,
        },
        [2] = {
          type			  = "slider",
          name			  = optionIndent .. L.Joker_Options_PeriodicFrequency,
          tooltip			= L.Joker_Options_PeriodicFrequency_Tip,
          min         = 1,
          max         = 25,
          step        = 5,
          getFunc			= function() return Joker.savedVariables.PeriodicFrequency end,
          setFunc			= function(value) Joker.savedVariables.PeriodicFrequency = value end,
          width			  = "full",
          default			= Joker.savedVariables.PeriodicFrequency,
          disabled    = function() return not Joker.savedVariables.PeriodicJokes end,
        },
        [3] = {
          type = "divider",
        },
        [4] = {
          type			  = "editbox",
          name			  = optionIndent .. L.Joker_Options_RandomPool,
          tooltip			= L.Joker_Options_RandomPool_Tip,
          getFunc     = function() return Joker.savedVariables.RandomPool end,
          setFunc     = function(value) d(value); Joker.savedVariables.RandomPool = value end,
          warning     = Joker.savedVariables.RandomPool_Warning,
          default     = Joker.savedVariables.RandomPool_Default,
          disabled    = function() return true end
        },
        [5] = {
          type			  = "description",
          title       = optionIndent .. Joker.Colorize(L.Joker_Options_RandomPool_Types .. ":"),
        },
        [6] = {
          type			  = "description",
          text			  = optionIndent .. Joker.Colorize(L.Joker_Options_RandomPool_Types_Default .. ": ", "AA00FF") .. Joker.savedVariables.RandomPool_Default,
        },
        [7] = {
          type			  = "description",
          text			  = optionIndent .. Joker.Colorize(L.Joker_Options_RandomPool_Types_Available .. ": ") .. "Edgy, Pickup, PickupXXX, PickupHP, Burn, GoT",
          tooltip     = L.Joker_Options_RandomPool_Types_Available_Tip
        }
      }
    })

    -- /Slash Command Reference
    table.insert(panelOptions, {
      type = "submenu",
      name = Joker.Colorize(optionIndent_Title .. L.Joker_Commands_Title),
      tooltip	= "",
      controls		= {
        [1] = {
          type = "header",
          name = optionIndent .. L.Joker_Quick_Btn_Joke_Slash, 
        },
        [2] = {
          type = "description",
          text = optionIndent .. Joker.Colorize('/joker ') .. L.Joker_Quick_Btn_Joker
        },
        [3] = {
          type = "description",
          text = optionIndent .. Joker.Colorize('/joke ') .. L.Joker_Quick_Btn_Joke_Tip
        },
        [4] = {
          type = "description",
          text = optionIndent .. Joker.Colorize('/joke-eso ') .. L.Joker_Quick_Btn_JokeESO_Tip
        },
        [5] = {
          type = "description",
          text = optionIndent .. Joker.Colorize('/joke-dad ' .. L.Joker_Or ..' /dad ') .. L.Joker_Quick_Btn_JokeDad_Tip
        },
        [6] = {
          type = "description",
          text = optionIndent .. Joker.Colorize('/joke-got ') .. L.Joker_Quick_Btn_JokeGoT_Tip
        },
        [7] = {
          type = "description",
          text = optionIndent .. Joker.Colorize('/joke-starwars ' .. L.Joker_Or ..' /starwars ') .. L.Joker_Quick_Btn_JokeStarWars_Tip
        },
        [8] = {
          type = "description",
          text = optionIndent .. Joker.Colorize('/joke-burn ' .. L.Joker_Or ..' /burn <target>') .. L.Joker_Quick_Btn_JokeBurn_Tip_Advanced
        },
        [9] = {
          type = "description",
          text = optionIndent .. Joker.Colorize('/joke-wisdom ' .. L.Joker_Or ..' /wisdom ') .. L.Joker_Quick_Btn_JokeWisdom_Tip
        },
        [10] = {
          type = "description",
          text = optionIndent .. Joker.Colorize('/joke-edgy ') .. L.Joker_Quick_Btn_JokeEdgy_Tip
        },
        [11] = {
          type = "description",
          text = optionIndent .. Joker.Colorize('/joke-norris ' .. L.Joker_Or ..' /norris ') .. L.Joker_Quick_Btn_JokeNorris_Tip
        },
        [12] = {
          type = "header",
          name = optionIndent .. L.Joker_Quick_Btn_JokePickup_Slash, 
        },
        [13] = {
          type = "description",
          text = optionIndent .. Joker.Colorize('/joke-pickup ' .. L.Joker_Or ..' /pickup <target> ') .. L.Joker_Quick_Btn_JokePickup_Tip_Advanced,
        },
        [14] = {
          type = "description",
          text = optionIndent .. Joker.Colorize('/pickup-xxx <target> ') .. L.Joker_Quick_Btn_JokePickupXXX_Tip_Advanced,
        },
        [15] = {
          type = "description",
          text = optionIndent .. Joker.Colorize('/pickup-hp <target> ') .. L.Joker_Quick_Btn_JokePickupHP_Tip_Advanced,
        },
        [16] = {
          type = "header",
          name = optionIndent .. L.Joker_Quick_Btn_Other_Slash, 
        },
        [17] = {
          type = "description",
          text = optionIndent .. Joker.Colorize('/8ball <question> ') .. L.Joker_Quick_Btn_Joke8Ball_Tip,
        },
        [18] = {
          type = "description",
          text = optionIndent .. Joker.Colorize('/catfact ') .. L.Joker_Quick_Btn_JokeCatFact_Tip,
        },
        [19] = {
          type = "header",
          name = optionIndent .. L.Joker_Quick_Btn_JokeReady_Slash, 
        },
        [20] = {
          type = "description",
          text = optionIndent .. Joker.Colorize('/ready ') .. L.Joker_Quick_Btn_JokeReady_Tip,
        },
        [21] = {
          type = "description",
          text = optionIndent .. Joker.Colorize('/ready <message> ') .. L.Joker_Quick_Btn_JokeReady_Tip_Advanced,
        },
        [22] = {
          type = "description",
          text = optionIndent .. Joker.Colorize('/ready <voteType> <message> ') .. L.Joker_Quick_Btn_JokeReady_Tip_Advanced_Vote,
        },
        [23] = {
          type = "divider",
        },
        [24] = {
          type = "description",
          text = optionIndent .. Joker.Colorize('More tomfoolery coming soon!'),
        }
      }
    })

    -- Quick Commands
    table.insert(panelOptions, {
      type			  = "header",
      name			  = L.Joker_Quick_Subtitle, 
      width			  = "full",
    })

    table.insert(panelOptions, {
      type			  = "description",
      text			  = L.Joker_Quick_Desc,
      width			  = "full",
    })

    -- Quick Command Buttons
    table.insert(panelOptions, {
      type			  = "button",
      name			  = optionIndent_Button .. L.Joker_Quick_Btn_Joke, -- Random /joke
      tooltip			= L.Joker_Quick_Btn_Joke_Tip,
      func			  = Joker.AnyJoke,
      width			  = "half",
    })
    table.insert(panelOptions, {
      type			  = "button",
      name			  = optionIndent_Button .. L.Joker_Quick_Btn_JokeESO, -- Random /joke
      tooltip			= L.Joker_Quick_Btn_JokeESO_Tip,
      func			  = Joker.ESO,
      width			  = "half",
    })
    table.insert(panelOptions, {
      type			  = "button",
      name			  = optionIndent_Button .. L.Joker_Quick_Btn_JokeDad, -- Random /joke
      tooltip			= L.Joker_Quick_Btn_JokeDad_Tip,
      func			  = Joker.Dad,
      width			  = "half",
    })
    table.insert(panelOptions, {
      type			  = "button",
      name			  = optionIndent_Button .. L.Joker_Quick_Btn_JokeEdgy, -- Random /joke
      tooltip			= L.Joker_Quick_Btn_JokeEdgy_Tip,
      func			  = Joker.Edgy,
      width			  = "half",
    })
    table.insert(panelOptions, {
      type			  = "button",
      name			  = optionIndent_Button .. L.Joker_Quick_Btn_JokeWisdom, -- Random /joke
      tooltip			= L.Joker_Quick_Btn_JokeWisdom_Tip,
      func			  = Joker.Wisdom,
      width			  = "half",
    })
    table.insert(panelOptions, {
      type			  = "button",
      name			  = optionIndent_Button .. L.Joker_Quick_Btn_JokeNorris, -- Random /joke
      tooltip			= L.Joker_Quick_Btn_JokeNorris_Tip,
      func			  = Joker.Norris,
      width			  = "half",
    })
    table.insert(panelOptions, {
      type			  = "button",
      name			  = optionIndent_Button .. L.Joker_Quick_Btn_JokePickup, -- Random /joke
      tooltip			= L.Joker_Quick_Btn_JokePickup_Tip,
      func			  = Joker.Pickup,
      width			  = "half",
    })
    table.insert(panelOptions, {
      type			  = "button",
      name			  = optionIndent_Button .. L.Joker_Quick_Btn_JokePickupHP, -- Random /joke
      tooltip			= L.Joker_Quick_Btn_JokePickupHP_Tip,
      func			  = Joker.PickupHP,
      width			  = "half",
    })
    table.insert(panelOptions, {
      type			  = "button",
      name			  = optionIndent_Button .. L.Joker_Quick_Btn_JokePickupXXX, -- Random /joke
      tooltip			= L.Joker_Quick_Btn_JokePickupXXX_Tip,
      func			  = Joker.PickupXXX,
      width			  = "half",
    })
    table.insert(panelOptions, {
      type			  = "button",
      name			  = optionIndent_Button .. L.Joker_Quick_Btn_JokeBurn, -- Random /joke
      tooltip			= L.Joker_Quick_Btn_JokeBurn_Tip,
      func			  = Joker.Burn,
      width			  = "half",
    })

    -- Pop Culture
    table.insert(panelOptions, {
      type = "divider"
    })
    table.insert(panelOptions, {
      type			  = "description",
      text			  = L.Joker_QuickPop_Desc,
      width			  = "full",
    })
    table.insert(panelOptions, {
      type			  = "button",
      name			  = optionIndent_Button .. L.Joker_Quick_Btn_JokeGoT, -- Random /joke
      tooltip			= L.Joker_Quick_Btn_JokeGoT_Tip,
      func			  = Joker.GoT,
      width			  = "half",
    })
    table.insert(panelOptions, {
      type			  = "button",
      name			  = optionIndent_Button .. L.Joker_Quick_Btn_JokeStarWars, -- Random /joke
      tooltip			= L.Joker_Quick_Btn_JokeStarWars_Tip,
      func			  = Joker.StarWars,
      width			  = "half",
    })
    
    -- Other/Utility Quick Commands
    table.insert(panelOptions, {
      type = "divider"
    })
    table.insert(panelOptions, {
      type			  = "description",
      text			  = L.Joker_QuickUtil_Desc,
      width			  = "full",
    })
    table.insert(panelOptions, {
      type			  = "button",
      name			  = optionIndent_Button .. L.Joker_Quick_Btn_Joke8Ball, -- Random /joke
      tooltip			= L.Joker_Quick_Btn_Joke8Ball_Tip,
      func			  = Joker.eightBall,
      width			  = "half",
    })
    table.insert(panelOptions, {
      type			  = "button",
      name			  = optionIndent_Button .. L.Joker_Quick_Btn_JokeTwister, -- Random /joke
      tooltip			= L.Joker_Quick_Btn_JokeTwister_Tip,
      func			  = Joker.Twister,
      width			  = "half",
    })
    table.insert(panelOptions, {
      type			  = "button",
      name			  = optionIndent_Button .. L.Joker_Quick_Btn_JokeCatFact, -- Random /joke
      tooltip			= L.Joker_Quick_Btn_JokeCatFact_Tip,
      func			  = Joker.Cat,
      width			  = "half",
    })
    table.insert(panelOptions, {
      type			  = "button",
      name			  = optionIndent_Button .. L.Joker_Quick_Btn_JokeReady, -- Random /joke
      tooltip			= L.Joker_Quick_Btn_JokeReady_Tip,
      func			  = Joker.readyCheck,
      width			  = "half",
    })

    -- Want more jokes?
    table.insert(panelOptions, {
      type = "divider",
    })
    table.insert(panelOptions, {
      type = "description",
      text = L.Joker_More_Desc,
      title = Joker.Colorize(L.Joker_More_Title),
    })

    table.insert(panelOptions, {
      type = "divider",
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
