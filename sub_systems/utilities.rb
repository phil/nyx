require_relative "../lib/nyx/sub_system"

class Utility < Nyx::SubSystem

  listen_for /^host (.*)$/ do |message|
    message.reply `#{message.matches}`
  end

  listen_for /^nyx ping$/ do |message|
    message.reply "Nyx Goes PONG!"
  end

  #listen_for /ping (?<in>.*)/ do |message|
    #message.reply "Pong!"
  #end

end
