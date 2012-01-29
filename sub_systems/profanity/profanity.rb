class Profanity < Nyx::SubSystem

	def incoming_message message
		case message.body
		when /fuck/
			Nyx::SubSystemManager.instance.send_message_to_room "Oi!", message.room_id
		end
	end

end