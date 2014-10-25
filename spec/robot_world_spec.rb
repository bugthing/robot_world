require 'spec_helper'
describe RobotWorld do
  let(:orientation) { :north }
  let(:planet) { RobotWorld::Planet.new x: 3, y: 2 }
  let(:robot_1) do
    RobotWorld::Robot.new x: 1,
                          y: 1,
                          facing: orientation,
                          planet: planet 
  end
  let(:robot_2) do
    RobotWorld::Robot.new x: 1,
                          y: 1,
                          facing: orientation,
                          planet: planet 
  end

  it 'works' do
    robot_1.forward
    robot_2.forward
  end
end
