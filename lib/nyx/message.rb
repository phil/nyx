require 'ostruct'

class Nyx::Message


	attr_accessor :origin # Used for the class that generated the message
	attr_accessor :user # Use details as to who the message is from

	attr_accessor :body

	def initialize *args
		self.origin = OpenStruct.new
		self.user = OpenStruct.new
	end

	
	def incoming_message message
		
	end

end