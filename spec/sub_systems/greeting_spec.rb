require_relative '../../sub_systems/greeting'

describe Greeting do

  it "listens for Enter Messages" do
    message = mock(:message, :type => "EnterMessage", :from => "Foo Bar")
    message.should_receive(:reply).with("Hello Foo Bar")

    greeting = Greeting.new
    #raise greeting.listeners.inspect
    greeting.listeners.each do |listener| 
      #raise listener.inspect
      listener[:handler].call message if listener[:type] == "EnterMessage"
    end
  end

end
