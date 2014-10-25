require 'spec_helper'
describe RobotWorld::Robot do

  let(:x) { 0 }
  let(:y) { 0 }
  let(:orientation) { :north }
  let(:planet) { {} }

  subject(:robot) do
     described_class.new x: x,
                         y: y,
                         facing: orientation,
                         planet: planet 
  end

  context 'when constructing the robot' do

    context 'with a nil x cooridate' do
      let(:x) { nil }
      specify { expect { robot }.to raise_exception }
    end

    context 'with an x cooridate less than 0' do
      let(:x) { -1 }
      specify { expect { robot }.to raise_exception }
    end

    context 'with an x cooridate exceeding 50' do
      let(:x) { 51 }
      specify { expect { robot }.to raise_exception }
    end

    context 'with a nil y cooridate' do
      let(:y) { nil }
      specify { expect { robot }.to raise_exception }
    end

    context 'with an y cooridate less than 0' do
      let(:y) { -1 }
      specify { expect { robot }.to raise_exception }
    end

    context 'with an y cooridate exceeding 50' do
      let(:y) { 51 }
      specify { expect { robot }.to raise_exception }
    end

    context 'with a nil orientation' do
      let(:orientation) { nil }
      specify { expect { robot }.to raise_exception }
    end

    context 'with a nil planet' do
      let(:planet) { nil }
      specify { expect { robot }.to raise_exception }
    end
  end

  it 'can be turned left' do
    robot.turn_left
    expect(robot.facing).to eq :west
    robot.turn_left
    expect(robot.facing).to eq :south
    robot.turn_left
    expect(robot.facing).to eq :east
    robot.turn_left
    expect(robot.facing).to eq :north
  end

  it 'can be turned right' do
    robot.turn_right
    expect(robot.facing).to eq :east
    robot.turn_right
    expect(robot.facing).to eq :south
    robot.turn_right
    expect(robot.facing).to eq :west
    robot.turn_right
    expect(robot.facing).to eq :north
  end

  describe '#move_forward' do
    subject { robot.move_forward }

    before do
      allow(robot.planet).to receive(:move_to).with(any_args).and_return move_result
    end
    let(:move_result) { :ok }

    it { should eq true }

    it 'sets the new cooridate' do
      subject
      expect(robot.x).to eq 1
    end

    context 'when move fails' do
      let(:move_result) { :fail }

      it { should eq false }
      it 'does change cooridate and the robot is lost' do
        subject
        expect(robot.x).to eq 1
        expect(robot.y).to eq 0
        expect(robot.lost?).to eq true
      end
    end

    context 'when move to a possition with a scent' do
      let(:move_result) { :scent }

      it { should eq false }
      it 'the robot does not move and is NOT lost' do
        subject
        expect(robot.x).to eq 0
        expect(robot.y).to eq 0
        expect(robot.lost?).to eq false
      end
    end
  end
end
