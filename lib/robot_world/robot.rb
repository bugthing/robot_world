require 'virtus'
module RobotWorld
  class Robot
    include Virtus.model(:strict => true)
    require_relative 'planet'
    require_relative 'compass'

    attribute :x, Integer, default: 0
    attribute :y, Integer, default: 0
    attribute :facing, Symbol, default: :north
    attribute :planet, RobotWorld::Planet

    def initialize(*args)
      super *args
      @lost = false
      raise ArgumentError: 'x cooridate too small' if x < 0
      raise ArgumentError: 'y cooridate too small' if y < 0
      raise ArgumentError: 'x cooridate too large' if x > 50
      raise ArgumentError: 'y cooridate too large' if y > 50
    end

    def move_forward
      new_x, new_y = move_x_y
      result = planet.move_to(new_x, new_y)

      if result == :ok || result == :fail
        self.x, self.y = new_x, new_y
      end

      if result == :fail
        @lost = true
      end

      result == :ok
    end

    def turn_left
      self.facing = compass.left
    end

    def turn_right
      self.facing = compass.right
    end

    def lost?
      @lost
    end

    private

    def compass
      Compass.new(facing)
    end

    def move_x_y
      case facing 
      when :north 
        return x+1, y
      when :south
        return x-1, y
      when :east
        return x, y+1
      when :west
        return x, y-1
      end
    end

  end
end
