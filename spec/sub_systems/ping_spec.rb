require_relative '../../sub_systems/greeting'

describe Greeting do

  it "listens for Enter Messages" do
    message = mock(:message)
    message.should_receive(:reply).with("Pong!")

    ping = Ping.new
    ping.listening_for[/(.*)/].call message
  end

end
