-- Settings menu.
function Joker.LoadSettings()
    local LAM = LibStub("LibAddonMenu-2.0")

    local panelData = {
        type = "panel",
        name = Joker.menuName,
        displayName = Joker.Colorize(Joker.menuName),
        author = Joker.Colorize(Joker.author, "D66E4A"),
        version = Joker.Colorize(Joker.version, "AA00FF"),
        slashCommand = "/joker",
        registerForRefresh = true,
        registerForDefaults = true,
    }
    LAM:RegisterAddonPanel(Joker.menuName, panelData)

    local optionsTable = {}

    table.insert(optionsTable, {
      type = "header",
      name = ZO_HIGHLIGHT_TEXT:Colorize("Joker Options"),
      width = "full",	--or "half" (optional)
    })

    -- General Info Note
    table.insert(optionsTable, {
      type = "description",
      title = "GUI options soon! Version 1 includes the following slash (/) commands:",
      text = "'/joker' shows this window!",
      width = "full",	--or "half" (optional)
    })
    table.insert(optionsTable, {
      type = "description",
      text = "'/joke' adds a random joke to your chatbox",
      width = "full",	--or "half" (optional)
    })
    table.insert(optionsTable, {
      type = "description",
      text = "'/eso' adds a random ESO-related joke to your chatbox",
      width = "full",	--or "half" (optional)
    })
    table.insert(optionsTable, {
      type = "description",
      text = "'/norris' adds a random Chuck Norris joke to your chatbox",
      width = "full",	--or "half" (optional)
    })
    table.insert(optionsTable, {
      type = "description",
      text = "'/norris me' adds a random joke to your chatbox featuring none other than you!, /n '/norris <target>' adds a random joke to your chatbox, using any text as the subject!",
      width = "full",	--or "half" (optional)
    })
    table.insert(optionsTable, {
      type = "description",
      text = "'/norris <target>' adds a random joke to your chatbox, using any text as the subject!",
      width = "full",	--or "half" (optional)
    })

    table.insert(optionsTable, {
      type = "header",
      name = ZO_HIGHLIGHT_TEXT:Colorize("Author Notes"),
      width = "full",	--or "half" (optional)
    })

    -- Requests Note
    table.insert(optionsTable, {
      type = "description",
      title = "Want more jokes?",
      text = "More fun-, pop-culture- and leisure-minded options (such as GoT jokes, popular memes, riddles, and more) are expected to be added in future releases. Bug reports, requests & suggestions are always enthusiastically welcomed! Whisper me ingame (NA @CallMeLent), or get in touch via esoui.com, Twitter (@adefee), or Github (@adefee).",
      width = "full",	--or "half" (optional)
    })

    -- Copyright Note
    table.insert(optionsTable, {
      type = "description",
      title = "Sources, Copyrights, etc",
      text = "The current version of this addon includes 545+ jokes! I want to emphasize that the jokes contained in this addon are (for the most part) not my own, but rather are originally sourced from various public internet sources. I claim no ownership of the content, and make no money from this addon or any content therein. If there are any copyright, trademark, DMCA, or other legal issues please reach out at me@andrewdefee.com and I'll comply as quickly and accurately as I can within the scope of US law. I'm just trying to share a few laughs - after all, what good is a joke if it's not shared?",
      width = "full",	--or "half" (optional)
    })
    
    LAM:RegisterOptionControls(Joker.menuName, optionsTable)
end
