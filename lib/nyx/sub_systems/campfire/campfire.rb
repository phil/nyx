class Campfire < Nyx::SubSystem

  #include Nyx::SubSystem

  def initialize
    Actor[:campfire] = Actor.current
    @rooms = Array.new
    connect
    join_room "Nyx"
  end

  def connect
    @campfire = Tinder::Campfire.new ENV["CAMPFIRE_SUBDOMAIN"], token: ENV["CAMPFIRE_TOKEN"]
  end

  def join_room room_name
    room = @campfire.find_room_by_name(room_name)
    room.join

    room.listen do |msg|
      message = Campfire::Message.new room, msg
      Actor[:message_manager].async.broadcast message
    end
  end

  class Message < Nyx::Message

    attr_accessor :room

    def initialize room, campfire_message
      super type: campfire_message.type, body: campfire_message.body
      @room = room
      @from = (campfire_message.user && campfire_message.user.email_address) || "nyx"
    end

    def reply text
      room.speak "#{text}"
      #puts "Replying to Campfire Message"
    end

  end

end
