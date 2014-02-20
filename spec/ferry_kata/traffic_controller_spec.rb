require 'spec_helper'

require 'ferry_kata/traffic_controller'

module FerryKata
  describe TrafficController do
    let(:event_bus) { EventBus }

    subject(:traffic_controller) {
      TrafficController.new(
        event_bus:            event_bus,
        ferry_space_capacity: 6,
        van_size:             3
      )
    }

    def handle_sail_ferry(event)
      @ferry_told_to_sail = true
    end

    def ferry_told_to_sail?
      @ferry_told_to_sail
    end

    before(:each) do
      event_bus.clear
      event_bus.subscribe(:sail_ferry, self, :handle_sail_ferry)
    end

    describe "#van_arrived" do
      context "no vans have arrived" do
        specify "sanity check" do
          expect(ferry_told_to_sail?).to be_false
        end
      end

      context "after one van" do
        it "does nothing" do
          traffic_controller.van_arrived
          expect(ferry_told_to_sail?).to be_false
        end
      end

      context "after two vans" do
        it "tells the ferry to sail" do
          traffic_controller.van_arrived
          traffic_controller.van_arrived
          expect(ferry_told_to_sail?).to be_true
        end
      end
    end

  end
end