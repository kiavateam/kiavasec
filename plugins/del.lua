--Start By @Tele_Sudo
local function delmsg (arg,data)
for k,v in pairs(data.messages_) do
tdcli.deleteMessages(v.chat_id_,{[0] = v.id_})
end
end
local function run(msg, matches)
    if matches[1] == 'del' then
    if msg.chat_id_:match("^-100") then
       if is_sudo(msg) then
          if tonumber(matches[2]) > 100 or tonumber(matches[2]) < 1 then
             pm = '*100 Number Of Chat was Deleted'
             tdcli.sendMessage(msg.chat_id_, data.msg.id_, 1, pm, 1, 'html')
             else
          tdcli_function ({
    ID = "GetChatHistory",
    chat_id_ = msg.chat_id_,
    from_message_id_ = 0,
    offset_ = 0,
    limit_ = tonumber(matches[2])
  }, delmsg, nil)
             pm ='*'..matches[2]..'* Deleted Msg'
             tdcli.sendMessage(msg.chat_id_, msg.id_, 1, pm, 1, 'html')
         end
     end
 else pm ='Sorry Just you can in supergroup'
    tdcli.sendMessage(msg.chat_id_, msg.id_, 1, pm, 1, 'html')
end
end
end

return {
    patterns = {
        '^[!#/]([Dd][Ee][Ll]) (%d*)$'
    },
    run = run
}
