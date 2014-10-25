require 'virtus'
module RobotWorld
  class Planet
    include Virtus.model(:strict => true)
    require_relative 'robot'

    attribute :x, Integer, default: 1
    attribute :y, Integer, default: 1

    attribute :name, String, default: 'Mars'

    attribute :robots, Array[RobotWorld::Robot]

    def move_to(new_x, new_y)
      if existing_robots_scents_at?(new_x, new_y)
        :scent
      elsif new_x < 0 || new_x > x || new_y < 0 || new_y > y
        :fail
      else
        :ok
      end
    end

    private

    def existing_robots_scents_at?(new_x, new_y)
      robots.select(&:lost?).each do |robot|
        return true if (robot.x == new_x && robot.y == new_y )
      end
      false
    end
  end
end
