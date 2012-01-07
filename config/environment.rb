require "bundler/setup"

begin
puts ARGV.inspect
THE_NUMBER_OF_NYX = ARGV[ARGV.index("-p") + 1] # Get Port number from command line
rescue
	THE_NUMBER_OF_NYX = 5000
end
puts "NYX Port: #{THE_NUMBER_OF_NYX}"

THE_ROOT_OF_NYX = File.expand_path("#{__FILE__}/../../")
puts "NYX Root: #{THE_ROOT_OF_NYX}"

THE_UPTIME_OF_NYX = 0

#ENV['BUNDLE_GEMFILE'] = File.expand_path("Gemfile")
#Bundler.setup
Bundler.require(:default) if defined?(Bundler)
#Bundler.require(:default, (@env || "development")) if defined?(Bundler) # For loading developemnt gems

#Load Libs
Dir.glob(File.join(THE_ROOT_OF_NYX, "**", "lib", "*.rb")) do |rb|#
	puts rb
	require File.expand_path(rb)
end

