class Ping < Nyx::SubSystem

  listen_for /ping/ do |message|
    message.reply "Pong!"
  end

end
