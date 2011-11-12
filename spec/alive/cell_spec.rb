require 'spec_helper'

describe "Alive::Cell" do
  let(:world) { Alive::World.new }
  let(:cell) { Alive::Cell.new(world) }
  
  it "should have 0,0 as default position" do
    cell.x.should == 0
    cell.y.should == 0
  end

  it "can spawn other cells at certain positions" do
    new_cell = cell.spawn_at(3,5)
    new_cell.x.should == 3
    new_cell.y.should == 5
    new_cell.world.should == world
  end

  it "is dead if its world does not contain it anymore" do
    world.cells -= [cell]
    cell.dead?.should be_true
  end
  
  context "neighbours" do
    it "should be properly detected" do
      cell = Alive::Cell.new(world)
      neighbours = [
        cell.spawn_at(-1,-1), cell.spawn_at(0,-1), cell.spawn_at(1,-1),
        cell.spawn_at(-1,0), cell.spawn_at(1,0),
        cell.spawn_at(-1,1), cell.spawn_at(0,1), cell.spawn_at(1,1)
      ]            
      no_neighbours = [cell.spawn_at(0,2), cell.spawn_at(-2,-1), cell.spawn_at(5,3)]
    
      cell.neighbours.should =~ neighbours
    end
  end
end