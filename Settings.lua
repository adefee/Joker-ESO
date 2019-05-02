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
      }
    })

    -- /Slash Command Reference
    table.insert(panelOptions, {
      type = "submenu",
      name = Joker.Colorize(optionIndent_Title .. L.Joker_Commands_Title),
      tooltip	= "",
      controls		= {
        [1] = {
          type = "description",
          text = optionIndent .. Joker.Colorize('/joker') .. " shows this window!"
        },
        [2] = {
          type = "description",
          text = optionIndent .. Joker.Colorize('/joke') .. " adds a random joke to your chatbox. Random pool does not include Edgy jokes or pickup lines"
        },
        [3] = {
          type = "description",
          text = optionIndent .. Joker.Colorize('/joke-eso') .. " adds a random ESO-related joke to your chatbox."
        },
        [4] = {
          type = "description",
          text = optionIndent .. Joker.Colorize('/joke-dad ' .. L.Joker_Or ..' /dad') .. " adds a random Dad joke to your chatbox."
        },
        [5] = {
          type = "description",
          text = optionIndent .. Joker.Colorize('/joke-got') .. " adds a random Game of Thrones joke to your chatbox."
        },
        [6] = {
          type = "description",
          text = optionIndent .. Joker.Colorize('/joke-burn ' .. L.Joker_Or ..' /burn') .. " adds a random burn to your chatbox. If you include a name (target), it will address it to them for you!"
        },
        [7] = {
          type = "description",
          text = optionIndent .. Joker.Colorize('/joke-wisdom ' .. L.Joker_Or ..' /wisdom') .. " adds a random tidbit of wisdom (though sometimes a bit sarcastic) to your chatbox."
        },
        [8] = {
          type = "description",
          text = optionIndent .. Joker.Colorize('/joke-edgy') .. " adds a random edgy/explicit joke to your chatbox (added by popular request!). Note that these jokes have been flagged as particularly inappropriate or explicit and likely are not suitable for all audiences. Please be considerate with your usage."
        },
        [9] = {
          type = "description",
          text = optionIndent .. Joker.Colorize('/joke-norris ' .. L.Joker_Or ..' /norris') .. " adds a random Chuck Norris joke to your chatbox."
        },
        [10] = {
          type = "divider",
        },
        [11] = {
          type = "description",
          text = optionIndent .. Joker.Colorize('/joke-pickup ' .. L.Joker_Or ..' /pickup <target>') .. " adds a random cheesy/cute pickup line to your chatbox. If you include a name (target), it will address it to them for you!",
        },
        [12] = {
          type = "description",
          text = optionIndent .. Joker.Colorize('/pickup-xxx <target>') .. " adds a random adult/r-rated pickup line to your chatbox. Note that these jokes have been flagged as particularly inappropriate or explicit and likely are not suitable for all audiences. If you include a name (target), it will address it to them for you!",
        },
        [13] = {
          type = "description",
          text = optionIndent .. Joker.Colorize('/pickup-hp <target>') .. " adds a random Harry Potter pickup line to your chatbox. If you include a name (target), it will address it to them for you!",
        },
        [14] = {
          type = "divider",
        },
        [15] = {
          type = "description",
          text = optionIndent .. Joker.Colorize('/8ball <question>') .. ": Undecided? Get quality life advice from the magic 8ball! Asking the question is optional :)",
        },
        [16] = {
          type = "description",
          text = optionIndent .. Joker.Colorize('/catfact') .. ": Get a random Khaji--err, cat fact in your chatbox. Sometimes they're true!",
        },
        [17] = {
          type = "divider",
        },
        [18] = {
          type = "description",
          text = optionIndent .. Joker.Colorize('/ready') .. ": Ready checks, but funnier & faster to type! Ready checks your group with a random, witty message or meme! Leeerrrooyyyyy Jeeenkins!'",
        },
        [19] = {
          type = "description",
          text = optionIndent .. Joker.Colorize('/ready <message>') .. ": Inside joke, or funnier than Joker? Ready check your group with your own custom message!",
        },
        [20] = {
          type = "divider",
        },
        [21] = {
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


    -- Legal
    table.insert(panelOptions, {
      type = "submenu",
      name = optionIndent_Title .. L.Joker_Legal_Title,
      tooltip	= "",
      controls		= {
        [1] = {
          type			  = "button",
          name			  = optionIndent_Button .. L.Joker_Options_Periodic, -- Random /joke
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
      }
    })

    -- table.insert(optionsTable, {
    --   type = "header",
    --   name = ZO_HIGHLIGHT_TEXT:Colorize("Author Notes"),
    --   width = "full",	--or "half" (optional)
    -- })

    -- -- Requests Note
    -- table.insert(optionsTable, {
    --   type = "description",
    --   title = Joker.Colorize("Want more jokes?"),
    --   text = "More fun-, pop-culture- and leisure-minded options (such as GoT jokes, popular memes, riddles, and more) are expected to be added in future releases. Bug reports, requests & suggestions are always enthusiastically welcomed! Whisper me ingame (NA @CallMeLent), or get in touch via esoui.com, Twitter (@adefee), or Github (@adefee).",
    --   width = "full",	--or "half" (optional)
    -- })

    -- -- Copyright Note
    -- table.insert(optionsTable, {
    --   type = "description",
    --   title = Joker.Colorize("Sources, Copyrights, etc"),
    --   text = "I want to emphasize that the jokes contained in this addon are (for the most part) not my own, but rather are originally sourced from various public internet sources. I claim no ownership of the content, and make no profit from this addon or any content therein. If there are any copyright, trademark, DMCA, or other legal issues please reach out at me@andrewdefee.com and I'll comply as quickly and accurately as I can within the scope of US law. I'm just trying to share a few laughs - after all, what good is a joke if it's not shared?",
    --   width = "full",	--or "half" (optional)
    -- })
    
    LAM:RegisterAddonPanel("Joker_Panel", panelData)
    LAM:RegisterOptionControls("Joker_Panel", panelOptions)
end
