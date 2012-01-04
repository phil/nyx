#! /usr/bin/env ruby
# Nyx, a personal Robot, somewhere between siri and Hubot

#puts ENV["p"]
#ARGV.each do|a|
#  puts "Argument: #{a}"
#end
#puts ARGV[ARGV.index("-p") + 1]

require 'rubygems'
require File.expand_path("../config/environment", __FILE__)

# class NyxConnection < EventMachine::Connection
#     attr_accessor :options, :status

#     def receive_data(data)
#         puts "#{@status} -- #{data}"
#         send_data("hello\n")
#     end
# end

EM.kqueue = true if EM.kqueue?

EventMachine.run do
	
	#include BigRainbowHead::SubSystemManager
	#BigRainbowHead::SubSystem.manager.load_sub_systems
	
	# EM.start_server 'localhost', THE_NUMBER_OF_NYX, NyxConnection do |conn|
	# 	conn.options = {:my => 'options'}
	# 	conn.status = :OK
	# end

	Nyx::SubSystem.manager.load_sub_systems

	class NyxWebInterface < Sinatra::Base
		get "/" do
			"Hello World"
		end
	end

	puts "Booting website"
	NyxWebInterface.run! :port => THE_NUMBER_OF_NYX
	#Thin::Server.start NyxWebInterface, "0.0.0.0", THE_NUMBER_OF_NYX

end

puts "bye bye..."