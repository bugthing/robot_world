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

    { north: 'N', south: 'S', west: 'W', east: 'E' }.each_pair do |d, o|
      context "with a '#{o}' orientation" do
        let(:orientation) { o }
        specify { expect(robot.facing).to eq d }
      end
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

  describe '#instuct' do
    subject { robot.instruct instruction }
    let(:instruction) { 'X' }

    specify { expect { subject }.to raise_exception }

    context 'when instuction is "L"' do
      let(:instruction) { 'L' }
      it 'can be told to turn left' do
        expect(robot).to receive(:turn_left).once
        subject
      end
    end

    context 'when instuction is "R"' do
      let(:instruction) { 'R' }
      it 'can be told to turn right' do
        expect(robot).to receive(:turn_right).once
        subject
      end
    end

    context 'when instuction is "F"' do
      let(:instruction) { 'F' }
      it 'can be told to move forward' do
        expect(robot).to receive(:move_forward).once
        subject
      end
    end
  end

  describe '#move_forward' do
    subject { robot.move_forward }

    before do
      allow(robot.planet).to receive(:scents_at).and_return []
      allow(robot.planet).to receive(:can_move_to?).and_return true
    end

    it { should eq true }
    it 'sets the new coordinate' do
      subject
      expect(robot.y).to eq 1
    end

    context 'when move goes out of bounds' do
      before do
        allow(robot.planet).to receive(:can_move_to?).and_return false
      end
      it { should eq false }
      it 'does not change coordinate, the robot is lost and record direction robot was facing' do
        subject
        expect(robot.y).to eq 0
        expect(robot.x).to eq 0
        expect(robot.lost?).to eq true
        expect(robot.lost_at).to eq :north
      end
    end

    context 'when move to a possition with a scent' do
      before do
        allow(robot.planet).to receive(:scents_at).with(0,0).and_return [:north]
      end
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
