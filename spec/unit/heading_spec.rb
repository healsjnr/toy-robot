require 'spec_helper'
require 'heading'

describe "Heading" do
  let(:north) { Heading.create(:north) }
  let(:east) { Heading.create(:east) }
  let(:south) { Heading.create(:south) }
  let(:west) { Heading.create(:west) }

  it { expect(north.left).to be west }
  it { expect(west.left).to be south }
  it { expect(south.left).to be east }
  it { expect(east.left).to be north }

  it { expect(north.right).to be east }
  it { expect(west.right).to be north }
  it { expect(south.right).to be west }
  it { expect(east.right).to be south }

  it { expect(north.direction).to eq ({ x: 0, y: 1 }) }
  it { expect(south.direction).to eq ({ x: 0, y: -1 }) }
  it { expect(east.direction).to eq ({ x: 1, y: 0 }) }
  it { expect(west.direction).to eq ({ x: -1, y: 0 }) }
end

