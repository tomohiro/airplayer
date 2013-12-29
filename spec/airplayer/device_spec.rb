require 'spec_helper'

module AirPlayer
  describe Device do
    let (:device) do
      AirPlayer::Device
    end

    describe '#devices' do
      it 'returns array' do
        expect(device.devices).to be_kind_of Array
      end
    end

    describe '#get' do
      context 'with exist device number' do
        it 'returns instance of device' do
          expect(device.get(0)).to be_kind_of Airplay::Device
        end
      end

      context 'with not exist device number' do
        it 'returns nil' do
          expect(device.get(99)).to be nil
        end
      end
    end

    describe '#exist?' do
      context 'with exist device number' do
        it 'returns true' do
          expect(device.exist?(0)).to be true
        end
      end

      context 'with not exist device number' do
        it 'returns false' do
          expect(device.exist?(99)).to be false
        end
      end
    end

    describe '#default' do
      it 'returns first airplay device' do
        expect(device.default).to eq dummy_device
      end
    end
  end
end
