class EventListener

  include Celluloid

  # Gets the event and translates that event into a proper class or discards it
  #   For example events.sunrise might become Event::Sun::Sunrise
  def listen
    redis.psubscribe('events.*') do |on|
      on.pmessage do |pattern, channel, message|
        puts "##{channel}: #{message} / #{pattern}"
        Event.new(channel: channel, raw_payload: message)
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
