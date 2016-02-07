require 'spec_helper'
require 'heading'

RSpec.shared_context "heading data" do
  let(:north) { Heading.create(:north) }
  let(:east) { Heading.create(:east) }
  let(:south) { Heading.create(:south) }
  let(:west) { Heading.create(:west) }
end
