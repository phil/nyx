require 'em-spec/rspec'
require 'support/singleton_helper'
require_relative '../../../lib/nyx/message_manager'

puts "\r\n"+__FILE__

module Nyx
  describe MessageManager do

    include EM::Spec

    describe "::broadcast" do

      it "broadcasts messages" do
        reset_singleton Nyx::MessageManager

        message = mock(:message, :type => "AnyMessage")
        listener = mock(:listener)
        listener.should_receive(:process).with(message) { done }
        Nyx::MessageManager.stub(:listeners) { [listener] }
        Nyx::MessageManager.broadcast message
      end
    end

    describe "::add_listener and ::listeners" do
      it "Adds listeners" do
        reset_singleton Nyx::MessageManager

        listener = mock(:listener)
        Nyx::MessageManager.add_listener listener
        Nyx::MessageManager.listeners.should include(listener)

        done
      end
    end

  end
end
