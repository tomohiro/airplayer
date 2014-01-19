require 'spec_helper'

module AirPlayer
  describe Device do
    let (:device) do
      AirPlayer::Device
    end

    before do
      Airplay.devices << double_device
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
        it 'returns default device and display message' do
          default_device = nil
          message = capture(:stdout) { default_device = device.get(99) }
          expect(default_device).to eq device.default
          expect(message).to match('Device number 99 is not found')
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
        expect(device.default).to eq Airplay.devices.first
      end
    end
  end
end
