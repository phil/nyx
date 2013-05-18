require 'em-spec/rspec'
require_relative '../../lib/nyx'
require_relative '../../sub_systems/message_store'

describe MessageStore do

  before :all do puts __FILE__; end

  describe :persistance do

    include EM::Spec

    it "listens for and stores messages" do
      message_hash = {:type => "entermessage", :from => "foobar"}
      message = mock(:message, message_hash.merge(:to_h => message_hash))

      subject.listeners.each do |listener|
        listener.call message
      end

      Nyx.memory.collection("messages").last.should == message_hash
      done
    end
  end

end
