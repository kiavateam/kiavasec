 	if text:match("^[#!/]del (%d+)$") and is_mod(msg.sender_user_id_, msg.chat_id_) then
       local delnumb = {string.match(text, "^[#/!](del) (%d+)$")} 
	   if tonumber(delnumb[2]) > 100 then
			send(msg.chat_id_, msg.id_, 1, 'Error\nuse /del [1-100]', 1, 'md')
else
       local id = msg.id_ - 1
        for i= id - delnumb[2] , id do 
        delete_msg(msg.chat_id_,{[0] = i})
        end
			send(msg.chat_id_, msg.id_, 1, '> '..delnumb[2]..' Last Msgs Has Been Removed.', 1, 'md')
    end
	end
