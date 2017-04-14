require_relative 'heading'

class RobotError < StandardError
end

class RobotInitializationError < RobotError
end

##
# Robot Class
# Represents a robot in a particular state.
# Robots are immutable.
# Executing an action on a robot returns an updated robot with the changes applied.
#
class Robot
  attr_reader :x, :y, :heading

  ##
  # Create a new robot
  #   x - Int representing x location
  #   y - Int representing y location
  #   heading - Heading class representing the direction.
  #
  def initialize(x, y, heading)
    raise RobotInitializationError, 'Heading cannot be nil' if heading.nil?
    @x = x
    @y = y
    @heading = heading
    freeze
  end

  def left
    Robot.new(@x, @y, @heading.left)
  end

  def right
    Robot.new(@x, @y, @heading.right)
  end

  def random
    Robot.new(@x, @y, @heading.random)
  end

  def move
    offset = @heading.direction
    new_x = @x + offset[:x]
    new_y = @y + offset[:y]
    Robot.new(new_x, new_y, heading)
  end

  def ==(o)
    o.class == self.class && o.state == state
  end

  def to_s
    "#{x},#{y},#{heading.to_s}"
  end

  protected

  def state
    [@x, @y, @heading]
  end
end

