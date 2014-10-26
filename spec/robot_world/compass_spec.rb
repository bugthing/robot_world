require 'spec_helper'
describe RobotWorld::Compass do

  let(:compass) { described_class.new(direction: direction) }

  context 'when facing north' do
    let(:direction) { :north }

    describe '#left' do
      subject { compass.left }
      it { should eq :west }
      context 'when facing south' do
        let(:direction) { :south }
        it { should eq :east }
      end
    end

    describe '#right' do
      subject { compass.right }
      it { should eq :east }
      context 'when facing west' do
        let(:direction) { :west }
        it { should eq :north }
      end
    end
  end
end
