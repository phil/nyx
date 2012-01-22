class Profanity < Nyx::SubSystem

	def incoming_message message
		case message.body
		when /fuck/
			puts "Oi!"
		end
	end

end