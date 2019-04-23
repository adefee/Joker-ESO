-- Settings menu.
function Joker.LoadSettings()
    local LAM = LibStub("LibAddonMenu-2.0")

    local panelData = {
        type = "panel",
        name = Joker.menuName,
        displayName = Joker.Colorize(Joker.menuName),
        author = Joker.Colorize(Joker.author, "AA00FF"),
        version = Joker.Colorize(Joker.version, "AA00FF"),
        slashCommand = "/joker",
        registerForRefresh = true,
        registerForDefaults = true,
    }
    LAM:RegisterAddonPanel(Joker.menuName, panelData)

    local optionsTable = {}

    table.insert(optionsTable, {
      type = "description",
      text = "You've viewed " .. Joker.Colorize(Joker.formatNumber(Joker.savedVariables.CountSeenJokesTotal)) .. " of " .. Joker.Colorize(Joker.formatNumber(Joker.savedVariables.CountJokesTotal)) .. " loaded jokes, wisdom, fun facts, & more!",
      width = "full",	--or "half" (optional)
    })

    table.insert(optionsTable, {
      type = "header",
      name = ZO_HIGHLIGHT_TEXT:Colorize("Joker Options"),
      width = "full",	--or "half" (optional)
    })

    -- General Info Note
    table.insert(optionsTable, {
      type = "description",
      title = "GUI options soon! Version 2 includes the following slash (/) commands:",
      width = "full",	--or "half" (optional)
    })
    table.insert(optionsTable, {
      type = "description",
      text = Joker.Colorize('/joker') .. " shows this window!",
      width = "full",	--or "half" (optional)
    })
    table.insert(optionsTable, {
      type = "description",
      text = Joker.Colorize('/joke') .. " adds a random joke to your chatbox. Random pool does not include Edgy jokes or pickup lines",
      width = "full",	--or "half" (optional)
    })
    table.insert(optionsTable, {
      type = "description",
      text = Joker.Colorize('/joke-eso') .. " adds a random ESO-related joke to your chatbox.",
      width = "full",	--or "half" (optional)
    })
    table.insert(optionsTable, {
      type = "description",
      text = Joker.Colorize('/joke-dad or /dad') .. " adds a random Dad joke to your chatbox.",
      width = "full",	--or "half" (optional)
    })
    table.insert(optionsTable, {
      type = "description",
      text = Joker.Colorize('/joke-got') .. " adds a random Game of Thrones joke to your chatbox.",
      width = "full",	--or "half" (optional)
    })
    table.insert(optionsTable, {
      type = "description",
      text = Joker.Colorize('/joke-burn or /burn') .. " adds a random burn to your chatbox. If you include a name (target), it will address it to them for you!",
      width = "full",	--or "half" (optional)
    })
    table.insert(optionsTable, {
      type = "description",
      text = Joker.Colorize('/joke-wisdom or /wisdom') .. " adds a random tidbit of wisdom (though sometimes a bit sarcastic) to your chatbox.",
      width = "full",	--or "half" (optional)
    })
    table.insert(optionsTable, {
      type = "description",
      text = Joker.Colorize('/joke-edgy') .. " adds a random edgy/explicit joke to your chatbox (added by popular request!). Note that these jokes have been flagged as particularly inappropriate or explicit and likely are not suitable for all audiences. Please be considerate with your usage.",
      width = "full",	--or "half" (optional)
    })
    table.insert(optionsTable, {
      type = "description",
      text = Joker.Colorize('/joke-norris or /norris') .. " adds a random Chuck Norris joke to your chatbox.",
      width = "full",	--or "half" (optional)
    })
    table.insert(optionsTable, {
      type = "description",
      text = Joker.Colorize('/norris me') .. " adds a random Norris joke to your chatbox, but replaces Chuck's name with your own!",
      width = "full",	--or "half" (optional)
    })
    table.insert(optionsTable, {
      type = "description",
      text = Joker.Colorize('/norris <target>') .. " adds a random Norris joke to your chatbox, but replaces Chuck's name with your custom text!",
      width = "full",	--or "half" (optional)
    })
    table.insert(optionsTable, {
      type = "description",
      text = Joker.Colorize('/joke-pickup or /pickup <target>') .. " adds a random cheesy/cute pickup line to your chatbox. If you include a name (target), it will address it to them for you!",
      width = "full",	--or "half" (optional)
    })
    table.insert(optionsTable, {
      type = "description",
      text = Joker.Colorize('/pickup-xxx <target>') .. " adds a random adult/r-rated pickup line to your chatbox. Note that these jokes have been flagged as particularly inappropriate or explicit and likely are not suitable for all audiences. If you include a name (target), it will address it to them for you!",
      width = "full",	--or "half" (optional)
    })
    table.insert(optionsTable, {
      type = "description",
      text = Joker.Colorize('/pickup-hp <target>') .. " adds a random Harry Potter pickup line to your chatbox. If you include a name (target), it will address it to them for you!",
      width = "full",	--or "half" (optional)
    })
    table.insert(optionsTable, {
      type = "description",
      text = Joker.Colorize('/8ball <question>') .. ": Undecided? Get quality life advice from the magic 8ball! Asking the question is optional :)",
      width = "full",	--or "half" (optional)
    })
    table.insert(optionsTable, {
      type = "description",
      text = Joker.Colorize('/catfact') .. ": Get a random Khaji--err, cat fact in your chatbox. Sometimes they're true!",
      width = "full",	--or "half" (optional)
    })
    table.insert(optionsTable, {
      type = "description",
      text = Joker.Colorize('/ready') .. ": Ready checks, but funnier & faster to type! Get a random, witty ready check or ptionally include your own custom prompt with '/ready <yourtext>'",
      width = "full",	--or "half" (optional)
    })
    table.insert(optionsTable, {
      type = "description",
      title = "Show me jokes periodically? " .. Joker.Colorize(Joker.savedVariables.PeriodicJokes),
      text = Joker.Colorize('/joke-auto') .. ": Joker can periodically post a joke to your chat window! Run this command to toggle on/off. Note: toggling takes immediate affect, but may require UI reload to update the status you see here.",
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
      title = Joker.Colorize("Want more jokes?"),
      text = "More fun-, pop-culture- and leisure-minded options (such as GoT jokes, popular memes, riddles, and more) are expected to be added in future releases. Bug reports, requests & suggestions are always enthusiastically welcomed! Whisper me ingame (NA @CallMeLent), or get in touch via esoui.com, Twitter (@adefee), or Github (@adefee).",
      width = "full",	--or "half" (optional)
    })

    -- Copyright Note
    table.insert(optionsTable, {
      type = "description",
      title = Joker.Colorize("Sources, Copyrights, etc"),
      text = "I want to emphasize that the jokes contained in this addon are (for the most part) not my own, but rather are originally sourced from various public internet sources. I claim no ownership of the content, and make no profit from this addon or any content therein. If there are any copyright, trademark, DMCA, or other legal issues please reach out at me@andrewdefee.com and I'll comply as quickly and accurately as I can within the scope of US law. I'm just trying to share a few laughs - after all, what good is a joke if it's not shared?",
      width = "full",	--or "half" (optional)
    })
    
    LAM:RegisterOptionControls(Joker.menuName, optionsTable)
end
