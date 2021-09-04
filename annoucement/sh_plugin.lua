local PLUGIN = PLUGIN

PLUGIN.name = "Announcement command"
PLUGIN.author = "KINGXIII"
PLUGIN.description = "Add a announcement command."

ix.chat.Register("Broadcast", {
	CanSay = function(self, speaker, text)
		if(speaker:IsAdmin() or speaker:Team() == FACTION_CWU then
			return true
		end
			speaker:NotifyLocalized("You dont have permission to use this command!")
			return false
	end,
	OnChatAdd = function(self, speaker, text)
		chat.AddText(Color(255, 215, 0), "[Announcement] ",ix.config.Get("chatColor"),speaker:Name() .. ": " .. text)
	end,
	prefix = {"/Announcement"},
	description = "Announce a message in the chat.",
	indicator = "chatTalking",
	deadCanChat = false
})