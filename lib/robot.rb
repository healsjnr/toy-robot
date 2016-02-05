require_relative 'heading'

class Robot
  attr_reader :x, :y, :heading

  def initialize(x, y, heading)
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

  def move
    offset = @heading.direction
    new_x = @x + offset[:x]
    new_y = @y + offset[:y]
    Robot.new(new_x, new_y, heading)
  end

  def ==(o)
    o.class == self.class && o.state == state
  end

  protected

  def state
    [@x, @y, @heading]
  end
end

