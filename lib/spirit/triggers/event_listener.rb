class EventListener

  include Celluloid

  def listen
    redis.psubscribe('events.*') do |on|
      on.pmessage do |pattern, channel, message|
        puts "##{channel}: #{message} / #{pattern}"
      end
    end
  end

  def stop_listening
    # Stop that listening!
  end

  def redis
    @redis ||= Redis.new
  end

  def triggers
    Trigger.all
  end
end
