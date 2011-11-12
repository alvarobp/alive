require 'spec_helper'

describe "Alive" do
  let(:world) { Alive::World.new }
  
  it "Rule #1: Any live cell with fewer than two live neighbours dies, as if caused by under-population" do
    cell = Alive::Cell.new(world)
    new_cell = cell.spawn_at(1,0)
    world.tick!
    cell.dead?.should be_true
  end

  it "Rule #2: Any live cell with two or three live neighbours lives on to the next generation" do
    cell = Alive::Cell.new(world)
    neighbour1 = cell.spawn_at(1,0)
    neighbour2 = cell.spawn_at(-1,1)
    world.tick!
    cell.alive?.should be_true

    world.clear

    cell = Alive::Cell.new(world)
    neighbour1 = cell.spawn_at(1,0)
    neighbour2 = cell.spawn_at(-1,1)
    neighbour3 = cell.spawn_at(0,1)
    world.tick!
    cell.alive?.should be_true
  end

  it "Rule #3: Any live cell with more than three live neighbours dies, as if by overcrowding" do
    cell = Alive::Cell.new(world)
    cell.spawn_at(1,0)
    cell.spawn_at(0,1)
    cell.spawn_at(1,1)
    cell.spawn_at(1,-1)
    cell.neighbours.count.should == 4

    world.tick!
    cell.dead?.should be_true
  end

  it "Rule #4: Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction" do
    cell = Alive::Cell.new(world)
    new_cell = cell.spawn_at(1,0)
    world.tick!
    cell.dead?.should be_true

    cell.spawn_at(0,1)
    cell.spawn_at(-1,0)
    cell.spawn_at(-1,1)
    cell.neighbours.count.should == 3
    world.tick!
    cell.alive?.should be_true

    world.clear
    cell = Alive::Cell.new(world)
    new_cell = cell.spawn_at(1,0)
    world.tick!

    cell.spawn_at(0,1)
    cell.spawn_at(-1,0)
    cell.spawn_at(-1,1)
    cell.spawn_at(1,1)
    cell.neighbours.count.should == 4
    world.tick!
    cell.dead?.should be_true # stays dead
  end
end