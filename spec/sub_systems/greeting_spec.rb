require_relative '../../sub_systems/greeting'

describe Greeting do

  it "listens for Enter Messages" do
    message = mock(:message, :type => "EnterMessage", :from => "Foo Bar")
    message.should_receive(:reply).with("Hello Foo Bar")

    greeting = Greeting.new
    greeting.listeners.each do |listener| 
      listener.call message
    end
  end

end
