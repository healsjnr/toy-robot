require 'spec_helper'
require 'table_top'

describe "Table top methods" do
  subject { TableTop.new }
  it { is_expected.to respond_to(:place) }
  it { is_expected.to respond_to(:move) }
  it { is_expected.to respond_to(:left) }
  it { is_expected.to respond_to(:right) }
  it { is_expected.to respond_to(:report) }
  it { is_expected.to respond_to(:undo) }
end

