class Nyx
  class Env

    def env
      @env ||= (ENV["NYX_ENV"] || "development")
    end

    def root
      @root ||= File.expand_path("#{__FILE__}../../../../")
    end

    def port
      @port ||= (ENV["NYX_PORT"] || ARGV[ARGV.index("-p") + 1] || 5000)
    end

    def to_s
      env
    end

  end

  def env
    @env ||= Env.new_link
  end

end
