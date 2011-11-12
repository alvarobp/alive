module Alive
  class World
    attr_accessor :cells

    def initialize
      @cells = []
    end

    def tick!
      @will_live = []
      @will_die = []
      
      alive_cells.each do |cell|
        if cell.alive_neighbours.count < 2 || cell.alive_neighbours.count > 3
          @will_die << cell
        end
      end
      
      dead_cells.each do |cell|
        if cell.alive_neighbours.count == 3
          @will_live << cell
        end
      end

      @will_live.each { |c| c.live! }
      @will_die.each { |c| c.die! }
    end

    def alive_cells
      @cells.select { |c| c.alive? }
    end

    def dead_cells
      @cells.select { |c| c.dead? }
    end
    
    def clear
      @cells = []
    end
  end
end