module Spirit
  class IntentListener
    attr_reader :environment
    def initialize(environment, config={})
      @environment = environment
    end

    def listen
      redis.psubscribe(channel_to_listen_on) do |c|
        c.pmessage { |ptrn, channel, message| intent_received(channel, message) }
      end
    end

    def intent_received(intent_identifier, params)
      logger.info "Intent: #{intent_identifier} | params: #{params}"
      Responder.new(intent_identifier, params).apply
    rescue
      logger.error "Failed to apply #{intent_identifier}"
    end


    private

    def channel_to_listen_on
      'intents.spirit.*'
    end

    def redis
      @redis ||= Redis.new
    end

    def logger
      @logger ||= Logger.new(STDOUT)
    end

  end
end
