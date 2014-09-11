require "thread"
require "logger"

class Nyx
  class Log

    # inspired from
    # https://github.com/jbasinger/log_queue/blob/master/log_queue.rb

    def initialize
      @shutdown = false
      @thread = Thread.new do
        get_to_da_choppa
      end
    end

    def get_to_da_choppa()

      while (!@shutdown)
        if (queue.length > 0)
          val = ""
          mutex.synchronize do
            val = queue.shift()
          end
          logger.add(val[0],val[1])
        end
        sleep(0.1)
      end
    end

    def finalize
      @shutdown = true
      @thread.join
    end

    def add(severity, msg=nil)
      return if @shutdown

      mutex.synchronize do
        queue.push([severity,msg])
      end
    end

    def debug(msg=nil)
      add(Logger::Severity::DEBUG, msg)
    end

    def info(msg=nil)
      add(Logger::Severity::INFO, msg)
    end

    def warn(msg=nil)
      add(Logger::Severity::WARN, msg)
    end

    def error(msg=nil)
      add(Logger::Severity::ERROR, msg)
    end

    def fatal(msg=nil)
      add(Logger::Severity::FATAL, msg)
    end

    def unknown(msg=nil)
      add(Logger::Severity::UNKNOWN, msg)
    end

    protected

    def queue
      @array ||= Array.new
    end

    def mutex
      @mutex ||= Mutex.new
    end

    def logger
      @log = Logger.new(STDOUT) # TODO Make this settable
    end

  end

  attr_accessor :log

  def self.log
    instance.log ||= Nyx::Log.new
  end

end
