class NyxWebInterface < Sinatra::Base

  set :views, File.join(Nyx::Env.root, "web", "views")
  set :public, File.join(Nyx::Env.root, "web", "public")
  set :static, true

  get "/" do
    @iss = Nyx::SubSystemManager.instance.installed_sub_systems
    @uptime = Nyx::SubSystemManager.installed(:status).uptime
    erb :base
  end


end
