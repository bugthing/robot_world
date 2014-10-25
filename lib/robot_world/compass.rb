module RobotWorld
  class Compass
    @@all_directions = [:north, :east, :south, :west]

    attr_reader :direction

    def initialize(direction)
      raise StandardError: 'Invalid direction' unless @@all_directions.index(direction)
      @direction = direction 
    end

    def left
      i = direction_index - 1
      i = max_index if(i < 0)
      @@all_directions[i]
    end

    def right
      i = direction_index + 1
      i = 0 if(i > max_index)
      @@all_directions[i]
    end

    private

    def max_index
      @@all_directions.size - 1
    end

    def direction_index
      @@all_directions.index(direction)
    end
  end
end
