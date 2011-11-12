require 'spec_helper'

describe "Alive::World" do
  let(:world) { Alive::World.new }

  it "should keep an array of cells" do
    world.cells.should == []
  end

  it "can be cleared up" do
    Alive::Cell.new(world)
    Alive::Cell.new(world, 1, 2)
    world.cells.size.should == 2
    world.clear
    world.cells.should be_empty
  end
end