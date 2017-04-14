require './lib/board.rb'

##
# Create a Board and provide proxy methods for Board class.
# This allows us to use pry as as CLI for driving the toy-robot.
#

@board = Board.new(5,5)
def new_board(x,y)
  @board = Board.new(x,y)
end

def place(x,y,heading)
  parsed_heading = (heading.is_a? Symbol) ? heading : heading.downcase.to_sym
  @board.place(x,y,parsed_heading)
end

def move
  @board.robot_move
end

def left
  @board.robot_left
end

def right
  @board.robot_right
end

def report
  @board.report
end

def random
  @board.robot_random
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
