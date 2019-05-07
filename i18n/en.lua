JokerL = JokerL or {}
local L = {}


--------------------------------------------------------------------------------------------------------------------
-- Locale: English (default for Joker)
--------------------------------------------------------------------------------------------------------------------

-- Basic / General
L.Joker_Title = "Joker - Best Enjoyed with Skooma!"
L.Joker_Or = "or"
L.Joker_And = "and"
L.Joker_Of = "of"
L.Joker_With = "with"

-- SECTION: Intro
L.Joker_Intro_Status_Prefix = "You've viewed"
L.Joker_Intro_Status_Suffix	= "loaded jokes, wisdom, fun facts, & more!"

-- SECTION: Quick Commands
L.Joker_Quick_Title = "Quick Commands"
L.Joker_Quick_Subtitle = "Click a button below to get a joke!"
L.Joker_Quick_Desc = "Joker will post a joke to your chatbox - just hit 'Enter' to send! Whenever possible, Joker will try to show you jokes you haven't seen before."
L.Joker_QuickPop_Desc = "Movies, TV, Pop Culture"
L.Joker_QuickUtil_Desc = "Other / Utility"

-- Quick Command Buttons (Jokes)
L.Joker_Quick_Btn_Joker = "Shows the Joker settings window (this window)"
L.Joker_Quick_Btn_Joke = "Any Joke"
L.Joker_Quick_Btn_Joke_Slash = "Jokes and Such"
L.Joker_Quick_Btn_Joke_Tip = "Retrieves a random joke of any kind (based on your Random Pool setting) and pastes in your chatbox!"
L.Joker_Quick_Btn_JokeESO = "ESO Joke"
L.Joker_Quick_Btn_JokeESO_Tip = "Adds a random ESO-related joke to your active chatbox."
L.Joker_Quick_Btn_JokeDad = "Dad Joke"
L.Joker_Quick_Btn_JokeDad_Tip = "Adds a random Dad joke to your active chatbox."
L.Joker_Quick_Btn_JokeGoT = "Game of Thrones"
L.Joker_Quick_Btn_JokeGoT_Tip = "Adds a random Game of Thrones joke to your active chatbox."
L.Joker_Quick_Btn_JokeStarWars = "Star Wars"
L.Joker_Quick_Btn_JokeStarWars_Tip = "Adds a random Star Wars joke to your active chatbox."
L.Joker_Quick_Btn_JokeWisdom = "Wisdom"
L.Joker_Quick_Btn_JokeWisdom_Tip = "Adds a random wisdom tidbit or shower thought to your active chatbox"
L.Joker_Quick_Btn_JokeEdgy = "Edgy Joke"
L.Joker_Quick_Btn_JokeEdgy_Tip = "Adds a random edgy joke to your active chatbox. Note that these jokes have been flagged as particularly inappropriate or explicit and likely are *not* suitable for all audiences. Please be considerate with your usage!"
L.Joker_Quick_Btn_JokeNorris = "Chuck Norris"
L.Joker_Quick_Btn_JokeNorris_Tip = "Adds a random Chuck Norris joke to your active chatbox."
L.Joker_Quick_Btn_JokePickup = "Pickup Line"
L.Joker_Quick_Btn_JokePickup_Slash = "Pickup Lines"
L.Joker_Quick_Btn_JokePickup_Tip = "Adds a random cheesy/cute pickup line to your active chatbox. See the /slash command for advanced options!"
L.Joker_Quick_Btn_JokePickup_Tip_Advanced = "Adds a random cheesy pickup line to your active chatbox. Optionally add a target to make them the subject!"
L.Joker_Quick_Btn_JokePickupXXX = "Pickup (Adult)"
L.Joker_Quick_Btn_JokePickupXXX_Tip = "Adds a random adult/r-rated pickup line to your active chatbox. Note that these jokes have been flagged as particularly inappropriate or explicit and likely are not suitable for all audiences. See the /slash command for advanced options!"
L.Joker_Quick_Btn_JokePickupXXX_Tip_Advanced = "Adds a random adult/r-rated pickup line to your active chatbox. Note that these jokes have been flagged as particularly inappropriate or explicit and likely are not suitable for all audiences. Optionally add a target to make them the subject!"
L.Joker_Quick_Btn_JokePickupHP = "Pickup (Harry Potter)"
L.Joker_Quick_Btn_JokePickupHP_Tip = "Adds a random Harry Potter pickup line to your active chatbox. See the /slash command for advanced options!"
L.Joker_Quick_Btn_JokePickupHP_Tip_Advanced = "Adds a random Harry Potter pickup line to your active chatbox. Optionally add a target to make them the subject!"
L.Joker_Quick_Btn_JokeBurn = "Burn"
L.Joker_Quick_Btn_JokeBurn_Tip = "Adds a random burn to your active chatbox. See the /slash command for advanced options!"
L.Joker_Quick_Btn_JokeBurn_Tip_Advanced = "Adds a random burn to your active chatbox. Optionally add a target to make them the subject!"


-- Quick Command Buttons (Other/Utility)
L.Joker_Quick_Btn_Other_Slash = "Other Fun Commands"
L.Joker_Quick_Btn_Joke8Ball = "8ball"
L.Joker_Quick_Btn_Joke8Ball_Tip = "Undecided? Get advice from the sage 8ball."
L.Joker_Quick_Btn_JokeTwister = "Tongue Twister"
L.Joker_Quick_Btn_JokeTwister_Tip = "Get a random tongue twister! Can you say it 3 times fast?"
L.Joker_Quick_Btn_JokeCatFact = "Cat Fact"
L.Joker_Quick_Btn_JokeCatFact_Tip = "Get a random Khaji--err, cat fact in your chatbox. Sometimes they're true!"
L.Joker_Quick_Btn_JokeReady = "Ready Check"
L.Joker_Quick_Btn_JokeReady_Slash = "Custom Ready Checks"
L.Joker_Quick_Btn_JokeReady_Tip = "Ready checks, but funnier & faster! Leerrooyyyyyyy Jeeenkinnssssss!"
L.Joker_Quick_Btn_JokeReady_Tip_Advanced = "Inside joke, or funnier than Joker? Ready check your group with your own custom message!"
L.Joker_Quick_Btn_JokeReady_Tip_Advanced_Vote = "Why stop at ready checks? Cast votes of any kind in your group! Choose between simple majority, supermajority, & unanimous vote types! Try `/ready <unan|simple|super> <votePrompt>`!"


-- SECTION: Options
L.Joker_Options_Title	= "Customization Options"
L.Joker_Options_Periodic = "Show me jokes periodically"
L.Joker_Options_Periodic_Tip	= "Joker can periodically post a joke to your chat window (only visible to you)!"
L.Joker_Options_PeriodicFrequency = "How often should Joker send you a joke?"
L.Joker_Options_PeriodicFrequency_Tip	= "This is the frequency ceiling at which Joker sends (just you) a joke. Joker procedurally increase joke chance based on number of zones since last joke (with a guaranteed occurence at the ceiling you set). The lower the value, the more often jokes will appear!"
L.Joker_Options_RandomPool = "Random /Joke Pool"
L.Joker_Options_RandomPool_Warning = "Intended for advanced users - incorrect values here may result in no jokes being shown!"
L.Joker_Options_RandomPool_Tip	= "For advanced users: Comma-separated list of joke types you want included in the random pool for /joke. See below or check the addon page on ESOUI for a list of all possible options."
L.Joker_Options_RandomPool_Types	= "Available Joke Types"
L.Joker_Options_RandomPool_Types_Default	= "Default"
L.Joker_Options_RandomPool_Types_Available	= "Available"
L.Joker_Options_RandomPool_Types_Available_Tip	= "Any items that include the terms Edgy and XXX contain content that has been flagged as potentially inappropriate for some audiences. Please be mindful of others and use responsibly."

-- SECTION: Available Commands
L.Joker_Commands_Title = "/Slash Commands"

-- SECTION: More Jokes
L.Joker_More_Title = "Want More Jokes?"
L.Joker_More_Desc = "More fun-, pop-culture- and leisure-minded options (such as movie & TV-show jokes, popular memes, riddles, and more) are expected to be added in future releases. Bug reports, requests & suggestions are always enthusiastically welcomed! Have jokes you want to add? Send them to me! Whisper me ingame (NA @CallMeLent), or get in touch via esoui.com, Twitter (@adefee), or Github (@adefee)."

-- SECTION: Legal
L.Joker_Legal_Title	 = "Legal"
L.Joker_Legal_Desc	 = "I want to emphasize that the jokes contained in this addon are (for the most part) not my own, but rather are originally sourced from various public internet sources. I claim no ownership of the content, and make no profit from this addon or any content therein. All code for this addon (and the content therein) is open-source and publicly available on Github. If there are any copyright, trademark, DMCA, or other legal issues please reach out at me@andrewdefee.com and I'll comply as quickly and accurately as I can within the scope of US law. I'm just trying to share a few laughs - after all, what good is a joke if it's not shared?"




------------------------------------------------------------------------------------------------------------------

function JokerL:GetLanguage() -- English is default locale, will return unless overwritten by other langs
  return L
end
