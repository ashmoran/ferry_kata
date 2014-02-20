module FerryKata
  # The closest thing we have to an Application object
  class Port
    class << self
      def build(event_bus:, ferry_space_capacity:, van_size:)
        new(
          event_bus:          event_bus,
          ferry:              Ferry.new(event_bus: event_bus),
          traffic_controller: TrafficController.new(
            event_bus:            event_bus,
            ferry_space_capacity: ferry_space_capacity,
            van_size:             van_size
          )
        )
      end
    end

    def initialize(event_bus:, ferry:, traffic_controller:)
      @event_bus          = event_bus
      @ferry              = ferry
      @traffic_controller = traffic_controller
      @open               = false

      add_closed_port_guard
    end

    # Send Port#open_for_traffic to allow traffic through the port
    #
    # Doing this in the initializer gives poor error reporting (in
    # Cucumber at least), so being explicit about when the port is
    # open for traffic is helpful.
    def open_for_traffic
      @event_bus.subscribe(:van_arrived, @traffic_controller, :van_arrived)
      @event_bus.subscribe(:sail_ferry, @ferry, :sail)

      @open = true
    end

    private

    # I wasted ages debugging a non-issue because I forgot to
    # send :open_for_traffic first. Unfortunately EventBus doesn't
    # (yet) support de-registering listeners so this wildcard
    # listener will survire the lifetime of the port.
    def add_closed_port_guard
      EventBus.subscribe(/.*/) do |event|
        if !@open
          raise "Send :open_for_traffic before sending messages"
        end
      end
    end
  end
end