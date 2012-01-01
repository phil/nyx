require "bundler/setup"

THE_NUMBER_OF_NYX = ARGV[ARGV.index("-p") + 1] # Get Port number from command line
# THE_ROOT_OF_NYX = File.expand_path("#{__FILE__}/../../")

#ENV['BUNDLE_GEMFILE'] = File.expand_path("Gemfile")
#Bundler.setup
Bundler.require(:default) if defined?(Bundler)
#Bundler.require(:default, (@env || "development")) if defined?(Bundler) # For loading developemnt gems

# Load Libs
#Dir.glob(File.join("**", "lib", "*.rb")) do |rb|
#	require File.expand_path(rb)
#end