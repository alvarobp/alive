module Alive
  class Cell
    attr_accessor :world, :alive, :x, :y
    
    def initialize(world, values={})
      @world = world
      @x = values[:x] || 0
      @y = values[:y] || 0
      @alive = values[:alive] || false
      @world.cells << self
    end

    def alive_neighbours
      neighbours.select { |cell| cell.alive? }
    end
    
    def neighbours
      (@world.cells - [self]).inject([]) do |array, candidate|
        if (x == candidate.x && adjacent_y.include?(candidate.y)) ||
           (y == candidate.y && adjacent_x.include?(candidate.x)) ||
           (adjacent_x.include?(candidate.x) && adjacent_y.include?(candidate.y))
          array << candidate
        end
        array
      end
    end

    def live!
      @alive = true
    end

    def die!
      @alive = false
    end
    
    def alive?
      @alive
    end
    
    def dead?
      !alive?
    end

    def inspect
      "<Alive::Cell @x=#{x.inspect} @y=#{y.inspect} @alive=#{alive}>"
    end
    
    def to_s
      inspect
    end

    private

    def adjacent_x
      [x+1, x-1]
    end

    def adjacent_y
      [y+1, y-1]
    end
  end
end