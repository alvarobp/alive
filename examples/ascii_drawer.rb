class AsciiDrawer
  def initialize(world, width, height)
    @world = world
    @width = width
    @height = height

    initialize_matrix
  end

  def clear
    0.upto(@height-1) { |i| 0.upto(@width-1) { |j| @matrix[i][j] = 0 } }
  end
  
  def populate
    @world.alive_cells.each { |cell| @matrix[cell.y-1][cell.x-1] = 1 unless @width < cell.y || @height < cell.x }
  end

  def draw
    clear_screen
    @matrix.each do |row|
      row.each do |value|
        print (value == 0) ? " " : "X"
      end
      puts
    end
  end

  private

  def clear_screen
    puts "\e[H\e[2J"
  end
  
  def initialize_matrix
    @matrix = (1..@height).map do
      [0]*@width
    end
  end
end