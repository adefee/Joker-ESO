-- * _JOKER_VERSION: 0.0.1 ** Please do not modify this line.
--[[----------------------------------------------------------
	Joker - Jokes, Riddles, Fun Facts, & Other Tomfoolery
  ----------------------------------------------------------
  *
	* Authors:
	* - Lent (IGN @CallMeLent, Github @adefee)
  *
  * Contents:
  * - Base/Default Joker variables, can be overwritten by /options/customize
  *
]]--

JokerData = JokerData or {} -- Content
JokerData.Config = JokerData.Config or {} -- content-specific config
JokerL = JokerL or {} -- i18n

Joker = {
  name = "Joker",
  version = "4.0.0",
  versionESO = 400000,
  author = "Lent (IGN @CallMeLent, Github @adefee)",
  color = "D66E4A",
  locale = JokerL:GetLanguage(),
  sadMessages = {
    "Joker is sad!",
    "Sad Joker!",
    "Bad Joker!",
    "Oof.",
    "Aww shucks!",
    "Dammit, Wanda!",
    "Unfortunate."
  },
  happyMessages = {
    "Awesome!",
    "Joker is happy.",
    "Wicked!",
    "Oh yeahhhh!",
    "Swag!",
    "Hot damn!",
    "Sweet!",
    "Joker can dig it!",
    "**Happy dance**"
  },
  utility = {},
  data = {},
  saved = {},
  defaults = {
    activeIntros = {
      "Hey, jTarget, ",
      "Yo, jTarget, ",
      "jTarget, ",
      "jTarget! ",
      "jTarget - ",
    },
    contentFilter = {
      nsfw_enable = 1,
      nsfw_sendToPublic = 0,
      nsfw_sendToGuild = 1,
      nsfw_sendToFriend = 1,
      spam_enable = 1,
      spam_limit = 3,
      spam_trackChannelsSeparately = 1,
      spam_includeTargetedContent = 0,
      spam_channelTracking = {}
    },
    count = {
      loaded = 0,
      active = 0,
      seen = 0,
      categories = {}
    },
    enable = {
      jokeIntros = 1, -- Replace intros (like in burns/pickup lines). Default 1
      contentFilter = 0, -- Enable content filter. Default 0
      consoleOnly = false -- Show jokes only in console/log, never post to chatbox. Default 0
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