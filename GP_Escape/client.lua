vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP", "GP_Escape")

local tracking = false
allowescape = false

Citizen.CreateThread(function() -- All this is a vRP function
	while kasperr == nil do
		TriggerEvent('kasperr_base:getBaseObjects', function(obj) kasperr = obj end)
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
    while true do
      Citizen.Wait(0)
      local pos = GetEntityCoords(GetPlayerPed(-1), true)
        if(Vdist(pos.x, pos.y, pos.z, Config.PoliceShutDownAlarm+1) < 1.4)then
          DrawMarker(27, Config.PoliceShutDownAlarm - 1.00, 0, 0, 0, 0, 0, 0, 2.0001, 2.0001, 1.5001, 0, 180, 249,165, false, false, 0,true)
          if GetDistanceBetweenCoords(Config.PoliceShutDownAlarm, GetEntityCoords(GetPlayerPed(-1))) < 3 then
            DrawText3Ds(Config.PoliceShutDownAlarm+1, Config.AlarmOffPolice)
            if IsControlJustPressed(1, 51) then -- E
                stopAlarm()
            end
        end
      end
    end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    local pos = GetEntityCoords(GetPlayerPed(-1), true)
      if(Vdist(pos.x, pos.y, pos.z, Config.HouseLeave+1) < 1.4)then
        if GetDistanceBetweenCoords(Config.HouseLeave, GetEntityCoords(GetPlayerPed(-1))) < 3 then
          DrawText3Ds(Config.HouseLeave+1, Config.LeaveHouse)
          if IsControlJustPressed(1, 51) then -- E
            SetEntityHeading(PlayerPedId(), Config.HouseLeaveHeading)
            SetEntityCoordsNoOffset(PlayerPedId(), Config.HouseLeaveTeleportTO, 0)
          end
      end
    end
  end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    local pos = GetEntityCoords(GetPlayerPed(-1), true)
      if(Vdist(pos.x, pos.y, pos.z, 347.03472900391,441.0163269043,147.70216369629+1) < 1.4)then
        if GetDistanceBetweenCoords(347.03472900391,441.0163269043,147.70216369629, GetEntityCoords(GetPlayerPed(-1))) < 3 then
          DrawText3Ds(347.03472900391,441.0163269043,147.70216369629+1, Config.RemoveTracker)
          if IsControlJustPressed(1, 51) then -- E
            if tracking then
              fjernlnke()
              TriggerEvent('your_cutscene_event', 'apa_fin_cel_apt3')
            else
              vRP.notify({Config.NoTracker}) -- vRP notify
            end
          end
      end
    end
  end
end)

Citizen.CreateThread(function()
    while true do
      Citizen.Wait(0)
      local pos = GetEntityCoords(GetPlayerPed(-1), true)
        if(Vdist(pos.x, pos.y, pos.z, Config.StartEscape+1) < 1.4)then
          DrawMarker(27, Config.StartEscape - 1.00, 0, 0, 0, 0, 0, 0, 2.0001, 2.0001, 1.5001, 0, 180, 249,165, false, false, 0,true)
          if GetDistanceBetweenCoords(Config.StartEscape, GetEntityCoords(GetPlayerPed(-1))) < 3 then
            DrawText3Ds(Config.StartEscape+0.60, Config.PayMoney)
            DrawText3Ds(Config.StartEscape+0.50, Config.PayMoney2)
            if IsControlJustPressed(1, 51) then -- E
              if allowescape then
                TriggerServerEvent('escape:checkmoney')
              else
                vRP.notify({Config.NoCops}) -- vRP notify
              end
            elseif IsControlJustPressed(1, 74) then -- H
              if allowescape then
                TriggerServerEvent('escape:checkmoney1')
              else
                vRP.notify({Config.NoCops}) -- vRP notify
              end
            end
        end
      end
    end
  end)

RegisterNetEvent('startescape')
AddEventHandler('startescape', function()
  TriggerServerEvent("EscapedLogs")
  while not PrepareAlarm("PRISON_ALARMS") do
    Citizen.Wait(0)
  end
    StartAlarm("PRISON_ALARMS", 1)
    SetEntityHeading(PlayerPedId(), Config.TeleportOutsidePrisonHeading)
    SetEntityCoordsNoOffset(PlayerPedId(), Config.TeleportOutsidePrison, 0)
    SendNotifcation('Stretch', Config.ContactTitel, Config.ContactNotify)
    tracking = true
    SetNewWaypoint(Config.WaypointToCutscene)
end)

RegisterNetEvent('startescape1')
AddEventHandler('startescape1', function()
  TriggerServerEvent("EscapedLogs1")
  while not PrepareAlarm("PRISON_ALARMS") do
    Citizen.Wait(0)
  end
    StartAlarm("PRISON_ALARMS", 1)
    SetEntityHeading(PlayerPedId(), Config.TeleportOutsidePrisonHeading)
    SetEntityCoordsNoOffset(PlayerPedId(), Config.TeleportOutsidePrison, 0)
    SendNotifcation('Stretch', Config.ContactTitel, Config.ContactNotify2)
    tracking = true
    SetNewWaypoint(Config.WaypointToCutscene)
end)

function stopAlarm()
    TriggerEvent("mythic_progressbar:client:progress", { -- Requies mythic_progressbar
      name = "GP_Escape",
      duration = 3800,
      label = Config.NotifyAlarmShutDown,
      useWhileDead = false,
      canCancel = true,
      controlDisables = {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
      }
    }, function(status)
      if not status then
        StopAlarm("PRISON_ALARMS", 1)
      end
    end)
end

function fjernlnke()
  TriggerEvent("mythic_progressbar:client:progress", { -- Requies mythic_progressbar
    name = "GP_Escape",
    duration = 3600,
    label = Config.RemoveTrackerBar,
    useWhileDead = false,
    canCancel = true,
    controlDisables = {
      disableMovement = true,
      disableCarMovement = true,
      disableMouse = false,
      disableCombat = true,
    }
  }, function(status)
    if not status then
      StopAlarm("PRISON_ALARMS", 1)
      vRP.notify({Config.TrackerOff}) -- vRP notify
      tracking = false
    end
  end)
end

function SendNotifcation(author, subject, string)
	SetNotificationTextEntry('STRING');
	AddTextComponentString(string);
	SetNotificationMessage('CHAR_SOCIAL_CLUB', 'LOGO', true, 0, author, subject);
	DrawNotification(false, false);
end

function DrawText3Ds(x,y,z, text)
  local onScreen,_x,_y=World3dToScreen2d(x,y,z)
  local px,py,pz=table.unpack(GetGameplayCamCoords())
  
  SetTextScale(0.35, 0.35)
  SetTextFont(4)
  SetTextProportional(1)
  SetTextColour(255, 255, 255, 215)
  SetTextEntry("STRING")
  SetTextCentre(1)
  AddTextComponentString(text)
  DrawText(_x,_y)
  local factor = (string.len(text)) / 370
  DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

RegisterNetEvent('allow_police')
AddEventHandler('allow_police',function(bool)
  allowescape = true
end)

RegisterNetEvent('allow_police1')
AddEventHandler('allow_police1',function(bool)
  allowescape = false
end)

RegisterNetEvent('your_cutscene_event') -- All the cutscene
AddEventHandler('your_cutscene_event', function(cutscene)
 local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
    RequestCutscene(cutscene, 8) -- Usually 8.
    while not (HasCutsceneLoaded()) do
        Wait(0)
    end
    
    TriggerEvent('save_all_clothes') -- Save the clothes your MP have on.

 local model = GetHashKey("ig_stretch")

    RequestModel(model)
    while not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(0)
    end
local ped = CreatePed(7, model, x, y ,z, 0.0, true, true)

 local model2 = GetHashKey("ig_rashcosvki")

    RequestModel(model2)
    while not HasModelLoaded(model2) do
        RequestModel(model2)
        Citizen.Wait(0)
    end
local ped2 = CreatePed(7, model2, x, y ,z, 0.0, true, true)

 local model3 = GetHashKey("u_m_y_prisoner_01")

    RequestModel(model3)
    while not HasModelLoaded(model3) do
        RequestModel(model3)
        Citizen.Wait(0)
    end
local ped3 = CreatePed(7, model3, x, y ,z, 0.0, true, true)

   
       SetCutsceneEntityStreamingFlags('MP_1', 0, 1)
	
    RegisterEntityForCutscene(ped, 'MP_1', 0, 0, 64)
	
	
	       SetCutsceneEntityStreamingFlags('MP_2', 0, 1)
	
    RegisterEntityForCutscene(PlayerPedId(), 'MP_2', 0, 0, 64)
	
		       SetCutsceneEntityStreamingFlags('MP_3', 0, 1)
	
    RegisterEntityForCutscene(ped2, 'MP_3', 0, 0, 64)
	
	
		       SetCutsceneEntityStreamingFlags('MP_4', 0, 1)
	
    RegisterEntityForCutscene(ped3, 'MP_4', 0, 0, 64)
	
    StartCutscene(0)

    -- Waiting for the cutscene to spawn the mp ped.
    while not (DoesCutsceneEntityExist('MP_2', 0)) do
        Wait(0)
    end
	
	    while not (DoesCutsceneEntityExist('MP_1', 0)) do
        Wait(0)
    end
	
		    while not (DoesCutsceneEntityExist('MP_3', 0)) do
        Wait(0)
    end
	
	
			    while not (DoesCutsceneEntityExist('MP_4', 0)) do
        Wait(0)
    end
	 SetCutsceneEntityStreamingFlags('MP_2', 0, 1)
	
RegisterEntityForCutscene(PlayerPedId(), 'MP_2', 0, 0, 64)
	
SetCutscenePedComponentVariationFromPed(PlayerPedId(), GetPlayerPed(-1), 1885233650) -- Set the saved clothing
SetPedComponentVariation(GetPlayerPed(-1), 11, jacket_old, jacket_tex, jacket_pal)
SetPedComponentVariation(GetPlayerPed(-1), 8, shirt_old, shirt_tex, shirt_pal)
SetPedComponentVariation(GetPlayerPed(-1), 3, arms_old, arms_tex, arms_pal)
SetPedComponentVariation(GetPlayerPed(-1), 4, pants_old,pants_tex,pants_pal)
SetPedComponentVariation(GetPlayerPed(-1), 6, feet_old,feet_tex,feet_pal)
SetPedComponentVariation(GetPlayerPed(-1), 1, mask_old,mask_tex,mask_pal)
SetPedComponentVariation(GetPlayerPed(-1), 9, vest_old,vest_tex,vest_pal)
SetPedPropIndex(GetPlayerPed(-1), 0, hat_prop, hat_tex, 0)
SetPedPropIndex(GetPlayerPed(-1), 1, glass_prop, glass_tex, 0)
    while not (HasCutsceneFinished()) do
        Wait(0)
    end
    DoScreenFadeOut(90)
    Wait(25000)
      if DoesEntityExist(ped) then
        DeletePed(ped)
      end
      if DoesEntityExist(ped2) then
        DeletePed(ped2)
      end
      if DoesEntityExist(ped3) then
        DeletePed(ped3)
      end

      -- After the cutscene

    SetEntityHeading(PlayerPedId(), 309.957)
    SetEntityCoordsNoOffset(PlayerPedId(), 329.26611328125,423.98629760742,148.99241638184, 0) -- Teleport in front of the sofa, instead of on top.
    DoScreenFadeIn(2500)

end)

RegisterNetEvent('save_all_clothes')
AddEventHandler('save_all_clothes',function()
    local ped = GetPlayerPed(-1)
    glass_prop,glass_tex = GetPedPropIndex(ped,1),GetPedPropTextureIndex(ped,1)
    hat_prop,hat_tex = GetPedPropIndex(ped,0),GetPedPropTextureIndex(ped,0)
    mask_old,mask_tex,mask_pal = GetPedDrawableVariation(ped,1),GetPedTextureVariation(ped,1),GetPedPaletteVariation(ped,1)
    vest_old,vest_tex,vest_pal = GetPedDrawableVariation(ped,9),GetPedTextureVariation(ped,9),GetPedPaletteVariation(ped,9)
    jacket_old,jacket_tex,jacket_pal = GetPedDrawableVariation(ped, 11),GetPedTextureVariation(ped,11),GetPedPaletteVariation(ped,11)
    shirt_old,shirt_tex,shirt_pal = GetPedDrawableVariation(ped,8),GetPedTextureVariation(ped,8),GetPedPaletteVariation(ped,8)
    arms_old,arms_tex,arms_pal = GetPedDrawableVariation(ped,3),GetPedTextureVariation(ped,3),GetPedPaletteVariation(ped,3)
    pants_old,pants_tex,pants_pal = GetPedDrawableVariation(ped,4),GetPedTextureVariation(ped,4),GetPedPaletteVariation(ped,4)
    feet_old,feet_tex,feet_pal = GetPedDrawableVariation(ped,6),GetPedTextureVariation(ped,6),GetPedPaletteVariation(ped,6)
end)