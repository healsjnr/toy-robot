require 'spec_helper'
require 'spec_data'
require 'toy_robot_simulator'

describe "ToyRobotSimulator" do
  include_context "heading data"
  subject(:toy_robot_simulator) { ToyRobotSimulator.new(5,5) }
  it { is_expected.to respond_to(:place) }
  it { is_expected.to respond_to(:report) }
  it { is_expected.to respond_to(:robot_move) }
  it { is_expected.to respond_to(:robot_left) }
  it { is_expected.to respond_to(:robot_right) }
  it { is_expected.to respond_to(:state) }

  describe "#place" do
    it "a robot" do
      toy_robot_simulator.place(0, 0, :north)
      expect(toy_robot_simulator.state).to eq Robot.new(0, 0, north)
    end

    it "should allow multiple calls" do
      toy_robot_simulator.place(0, 0, :north).place(1, 1, :north).place(3,3, :south)
      expect(toy_robot_simulator.state).to eq Robot.new(3,3, south)
    end

    it "should fail when out of bounds" do
      toy_robot_simulator.place(-1, 0, :north)
      expect(toy_robot_simulator.state).to be nil
    end

    it "should fail when direction is incorrect" do
      toy_robot_simulator.place(-1, 0, :elsewhere)
      expect(toy_robot_simulator.state).to be nil
    end
  end

  describe "#move_robot" do
    it "should move the robot if it can" do
      toy_robot_simulator.place(1,1,:north).robot_move
      expect(toy_robot_simulator.state).to eq Robot.new(1,2,north)
    end
    it "should have not effect if the robot cannot be moved" do
      toy_robot_simulator.place(4,4,:north).robot_move
      expect(toy_robot_simulator.state).to eq Robot.new(4,4,north)
    end
    it "should have not effect if the robot has not been placed" do
      toy_robot_simulator.robot_move
      expect(toy_robot_simulator.state).to eq nil
    end
  end

  describe "#robot_left and #robot_right" do
    it "should turn the robot left" do
      toy_robot_simulator.place(0,0,:north).robot_left
      expect(toy_robot_simulator.state).to eq Robot.new(0,0,west)
    end
    it "should turn the robot right" do
      toy_robot_simulator.place(0,0,:north).robot_right
      expect(toy_robot_simulator.state).to eq Robot.new(0,0,east)
    end
    it "should have not effect if the robot has not been placed" do
      toy_robot_simulator.robot_left
      expect(toy_robot_simulator.state).to eq nil
    end
  end

  describe "#report" do
    it "should return position when the robot has only been palced" do
      toy_robot_simulator.place(1,1,:north)
      expect(toy_robot_simulator.report).to eq "1,1,NORTH"
    end
    it "should return position when the robot has been placed and moved" do
      toy_robot_simulator.place(1,1,:north).robot_move
      expect(toy_robot_simulator.report).to eq "1,2,NORTH"
    end
    it "should return position when the robot has been placed, turned and moved" do
      toy_robot_simulator.place(1,1,:north).robot_left.robot_move
      expect(toy_robot_simulator.report).to eq "0,1,WEST"
    end
    it "should return a message when no robot has been placed" do
      expect(toy_robot_simulator.report).to eq "No robot placed yet"
    end
  end

  describe "Provided Tests" do
    #a)
    #PLACE 0,0,NORTH
    #MOVE
    #REPORT
    #Output: 0,1,NORTH
    it "should execute test 1 successfully" do
      toy_robot_simulator.place(0,0,:north).robot_move
      expect(toy_robot_simulator.report).to eq "0,1,NORTH"
    end

    #b)
    #PLACE 0,0,NORTH
    #LEFT
    #REPORT
    #Output: 0,0,WEST
    it "should execute test 2 successfully" do
      toy_robot_simulator.place(0,0,:north).robot_left
      expect(toy_robot_simulator.report).to eq "0,0,WEST"
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
      toy_robot_simulator.place(1,2,:east)
      toy_robot_simulator.robot_move
      toy_robot_simulator.robot_move
      toy_robot_simulator.robot_left
      toy_robot_simulator.robot_move
      expect(toy_robot_simulator.report).to eq "3,3,NORTH"
    end
  end
end



