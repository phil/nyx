require_relative "../../../lib/nyx/sub_system.rb"

class SubSystemExample < Nyx::SubSystem
  command :add, "Adds something to the SubSystem" do
    SubSystemExample.add_method_test
  end

  listen_for /alpha/ do |message|
    message.reply "Alpha Response"
  end

  listen_for "LeaveMessage" => /alpha/ do |message|
    message.reply "Another Alpha Response"
  end


  listen_for /beta/, :beta_action

  listen_for "EnterMessage" => /(.*)/ do |message|
    message.reply "Welcome"
  end

  def beta_action message
    message.reply "Beta Response"
  end

end

describe SubSystemExample do

  before :all do puts __FILE__; end


  describe "Sub System Commands" do
    it "has an 'add' command" do
      ex = SubSystemExample.new
      SubSystemExample.commands.should include(:add => "Adds something to the SubSystem")
    end
    it "responds to :add command" do
      SubSystemExample.should_receive(:add_method_test)

      ex = SubSystemExample.new
      ex.add
    end
  end

  describe "Sub System Listen Hooks" do
    it "listens for /alpha/" do
      ex = SubSystemExample.new
      ex.listeners.detect { |listener| listener.pattern == /alpha/ }.should_not be_nil
    end
    it "listens for /beta/" do
      ex = SubSystemExample.new
      ex.listeners.detect { |listener| listener.pattern == /beta/ }.should_not be_nil
    end

    it "responds to 'alpha'" do
      message = mock(:message)
      message.should_receive(:reply).with("Alpha Response")

      ex = SubSystemExample.new
      ex.listeners.detect { |listener| listener.pattern == /alpha/ }.call(message)
    end

    it "responds to another 'alpha'" do
      message = mock(:message)
      message.should_receive(:reply).with("Another Alpha Response")

      ex = SubSystemExample.new
      ex.listeners.detect { |listener| listener.type == "LeaveMessage" && listener.pattern == /alpha/ }.call(message)
    end

    it "responds to 'beta'" do
      message = mock(:message)
      message.should_receive(:reply).with("Beta Response")

      ex = SubSystemExample.new
      ex.listeners.detect { |listener| listener.pattern == /beta/ }.call(message)
    end


  end

  describe :tag do
    it "has a name" do
      ex = SubSystemExample.new
      ex.tag.should eql(:sub_system_example)
    end
  end

  describe :status do
    it "has a status" do
      pending
      ex = SubSystemExample.new
      ex.status
    end
  end

end
