local function CerNer(msg, matches)
tg.sendMessage(msg.chat_id, 0, 0,  "انلاینم کونی", 0)
end
return {
  patterns = {
    "^(ping)$",
  },
  run = CerNer
}
