Config = {}

-- Important stuff
Config.PriceNoticed = 100000
Config.PriceUnnoticed = 200000
Config.PolicePermission = "police.service" -- Notify onduty cops about the escape
Config.PoliceGroup = "Politistyrken" -- Check if a cop is online

-- Language
Config.AlarmOffPolice = "[~g~E~s~] Turn Off"
Config.LeaveHouse = "Leave"
Config.RemoveTracker = "[~g~E~s~] Remove tracker"
Config.NoTracker = "You are not being tracked!"
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
