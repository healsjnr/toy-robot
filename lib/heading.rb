class Heading
  attr_reader :value, :direction

  VALID = [:north, :east, :south, :west]
  OFFSETS = { 
    north: { x: 0, y: 1 },
    south: { x: 0, y: -1 },
    east: { x: 1, y: 0 },
    west: { x: -1, y: 0 }
  }
  def self.create(h)
    HEADINGS[h]
  end

  def right
    rotate(1)
  end
  
  def left 
    rotate(-1)
  end
  
  def to_s
    value.to_s.upcase
  end

  private 

  def rotate(offset)
    new_heading = VALID[(VALID.index(@value) + offset) % VALID.length]
    HEADINGS[new_heading]
  end

  def initialize(h)
    @value = h
    @direction = OFFSETS[h]
    freeze
  end

  HEADINGS = VALID.zip(VALID.map{ |h| self.new(h) }).to_h
  private_class_method :new
end
