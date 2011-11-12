module Alive
  class World
    attr_accessor :cells

    def initialize
      @cells = []
    end

    def tick!
      @cells.each do |cell|
        @cells -= [cell] if cell.neighbours.count < 2
      end
    end
  end
end