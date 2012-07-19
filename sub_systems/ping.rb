require_relative "../lib/nyx/sub_system"

class Ping < Nyx::SubSystem

  listen_for /^ping$/ do |message|
    message.reply "Pong!"
  end

  listen_for /^nyx ping$/ do |message|
    message.reply "Nyx Goes PONG!"
  end

  #listen_for /ping (?<in>.*)/ do |message|
    #message.reply "Pong!"
  #end


end
