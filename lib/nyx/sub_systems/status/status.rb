class Status < Nyx::SubSystem

  #include Nyx::SubSystem
  listen_for /status/, :update_status

  def update_status
    
  end

end
