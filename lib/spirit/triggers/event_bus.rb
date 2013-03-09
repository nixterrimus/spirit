module EventBus
  class << self
    def fire_event(event, message='')
      puts "#{formatted_event(event)}: #{message}"
    end

    private

    def formatted_event(event)
      "zapp.event.#{event}"
    end
  end
end
