require 'spec_helper'
require 'spec_data'
require 'board'

describe "Board" do
  include_context "heading data"
  subject(:board) { Board.new(5,5) }
  it { is_expected.to respond_to(:place) }
  it { is_expected.to respond_to(:report) }
  it { is_expected.to respond_to(:move_robot) }
  it { is_expected.to respond_to(:robot_left) }
  it { is_expected.to respond_to(:robot_right) }
 
  describe "#place" do
    it "a robot" do 
      expect(board.place(0, 0, :north)).to eq Robot.new(0, 0, north)
    end
 
    it "should allow multiple calls" do 
      board.place(0, 0, :north)
      board.place(1, 1, :north)
      expect(board.place(3, 3, :south)).to eq Robot.new(3,3, south)
    end
 
    it "should fail when out of bounds" do
      expect(board.place(-1, 0, :north)).to be nil
    end
    
    it "should fail when direction is incorrect" do
      expect(board.place(-1, 0, :elsewhere)).to be nil
    end
  end
 
  describe "#move_robot" do
    it "should move the robot if it can" do
      board.place(1,1,:north)
      expect(board.move_robot).to eq Robot.new(1,2,north)
    end
    it "should have not effect if the robot cannot be moved" do
      board.place(4,4,:north)
      expect(board.move_robot).to eq Robot.new(4,4,north)
    end
    it "should have not effect if the robot has not been placed" do
      expect(board.move_robot).to eq nil
    end
  end

  describe "#robot_left and #robot_right" do
    it "should turn the robot left" do
      board.place(0,0,:north)
      expect(board.robot_left).to eq Robot.new(0,0,west)
    end
    it "should turn the robot right" do
      board.place(0,0,:north)
      expect(board.robot_right).to eq Robot.new(0,0,east)
    end
    it "should have not effect if the robot has not been placed" do
      board.robot_left
      expect(board.robot_left).to eq nil
    end
  end

  describe "#report" do
    it "should return position when the robot has only been palced" do
      board.place(1,1,:north)
      expect(board.report).to eq "1,1,NORTH"
    end
    it "should return position when the robot has been placed and moved" do
      board.place(1,1,:north)
      board.move_robot
      expect(board.report).to eq "1,2,NORTH"
    end
    it "should return position when the robot has been placed, turned and moved" do
      board.place(1,1,:north)
      board.robot_left
      board.move_robot
      expect(board.report).to eq "0,1,WEST"
    end
    it "should return a message when no robot has been placed" do
      expect(board.report).to eq "No robot placed yet"
    end
  end

  describe "Provided Tests" do
    #a)
    #PLACE 0,0,NORTH
    #MOVE
    #REPORT
    #Output: 0,1,NORTH
    it "should execute test 1 successfully" do
      board.place(0,0,:north)
      board.move_robot
      expect(board.report).to eq "0,1,NORTH"
    end

    #b)
    #PLACE 0,0,NORTH
    #LEFT
    #REPORT
    #Output: 0,0,WEST
    it "should execute test 2 successfully" do
      board.place(0,0,:north)
      board.robot_left
      expect(board.report).to eq "0,0,WEST"
    end

    #c)
    #PLACE 1,2,EAST
    #MOVE
    #MOVE
    #LEFT
    #MOVE
    #REPORT
    #Output: 3,3,NORTH
    it "should execute test 3 successfully" do
      board.place(1,2,:east)
      board.move_robot
      board.move_robot
      board.robot_left
      board.move_robot
      expect(board.report).to eq "3,3,NORTH"
    end
  end

  describe "#within_bounds" do
    it { expect(board.send(:within_bounds,0,0)).to be true }
    it { expect(board.send(:within_bounds,4,4)).to be true }
    it { expect(board.send(:within_bounds,-1,0)).to be false }
    it { expect(board.send(:within_bounds,-1,-1)).to be false }
    it { expect(board.send(:within_bounds,0,-1)).to be false }
    it { expect(board.send(:within_bounds,0,5)).to be false }
    it { expect(board.send(:within_bounds,5,0)).to be false }
  end

end


 
