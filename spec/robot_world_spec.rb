require 'spec_helper'
describe RobotWorld do
  let(:robot_world) { described_class.new string }
  let(:string) { "" }

  describe '#lines' do
    subject { robot_world.lines }
    it { should eq [] }
    context 'with a multiline string' do
      let(:string) { "XXX\nABC\nXYZ" }
      it 'all except 1st line are stored' do
        expect(robot_world.lines).to eq ["ABC","XYZ"]
      end
    end
  end

  describe '#planet' do
    subject { robot_world.planet }

    context 'with an empty string' do
      specify { expect { subject }.to raise_exception /Invalid planet/ }
    end

    context 'with an incorrect first line' do
      let(:string) { "1 A" }
      specify { expect { subject }.to raise_exception /Invalid planet/ }
    end

    context 'with an valid first line' do
      let(:string) { "1 2" }
      it 'constructs planet with intructions' do
        expect(subject.x).to eq 1
        expect(subject.y).to eq 2
      end
    end
  end

  describe '::execute' do
    subject { robot_world.execute }

    context 'with a valid 2nd line' do
      let(:string) { "1 2\n1 1 N" }

      it 'adds a robot for the 1st none blank line' do
        subject
        robot = robot_world.planet.robots.first
        expect(robot.x).to eq 1
        expect(robot.y).to eq 1
        expect(robot.facing).to eq :north
      end
    end

    context 'using a mock robot' do

      before { allow(robot_world.planet).to receive(:add_robot_at).and_return robot }
      let(:robot) { double(x: 1, y: 1, facing: 'N', lost?: true) }

      context 'with a 3rd line exceeding 100 chars' do
        let(:string) { "1 2\n1 1 N\n" + ("RL" * 51) }

        it 'ignores instructions over 100' do
          expect(robot).to receive(:instruct).with('R').exactly(50).times
          expect(robot).to receive(:instruct).with('L').exactly(50).times
          expect(STDOUT).to receive(:puts).with('1 1 N LOST').once
          subject
        end
      end

      context 'with a valid 3rd line' do
        let(:string) { "1 2\n1 1 N\nFRL" }

        it 'sends each char to robot for none blank line' do
          expect(robot).to receive(:instruct).with('F').ordered
          expect(robot).to receive(:instruct).with('R').ordered
          expect(robot).to receive(:instruct).with('L').ordered
          expect(STDOUT).to receive(:puts).with('1 1 N LOST').once
          subject
        end
      end
    end
  end
end
