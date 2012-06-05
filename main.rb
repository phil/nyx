#! /usr/bin/env ruby
# Nyx, a personal Robot, somewhere between siri and Hubot

require 'rubygems'
require_relative "config/environment"

EM.kqueue = true if EM.kqueue?

EventMachine.run do

	Nyx::SubSystemManager.instance.load_sub_systems

	NyxWebInterface.run! :port => THE_NUMBER_OF_NYX
end

puts "bye bye..."
