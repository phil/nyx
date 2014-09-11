require_relative "../lib/nyx/sub_system"

class Greeting < Nyx::SubSystem

  listen_for({"EnterMessage" => /(.*)/}, :greeting)
  
  def greeting message
    message.reply colloquial
  end

  def colloquial
    (general_greetings | daytime_greetings).sample
  end

  protected

  def general_greeting
    general_greetings.sample
  end

  def daytime_greetings
    case Time.now.hour
    when 0..12
      morning_greetings
    when 13..17
      afternoon_greetings
    when 18..24
      evening_greetings
    end
  end
    
  def general_greetings
    ["good day", "hello", "welcome"]
  end

  def morning_greetings
    ["good morning"]
  end

  def afternoon_greetings
    ["good afternoon"]
  end

  def evening_greetings
    ["good evening"]
  end

end
