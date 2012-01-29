class Campfire < Nyx::SubSystem

	CAMPFIRE_SUB_DOMAIN = "maniacalrobot"

	CAMPFIRE_NYX_EMAIL = "nyx@maniacalrobot.co.uk"
	CAMPFIRE_NYX_API_KEY = "24812604289b7332546dbb4fcbea1502115698b4"

	attr_accessor :campfire
	attr_accessor :rooms

	def initialize *args
		#self.campfire
		self.rooms = Array.new

		connect

		enter_room "Nyx"
	end

	# Override in system 
	def finalize
		self.rooms.each do |room|
			EM.next_tick do
				room.leave
			end
		end
	end

	def connect
		self.campfire ||= Tinder::Campfire.new CAMPFIRE_SUB_DOMAIN, :token => CAMPFIRE_NYX_API_KEY
	end

	def enter_room name
		room = self.campfire.find_room_by_name(name)
		room.join
		room.listen { |msg|

			Nyx::Log.info "#{msg}"

			message = Nyx::Message.new
			message.room_id = msg.room_id
			message.body = msg.body

			case msg.type
			when "TextMessage"
				process_text_message msg

			when "PasteMessage"
			when "SoundMessage"

			when "AdvertisementMessage"

			when "AllowGuestsMessage"
			when "DisallowGuestsMessage"
			when "IdleMessage"
			when "KickMessage"
			
			when "EnterMessage"
				room.speak "Hello #msg"
			when "LeaveMessage"

			when "SystemMessage"
			when "TimestampMessage"
			when "TopicChangeMessage"
			when "UnidleMessage"
			when "UnlockMessage"
			when "UploadMessage"
						
			else
				puts "Uknown Message Type #{msg.type}"
			end



# 			TextMessage (regular chat message),
# PasteMessage (pre-formatted message, rendered in a fixed-width font),
# SoundMessage (plays a sound as determined by the message, which can be either “rimshot”, “crickets”, or “trombone”),
# TweetMessage (a Twitter status URL to be fetched and inserted into the chat)


		}
		self.rooms << room
	end

	def incoming_message message
		#unless message.user_email_address == "nyx@maniacalrobot.co.uk"

		#end
	end

	def reply message
		
	end


	def process_text_message msg
		message = Nyx::Message.new
		message.room_id = msg.room_id
		message.body = msg.body

		# Need to store how to reply to this message
		#message.origin.subsystem = self.subsystem
		unless msg.user.nil?
			message.user_email_address = msg.user.email_address
		end

		if msg.user && msg.user.email_address == CAMPFIRE_NYX_EMAIL
			#puts "nyx message in: #{msg}"
		else
			puts "processing text message"
			EM.next_tick {
				Nyx::SubSystemManager.instance.broadcast_incoming_message message
			}
		end
	end

end