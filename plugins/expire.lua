local function check_member_superrem2(cb_extra, success, result)
  local receiver = cb_extra.receiver
  local data = cb_extra.data
  local msg = cb_extra.msg
  for k,v in pairs(result) do
    local member_id = v.id
    if member_id ~= our_id then
	  -- Group configuration removal
      data[tostring(msg.to.id)] = nil
      save_data(_config.moderation.data, data)
      local groups = 'groups'
      if not data[tostring(groups)] then
        data[tostring(groups)] = nil
        save_data(_config.moderation.data, data)
      end
      data[tostring(groups)][tostring(msg.to.id)] = nil
      save_data(_config.moderation.data, data)
	  chat_del_user(get_receiver(msg), 'user#id'..160149610, ok_cb, false) -- Your ID
	  leave_channel(get_receiver(msg), ok_cb, false)
    end
  end
end

local function superrem2(msg)
	local data = load_data(_config.moderation.data)
    local receiver = get_receiver(msg)
    channel_get_users(receiver, check_member_superrem2,{receiver = receiver, data = data, msg = msg})
end
local function pre_process(msg)
	local timetoexpire = 'unknown'
	local expiretime = redis:hget ('expiretime', get_receiver(msg))
	local now = tonumber(os.time())
	if expiretime then    
		timetoexpire = math.floor((tonumber(expiretime) - tonumber(now)) / 86400) + 1
		if tonumber("0") > tonumber(timetoexpire) then
		if get_receiver(msg) then
		redis:del('expiretime', get_receiver(msg))
		rem_mutes(msg.to.id)
		superrem2(msg)
		return send_large_msg(get_receiver(msg), '⏰ تاریخ انقضای گروه پایان یافت\n\n> برای تمدید تاریخ انقضای گروه میتوانید به گروه پشتیبانی روبات مراجعه نمایید و تقاضای تمدید دوباره نمایید\n\n👥 لینک گروه پشتیبانی :\nhttps://telegram.me/joinchat/CYuwakBXO9sosgQ_8xuYTw')
		else
			return
		end
	end
	if tonumber(timetoexpire) == 0 then
			if redis:hget('expires0',msg.to.id) then return msg end
		local user = "user#id"..160149610 -- Your ID
		local text = "⏰ تاریخ انقضای گروه ارسال شده به پایان رسیده است"
			local text12 = 0
			local data = load_data(_config.moderation.data)
			local group_owner = data[tostring(msg.to.id)]['set_owner']
			if not group_owner then
group_owner = "--"
end
			local group_link = data[tostring(msg.to.id)]['settings']['set_link']
			if not group_link then
group_link = "<code>Not Seted !</code>"
end
local exppm = '<b>Charge Finished</b>\n'
..'<b>-----------------------------------------------</b>\n'
..'<b>Group Name :</b> <code> '..msg.to.title..' </code>\n'
..'<b>Group ID :</b> <code> '..msg.to.id..'  </code>\n'
..'<b>Group Owner :</b>  <code> '..group_owner..'  </code> \n'
..'<b>Group Link :</b> '..group_link..'\n'
..'<b>Info Time :</b>\n'..text12..'\n'
..'<b>-----------------------------------------------</b>\n'
..'Charge For 1 <b>Week</b> :\n'
..'/setexp_'..msg.to.id..'_7\n'
..'Charge For 1 <b>Month</b> :\n'
..'/setexp_'..msg.to.id..'_30\n'
..'<b>-----------------------------------------------</b>\n'
..'Our Channel : @PrivateTeam'

			local sends = send_msg(user, exppm, ok_cb, false)   
			send_large_msg(get_receiver(msg), '⏰ کمتر از یکروز تا انقضای گروه باقی مانده است\n\n> برای تمدید تاریخ انقضای گروه میتوانید به گروه پشتیبانی روبات مراجعه نمایید و تقاضای تمدید دوباره نمایید\n\n👥 لینک گروه پشتیبانی :\nhttps://telegram.me/joinchat/CYuwakBXO9sosgQ_8xuYTw')
   redis:hset('expires0',msg.to.id,'0')
	end
	if tonumber(timetoexpire) == 1 then
			if redis:hget('expires1',msg.to.id) then return msg end
      local user = "user#id"..160149610 -- Your ID
			local text2 = "⏰ یکروز تا پایان انقضای گروه ارسال شده"
			local text13 = 1
			local data = load_data(_config.moderation.data)
			local group_owner = data[tostring(msg.to.id)]['set_owner']
			if not group_owner then
group_owner = "--"
end
			local group_link = data[tostring(msg.to.id)]['settings']['set_link']
			if not group_link then
group_link = "<code>Not Seted !</code>"
end
local exppm = '<b>Charge Finished</b>\n'
..'<b>-----------------------------------------------</b>\n'
..'<b>Group Name :</b> <code> '..msg.to.title..' </code>\n'
..'<b>Group ID :</b> <code> '..msg.to.id..'  </code>\n'
..'<b>Group Owner :</b>  <code> '..group_owner..'  </code> \n'
..'<b>Group Link :</b> '..group_link..'\n'
..'<b>Info Time :</b>\n'..text13..'\n'
..'<b>-----------------------------------------------</b>\n'
..'Charge For 1 <b>Week</b> :\n'
..'/setexp_'..msg.to.id..'_7\n'
..'Charge For 1 <b>Month</b> :\n'
..'/setexp_'..msg.to.id..'_30\n'
..'<b>-----------------------------------------------</b>\n'
..'Our Channel : @PrivateTeam'
		local sends = send_msg(user, exppm, ok_cb, false)
			send_large_msg(get_receiver(msg), '⏰ 1 روز تا انقضای گروه باقی مانده است\n\n> برای تمدید تاریخ انقضای گروه میتوانید به گروه پشتیبانی روبات مراجعه نمایید و تقاضای تمدید دوباره نمایید\n\n👥 لینک گروه پشتیبانی :\nhttps://telegram.me/joinchat/CYuwakBXO9sosgQ_8xuYTw')
		redis:hset('expires1',msg.to.id,'1')
	end
	if tonumber(timetoexpire) == 2 then
		if redis:hget('expires2',msg.to.id) then return msg end
			send_large_msg(get_receiver(msg), '⏰ 2 روز تا انقضای گروه باقی مانده است\n\n> برای تمدید تاریخ انقضای گروه میتوانید به گروه پشتیبانی روبات مراجعه نمایید و تقاضای تمدید دوباره نمایید\n\n👥 لینک گروه پشتیبانی :\nhttps://telegram.me/joinchat/CYuwakBXO9sosgQ_8xuYTw')
		redis:hset('expires2',msg.to.id,'2')
	end
	if tonumber(timetoexpire) == 3 then
					if redis:hget('expires3',msg.to.id) then return msg end
			send_large_msg(get_receiver(msg), '⏰ 3 روز تا انقضای گروه باقی مانده است\n\n> برای تمدید تاریخ انقضای گروه میتوانید به گروه پشتیبانی روبات مراجعه نمایید و تقاضای تمدید دوباره نمایید\n\n👥 لینک گروه پشتیبانی :\nhttps://telegram.me/joinchat/CYuwakBXO9sosgQ_8xuYTw')
		 redis:hset('expires3',msg.to.id,'3')
	end
	if tonumber(timetoexpire) == 4 then
					if redis:hget('expires4',msg.to.id) then return msg end
			send_large_msg(get_receiver(msg), '⏰ 4 روز تا انقضای گروه باقی مانده است\n\n> برای تمدید تاریخ انقضای گروه میتوانید به گروه پشتیبانی روبات مراجعه نمایید و تقاضای تمدید دوباره نمایید\n\n👥 لینک گروه پشتیبانی :\nhttps://telegram.me/joinchat/CYuwakBXO9sosgQ_8xuYTw')
		redis:hset('expires4',msg.to.id,'4')
	end
	if tonumber(timetoexpire) == 5 then
					if redis:hget('expires5',msg.to.id) then return msg end
			send_large_msg(get_receiver(msg), '⏰ 5 روز تا انقضای گروه باقی مانده است\n\n> برای تمدید تاریخ انقضای گروه میتوانید به گروه پشتیبانی روبات مراجعه نمایید و تقاضای تمدید دوباره نمایید\n\n👥 لینک گروه پشتیبانی :\nhttps://telegram.me/joinchat/CYuwakBXO9sosgQ_8xuYTw')
		redis:hset('expires5',msg.to.id,'5')
	end
end
return msg
end
function run(msg, matches)
	if matches[1]:lower() == 'setexpire' then
		if not is_sudo(msg) then return end
		local time = os.time()
		local buytime = tonumber(os.time())
		local timeexpire = tonumber(buytime) + (tonumber(matches[2]) * 86400)
		redis:hset('expiretime',get_receiver(msg),timeexpire)
		return "⏰ Group <b>Expire</b> Has been seted to <code>"..matches[2].. "</code> Days later :D"
	end
	
	if matches[1]:lower() == 'setexp' then
		if not is_sudo(msg) then return end
    local expgp = "channel#id"..matches[2]
		local time = os.time()
		local buytime = tonumber(os.time())
		local timeexpire = tonumber(buytime) + (tonumber(matches[3]) * 86400)
		redis:hset('expiretime',expgp,timeexpire)
		return "⏰ Group <code>Expire</code> Has been seted to <code>"..matches[3].. "</code> Days later :D\n\n🗣 Thanks to @MobinDev"
	end
	if matches[1]:lower() == 'expire' then
		local expiretime = redis:hget ('expiretime', get_receiver(msg))
		if not expiretime then return 'Group <code>Expire</code> is Unlimite !' else
			local now = tonumber(os.time())
			local text = (math.floor((tonumber(expiretime) - tonumber(now)) / 86400) + 1)
			return (math.floor((tonumber(expiretime) - tonumber(now)) / 86400) + 1) .. " روز دیگر\n\n> در صورتی تمایل به شارژ تاریخ گروه دارید میتوانید از دستور زیر استفاده نمایید\n\n!charge"
		
		end
		end
			if matches[1]:lower() == 'charge' then
			if not is_owner(msg) then return end
			local expiretime = redis:hget ('expiretime', get_receiver(msg))
			local now = tonumber(os.time())
			local text4 = (math.floor((tonumber(expiretime) - tonumber(now)) / 86400) + 1)
			if not expiretime then 
				expiretime = "-"
				end
local text3 = "<code>Group Need to Charge :(</code>"
local user = "user#id"..160149610 -- Your ID
local data = load_data(_config.moderation.data)
local group_owner = data[tostring(msg.to.id)]['set_owner']
if not group_owner then
group_owner = "--"
end
local group_link = data[tostring(msg.to.id)]['settings']['set_link']
if not group_link then
group_link = "<code>Not Seted !</code>"
end
local exppm = 'Charge <b>Request</b> !\n'
..'<b>-----------------------------------------------</b>\n'
..'<b>Group Name :</b> <code>'..msg.to.title..'</code>\n'
..'<b>Group ID :</b> <code>'..msg.to.id..' </code>\n'
..'<b>Group Owner :</b> <code>'..group_owner..'</code>\n'
..'<b>Group Link :</b> '..group_link..'\n'
..'<b>Info Time :</b> <code>'..text4..'</code>\n'
..'<b>Info Msg :</b> '..text3..'\n'
..'<b>-----------------------------------------------</b>\n'
..'Charge For 1 <b>Week</b> :\n'
..'/setexp_'..msg.to.id..'_7\n'
..'Charge For 1 <b>Month</b> :\n'
..'/setexp_'..msg.to.id..'_30\n'
..'<b>-----------------------------------------------</b>\n'
..'Our Channel : @PrivateTeam'
			local sends = send_msg(user, exppm, ok_cb, false)
		return "Your <b>Request</b> Was Sent!"
end
end
return {
  patterns = {
                "^(setexpire) (.*)$",
		"^(setexp)_(.*)_(.*)$",
	        "^(expire)$",
		"^(charge)$",
		"^[!#/](charge)$",
		"^[!#/](setexpire) (.*)$",
		"^[!#/](setexp)_(.*)_(.*)$",
	        "^[!#/](expire)$",
  },
  run = run,
  pre_process = pre_process
}
 
-- By @MobinDev
