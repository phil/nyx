require_relative '../../../lib/nyx/listener'

module Nyx
  describe Listener do

    before :all do puts __FILE__; end

    let(:listener){ Listener.new }

    describe :process do
      let(:message){ mock(:message) }
      let(:matches){ mock(:match_object) }

      it "calls 'call' with the messag and the matches" do
        listener.stub(:type_match_for_message){ true }
        listener.stub(:pattern_matches_for_message){ matches }
        listener.should_receive(:call).with(message, matches)

        listener.process message
      end

      it "should not call 'calls' if the type match fails" do
        listener.stub(:type_match_for_message){ false }
        listener.stub(:pattern_matches_for_message){ matches }
        listener.should_not_receive(:call)

        listener.process message
      end

      it "should not call 'call' if the the pattern match fails" do
        listener.stub(:type_match_for_message){ true }
        listener.stub(:pattern_matches_for_message){ nil }
        listener.should_not_receive(:call)

        listener.process message
      end
    end

    describe :call do
      let(:message){ mock(:message) }
      let(:matches){ mock(:matches) }

      it "calls the method handler with the message" do
        method_handler = mock(:method_handler)
        method_handler.should_receive(:call).with(message)

        listener.stub(:method_handler){ method_handler }

        listener.call message, matches
      end

      it "calls the method handler with the message" do
        block_handler = mock(:block_handler)
        block_handler.should_receive(:call).with(message)

        listener.stub(:block_handler){ block_handler }

        listener.call message, matches
      end

    end


    describe :pattern_matches_for_message do
      before do
        listener.stub(:pattern){ /Foo Bar/ }
      end

      it "matches 'Foo Bar' in 'Mchoo Foo Bar fufu'" do 
        message = mock(:message, :body => "Mchoo Foo Bar fufu")
        listener.pattern_matches_for_message(message).should_not be_nil
        listener.pattern_matches_for_message(message)[0].should eql("Foo Bar")
      end

      it "does not match 'Foo Bar' in 'woka woka'" do 
        message = mock(:message, :body => "Woka woka")
        listener.pattern_matches_for_message(message).should be_nil
      end
    end

    describe :type_match_for_message do
      it "matches 'AnyMessage' messages" do
        listener.stub(:type){ "AnyMessage" }
        message = mock(:message, :type => "AnyMessage")
        listener.type_match_for_message(message).should be_true
      end
      it "does not match 'FooBarMessage' messages" do
        listener.stub(:type){ "NotFooBarMessage" }
        message = mock(:message, :type => "FooBarMessage")
        listener.type_match_for_message(message).should be_false
      end
    end

  end
end
