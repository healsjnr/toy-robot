##
# Heading Class
#
# Represents a valid heading (North, South, East or West)
# Also represents the offset when moving along the current heading.
#
# Provides a factory method for generating a Heading
# Initialize is private and the four options are memoized.
# Calling left or right returns the appropriate heading from the four options.
#
class Heading
  attr_reader :value, :direction

  VALID = [:north, :east, :south, :west]
  OFFSETS = { 
    north: { x: 0, y: 1 },
    south: { x: 0, y: -1 },
    east: { x: 1, y: 0 },
    west: { x: -1, y: 0 }
  }

  ##
  # Takes the symbol h and looks up the heading in the list of headings.
  # h - Symbol (:north, :south, :east, :west)
  # returns a heading or nil if invalid.
  #
  def self.create(h)
    HEADINGS[h]
  end

  ##
  # The left and right methods return a new heading in the
  # appropriate direction.
  #
  def right
    rotate(1)
  end
  
  def left 
    rotate(-1)
  end
  
  def to_s
    value.to_s.upcase
  end

  def random
    other_headings = HEADINGS.values - [@value]
    other_headings[Random.rand(other_headings.length)]
  end

  private 

  ##
  # Use the current index plus and offset modulo 4 to find the next heading.
  # rotate_offset is +1 for right, -1 for left.
  #
  def rotate(rotate_offset)
    new_heading = VALID[(VALID.index(@value) + rotate_offset) % VALID.length]
    HEADINGS[new_heading]
  end

  def initialize(h)
    @value = h
    @direction = OFFSETS[h]
    freeze
  end

  # Create the valid heading objects in a map of { :heading_symbol => heading_instance }
  HEADINGS = VALID.zip(VALID.map{ |h| self.new(h) }).to_h
  private_class_method :new
end
