require './lib/toy_robot_simulator.rb'

##
# Create a Simulator and provide proxy methods for Simulator class.
# This allows us to use pry as as CLI for driving the toy-robot.
#

@simulator = ToyRobotSimulator.new(5,5)
def new_simulator(x,y)
  @simulator = ToyRobotSimulator.new(x,y)
end

def place(x,y,heading)
  parsed_heading = (heading.is_a? Symbol) ? heading : heading.downcase.to_sym
  @simulator.place(x,y,parsed_heading)
end

def move
  @simulator.robot_move
end

def left
  @simulator.robot_left
end

def right
  @simulator.robot_right
end

def report
  @simulator.report
end

def toy_robot_help
  puts "Place a robot:"
  puts "  > place x, y, 'north'|'south'|'east'|'west'"
  puts "Move robot:"
  puts "  > move"
  puts "Turn robot:"
  puts "  > left"
  puts "  > right"
  puts "Robot robot position"
  puts "  > report"
end

# Toy Robot CLI
# To print usage call
# > toy_robot_help
if __FILE__ == $0
  require 'pry'
  binding.pry
end
