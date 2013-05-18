class NyxWebInterface < Sinatra::Base

  set :views, File.join(Nyx.root, "web", "views")
  set :public_folder, File.join(Nyx.root, "web", "public")
  set :static, true

  get "/" do
    @iss = Nyx.sub_system_manager.installed_sub_systems
    @uptime = Nyx.sub_system_manager.installed(:status).system_uptime
    erb :base
  end


end
