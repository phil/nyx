require_relative "../lib/nyx/sub_system"
require_relative "../lib/nyx/message"


class Ping < Nyx::SubSystem

  listen_for /^ping$/ do |message|
    message.reply "Pong!"
  end

  listen_for /^nyx ping$/ do |message|
    message.reply "Nyx Goes PONG!"
  end

  listen_for /echo (?<text>.*)/ do |message, matches|
    #message.reply "echo …"
    message.reply matches[:text]
  end

end
