require 'spec_helper'
require 'board'

describe "Board" do
  subject { Board.new }
  it { is_expected.to respond_to(:place) }
  it { is_expected.to respond_to(:robot) }
  it { is_expected.to respond_to(:undo) }
  it { is_expected.to respond_to(:report) }
 
  describe "#place" do
    it "a robot" do 
      expect(board.place(0, 0, :north)).to be Robot.new(0, 0, :north)
    end
 
    it "should allow multiple calls" do 
      board.place(0, 0, :north)
      board.place(1, 1, :north)
      expect(board.place(3, 3, :south)).to be Robot.new(3,3, :south)
    end
 
    it "should fail when out of bounds" do
      expect(board.place(-1, 0, :north)).to be nil
    end
    
    it "should fail when direction is incorrect" do
      expect(board.place(-1, 0, :elsewhere)).to be nil
    end
  end
end


 
