require 'spec_helper'

module AirPlayer
  describe Controller do
    let (:controller) do
      AirPlayer::Controller
    end

    before do
      Airplay.devices << double_device
    end

    describe '.new' do
      context 'with args' do
        it 'returns instance of Controller' do
          expect(controller.new(device: 0)).to be_kind_of Controller
        end
      end

      context 'without args' do
        it 'raise TypeError' do
          expect{ controller.new }.to raise_error(TypeError)
        end
      end
    end

    describe '.pause' do
      context 'with not playing media' do
        it 'do nothing' do
          expect(controller.new(device: 0).pause).to be nil
        end
      end
    end
  end
end
