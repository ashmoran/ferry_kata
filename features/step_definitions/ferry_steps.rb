require 'event_bus'

class PortMonitor
  def initialize
    @ferry_sailed = false
  end

  def handle_ferry_sailed(event)
    @ferry_sailed = true
  end

  def ferry_sailed?
    false
  end
end

Before do
  EventBus.clear
end

Before do
  @port_monitor = PortMonitor.new
  EventBus.subscribe(:ferry_sailed, @port_monitor, :handle_ferry_sailed)
end

Given %r/^a Ferry has space capacity (\d+) and weight capacity (\d+)$/ do |arg1, arg2|

end

Given %r/^there is (\d+) Ferry$/ do |arg1|

end

Given %r/^no vehicles have arrived$/ do

end

Then %r/^a Ferry has not sailed$/ do
  expect(@port_monitor.ferry_sailed?).to be_false
end