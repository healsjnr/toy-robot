require_relative 'robot'
require_relative 'heading'

class Board

  NO_ROBOT_PLACED = "No robot placed yet"

  def initialize(width, height)
    @width = width
    @height = height
    @state = []
  end

  def place(x, y, heading_symbol)
    heading = Heading.create(heading_symbol)
    if (within_bounds(x,y) && !heading.nil?)
      @state.unshift(Robot.new(x,y,heading))
    else
      puts "Invalid heading: #{heading}" if heading.nil?
    end
    @state.first
  end

  def report
    (@state.first || NO_ROBOT_PLACED).to_s
  end

  def robot_left
    robot = @state.first
    if robot
      @state.unshift(robot.left)
    end
    @state.first
  end

  def robot_right
    robot = @state.first
    if robot
      @state.unshift(robot.right)
    end
    @state.first
  end

  def move_robot
    robot = @state.first
    if robot
      moved_robot = robot.move
      @state.unshift(moved_robot) if within_bounds(moved_robot.x, moved_robot.y)
    end
    @state.first
  end

  private
  def within_bounds(x,y)
    x >= 0 && x < @width && y >= 0 && y < @height
  end
end
