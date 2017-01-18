local function CERNER(msg, matches)
tdcli.forwardMessages(chat_id, chat_id,{[0] = reply_id}, 0)
	end
return {
  patterns = {
    "^[#!/](fwd)$",
  },
  run = CERNER
}
