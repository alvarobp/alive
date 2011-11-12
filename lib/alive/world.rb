module Alive
  class World
    attr_accessor :cells

    def initialize
      @cells = []
    end

    def tick!
      @cells.each do |cell|
        @cells -= [cell] if cell.neighbours.count < 2 || cell.neighbours.count > 3
      end
    end

    def clear
      @cells = []
    end
  end
end