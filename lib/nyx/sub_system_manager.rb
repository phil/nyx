require 'singleton'

class Nyx::SubSystemManager
	
	include Singleton
	
	attr_accessor :installed_sub_systems

	def initialize
		self.installed_sub_systems ||= Array.new
	end
	
	def load_sub_systems
		
		Dir.glob(File.join("**", "sub_systems", "*")) do |sub_system_dir|
			
			puts File.expand_path(sub_system_dir)
			
			sub_system_file = File.join File.expand_path(sub_system_dir), File.basename(sub_system_dir) + ".rb"
			puts sub_system_file
			
			if File.exists? sub_system_file
				self.load_sub_system sub_system_file#, :setup_watcher => true
			end
			
		end
		
	end
	
	def load_sub_system sub_system_file, opts = Hash.new
		#opts[:setup_watcher] ||= true
		load sub_system_file
		
		self.installed_sub_systems << File.basename(sub_system_file, File.extname(sub_system_file)).classify.constantize.new
		
		#EM.watch_file sub_system_file, BigRainbowHead::SubSystemFileWatch if opts[:setup_watcher]
	end
	

	# Sends the incoming message to all 
	def broadcast_incoming_message message
		# Let all the subsystems know about it
		installed_sub_systems.each do |sub_system|
			EM.next_tick do
				puts "broadcasting message to #{sub_system.name}"
				sub_system.incoming_message(message)
			end
		end
	end

	def broadcast_outgoing_message message
		
	end

	def send_message message
		
	end

	def send_message_to_room message, room_id
		puts "sending message to room #{room_id}"
		# find campfire
		campfire = Nyx::SubSystemManager.instance.installed_sub_systems.detect { |sys| sys.name == :campfire }
		room = campfire.rooms.detect { |room| room.id == room_id }
		room.speak message
	end


	def self.installed sub_system
		Nyx::SubSystemManager.instance.installed_sub_systems.detect { |sys| sys.name == sub_system }
	end
	
end