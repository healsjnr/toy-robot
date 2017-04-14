require './lib/board.rb'

module ConsoleUtils
  def draw_line(y_off, x_off, line_length, board)
    (x_off..(line_length + x_off - 1)).reduce('') do |acc, x|
      map_char = board.within_bounds(x, y_off) ? '  ' : '=='
      final_char = board.is_robot?(x, y_off) ? '<>' : map_char 
      acc + final_char
    end
  end

  def clear
    system('clear') or system('cls')
  end
end


class GameState
  include ConsoleUtils

  BUFFER = 2
  BOARD_SIDE = 10

  def initialize
    @render = { x: BOARD_SIDE + (BUFFER * 2), y: BOARD_SIDE + (BUFFER * 2) }
    @board = Board.new(BOARD_SIDE, BOARD_SIDE)
    board.place(0,0,:north)
  end

  def update
    clear
    current_state = board.state
    new_state = board.robot_move.state
    if new_state == current_state
      new_state = board.robot_random.robot_move.state
    end 
    img = rasterize(board)
    puts img
    puts new_state
  end

  def rasterize(board)
    x_off = (board.width - render[:x]) / 2
    y_off = (board.width - render[:y]) / 2
    lines = (y_off..(render[:y] + y_off - 1)).reduce('') do |acc, y|
      acc + draw_line(y, x_off, render[:x], board) + "\n"
    end
  end

  private
  attr_reader :board, :render
end

def tick(game_state, length_ms: 50)
  start = Time.now
  game_state.update
  tick_remaining = length_ms - ((Time.now - start) * 1000)
  sleep([tick_remaining.to_f / 1000, 0].max)
end

def run()
  game_state = GameState.new
  while (true)
    tick(game_state)
  end
end

#class GameState
#  include ConsoleUtils
#
#  MAP = [
#    [1,1,1,1,1,1,1],
#    [1,0,0,0,0,0,1],
#    [1,0,0,0,0,0,1],
#    [1,0,0,0,0,0,1],
#    [1,1,1,1,1,1,1]
#  ]
#
### Fill existing inner arrays
### Fill outer array
#
#
#  def board_draw(state)
#    # start with an offset and a finish
#    # track x and y as you print a scan line
#    # when printing charcter check: is it in the board or not, is it a robot
#
#  end
#
#  def initialize()
#    @location = [1,1]
#    @direction = 1
#  end
#
#  def update
#    map_state = MAP.map { |m| m.clone }
#    map_state[location.first][location.last] = 2
#    @location, @direction = move_location(MAP, location, direction)
#    clear
#    maze = map_state.map { |l| draw_line(l) }.join("\n")
#    puts maze
#    puts location.join(',')
#    puts direction
#  end
#
#  ## use the immutable idea here
#  def move_location(map, current_location, direction)
#    next_location = location.clone
#    next_location[1] = next_location[1] + direction
#    return next_location, direction unless map[next_location.first][next_location.last] == 1
#    next_location = location.clone
#    next_location[1] = next_location[1] - direction
#    return next_location, -direction
#  end
#
#  private
#  attr_reader :location, :direction
#end
if __FILE__ == $0
  run
end

