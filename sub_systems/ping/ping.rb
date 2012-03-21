class Ping < Nyx::SubSystem

  attr_accessor :boot_time

  def initialize *args

  end

  def finalize

  end

  def incoming_message message
    if message.body.match /ping/		
      #Nyx::SubSystemManager.instance.reply_to_message message, "PONG!"
      message.reply "Pong!"
    end
  end
end
