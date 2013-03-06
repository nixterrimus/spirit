module EventBus
  class << self
    def fire_event(event, message={})
      puts "#{formatted_event(event)}: #{formatted_message(message)}"
    end

    private

    def formatted_event(event)
      "zapp.event.#{event}"
    end

    def formatted_message(message)
      message.to_json
    end
  end
end
