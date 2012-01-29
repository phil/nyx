class Nyx::SubSystem

	# Override in subsystem for init
	def initialize *args
	end

	# Override in subsystem 
	def finalize
	end

	# Used to identify the sub system at runtime
	def name
		self.class.to_s.underscore.to_sym
	end

	# Called by sub system manager when new messages are received
	# Override ni system
	def incoming_message message
		
	end
	
end