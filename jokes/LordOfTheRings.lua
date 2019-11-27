-- * _JOKER_VERSION: 0.0.1 ** Please do not modify this line.
--[[----------------------------------------------------------
	Joker - Jokes, Riddles, Fun Facts, & Other Tomfoolery
  ----------------------------------------------------------
  *
  * ADDING YOUR OWN JOKES:
  * Be aware that modifying this file incorrectly could break Joker,
  * so for normal users I recommend just compiling your jokes in the
  * '_MyCustomJokes.lua' file instead.
  *
  * COMPILATION: LotR-related jokes
	*
	* SOURCES:
  * Reddit Search, 
  * Google Search
	*
]]--

JokerData = JokerData or {}
JokerData.Config = JokerData.Config or {}

JokerData.Config.LordOfTheRings = {
  command = "lotr",
  disable = true,
  joke = true,
  label = "Lord of the Rings",
  nsfw = false,
  whitelistSlashCommand = true
}

JokerData.LordOfTheRings = {
  "Why don't you ask a hobbit for money? Because they're always a little short."
}
