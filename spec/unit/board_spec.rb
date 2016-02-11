require 'spec_helper'
require 'board'

describe "Board" do
  subject(:board) { Board.new(5,5) }

  it { is_expected.to respond_to(:safe_location) }

  describe "#within_bounds" do
    it { expect(board.safe_location(0,0)).to be true }
    it { expect(board.safe_location(4,4)).to be true }
    it { expect(board.safe_location(-1,0)).to be false }
    it { expect(board.safe_location(-1,-1)).to be false }
    it { expect(board.safe_location(0,-1)).to be false }
    it { expect(board.safe_location(0,5)).to be false }
    it { expect(board.safe_location(5,0)).to be false }
  end

end


 
