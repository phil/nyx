require 'em-spec/rspec'
require 'support/singleton_helper'
require_relative '../../../lib/nyx/message_manager'

puts "\r\n"+__FILE__

describe Nyx::MessageManager do

  include EM::Spec

  describe :broadcast do

    it "broadcasts messages" do
      message = mock(:message, :type => "AnyMessage")
      listener = mock(:listener)
      listener.should_receive(:process).with(message) { done }
      subject.stub(:listeners) { [listener] }
      subject.broadcast message
    end
  end

  #describe "::add_listener and ::listeners" do
    #xit "Adds listeners" do
      #listener = mock(:listener)
      #Nyx::MessageManager.add_listener listener
      #Nyx::MessageManager.listeners.should include(listener)

      #done
    #end
  #end

end
