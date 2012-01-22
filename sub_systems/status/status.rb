class Status < Nyx::SubSystem

	attr_accessor :boot_time

	def initialize *args
		self.boot_time = Time.now
	end
	
	def finalize
		self.timer.cancel
	end

	def incoming_message message
		puts "status check"
		if message.body.match /nyx status/
			puts "status check!"
			str = ""
			str << "Uptime: #{uptime}"		
			Nyx::SubSystemManager.instance.send_message_to_room str, message.room_id
		end
	rescue
		return
	end

	def uptime
		Time.at(Time.now - self.boot_time)
	end
	
end