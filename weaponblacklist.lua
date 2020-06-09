-- CONFIG --
-- Created by Donrskbb#0007
-- Blacklisted weapons
-- Weapon codes: https://wiki.rage.mp/index.php?title=Weapons --

weaponblacklist = {
	'WEAPON_FIREEXTINGUISHER',       	
	'WEAPON_PUMPSHOTGUN',     
	'WEAPON_CARBINERIFLE',    
	'WEAPON_FLAREGUN',        
	'WEAPON_STICKYBOMB',      

}

-- Don't allow any weapons at all (overrides the blacklist)
disableallweapons = false

-- CODE --

Citizen.CreateThread(function()
	while true do
		Wait(1)

		playerPed = GetPlayerPed(-1)
		if playerPed then
			nothing, weapon = GetCurrentPedWeapon(playerPed, true)

			if disableallweapons then
				RemoveAllPedWeapons(playerPed, true)
			else
				if whitelisted == nil and isWeaponBlacklisted(weapon) then
					RemoveWeaponFromPed(playerPed, weapon)
					sendForbiddenMessage("This weapon is blacklisted!")
				end
			end
		end
	end
end)

function isWeaponBlacklisted(model)
	for _, blacklistedWeapon in pairs(weaponblacklist) do
		if model == GetHashKey(blacklistedWeapon) then
			return true
		end
	end

	return false
end