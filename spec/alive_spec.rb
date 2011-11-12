require 'spec_helper'

describe "Alive" do
  let(:world) { Alive::World.new }
  
  it "Rule #1: Any live cell with fewer than two live neighbours dies, as if caused by under-population" do
    cell = Alive::Cell.new(world)
    new_cell = cell.spawn_at(1,0)
    world.tick!
    cell.dead?.should be_true
  end
end