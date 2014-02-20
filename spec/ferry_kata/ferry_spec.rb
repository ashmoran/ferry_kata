require 'spec_helper'
require 'ferry_kata/ferry'

module FerryKata
  describe Ferry do
    let(:event_bus) { EventBus }

    subject(:ferry) { Ferry.new(event_bus: event_bus) }

    def handle_ferry_sailed(event)
      @ferry_sailed = true
    end

    def ferry_sailed?
      @ferry_sailed
    end

    before(:each) do
      event_bus.clear
      event_bus.subscribe(:ferry_sailed, self, :handle_ferry_sailed)
    end

    describe "#sail" do
      it "sails the ferry" do
        expect {
          ferry.sail
        }.to change { ferry_sailed? }.to(true)
      end
    end
  end
end
