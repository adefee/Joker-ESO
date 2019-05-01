JokerL = JokerL or {}
local L = {}

--------------------------------------------------------------------------------------------------------------------
-- Locale: Francais
-- All strings currently need translated, any help welcome!
--------------------------------------------------------------------------------------------------------------------

-- General Strings
L.Joker_Title			= "Joker - Best Enjoyed with Skooma!"

------------------------------------------------------------------------------------------------------------------

if (GetCVar('language.2') == 'fr') then -- Overwrite GetLanguage for new language
	for k,v in pairs(JokerL:GetLanguage()) do
		if (not L[k]) then -- No translation for this string, use default
			L[k] = v
		end
	end
	function JokerL:GetLanguage() -- set new language return
		return L
	end
end
