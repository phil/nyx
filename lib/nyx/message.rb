class Nyx::Message

  attr_reader :created_at

  attr_reader :from
  attr_reader :body

  attr_reader :type

  def type
    @type ||= "AnyMessage"
  end

  def initialize attrs = Hash.new
    @created_at = Time.now
    
    @type = attrs[:type] if attrs.key?(:type)
    @body = attrs[:body] if attrs.key?(:body)
    @from = attrs[:from] if attrs.key?(:from)
  end

  def reply text
    raise "Message#reply needs overriding"
  end

  def nyx?
    self.from.blank? || !!self.from.match(/nyx/)
  end

end
