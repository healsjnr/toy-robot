require_relative 'robot'
require_relative 'heading'

##
# Board Class
# Represents a Board on which a robot can be placed. It is defined by it's width and height
# a safe_location method which returns true if the x,y coordinate is within the
# bounds of the board.
#
class Board

  def initialize(width, height)
    @width = width
    @height = height
  end

  ##
  # Check the x,y locations is within the bounds of the board.
  #
  def safe_location(x,y)
    x >= 0 && x < @width && y >= 0 && y < @height
  end
end
