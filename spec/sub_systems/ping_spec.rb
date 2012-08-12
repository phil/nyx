require_relative '../../sub_systems/ping'

describe Ping do

  before :all do puts __FILE__; end

  it "listens for Enter Messages" do
    message = mock(:message)
    message.should_receive(:reply).with("Pong!")

    ping = Ping.new
    ping.listeners[0].call message
  end

  it "pings back your message" do
    pending
    message = mock(:message)
    message.should_receive(:reply).with("Pong: Foo Bar") { done }

    ping = Ping.new
    ping.listeners[0].call message
  end

end
