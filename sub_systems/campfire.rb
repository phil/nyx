class Campfire < Nyx::SubSystem

  CAMPFIRE_SUB_DOMAIN = "maniacalrobot"

  CAMPFIRE_NYX_EMAIL = "nyx@maniacalrobot.co.uk"
  CAMPFIRE_NYX_API_KEY = "24812604289b7332546dbb4fcbea1502115698b4"

  attr_accessor :campfire
  attr_accessor :rooms

  def initialize *args
    self.rooms = Array.new
    connect

    Nyx::Memory.get("campfire_room") do |value|
      enter_room value
    end
  end

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

      process_message msg
      #case msg.type
      #when "TextMessage"
        #process_text_message msg

      #when "PasteMessage"
      #when "SoundMessage"

      #when "AdvertisementMessage"

      #when "AllowGuestsMessage"
      #when "DisallowGuestsMessage"
      #when "IdleMessage"
      #when "KickMessage"

      #when "EnterMessage"
        #room.speak "Hello #{msg}"
        
      #when "LeaveMessage"

      #when "SystemMessage"
      #when "TimestampMessage"
      #when "TopicChangeMessage"
      #when "UnidleMessage"
      #when "UnlockMessage"
      #when "UploadMessage"

      #else
        #puts "Uknown Message Type #{msg.type}"
        #Nyx::Log.warn "Unknown Message Type: #{msg.type} for #{msg}"
      #end
    }
    self.rooms << room
  end

  def incoming_message message
    #unless message.user_email_address == "nyx@maniacalrobot.co.uk"

    #end
  end

  def process_message msg
    message = Campfire::Message.new
    message.room = self.rooms.detect{|room| room.id == msg.room_id}
    message.body = msg.body
    message.type = msg.type

    # Need to store how to reply to this message
    #message.origin.subsystem = self.subsystem
    unless msg.user.nil?
      message.from = msg.user.email_address
    end

    if message.from == CAMPFIRE_NYX_EMAIL
      #puts "nyx message in: #{msg}"
    else
      EM.next_tick {
        Nyx::SubSystemManager.instance.broadcast_incoming_message message
      }
    end
  end

  class Message < Nyx::Message
    attr_accessor :room
    def reply text
      room.speak "@#{self.from} #{text}"
    end
  end

  def subsystem_status
    {
      :rooms => self.rooms
    }
  end

  def help
    {
      :command => "campfire:<COMMAND>"
    }
  end

  def help_extended
    {
      :commands => [
        "list",
        "add"
      ]
    }
  end

  private

  def credentials
    
  end

  def rooms_to_enter
    
  end


end


__END__

<Hashie::Mash 
  body=nil
  created_at=2012-03-25 21:28:37 +0100 
  id=529784821 
  room_id=474233 
  starred="false" 
  type="EnterMessage" 

  user=#<Hashie::Mash 
    admin=true 
    avatar_url="http://asset0.37img.com/global/missing/avatar.gif?r=3" 
    created_at=2012-01-08 10:42:56 +0000 
    email_address="phil@maniacalrobot.co.uk" 
    id=1094437 
    name="Phil Balchin" 
    type="Member">
>
<Hashie::Mash 
  body="Hello" 
  created_at=2012-03-25 21:28:40 +0100 
  id=529784830 
  room_id=474233 
  starred="false" 
  type="TextMessage" 

  user=#<Hashie::Mash 
    admin=false 
    avatar_url="http://asset0.37img.com/global/missing/avatar.gif?r=3" 
    created_at=2012-01-14 21:46:05 +0000 
    email_address="nyx@maniacalrobot.co.uk" 
    id=1100831 
    name="Nyx" 
    type="Member">
>
