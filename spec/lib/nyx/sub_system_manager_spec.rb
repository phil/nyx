require_relative "../../../lib/nyx/sub_system_manager.rb"
require_relative "../../../lib/nyx/message_manager.rb"
require 'support/singleton_helper'

class MyExampleSystem
end

module Nyx
  describe SubSystemManager do

    before do
      reset_singleton Nyx::SubSystemManager
    end

    subject { Nyx::SubSystemManager.instance }

    it "Loads SubSyetems" do

    end

    it "Loads a SubSystem" do
      
    end
    
    describe :load_sub_system do
      let(:sub_system_file){ "sub_system_file.rb" }
      let(:listeners){ [mock(:listener)] }
      let(:sub_system){ mock :sub_system, :listeners => listeners }

      it "adds listeners to the MessageManager" do
        Nyx::MessageManager.should_receive(:add_listeners).with(listeners)

        subject.should_receive(:load).with(sub_system_file)
        subject.stub(:init_sub_system){ sub_system }
        subject.load_sub_system sub_system_file
      end
    end

    describe :sub_system_class do
      it "conversts filenames to sub systems class constants" do
        subject.sub_system_class("foobar/nyx/subsystems/my_example_system.rb").should eql(MyExampleSystem)
      end
    end
      

    it "lists installed systems" do
      Nyx::SubSystemManager.instance.installed_sub_systems
    end

  end
end
