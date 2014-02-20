module FerryKata
  class TrafficController
    def initialize(event_bus:, ferry_space_capacity:, van_size:)
      @ferry_space_capacity = ferry_space_capacity
      @ferry_space_left     = ferry_space_capacity
      @van_size             = van_size
    end

    # Event handler method (event object not needed yet)
    def van_arrived(event = nil)
      # This algorithm may not yet cover every last possible edge case...
      @ferry_space_left -= @van_size

      if @ferry_space_left == 0
        EventBus.publish(:sail_ferry)
      end
    end
  end
end