require 'gosu'
require 'alive'

class GameWindow < Gosu::Window
  WIDTH = 640
  HEIGHT = WIDTH
  BACKGROUND_COLOR = Gosu::Color::WHITE
  
  def initialize(seed_data, cells_width, title=nil)
    @world = Alive::World.new
    @cells_width = cells_width
    @cell_width = WIDTH.to_f/cells_width.to_f
    
    initialize_world(seed_data)
    
    super WIDTH, WIDTH, false, 1000
    caption_string = "Conway's Game of Life"
    caption_string << ": #{title}" if title
    self.caption = caption_string
  end
  
  def update
    @world.tick!
  end

  def draw
    draw_background
    @world.alive_cells.each do |cell|
      unless @cells_width < cell.y || @cells_width < cell.x
        start_x = (cell.x-1)*@cell_width
        end_x = cell.x*@cell_width
        start_y = (cell.y-1)*@cell_width
        end_y = cell.y*@cell_width
        
        draw_quad(start_x, start_y, cell_color,
          end_x, start_y, cell_color,
          end_x, end_y, cell_color,
          start_x, end_y, cell_color
        )
      end
    end
  end

  def cell_color
    Gosu::Color::BLACK
  end

  private

  def draw_background
    draw_quad(
      0,     0,      BACKGROUND_COLOR,
      WIDTH, 0,      BACKGROUND_COLOR,
      0,     HEIGHT, BACKGROUND_COLOR,
      WIDTH, HEIGHT, BACKGROUND_COLOR,
      0)
  end
  
  def initialize_world(data)
    data.each_with_index do |row, i|
      row.each_with_index do |state, j|
        Alive::Cell.new(@world, :x => j+1, :y => i+1, :alive => state == 1)
      end
    end
  end
end

seeds = {}
seeds['blinker'] = [
  [0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0],
  [0, 1, 1, 1, 0],
  [0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0]
]

seeds['toad'] = [
  [0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0],
  [0, 0, 1, 1, 1, 0],
  [0, 1, 1, 1, 0, 0],
  [0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0]
]

seeds['beacon'] = [
  [0, 0, 0, 0, 0, 0],
  [0, 1, 1, 0, 0, 0],
  [0, 1, 0, 0, 0, 0],
  [0, 0, 0, 0, 1, 0],
  [0, 0, 0, 1, 1, 0],
  [0, 0, 0, 0, 0, 0]
]

seeds['pulsar'] = [
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0],
  [0, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0],
  [0, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0],
  [0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0],
  [0, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0],
  [0, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0],
  [0, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
]

if ARGV.empty?
  puts "Usage: #{__FILE__} PATTERN\n\nAvailable patterns are: #{seeds.keys.sort.join(" ")}"
  exit
end

seed_name = ARGV.first
window = GameWindow.new(seeds[seed_name], seeds[seed_name].first.size, seed_name.capitalize)
window.show