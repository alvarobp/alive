require File.dirname(__FILE__) + '/../lib/alive'
require File.dirname(__FILE__) + '/ascii_drawer'

# 0 0 0 0 0 0
# 0 0 0 0 0 0
# 0 0 1 1 1 0
# 0 1 1 1 0 0
# 0 0 0 0 0 0
# 0 0 0 0 0 0

toad = [
  [0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0],
  [0, 0, 1, 1, 1, 0],
  [0, 1, 1, 1, 0, 0],
  [0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0]
]

world = Alive::World.new
toad.each_with_index do |row, i|
  row.each_with_index do |state, j|
    Alive::Cell.new(world, :x => j+1, :y => i+1, :alive => state == 1)
  end
end

drawer = AsciiDrawer.new(world, 6, 6)

while(true) do
  drawer.clear
  drawer.populate
  drawer.draw
  sleep 1
  world.tick!
end
