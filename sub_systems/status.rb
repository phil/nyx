class Status < Nyx::SubSystem

  listen_for /status/, :process_status

	attr_accessor :boot_time

	def initialize *args
		self.boot_time = Time.now
    EM.add_periodic_timer 30 do 
      check_load_averages
    end
	end
	
	def finalize
		#self.timer.cancel
	end

  private

  def process_status message
    message.reply "Checking System Status"

    message.reply "system: #{system_uptime}"
    message.reply "nyx: #{nyx_uptime}"

    Nyx.sub_system_manager.sub_systems.each do |sub_system|
      message.reply "#{sub_system.name}: #{sub_system.status[:status]} #{sub_system.status.to_s}"
    end
  end

	def nyx_uptime
		Time.at(Time.now - self.boot_time)
	end

  def load_averages
    
  end

  def system_uptime
    `uptime`
  end

  #load averages: 1.12 1.71 1.70
  def check_load_averages
    matches = system_uptime.match(/load averages: (?<min>[.0-9]+) (?<mid>[.0-9]+) (?<long>[.0-9]+)/)
    if matches["mid"].to_f > 1
      message = Nyx::Message.new
      message.body = "Load Averages are high"
      Nyx.message_manager.broadcast message
    end
  end
	
end
