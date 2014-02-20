require 'spec_helper'

require 'ferry_kata/port'

require 'ferry_kata/ferry'
require 'ferry_kata/traffic_controller'

module FerryKata
  describe Port do
    let(:traffic_controller) {
      double(TrafficController, van_arrived: nil)
    }

    let(:ferry) { double(Ferry, sail: nil) }

    let(:event_bus) { EventBus }

    subject(:port) {
      Port.new(
        event_bus:            event_bus,
        ferry:                ferry,
        traffic_controller:   traffic_controller
      )
    }

    before(:each) do
      event_bus.clear
      port.open_for_traffic
    end

    it "does something" do
      event_bus.publish(:sail_ferry)
      expect(ferry).to have_received(:sail)
    end

    it "relays :van_arrived to the TrafficController" do
      event_bus.publish(:van_arrived)
      expect(traffic_controller).to have_received(:van_arrived)
    end
  end
end