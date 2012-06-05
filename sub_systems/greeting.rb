require_relative "../lib/nyx/sub_system"

class Greeting < Nyx::SubSystem

  listen_for "EnterMessage" => /(.*)/ do |message|
    message.reply "Hello #{message.from}"
  end

end
