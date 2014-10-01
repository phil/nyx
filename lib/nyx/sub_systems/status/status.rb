class Status < Nyx::SubSystem

  #include Nyx::SubSystem
  listen_for /status/, :update_status

  def initialize
    Actor.current.async.broadcast_status
  end

  def update_status message
    message.reply "A'Okay"
  end

  def broadcast_status
    puts ""
    puts "broadcast_status in 2 …"
    after(2) do
      Actor[:nyx].message_manager.broadcast Status::Message.new(body: "ping", from: Status)
      Actor.current.async.broadcast_status
    end
  end

  class Message < Nyx::Message
    def reply text
      puts "Message Reply: #{text}"
    end
  end

end
