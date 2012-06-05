require_relative "../../../lib/nyx/memory.rb"
require 'em-spec/rspec'

module Nyx
  describe Memory do

    it "should be a singleton" do
      expect { Nyx::Memory.new }.to raise_error(NoMethodError)
      Nyx::Memory.instance.should === Nyx::Memory.instance
    end

    #describe :store do
      #include EM::SpecHelper

      #it "stores key value pairs" do
        #em do
          #Nyx::Memory.instance.should_receive(:foo=).with("wow")
          #Nyx::Memory.store "foo" => "bar"
          #done
        #end
      #end
    #end

    #describe :retrive do
      #include EM::SpecHelper
      #it "retrives values" do
        #em do
          #Nyx::Memory.retrieve("foo"){|rtn|
            #rtn.should eql("bar")
          #}
          #done
        #end
      #end
    #end
    
    describe "keys and values" do
      include EM::Spec
      it "stores keys and retreives values" do
        Nyx::Memory.set("foo" => "bar") do 
          Nyx::Memory.get(["foo"]) do |hsh|
            hsh.keys.should include("foo")
            hsh["foo"].should eql("bar")
          end
        end
        done
      end
    end

  end
end
