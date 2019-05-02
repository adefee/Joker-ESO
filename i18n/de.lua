JokerL = JokerL or {}
local L = {}

--------------------------------------------------------------------------------------------------------------------
-- Locale: Deutsch
-- All strings currently need translated, any help welcome!
--------------------------------------------------------------------------------------------------------------------

-- Basic / General
L.Joker_Or = "oder"
L.Joker_And = "und"
L.Joker_Of = "von"
L.Joker_With = "mit"

------------------------------------------------------------------------------------------------------------------

if (GetCVar('language.2') == 'de') then -- overwrite GetLanguage for new language
	for k,v in pairs(JokerL:GetLanguage()) do
		if (not L[k]) then -- no translation for this string, use default
			L[k] = v
		end
	end
	function JokerL:GetLanguage() -- set new language return
		return L
	end
end
