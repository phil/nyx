module Nyx
  class Env

    class << self
      attr_accessor :env
      attr_accessor :root
      attr_accessor :port

      def env
        @env ||= (ENV["NYX_ENV"] || "development")
      end

      def root
        @root ||= File.expand_path("#{__FILE__}../../../../")
      end

      def port
        @port ||= (ENV["NYX_PORT"] || ARGV[ARGV.index("-p") + 1] || 5000)
      end

    end

  end
end
