class Thing

  attr_accessor :name # the main name
  attr_accessor :aliases # array other names

  attr_accessor :type
  attr_accessor :attributes # hash/json style object

  def using
    Thing.find_by_name "foobar"
  end

  def message_parsing message
    #message.tokens = 
  end

  def learn 
    /(something) is a (person)/
    /i am (status)/
  end

  def to_h
    #collect all instance vars
  end

  module Person
    attr_accessor :email
  end
  module Website
    attr_accessor :address
  end

end
