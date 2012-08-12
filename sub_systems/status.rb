class Status < Nyx::SubSystem

  listen_for /status/ do |message|
    message.reply "Checking System Status"
    Nyx::SubSystemManager.sub_systems.each do |sub_system|
      message.reply sub_system.status.to_s
    end
  end

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
		    message.reply str
		end
	rescue
		return
	end

	def uptime
		Time.at(Time.now - self.boot_time)
	end
	
end
