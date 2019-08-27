--[[----------------------------------------------------------
	Joker - Jokes, Riddles, Fun Facts, & Other Tomfoolery
  ----------------------------------------------------------
  * VERSION: --0.0.1 ** Please do not modify this line.
  *
	* Authors:
	* - Lent (IGN @CallMeLent, Github @adefee)
  *
  * Contents:
  * - Base/Default Joker variables, can be overwritten by /options/customize
  *
]]--

JokerData = JokerData or {} -- Content
JokerL = JokerL or {} -- i18n

Joker = {
  name = "Joker",
  version = "4.0.0",
  versionESO = 400000,
  author = "Lent (IGN @CallMeLent, Github @adefee)",
  color = "D66E4A",
  locale = JokerL:GetLanguage(),
  categories = {},
  pickupPrefixes = {},
  utility = {},
  data = {},
  saved = {},
  defaults = {
    activeIntros = {
      "Hey, jTarget, ",
      "Yo, jTarget, ",
      "jTarget, ",
      "jTarget! "
    },
    activeJokes = {
      Burns = "Burns",
      Cat = "Cat Facts",
      Dad = "Dad",
      Edgy = "Edgy/Adult",
      ESO = "Elder Scrolls",
      GameOfThrones = "Game of Thrones",
      HarryPotter = "Harry Potter",
      LordOfTheRings = "Lord of the Rings",
      Norris = "Chuck Norris",
      PickupLines = "Pickup Lines",
      PickupLinesXXX = "Adult Pickup Lines",
      PickupLinesHP = "Potter Pickup Lines",
      PickupLinesPokemon = "Pokemon Pickup Lines",
      Pokemon = "Pokemon",
      ReadyChecks = "Ready Checks",
      Riddles = "Riddles",
      StarWars = "Star Wars",
      Twisters = "Tongue Twisters",
      Wisdom = "Wise(?) Wisdom",
    },
    contentFilter = {
      sensitive_enable = 1,
      sensitive_sendToPublic = 0,
      sensitive_sendToGuild = 1,
      sensitive_sendToFriend = 1,
      spam_enable = 1,
      spam_limit = 3,
      spam_trackChannelsSeparately = 1,
      spam_includeTargetedContent = 0,
      spam_channelTracking = {}
    },
    count = {
      loaded = 0,
      active = 0,
      seen = 0
    },
    enable = {
      jokeIntros = 1,
      contentFilter = 0
    },
    internal = {
      lastUpdate = 0,
      enableUpdates = 0,
      firstLoad = 1
    },
    periodic = {
      jokes_enable = 1,
      jokes_frequency = 1,
      jokes_lastSeen = 0,
      health_enable = 1,
      health_frequency = 1,
      health_lastSeen = 0
    },
    randomPool = {
      blacklist = {"Burns", "Edgy", "PickupLines", "PickupLinesXXX", "PickupLinesHP", "PickupLinesPokemon", "ReadyChecks", "Riddles"},
      enabled = {}
    },
    rolls = {
      syncWhenAble = 1
    }
  }
}