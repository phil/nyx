require "em-http-request"
require 'em-spec/rspec'

EM.describe "EM Spec Examples" do

  # Wraps each exmaple in a mini EventMachine Reactor Loop
  include EM::SpecHelper

  it "waits for the 'done' method to be called" do
    em do

      puts "1: begining of example"

      # schedule block to run in 5 seconds
      EM.add_timer(5) do
        puts "4: end of example"
        done # Always call done, otherwise your example will never finish
      end

      # schedule block to run every second
      EM.add_periodic_timer(1) do
        puts "3: processing stuff"
      end

      5.times do |i|
      http = EM::HttpRequest.new('http://maniacalrobot.co.uk/astrorunner').get
      http.callback do 
        puts "  #{i}: " + http.response.scan(/h1>(.*)<\/h1/).to_s
      end
      end

      puts "2: middle of example"

    end
  end
end

