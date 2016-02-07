require_relative 'robot'
require_relative 'heading'

##
# Board Class
# Represents the board the robot is sitting on along with the current state.
#
#   State is represented as a stack of robots.
#   Each robot move creates a new robot that is pushed onto the stack.
#   The top robot represents the current state.
#
# Board is initialized with a width and height.
# The robot cannot be moved off the board.
# State is only exposed via the state method which returns the top robot.
#
class Board

  NO_ROBOT_PLACED = "No robot placed yet"

  def initialize(width, height)
    @width = width
    @height = height
    @state = []
  end

  ##
  # place a robot on the board.
  # If the location or heading are invalid, log an error (puts at the moment)
  # Returns self to allow method chaining
  #
  #   x - Int representing x location
  #   y - Int representing y location
  #   heading - Symbol (:north, :south, :east, :west)
  #
  def place(x, y, heading_symbol)
    heading = Heading.create(heading_symbol)
    valid_location = within_bounds(x, y)
    if valid_location && !heading.nil?
      @state.unshift(Robot.new(x,y,heading))
    else
      puts "Invalid heading: #{heading}" if heading.nil?
      puts "Invalid location: (#{x}, #{y}). Must be between (0, 0) and (#{@width}, #{@height})" unless valid_location
    end
    self
  end

  ##
  # Return the current state of the robot as a string.
  #
  def report
    (@state.first || NO_ROBOT_PLACED).to_s
  end

  ##
  # Turn the robot left
  # Append to state and return self.
  #
  def robot_left
    state_execute do |robot|
      robot.left
    end
  end

  ##
  # Turn the robot right
  # Append to state and return self.
  #
  def robot_right
    state_execute do |robot|
      robot.right
    end
  end

  ##
  # Move the robot.
  # If robot position is valid after the move,
  # append to state and return self.
  #
  def move_robot
    state_execute do |robot|
      robot.move
    end
  end

  ##
  # Return the current state as defined by the top robot.
  #
  def state
    @state.first
  end

  private
  ##
  # Check the x,y locations is within the bounds of the board.
  #
  def within_bounds(x,y)
    x >= 0 && x < @width && y >= 0 && y < @height
  end

  ##
  # Execute an operation within the state
  #   Get the current robot. If nil, ignore command.
  #   Yield the robot the to the block given
  #   Append the returned robot to the state if it is within the bounds
  #   Return self.
  #
  def state_execute
    robot = @state.first
    if robot
      updated_robot = yield robot
      @state.unshift(updated_robot) if within_bounds(updated_robot.x, updated_robot.y)
    end
    self
  end
end
