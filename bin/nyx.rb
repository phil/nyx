#! /usr/bin/env ruby
# nyx, a personal maniacal robot …

require 'rubygems'

require "bundler/setup"
Bundler.require(:default) if defined?(Bundler)

require_relative "../lib/nyx"

supervisor = Nyx.supervise_as :nyx
trap("INT") { supervisor.terminate; exit }
sleep
