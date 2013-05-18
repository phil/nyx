require_relative "../../../lib/nyx/sub_system_manager.rb"
#require_relative "../../../lib/nyx/message_manager.rb"

class MyExampleSystem
end

describe Nyx::SubSystemManager do

  before :all do puts __FILE__; end

  it "Loads SubSyetems" do

  end

  it "Loads a SubSystem" do

  end

  describe :load_sub_system do
    let(:sub_system_file){ "sub_system_file.rb" }
    let(:listeners){ [mock(:listener)] }
    let(:sub_system){ mock :sub_system, :listeners => listeners }
    let(:message_manager) { mock :message_manager, :to_sym => :message_manager }


    it "adds listeners to the MessageManager" do
      message_manager.should_receive(:add_listeners).with(listeners)
      Nyx.stub(:message_manager){message_manager}

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


  xit "lists installed systems" do
    Nyx::SubSystemManager.instance.installed_sub_systems
  end

end
