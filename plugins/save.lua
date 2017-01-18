local function save_value(msg, name, value)
  if (not name or not value) then
    return
  end
  local hash = nil
  if msg.to.type == 'channel' then
    hash = 'chat:'..msg.to.id..':variables'
  end
    if msg.to.type == 'chat' then
    hash = 'chat:'..msg.to.id..':variables'
  end
  if msg.to.type == 'user' then
    hash = 'user:'..msg.from.id..':variables'
  end
  if hash then
    redis:hset(hash, name, value)
    return "Saved "..name.." the "..value
  end
end
--get--
local function get_variables_hash(msg)
  if msg.to.type == 'channel' then
    return 'chat:'..msg.to.id..':variables'
  end
    if msg.to.type == 'chat' then
    return 'chat:'..msg.to.id..':variables'
  end
  if msg.to.type == 'user' then
    return 'user:'..msg.from.id..':variables'
  end
end
local function list_variables(msg)
  local hash = get_variables_hash(msg)

  if hash then
    local names = redis:hkeys(hash)
    local text = ''
    for i=1, #names do
      text = text..names[i]..'\n'
    end
    return text
  end
end
local function get_value(msg, var_name)
  local hash = get_variables_hash(msg)
  if hash then
    local value = redis:hget(hash, var_name)
    if not value then
      return
    else
      return value
    end
  end
end

--------------------------------------------------------------
local function get_variables_hash(msg)
  if msg.to.type == 'chat' or msg.to.type == 'channel' then
    return 'chat:'..msg.to.id..':variables'
  end
end 

local function get_value(msg, var_name)
  local hash = get_variables_hash(msg)
  if hash then
    local value = redis:hget(hash, var_name)
    if not value then
      return
    else
      return '\n'..value
    end
  end
end

local function del_value(msg, name)
  local hash = get_variables_hash(msg)
  redis:hdel(hash, name)
  return ''..name..'  removed'
end

function clear_value(msg, name)  
  local hash = get_variables_hash(msg)
  redis:del(hash, name)
  return 'cleaned'
end

local function list_variables_chat(msg)
  local hash = get_variables_hash(msg)
  if hash then
    local names = redis:hkeys(hash)
    local text = 'List saved :\n\n'
    for i=1, #names do
      text = text..'> '..names[i]..'\n'
    end
    return text
  else
  return 
  end
end

local function run (msg, matches)
if matches[1] == 'save' and matches[2] == "+" then
if is_owner(msg) then
    local name = string.sub(matches[3], 1, 50)
  local value = string.sub(matches[4], 1, 1000)
  local text = save_value(msg, name, value)
  return text
end
end
if matches[1] == 'get' and is_owner(msg) then
    if matches[2] then
    return get_value(msg, matches[2])
  else
    return list_variables(msg)
  end
end
if matches[1]:lower() == 'savelist' and is_owner(msg) then
return list_variables_chat(msg)
  end
  if matches[1] == 'clean' and matches[2] == 'savelist' then
  if is_owner(msg) then
  local asd = '1'
    return clear_value(msg, asd)
	end
	end
if matches[1] == 'save' and matches[2] == "-" then
if is_owner(msg) then
  local name = string.sub(matches[3], 1, 50)
  local text = del_value(msg, name)
  return text
end
end
end

return{
patterns = {
"^[!/](save) (+) ([^%s]+) (.*)$",
    "^[!/](get) (.*)$",
	"^[!/](save) (-) (.*)$",
	"^[!/](savelist)$",
	"^[!/](clean) (.*)$",
	},
	run = run
}
--------------Powered by @shakh_telegram_bot : mamad datak ghadim :)
--------------team @datak_team
