require 'spec_helper'

describe "Alive::Cell" do
  let(:world) { Alive::World.new }
  let(:cell) { Alive::Cell.new(world) }
  
  it "should have 0,0 as default position" do
    cell.x.should == 0
    cell.y.should == 0
  end

  it "can create other cells at certain positions" do
    new_cell = Alive::Cell.new(world, :x => 3, :y => 5)
    new_cell.x.should == 3
    new_cell.y.should == 5
    new_cell.world.should == world
  end

  it "can create cells dead or alive" do
    alive_cell = Alive::Cell.new(world, :x => 3, :y => 5, :alive => true)
    alive_cell.alive?.should be_true

    dead_cell = Alive::Cell.new(world, :x => 3, :y => 5, :alive => false)
    dead_cell.dead?.should be_true
  end

  it "should properly detect its neighbours" do
    cell = Alive::Cell.new(world)
    neighbours = [
      Alive::Cell.new(world, :x => -1, :y => -1), Alive::Cell.new(world, :x => 0, :y => -1), Alive::Cell.new(world, :x => 1, :y => -1),
      Alive::Cell.new(world, :x => -1, :y => 0), Alive::Cell.new(world, :x => 1, :y => 0),
      Alive::Cell.new(world, :x => -1, :y => 1), Alive::Cell.new(world, :x => 0, :y => 1), Alive::Cell.new(world, :x => 1, :y => 1)
    ]            
    no_neighbours = [Alive::Cell.new(world, :x => 0, :y => 2), Alive::Cell.new(world, :x => -2, :y => -1), Alive::Cell.new(world, :x => 5, :y => 3)]
    
    cell.neighbours.should =~ neighbours
  end

  it "should properly detect its alive neighbours" do
    cell = Alive::Cell.new(world)
    alive_neighbours = [Alive::Cell.new(world, :x => 1, :y => 1, :alive => true), Alive::Cell.new(world, :x => 0, :y => -1, :alive => true)]
    other_neighbours = [Alive::Cell.new(world, :x => -1, :y => -1), Alive::Cell.new(world, :x => 1, :y => -1)]
    no_neighbours = [Alive::Cell.new(world, :x => 0, :y => 2), Alive::Cell.new(world, :x => -2, :y => -1), Alive::Cell.new(world, :x => 5, :y => 3)]
    
    cell.alive_neighbours.should =~ alive_neighbours
  end
end