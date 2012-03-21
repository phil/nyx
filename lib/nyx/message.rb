class Nyx::Message

  attr_accessor :from
  attr_accessor :body

  def initialize *args
  end

  def reply text
    raise "Message#reply needs overriding"
  end

end
