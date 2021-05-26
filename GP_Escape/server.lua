local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","gp_silenser")

local police = 0

function discordLog()
    local user_id = vRP.getUserId({source}) -- vRP Function
    vRP.getUserIdentity({user_id, function(identity) -- vRP Function
        if identity then
            local lastname = identity.name -- vRP Function
            local firstname = identity.firstname -- vRP Function
            local registration = identity.registration -- vRP Function
            local d1name = Config.d1NameLog
            local d1message = Config.d1message1
            PerformHttpRequest("Your Discord API", function(err, text, headers) end, 'POST', json.encode({username = d1name, content = d1message}), { ['Content-Type'] = 'application/json' })
        end
    end})
end

function discordLog1()
    local user_id = vRP.getUserId({source}) -- vRP Function
    local d1name = Config.d1NameLog
    local d1message = Config.d1message2
    PerformHttpRequest("Your Discord API", function(err, text, headers) end, 'POST', json.encode({username = d1name, content = d1message}), { ['Content-Type'] = 'application/json' })
end

RegisterServerEvent('escape:checkmoney')
AddEventHandler('escape:checkmoney', function()
	local user_id = vRP.getUserId({source}) -- vRP Function
	local player = vRP.getUserSource({user_id})
	  if vRP.tryFullPayment({user_id,Config.PriceNoticed}) then
		TriggerClientEvent('startescape', player)
	  else
		TriggerClientEvent('escape:notenough', player)
	  end	
end)

RegisterServerEvent('escape:checkmoney1')
AddEventHandler('escape:checkmoney1', function()
	local user_id = vRP.getUserId({source}) -- vRP Function
	local player = vRP.getUserSource({user_id})
	  if vRP.tryFullPayment({user_id,Config.PriceUnnoticed}) then
		TriggerClientEvent('startescape1', player)
	  else
		TriggerClientEvent('escape:notenough', player)
	  end	
end)

RegisterServerEvent('EscapedLogs')
AddEventHandler('EscapedLogs',function()
	local source = source
    local user_id = vRP.getUserId({source}) -- vRP Function
	local player = vRP.getUserSource({user_id})
    discordLog()
	vRPclient.getPosition(player,{},function(x,y,z) -- vRP Function from here to end of event
		vRP.getUserIdentity({user_id, function(identity) 
		  if identity.firstname then
			IregretLife(x,y,z,identity.firstname,identity.name)
		  end
		end})
	end)
end)

RegisterServerEvent('EscapedLogs1')
AddEventHandler('EscapedLogs1',function()
    local source = source
    local user_id = vRP.getUserId({source}) -- vRP Function
	local player = vRP.getUserSource({user_id})
    discordLog1()
	vRPclient.getPosition(player,{},function(x,y,z) -- vRP Function from here to end of event
		vRP.getUserIdentity({user_id, function(identity)
		  if identity.firstname then
			IregretLife(x,y,z,identity.firstname,identity.name)
		  end
		end})
	end)
end)

function IregretLife(x,y,z,name,last) -- All in this function is vRP
	local players = {}
	users = vRP.getUsers({})
	for k,v in pairs(users) do
	  local player = vRP.getUserSource({k})
	  -- check user
	  if vRP.hasPermission({k,Config.PolicePermission}) and player ~= nil then
		table.insert(players,player)
	  end
	end
  
	  for k,v in pairs(players) do 
		TriggerEvent("InteractSound_SV:PlayOnOne", v, "panik2", 0.2) -- Requies InteractSound
		TriggerClientEvent('dd_notify', "[Alarm] Fangeflugt, tjek din GPS for lokation.", source)
		vRP.setHunger(tonumber(target_id), 0)  -- unfreze food
		vRP.setThirst(tonumber(target_id), 0)  -- unfreze thirst
	    jail_clock(tonumber(target_id),timer-1) -- realease you from prison
		vRP.request({v,"Fangeflugt: Indstil GPS til stedet", 30, function(v,ok) -- 
		  if ok then 
			vRPclient.setGPS(v,{x,y})
		  end
		end})
		vRPclient.addBlip(v,{x,y,z,458,29,"Panic"}, function(bid) 
		  SetTimeout(60000,function()
			vRPclient.removeBlip(v,{bid})
		  end)
		end)
	  end
  end

function pol_cycle()
	SetTimeout(0,function()
			if police >= 4 then
				TriggerClientEvent('allow_police',-1,false)	
				--print("allow")	
			elseif police <= 0 then
				TriggerClientEvent('allow_police1',-1,false)
				--print("nono")
				getCurrentPol()
			end
		end)
	SetTimeout(10000,pol_cycle)
end
pol_cycle()

-- the rest of this code are vRP code. 
AddEventHandler("vRP:playerJoinGroup", function(user_id, group, gtype) 
    local _source = vRP.getUserSource({user_id})
    if user_id and source then
		if group == Config.PoliceGroup then
			police = police + 1
		end
    end
end)

AddEventHandler("vRP:playerLeaveGroup", function(user_id, group, gtype) 
    local _source = vRP.getUserSource({user_id})
    if user_id and source then
		if group == Config.PoliceGroup then
			police = police - 1
		end
    end
end)

AddEventHandler("vRP:playerSpawn", function(user_id, source, first_spawn) 
    if vRP.hasGroup({user_id,Config.PoliceGroup}) then
		police = police + 1
	end
end)

AddEventHandler("vRP:playerLeave", function(user_id, source, first_spawn) 
    if vRP.hasGroup({user_id,Config.PoliceGroup}) then
		police = police - 1
    end
end)

function getCurrentPol()
	polGroup = vRP.getUsersByGroup({Config.PoliceGroup})
	for k,v in pairs(polGroup) do 
		police = police + 1
	end
end