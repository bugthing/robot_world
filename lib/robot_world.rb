require 'robot_world/version'
class RobotWorld
  require_relative 'robot_world/cli'
  require_relative 'robot_world/compass'
  require_relative 'robot_world/planet'
  require_relative 'robot_world/robot'

  attr_reader :lines

  def initialize(string='')
    @planet_line, *@lines = string.split "\n"
    @planet_line ||= '' # ensure its a string
    @planet = nil
  end

  def planet
    if @planet.nil?
      matches = @planet_line.match(/^(?<px>\d)\s+(?<py>\d)\s*$/)
      raise ArgumentError, 'Invalid planet line' unless matches
      @planet = RobotWorld::Planet.new x: matches[:px], y: matches[:py]
    end
    @planet
  end

  def execute
    robot = nil
    lines.each do |line|
      next if line =~ /^\s*$/
      if robot.nil?
        rx, ry, direction = line.split(/\s+/, 3)
        robot = planet.add_robot_at(x: rx, y: ry, facing: direction)
      else
        line[0..99].each_char { |c| robot.instruct(c) }
        puts "#{robot.x} #{robot.y} #{robot.facing} #{robot.lost? ? 'LOST' : ''}"
        robot = nil
      end
    end
  end
end
