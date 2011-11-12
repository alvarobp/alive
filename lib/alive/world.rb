module Alive
  class World
    attr_accessor :cells

    def initialize
      @cells = []
      @dead_cells = []
    end

    def tick!
      @next_alive_cells = []
      @next_dead_cells = []
      
      @cells.each do |cell|
        if cell.neighbours.count < 2 || cell.neighbours.count > 3
          @next_dead_cells << cell
        else
          @next_alive_cells << cell
        end
      end
      
      @dead_cells.each do |cell|
        if cell.neighbours.count == 3
          @dead_cells -= [cell]
          @next_alive_cells << cell
        end
      end
      
      @dead_cells += @next_dead_cells
      @cells = @next_alive_cells
    end

    def clear
      @cells = []
      @dead_cells = []
    end
  end
end