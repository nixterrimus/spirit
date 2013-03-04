class EventListener

  include Celluloid

  def listen
    redis.psubscribe(channel_to_listen_on) do |c|
      c.pmessage { |ptrn, channel, message| event_received(channel, message) }
    end
  end

  def event_received(channel, message)
    event = Event.new(channel: channel, raw_payload: message)
    triggers.each { |trigger| trigger.apply(event) }
  end

  def stop_listening
    redis.psubscribe(channel_to_listen_on)
  end

  def triggers
    Trigger.all
  end

  private

  def redis
    @redis ||= Redis.new
  end

  def channel_to_listen_on
    'events.*'
  end
end
