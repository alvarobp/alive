require 'spec_helper'

describe "Alive::World" do
  let(:world) { Alive::World.new }

  it "should keep an array of cells" do
    world.cells.should == []
  end
end