require 'spec_helper'
describe RobotWorld::Planet do

  subject(:planet) { described_class.new }

  context 'the default object' do
    it { expect(planet.x).to eq 1 }
    it { expect(planet.y).to eq 1 }
    it { expect(planet.name).to eq 'Mars' }
    it { expect(planet.robots).to be_empty }
  end

  describe '#move_to' do
    subject { planet.move_to(new_x, new_y) }  

    let(:new_x) { 2 }
    let(:new_y) { 2 }

    context 'move is outside bounds' do
      it { should eq :fail }
    end

    context 'move is inside bounds' do
      let(:new_x) { 1 }
      let(:new_y) { 1 }
      it { should eq :ok }
    end

    context 'move where robot has already been lost' do
      before do
        allow(planet).to receive(:robots).and_return([lost_robot])
      end
      let(:lost_robot) { double(lost?: true, x: 2, y: 2) }

      it { should eq :scent }

      context 'move where robot has NOT already been lost' do
        let(:lost_robot) { double(lost?: true, x: 2, y: 3) }
        it { should eq :fail }
      end
    end
  end
end
