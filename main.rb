#! /usr/bin/env ruby
# Nyx, a personal Robot, somewhere between siri and Hubot

require 'rubygems'
require File.expand_path("../config/environment", __FILE__)

EM.kqueue = true if EM.kqueue?

EventMachine.run do

	Nyx::SubSystemManager.instance.load_sub_systems

	puts "Booting website"
	NyxWebInterface.run! :port => THE_NUMBER_OF_NYX
	#Thin::Server.start NyxWebInterface, "0.0.0.0", THE_NUMBER_OF_NYX
end

puts "bye bye..."
