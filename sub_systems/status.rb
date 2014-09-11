class Status < Nyx::SubSystem

  listen_for /status/, :process_status

	attr_accessor :boot_time

	def initialize *args
		self.boot_time = Time.now
	end
	
  private

  def process_status message
    message.reply "Checking System Status"

    message.reply "nyx: #{nyx_uptime}"

    Nyx.sub_system_manager.sub_systems.each do |sub_system|
      message.reply "#{sub_system.name} OKAY"
      #message.reply "#{sub_system.name}: #{sub_system.status[:status]} #{sub_system.status.to_s}"
    end
  end

	def nyx_uptime
		Time.at(Time.now - self.boot_time)
	end
	
end
