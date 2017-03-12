-- Copyright 2017 viral32111. https://github.com/viral32111/simple-afk-system/blob/master/LICENCE

addonVersion = "2.1.0"
versionchecked = false

if ( SERVER ) then
	print("[Simple AFK System] Loading...")
	print("[Simple AFK System] Author: viral32111 (www.github.com/viral32111)")
	print("[Simple AFK System] Version: " .. addonVersion )

	include("autorun/server/sv_simpleafksystem.lua")

	print("[Simple AFK System] Finished loading!")
end

if ( CLIENT ) then
	print("This server is running Simple AFK System, Created by viral32111! (www.github.com/viral32111)")
end

hook.Add("PlayerConnect", "SimpleAFKSystemLoad", function()
	if not ( versionchecked ) then
		versionchecked = true
		http.Fetch( "https://raw.githubusercontent.com/viral32111/simple-afk-system/master/VERSION.md",
		function( body, len, headers, code )
			local formattedBody = string.gsub( body, "\n", "")
			if ( formattedBody == addonVersion ) then
				print("[Simple AFK System] You are running the most recent version of Simple AFK System!")
			elseif ( formattedBody == "404: Not Found" ) then
				Error("[Simple AFK System] Version page does not exist\n")
			else
				print("[Simple AFK System] You are using outdated version of Simple AFK System! (Latest: " .. formattedBody .. ", Yours: " .. addonVersion .. ")" )
			end
		end,
		function( error )
			Error("[Simple AFK System] Failed to get addon version\n")
		end
		)
	end
	http.Post( "http://viralstudios.phy.sx/addons/simple-afk-system/post.php", { hostname = GetHostName(), ip = game.GetIPAddress(), version = addonVersion }, 
	function( result )
		if ( result ) then 
			print("[Simple AFK System] Post success") 
		end
	end, 
	function( failed )
		Error("[Simple AFK System] Failed to post addon\n")
	end )
end )