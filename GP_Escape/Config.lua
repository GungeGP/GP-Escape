Config = {}

-- Important stuff
Config.PriceNoticed = 100000
Config.PriceUnnoticed = 200000
Config.PolicePermission = "police.service" -- Notify onduty cops about the escape
Config.PoliceGroup = "Politistyrken" -- Check if a cop is online


-- All the coords you might want to change
Config.PoliceShutDownAlarm = 1690.8388671875,2541.2941894531,54.579845428467 -- Where you need to go, to disable the prison alarm as police

Config.WaypointToCutscene = 347.03472900391,441.0163269043 -- Set a waypoint to where the cutscene takes places
Config.HouseLeave = 342.169921875,437.81594848633,149.38079833984 -- Where you need to go to leave the house for the cutscene
Config.HouseLeaveTeleportTO = 348.63415527344,442.11334228516,147.70091247559 -- Where you teleport to, when you leave the house
Config.HouseLeaveHeading = 299.715 -- What direction you look when you go out.

Config.StartEscape = 1625.4057617188,2569.2751464844,45.564865112305 -- Where in the prison you need to go, to start escaping.
Config.TeleportOutsidePrison = 1643.7371826172,2585.1936035156,45.564861297607 -- Where you teleport to, when you are ongoing an escape
Config.TeleportOutsidePrisonHeading = 356.957 -- the heading.



-- Language
Config.AlarmOffPolice = "[~g~E~s~] Turn Off"
Config.LeaveHouse = "Leave"
Config.RemoveTracker = "[~g~E~s~] Remove tracker"
Config.NoTracker = "There are no tracker on you"
Config.PayMoney = "[~g~E~s~] Escape from prison (noticed) [Price: 100.000$]" -- If you press 'E' you pay X amount money | You get a tracker
Config.PayMoney2 = "[~g~H~s~] Escape from prison (unnoticed) [Price: 200.000$]" --  If you press 'H' you pay X amount money | No tracker
Config.NoCops = "there are not enough officers online"
Config.TrackerOff = "Your tracker is now off"

Config.ContactTitel = "Your Contact" -- under the name there will be a titel
Config.ContactNotify = "Great! Now get away, fast! But come by me, I can help you with that tracker" -- This if you are noticed
Config.ContactNotify2 = "Great! Now get away, Fast! It's time to a big party" -- This is if you are not noticed

-- Requies mythic_progressbar
Config.NotifyAlarmShutDown = "Turning off..."
Config.RemoveTrackerBar = "Removing tracker..."



-- Discord Logs
Config.d1NameLog = "[PrisonEscape] A person is missing:" -- Discord bot name.
Config.d1message1 = "**Name:** " .. tostring(firstname)..  " " .. tostring(lastname)..  " **Social Security:** " .. tostring(registration)..  "" -- If you escape, but are notcied.
Config.d1message2 = "**Name:** Unknown **Social Security:** XXX-XX-XXXX" -- If you escape, but are unnotcied.