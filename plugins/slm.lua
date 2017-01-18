local function CERNER(msg, matches)
tdcli.sendMessage(chat_id, msg.id_, 1, '<b>sllm</b>', 1, 'html')
	end
end
return {
  patterns = {
    "^(slm)$",
  },
  run = CERNER
}
