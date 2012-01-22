class Pinger < Nyx::SubSystem

	cattr_accessor :sites
	@@sites ||= ["maniacalrobot.co.uk", "ohdram.com"]

	attr_accessor :timer

	def initialize *args

		puts "Pinger: init"
		
		self.timer = EM::PeriodicTimer.new 10 do

			Pinger.sites.each do |site|
				#puts "Pinger: ping #{site}"

				http = EM::HttpRequest.new('http://maniacalrobot.co.uk/').get
    			http.errback { p 'Uh oh' }
    			http.callback {
	    	  		#p http.response_header
		    	}	
			end
		end

	end
	
	def finalize
		self.timer.cancel
	end
	
end