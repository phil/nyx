#! /usr/bin/env ruby
# Nyx, a personal Robot, somewhere between siri and Hubot

#puts ENV["p"]
#ARGV.each do|a|
#  puts "Argument: #{a}"
#end
#puts ARGV[ARGV.index("-p") + 1]

require 'rubygems'
puts "RUBY: #{RUBY_PLATFORM}"
require File.expand_path("../config/environment", __FILE__)
require File.expand_path("../web/web", __FILE__)

# class NyxConnection < EventMachine::Connection
#     attr_accessor :options, :status

#     def receive_data(data)
#         puts "#{@status} -- #{data}"
#         send_data("hello\n")
#     end
# end

EM.kqueue = true if EM.kqueue?

EventMachine.run do

	# module TcpSocketInterface
	# end

	# EventMachine.start_server '127.0.0.1', 5001, TcpSocketInterface do |connection|
		
	# end
	
	#include BigRainbowHead::SubSystemManager
	#BigRainbowHead::SubSystem.manager.load_sub_systems
	
	# EM.start_server 'localhost', THE_NUMBER_OF_NYX, NyxConnection do |conn|
	# 	conn.options = {:my => 'options'}
	# 	conn.status = :OK
	# end

	# Nyx::SubSystem.manager.load_sub_systems

	

	puts "Booting website"
	NyxWebInterface.run! :port => THE_NUMBER_OF_NYX
	#Thin::Server.start NyxWebInterface, "0.0.0.0", THE_NUMBER_OF_NYX

	EventMachine.add_periodic_timer 2 do
		puts "fire!"
	end

end

puts "bye bye..."