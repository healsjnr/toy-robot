require 'spec_helper'
require 'spec_data'
require 'robot'
require 'heading'

describe "Robot" do
  include_context "heading data"
  subject(:robot) { Robot.new(0, 0, north) }
  describe "methods" do 
    it { expect(robot).to respond_to(:move) }
    it { expect(robot).to respond_to(:left) }
    it { expect(robot).to respond_to(:right) }
    it { expect(robot).to respond_to(:x) }
    it { expect(robot).to respond_to(:y) }
    it { expect(robot).to respond_to(:heading) }
  end

  describe "#new" do
    it { expect(Robot.new(0, 0, north)).to_not be nil }
  end

  describe "#move" do
    it "should move in the direction specified" do
      expect(robot.move).to eq Robot.new(0, 1, north) 
    end
    it "should maintain heading" do
      expect(robot.move.heading).to eq north
    end
  end

  let(:north_robot) { Robot.new(0, 0, north) }
  let(:east_robot) { Robot.new(0, 0, east) }
  let(:south_robot) { Robot.new(0, 0, south) }
  let(:west_robot) { Robot.new(0, 0, west) }

  describe "#left" do
    it { expect(north_robot.left).to eq west_robot }
    it { expect(west_robot.left).to eq south_robot }
    it { expect(south_robot.left).to eq east_robot }
    it { expect(east_robot.left).to eq north_robot }
  end
  
  describe "#right" do
    it { expect(north_robot.right).to eq east_robot }
    it { expect(west_robot.right).to eq north_robot }
    it { expect(south_robot.right).to eq west_robot }
    it { expect(east_robot.right).to eq south_robot }
  end
end
