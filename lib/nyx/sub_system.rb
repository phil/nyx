class Nyx::SubSystem
	
	# Convenience method
	def self.manager
		puts "loading manager"
		Nyx::SubSystemManager.instance
	end

	# Override in subsystem for init
	def initialize *args
	end

	# Override in system 
	def finalize
	end
	
end