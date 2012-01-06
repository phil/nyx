class NyxWebInterface < Sinatra::Base
		get "/" do
			"Hello World uptime: #{THE_UPTIME_OF_NYX}"
		end
	end