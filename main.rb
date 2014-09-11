#! /usr/bin/env ruby
# Nyx, a personal Robot, somewhere between siri and Hubot

require 'rubygems'

require "bundler/setup"
Bundler.require(:default) if defined?(Bundler)

require_relative "lib/nyx"

EM.kqueue = true if EM.kqueue?

EventMachine.run do
  Signal.trap("INT")  { EventMachine.stop }
  Signal.trap("TERM") { EventMachine.stop }

	Nyx.sub_system_manager.load_sub_systems
end
