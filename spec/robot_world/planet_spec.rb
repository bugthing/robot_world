require 'spec_helper'
describe RobotWorld::Planet do

  subject(:planet) { described_class.new }

  context 'the default object' do
    it { expect(planet.x).to eq 1 }
    it { expect(planet.y).to eq 1 }
    it { expect(planet.name).to eq 'Mars' }
    it { expect(planet.robots).to be_empty }
  end

  describe '#can_move_to?' do
    subject { planet.can_move_to?(new_x, new_y) }  

    context 'move is outside bounds' do
      let(:new_x) { 2 }
      let(:new_y) { 2 }

      it { should eq false }
    end

    context 'move is inside bounds' do
      let(:new_x) { 1 }
      let(:new_y) { 1 }

      it { should eq true }
    end
  end

  describe '#scents_at?' do
    subject { planet.scents_at(1, 1) }  
    context 'when no robots' do
      it { should be_empty }
    end
    context 'when no lost robots' do
      before { planet.robots << double(lost?: false)  }
      it { should be_empty }
    end
    context 'when no lost robots at coordinates' do
      before { planet.robots << double(lost?: true, x: 0, y: 0) }
      it { should be_empty }
    end
    context 'when 1 lost robots at coordinates' do
      before { planet.robots << double(lost?: true, x: 1, y: 1, facing: :north) }
      it { should eq [:north] }
    end
    context 'when 2 lost robots at coordinates' do
      before do
         planet.robots << double(lost?: true, x: 1, y: 1, facing: :north) 
         planet.robots << double(lost?: true, x: 1, y: 1, facing: :south)
      end
      it { should eq [:north, :south] }
    end
  end

  describe '#add_robot_at' do
    subject { planet.add_robot_at(x: 1, y: 1, facing: 'N') }  
    it 'instanciats a new robot and adds to planet' do
      robot = double
      allow(RobotWorld::Robot).to receive(:new).with(x: 1, y: 1, facing: 'N', planet: planet).and_return(robot)
      subject
      expect(planet.robots).to include robot
    end
  end
end
