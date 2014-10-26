require 'virtus'
class RobotWorld
  class Robot
    include Virtus.model(:strict => true)
    require_relative 'planet'
    require_relative 'compass'

    attribute :x, Integer, default: 0
    attribute :y, Integer, default: 0
    attribute :facing, RobotWorld::Compass::Direction, default: :north
    attribute :planet, RobotWorld::Planet

    attr_reader :lost_at

    def initialize(*args)
      super *args
      @lost_at = nil
      raise ArgumentError, 'x cooridate too small' if x < 0
      raise ArgumentError, 'y cooridate too small' if y < 0
      raise ArgumentError, 'x cooridate too large' if x > 50
      raise ArgumentError, 'y cooridate too large' if y > 50
    end

    def instruct(instruction)
      return if lost?
      case instruction
      when 'L'; turn_left
      when 'R'; turn_right
      when 'F'; move_forward
      else
        raise RuntimeError, "Could not determin Robot instruction from: #{instruction}"
      end
    end

    def move_forward
      return false if(planet.scents_at(x, y).include?(facing))

      new_x, new_y = move_x_y

      if planet.can_move_to?(new_x, new_y)
        self.x, self.y = new_x, new_y
        true
      else
        @lost_at = facing
        false
      end
    end

    def turn_left
      self.facing = compass.left
    end

    def turn_right
      self.facing = compass.right
    end

    def lost?
      !@lost_at.nil?
    end

    private

    def compass
      Compass.new(direction: facing)
    end

    def move_x_y
      case facing 
      when :north; return x, y+1
      when :south; return x, y-1
      when :east; return x+1, y
      when :west; return x-1, y
      end
    end
  end
end
