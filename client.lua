local showJobs = false

--Get ESX Data
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

-- Store data for later
emsonline = 0
policeonline = 0
taxionline = 0
mechanoonline = 0
playersonline = 0


-- Get jobs data every 10 secconds
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10000)
		ESX.TriggerServerCallback('onlinejobs:getJobsOnline', function(ems, police, mechano, players)
			emsonline    = ems
			policeonline = police
			mechanoonline = mechano
			playersonline = players
		end)
	end
end)

local showJobs = false
local leftSide = 0.515
local emsY = 0.78
local policeY = emsY + 0.029
local mechanoY = policeY - 0.058
local playersY = policeY + 0.029

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if showJobs then
			-- PLAYERS
			if true then
				DrawText2D(leftSide, playersY, 1.0,1.0,0.45, "Players: " .. playersonline, 255, 0, 0, 150)
			end

			-- EMS
			if emsonline >= 1 then
				DrawText2D(leftSide, emsY, 1.0,1.0,0.45, "UELS: ON", 255, 0, 0, 150)
			else
				DrawText2D(leftSide, emsY, 1.0,1.0,0.45, "UELS: OFF", 255, 0, 0, 150)
			end

			-- POLICE
			if policeonline >= 1 then
				DrawText2D(leftSide, policeY, 1.0,1.0,0.45, "DPLS: ON", 0, 0, 255, 150)
			else
				DrawText2D(leftSide, policeY, 1.0,1.0,0.45, "DPLS: OFF", 0, 0, 255, 150)
			end
			
			-- MECHANIC
			if mechanoonline >= 1 then
				DrawText2D(leftSide, mechanoY, 1.0,1.0,0.45, "Mecânico: ON", 169, 169, 169, 150)
			else
				DrawText2D(leftSide, mechanoY, 1.0,1.0,0.45, "Mecânico: OFF", 169, 169, 169, 150)
			end
		end
	end
end)

ToggleJobs = function()
	showJobs = not showJobs
end

RegisterCommand("on", function(source, args, raw)
	ToggleJobs()
end)

function DrawText2D(x,y ,width,height,scale, text, r,g,b,a)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end