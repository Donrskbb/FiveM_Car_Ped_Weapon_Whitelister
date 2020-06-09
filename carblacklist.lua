-- CONFIG --
-- Created by Donrskbb#0007
-- Blacklisted vehicle models
carblacklist = {
	"mercedesb",
	"police3",
	"police2",
	"fbi",
	"policeb",
}

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(2000)

		local xPlayer = ESX.GetPlayerData()

		if(xPlayer.job.name == "police" or xPlayer.job.name == "ambulance" or xPlayer.job.name == "mechanic" or xPlayer.job.name == "admin") then			

		else
			if IsPedInAnyVehicle(GetPlayerPed(-1)) then
				playerPed = GetPlayerPed(-1)
				v = GetVehiclePedIsIn(playerPed, false)

				if playerPed and v then
					if GetPedInVehicleSeat(v, -1) == playerPed then
						if(checkCar(playerPed, v)) then
							Citizen.Wait(5000)
						end
					end
				end
			end
		end
	end
end)

function checkCar(playerPed, car)
	if car then
		carModel = GetEntityModel(car)
		carName = GetDisplayNameFromVehicleModel(carModel)

		if isCarBlacklisted(carModel) then
			TaskLeaveVehicle(playerPed, car, 1)

			TriggerEvent("pNotify:SendNotification", {
				text = "Dit voertuig is alleen toegestaan voor hulpdiensten.",
				type = "error",
				timeout = 5000,
				layout = "bottomCenter"
			})

			return true
		end
	end

	return false
end

function isCarBlacklisted(model)
	for _, blacklistedCar in pairs(carblacklist) do
		if model == GetHashKey(blacklistedCar) then
			return true
		end
	end

	return false
end