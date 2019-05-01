JokerL = JokerL or {}
local L = {}


--------------------------------------------------------------------------------------------------------------------
-- Locale: English (default for Joker)
--------------------------------------------------------------------------------------------------------------------

-- General
L.Joker_Title = "Joker - Best Enjoyed with Skooma!"

-- Intro
L.Joker_Intro_Status_Prefix = "You've viewed"
L.Joker_Intro_Status_Of = "of"
L.Joker_Intro_Status_Suffix	= "loaded jokes, wisdom, fun facts, & more!"

-- Options
L.Joker_Options_Title	= "Options"
L.Joker_Options_Periodic = "Show me jokes periodically"
L.Joker_Options_Periodic_Tip	= "Joker can periodically post a joke to your chat window (only visible to you)!"
L.Joker_Options_PeriodicFrequency = "Number of zones between periodic jokes?"
L.Joker_Options_PeriodicFrequency_Tip	= "This is the frequency *ceiling* at which Joker sends (just you) a joke. Lower values are more frequent. Higher values procedurally increase joke chance based on number of zones since last joke."

-- Available Commands
L.Joker_Commands_Title = "Commands"

-- More Jokes
L.Joker_More_Title = "Want More Jokes?"

-- Legal
L.Joker_Legal_Title	 = "Credits & Legal"




------------------------------------------------------------------------------------------------------------------

function JokerL:GetLanguage() -- English is default locale, will return unless overwritten by other langs
  return L
end
