-- Begin warning.lua
-- This plugin match with Beyound Team source

local dataLoad = load_data(_config.moderation.data)
-- Set
local function limitWarn(msg, maxNum)
	if tonumber(maxNum) < 1 or tonumber(maxNum) > 10 then
		return '*Warning Range is between* [ `0 - 10` ].'
	end
    local warnLimit = maxNum
    dataLoad[tostring(msg.chat_id_)]['settings']['warning_max'] = warnLimit
    save_data(_config.moderation.data, dataLoad)
    return '*Warning Range Has Been Set to* [`'..maxNum..'`]'
end
-- Get
local function getMax(msg)
	local chat = chat_id
    local warnLimit = dataLoad[tostring(msg.chat_id_)]['settings']['warning_max']
    if not warnLimit then
	local warnNum = 10
	dataLoad[tostring(chat)]['settings']['warning_max'] = tostring(warnNum) 
        return '*Warning not set! But I set to* [ `10` ]'
    end
    return '*Warning Range is* [ `'..warnLimit..'` ]'
end
-- /warn
local function warnUser(user_id, chat_id)
	if is_mod1(chat_id, user_id) or user_id == tonumber(our_id) then
		return
	else
		local chat = chat_id
		local warnLimit = dataLoad[tostring(chat)]['settings']['warning_max']
		local wUser = redis:hget(user_id..'warning'..chat_id, chat_id)
		if not wUser or wUser == '0' then
			redis:hset(user_id..'warning'..chat_id, chat_id, '1')
			tdcli.sendMessage(chat_id, 0, 1, '*Warning Level Is:* `1`', 1, 'md')
		else
			gWarn = tonumber(wUser) + 1
			redis:hset(user_id..'warning'..chat_id, chat_id, gWarn)
			if tonumber(gWarn) >= tonumber(warnLimit) then
				kick_user(user_id, chat_id)
				redis:hset(user_id..'warning'..chat_id, chat_id, '0')
			else
				tdcli.sendMessage(chat_id, 0, 1, '*Warning Level Is:* `'..tostring(gWarn)..'`', 1, 'md')
			end
		end
	end
end
local function warnByReply(arg, data)
	if gp_type(chat) == "channel" or gp_type(chat) == "chat" then
		local function getIDreply(arg, data)
		if is_mod1(arg.chat_id, data.id_) or data.id_ == tonumber(our_id) then
			return
		else
			return warnUser(data.id_, arg.chat_id)
		end
	end
	tdcli_function ({
		ID = "GetUser",
		user_id_ = data.sender_user_id_
		}, getIDreply, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
        
    else
        return
    end
end
local function warnByUsername(arg, data)
	if arg.username then
		if is_mod1(arg.chat_id, data.id_) or data.id_ == tonumber(our_id) then 
			return 
		else
			warnUser(data.id_, arg.chat_id)
		end
	else
		return '_Can\'t find this username_'
	end
end
-- /unwarn
local function unWarnUser(user_id, chat_id)
	if is_mod1(chat_id, user_id) or user_id == tonumber(our_id) then
		return
	else
		local wUser = redis:hget(user_id..'warning'..chat_id, chat_id)
		if not wUser or wUser == '0' then
			return '_This user don\'t have warning._'
		else
			gWarn = tonumber(wUser) - 1
			redis:hset(user_id..'warning'..chat_id, chat_id, gWarn)
			tdcli.sendMessage(chat_id, 0, 1, '*Warning Level Is:* `'..tostring(gWarn)..'`', 1, 'md')
		end
	end
end
local function unWarnByReply(arg, data)
    if gp_type(chat) == "channel" or gp_type(chat) == "chat" then
		local function getIDreply(arg, data)
			if is_mod1(arg.chat_id, data.id_) or data.id_ == tonumber(our_id) then
				return
			else
				return unWarnUser(data.id_, arg.chat_id)
			end
		end
		tdcli_function ({
			ID = "GetUser",
			user_id_ = data.sender_user_id_
			}, getIDreply, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
    else
        return
    end
end
local function unWarnByUsername(arg, data)
	if gp_type(chat) == "channel" or gp_type(chat) == "chat" then
		if arg.username then
			if is_mod1(arg.chat_id, data.id_) or data.id_ == tonumber(our_id) then
				return
			else
				unWarnUser(data.id_, arg.chat_id)
			end
		else
			return '_Can\'t find this username_'
		end
    end
end
-- /unwarnall
local function unWarnAllUser(user_id, chat_id)
	if is_mod1(chat_id, user_id) or user_id == tonumber(our_id) then
		return
	else
		local wUser = redis:hget(user_id..'warning'..chat_id, chat_id)
		if not wUser or wUser == '0' then
			return '_This user don\'t have warning._'
		else
			redis:hset(user_id..'warning'..chat_id, chat_id, '0')
			tdcli.sendMessage(chat_id, 0, 1, '_User Warnings Has Been Cleard!_', 1, 'md')
		end
	end
end
local function unWarnAllByReply(arg, data)
    if gp_type(chat) == "channel" or gp_type(chat) == "chat" then
		local function getIDreply(arg, data)
			if is_mod1(arg.chat_id, data.id_) or data.id_ == tonumber(our_id) then
				return
			else
				return unWarnAllUser(data.id_, arg.chat_id)
			end
		end
		tdcli_function ({
			ID = "GetUser",
			user_id_ = data.sender_user_id_
			}, getIDreply, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
    else
        return
    end
end
local function unWarnAllByUsername(arg, data)
	if arg.username then
		if is_mod1(arg.chat_id, data.id_) or data.id_ == tonumber(our_id) then
			return
		else
			unWarnAllUser(data.id_, arg.chat_id)
		end
	else
		return '_Can\'t find this username._'
	end
end
-- /getwarn
local function getWarnUser(user_id, chat_id)
	local wUser = redis:hget(user_id..'warning'..chat_id, chat_id)
	tdcli.sendMessage(chat_id, 0, 1, '*Warning Level Is:* `'..tostring(wUser)..'`', 1, 'md')
end
local function getWarnByReply(arg, data)
	if gp_type(chat) == "channel" or gp_type(chat) == "chat" then
		local function getIDreply(arg, data)
			if is_mod1(arg.chat_id, data.id_) or data.id_ == tonumber(our_id) then
				return
			else
				getWarnUser(data.id_, arg.chat_id)
		end
	end
	tdcli_function ({
		ID = "GetUser",
		user_id_ = data.sender_user_id_
		}, getIDreply, {chat_id=data.chat_id_,user_id=data.sender_user_id_})

    else
        return
    end
end
local function getWarnByUsername(arg, data)
	if arg.username then
		if is_mod1(arg.chat_id, data.id_) or data.id_ == tonumber(our_id) then
			return
		else
			getWarnUser(data.id_, arg.chat_id)
		end
	else
        return '_Can\'t find a user with that username._'
    end
end

-------------Commands------------

local function run(msg, matches)
	local warnLimit = dataLoad[tostring(msg.chat_id_)]['settings']['warning_max']
	if is_mod(msg) then
	if warnLimit then
		if matches[1]:lower() == 'getmax' then
			local msg = getMax(msg)
			return msg
		end
        if matches[1]:lower() == 'warnmax' and matches[2] then
            local msg = limitWarn(msg, matches[2])
			return msg
        end
		if matches[1]:lower() == 'getwarn' then
			if tonumber(msg.reply_to_message_id_) ~= 0 then
				tdcli_function ({
					ID = "GetMessage",
					chat_id_ = msg.chat_id_,
					message_id_ = msg.reply_to_message_id_
					}, getWarnByReply, {chat_id=msg.chat_id_})
			elseif string.match(matches[2], '^%d+$') then
				if not matches[2] then return end
				if tonumber(matches[2]) == tonumber(our_id) then
					return
				end
                    getWarnUser(matches[2], msg.chat_id_)
			else
					tdcli_function ({
						ID = "SearchPublicChat",
						username_ = matches[2]
						}, getWarnByUsername, {chat_id=msg.chat_id_,username=matches[2]})
			end
		end
		if matches[1]:lower() == 'warn' then
			if tonumber(msg.reply_to_message_id_) ~= 0 then
				tdcli_function ({
					ID = "GetMessage",
					chat_id_ = msg.chat_id_,
					message_id_ = msg.reply_to_message_id_
					}, warnByReply, {chat_id=msg.chat_id_})
			elseif string.match(matches[2], '^%d+$') then
				if not matches[2] then return end
				if tonumber(matches[2]) == tonumber(our_id) then
					return
				end
                    warnUser(matches[2], msg.chat_id_)
			else
				tdcli_function ({
					ID = "SearchPublicChat",
					username_ = matches[2]
					}, warnByUsername, {chat_id=msg.chat_id_,username=matches[2]})
			end
		end
		if matches[1]:lower() == 'unwarn' then
			if tonumber(msg.reply_to_message_id_) ~= 0 then
				tdcli_function ({
					ID = "GetMessage",
					chat_id_ = msg.chat_id_,
					message_id_ = msg.reply_to_message_id_
					}, unWarnByReply, {chat_id=msg.chat_id_})
			elseif string.match(matches[2], '^%d+$') then
				if not matches[2] then return end
				if tonumber(matches[2]) == tonumber(our_id) then
                    return
                end
                    unWarnUser(matches[2], msg.chat_id_)
			else
				tdcli_function ({
					ID = "SearchPublicChat",
					username_ = matches[2]
					}, unWarnByUsername, {chat_id=msg.chat_id_,username=matches[2]})
			end
		end
		if matches[1]:lower() == 'unwarnall' then
			if tonumber(msg.reply_to_message_id_) ~= 0 then
				tdcli_function ({
					ID = "GetMessage",
					chat_id_ = msg.chat_id_,
					message_id_ = msg.reply_to_message_id_
					}, unWarnAllByReply, {chat_id=msg.chat_id_})
			elseif string.match(matches[2], '^%d+$') then
				if not matches[2] then return end
				if tonumber(matches[2]) == tonumber(our_id) then
                    return
                end
                    unWarnAllUser(matches[2], msg.chat_id_)
			else
				tdcli_function ({
					ID = "SearchPublicChat",
					username_ = matches[2]
					}, unWarnAllByUsername, {chat_id=msg.chat_id_,username=matches[2]})
			end
		end
		else
			if matches[1]:lower() == 'warnmax' and matches[2] then
				local msg = limitWarn(msg, matches[2])
					return msg
				else
					return '_First Set Warning Range!_'
			end
    end
	end
end

return {
    patterns =
    {
        "^[!/#]([Ww][Aa][Rr][Nn][Mm][Aa][Xx]) (%d+)$",
		"^[!/#]([Gg][Ee][Tt][Mm][Aa][Xx])$",
        "^[!/#]([Ww][Aa][Rr][Nn]) (.*)$",
        "^[!/#]([Ww][Aa][Rr][Nn])$",
		"^[!/#]([Uu][Nn][Ww][Aa][Rr][Nn])$",
        "^[!/#]([Uu][Nn][Ww][Aa][Rr][Nn]) (.*)$",
		"^[!/#]([Gg][Ee][Tt][Ww][Aa][Rr][Nn]) (.*)$",
        "^[!/#]([Gg][Ee][Tt][Ww][Aa][Rr][Nn])$",
		"^[!/#]([Uu][Nn][Ww][Aa][Rr][Nn][Aa][Ll][Ll])$",
        "^[!/#]([Uu][Nn][Ww][Aa][Rr][Nn][Aa][Ll][Ll]) (.*)$",

    },
    run = run
}

