PLUGIN.name = "Pac Flag"
PLUGIN.author = "NS : AleXXX_007 IX : KINGXIII"
PLUGIN.desc = "Adds 'p' Flag, that allows use of PAC3. Also adds possibility of blocking access to PAC3"

ix.flag.Add("P", "Access to PAC3 editor")

hook.Add( "PrePACEditorOpen", "FlagCheck", function( client )
   if not client:GetChar():HasFlags("P") then
       return false
   end
end )

ix.command.Add("pacban", {
	adminOnly = true,
	syntax = "<string name>",
	OnRun = function (client, arguments)
		local target = ix.command.FindPlayer(client, arguments[1])		
		pace.Ban(target)
		client:Notify("Player "..target:Name().." now is forbidden to use PAC3")
	end
})

ix.command.Add("pacunban", {
	adminOnly = true,
	syntax = "<string name>",
	OnRun = function (client, arguments)
		local target = ix.command.FindPlayer(client, arguments[1])		
		pace.Unban(target)
		client:Notify("Player "..target:Name().." now is allowed to use PAC3")
	end
})