require './lib/board.rb'
@board = Board.new(5,5)
def new_board(x,y)
  @board = Board.new(x,y)
end

def place(x,y,heading)
  @board.place(x,y,heading)
end

def move
  @board.move_robot
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

# > help # print usage.
if __FILE__ == $0
  require 'pry'
  binding.pry
end
