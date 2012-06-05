class Profanity < Nyx::SubSystem

	def incoming_message message
		case message.body
		when /fuck|shit|shite|bollocks|cunt|twat/
			Nyx::SubSystemManager.instance.reply_to_message message, "Oi!"
		end
	end

end