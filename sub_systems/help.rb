require_relative "../lib/nyx/sub_system"

class Help < Nyx::SubSystem

  def incoming_message message
    message.body.scan /help (.*)/ do |s|
      message.reply "you want help on #{s}?"
    end
  end

end
