module FerryKata
  class Ferry
    def initialize(event_bus:)
      @event_bus = event_bus
    end

    # Command method (command "event" not needed yet)
    def sail(command = nil)
      @event_bus.publish(:ferry_sailed)
    end
  end
end