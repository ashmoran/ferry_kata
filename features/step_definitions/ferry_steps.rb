require 'event_bus'

class PortListener
  def initialize
    @ferry_sailed = false
  end

  def handle_ferry_sailed(event)
    @ferry_sailed = true
  end

  def ferry_sailed?
    @ferry_sailed
  end
end

Before do
  @config = Hash.new
end

Before do
  EventBus.clear
end

# # Handy debugging hook, enable as needed
# Before do
#   EventBus.subscribe(/.*/) do |event|
#     p event
#   end
# end

Before do
  @port_monitor = PortListener.new
  EventBus.subscribe(:ferry_sailed, @port_monitor, :handle_ferry_sailed)
end

Given %r/^there is a Port$/ do
  @port =
    FerryKata::Port.build(
      event_bus:            EventBus,
      ferry_space_capacity: @config.fetch(:ferry_space_capacity),
      van_size:             3
    )
  @port.open_for_traffic
end

Given %r/^a Ferry has space capacity (\d+)$/ do |space_capacity|
  @config[:ferry_space_capacity] = space_capacity.to_i
end

Given %r/^no vehicles have arrived$/ do
  # NOOP
end

When %r/^(?:a|another) van arrives$/ do
  EventBus.publish(:van_arrived)
end

Then %r/^a Ferry sails$/ do
  expect(@port_monitor.ferry_sailed?).to be_true
end

Then %r/^a Ferry does not sail$/ do
  expect(@port_monitor.ferry_sailed?).to be_false
end