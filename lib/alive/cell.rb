module Alive
  class Cell
    attr_accessor :world, :x, :y
    
    def initialize(world, x=0, y=0)
      @world = world
      @x = x
      @y = y
      @world.cells << self
    end

    def spawn_at(x,y)
      Cell.new(@world, x, y)
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

    def dead?
      !@world.cells.include?(self)
    end

    def inspect
      "<Alive::Cell @x=#{x.inspect} @y=#{y.inspect}>"
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