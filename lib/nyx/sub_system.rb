class Nyx::SubSystem
	
	# Convenience method
	# def self.manager
	# 	Nyx::SubSystemManager.instance
	# end

	# Override in subsystem for init
	def initialize *args
	end

	# Override in system 
	def finalize
	end


	def name
		self.class.to_s.underscore.to_sym
	end

	def incoming_message message
		
	end
	
end