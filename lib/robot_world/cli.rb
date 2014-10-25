require 'thor'
module RobotWorld
  class CLI < Thor

    desc 'move_robot', 'Process STDIN to move a robot on mars'
    long_desc <<-LONGDESC
    Default action,
    `robot-world move_robot` will process STDIN as robot instructions from earth
    and output the robot's possitional information.

    Sample instructions:
    \x5 8 6
    \x5 1 1 E
    \x5 RFLF

    Instructions explained:
    \x5 8 6 <-- Size of mars. 8 by 6 (x, y)
    \x5 1 1 E <-- Start position of robot (x=1 y=1)
    \x5 RFLF <-- Movement (right, forward, left, forward)

    LONGDESC
    def move_robot
      puts "MOVING: #{$stdin}"
    end

    default_task :move_robot
  end
end
