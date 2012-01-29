class NyxWebInterface < Sinatra::Base

	set :views, File.join(THE_ROOT_OF_NYX, "web", "views")
	set :public, File.join(THE_ROOT_OF_NYX, "web", "public")
	set :static, true

		get "/" do
			@iss = Nyx::SubSystemManager.instance.installed_sub_systems
			@uptime = Nyx::SubSystemManager.installed(:status).uptime
			erb :base
		end
	end