class Nyx::Message

  attr_accessor :from
  attr_accessor :body

  attr_accessor :type

  attr_accessor :matches

  def initialize *args
  end

  def reply text
    raise "Message#reply needs overriding"
  end

  def nyx?
    self.from == "nyx@maniacalrobot.co.uk"
  end

end
