class Nyx::Message

  attr_reader :created_at

  attr_accessor :from
  attr_accessor :body

  attr_accessor :type

  def type
    @type ||= "AnyMessage"
  end

  def initialize attrs = Hash.new
    @created_at = Time.now
    self.type = attrs[:type] if attrs.key?(:type)
    self.body = attrs[:body] if attrs.key?(:body)
    self.from = attrs[:from] if attrs.key?(:from)
  end

  def reply text
    raise "Message#reply needs overriding"
  end

  def nyx?
    self.from == "nyx@maniacalrobot.co.uk"
  end

  def to_h
    hsh = {class: self.class.to_s}
    instance_variables.each do |ivar|
      hsh[ivar.to_s.gsub(/@/, "").to_sym] = instance_variable_get(ivar).to_s
    end
    hsh
  end

end
