require 'em-spec/rspec'
require_relative "../../../lib/nyx/memory.rb"
require 'support/singleton_helper'

puts "\r\n"+__FILE__

# http://blog.ardes.com/2006/12/11/testing-singletons-with-ruby
# For Getting Singletons to not be singletons in tests
#require 'singleton'
#class <<Singleton
#def included_with_reset(klass)
#included_without_reset(klass)
#class <<klass
#def reset_instance
#Singleton.send :__init__, self
#self
#end
#end
#end
#alias_method :included_without_reset, :included
#alias_method :included, :included_with_reset
#end

#irb(main):026:0> MySingleton.instance
#=> #<MySingleton:0x396fc>
#irb(main):027:0> MySingleton.reset_instance
#=> MySingleton
#irb(main):028:0> MySingleton.instance
#=> #<MySingleton:0x1cd04>

module Nyx
  describe Memory do

    describe do
      include EM::Spec
      it "should be a singleton" do
        reset_singleton Nyx::Memory
        expect { Nyx::Memory.new }.to raise_error(NoMethodError)
        #memory.instance.should == Nyx::Memory.instance
        done
      end
    end

    describe :ping do
      include EM::Spec
      it "should PONG" do 
        reset_singleton Nyx::Memory
        Nyx::Memory.ping do |pong|
          pong.should eql("PONG")
          done
        end
        EM.add_timer(1){ done }
      end
    end

    describe "keys and values" do
      include EM::Spec

      it "stores keys and retrieves values" do
        reset_singleton Nyx::Memory
        Nyx::Memory.set("alpha" => "beta") do 
          Nyx::Memory.get("alpha") do |values|
            values.should eql({"alpha" => "beta"})
            done
          end
        end
      end

      it "stores more keys and retrieves values" do
        reset_singleton Nyx::Memory
        #raise memory.inspect
        Nyx::Memory.set("delta" => "gamma", "phi" => "pi") do 
          Nyx::Memory.get("delta", "phi") do |values|
            values.should eql({"delta" => "gamma", "phi" => "pi"})
            done
          end
        end
      end

    end

  end
end
