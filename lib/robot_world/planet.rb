require 'virtus'
class RobotWorld
  class Planet
    include Virtus.model
    require_relative 'robot'

    attribute :x, Integer, default: 1
    attribute :y, Integer, default: 1
    attribute :name, String, default: 'Mars'

    def robots
      @robots ||= []
    end

    def can_move_to?(new_x, new_y)
      !(new_x < 0 || new_x > x || new_y < 0 || new_y > y)
    end

    def scents_at(new_x, new_y)
      robots.select(&:lost?).map do |robot|
        robot.facing if(robot.x == new_x && robot.y == new_y)
      end.compact
    end

    def add_robot_at(x: 0, y: 0, facing: :north)
      robot = RobotWorld::Robot.new x: x, 
                                    y: y, 
                                    facing: facing,
                                    planet: self
      robots << robot
      robot
    end
  end
end
