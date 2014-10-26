require 'virtus'
class RobotWorld
  class Compass
    include Virtus.model(:strict => true)

    class Direction < Virtus::Attribute
      def coerce(value)
        return value if %i(north south east west).include?(value)
        case value
        when 'N'; :north
        when 'S'; :south
        when 'E'; :east
        when 'W'; :west
        else
          raise CoercionError, "Could not determin direction from: #{value}"
        end
      end
    end

    @@all_directions = [:north, :east, :south, :west]

    attribute :direction, RobotWorld::Compass::Direction

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
