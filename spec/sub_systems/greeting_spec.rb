require_relative '../../sub_systems/greeting'

describe Greeting do

  before :all do puts __FILE__; end

  it "listens for enter messages" do
    message = mock(:message, :type => "entermessage", :from => "foo bar")
    message.should_receive(:reply).with("Hello foo bar")

    subject.listeners.each do |listener| 
      listener.call message
    end
  end

end
