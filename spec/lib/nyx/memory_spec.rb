require 'em-spec/rspec'
require_relative "../../../lib/nyx/memory.rb"
#require 'support/singleton_helper'

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

describe Nyx::Memory do

  describe :ping do
    include EM::Spec
    xit "should PONG" do 
      Nyx::Memory.ping do |pong|
        pong.should eql("PONG")
        done
      end
      EM.add_timer(1){ done }
    end
  end

  describe "keys and values" do
    include EM::Spec

    xit "stores keys and retrieves values" do
      Nyx::Memory.set("alpha" => "beta") do 
        Nyx::Memory.get("alpha") do |values|
          values.should eql({"alpha" => "beta"})
          done
        end
      end
    end

    xit "stores more keys and retrieves values" do
      Nyx::Memory.set("delta" => "gamma", "phi" => "pi") do 
        Nyx::Memory.get("delta", "phi") do |values|
          values.should eql({"delta" => "gamma", "phi" => "pi"})
          done
        end
      end
    end

  end

end
