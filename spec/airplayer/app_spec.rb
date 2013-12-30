require 'spec_helper'

module AirPlayer
  describe App do
    let (:airplayer) do
      AirPlayer::App.new
    end

    describe '.new' do
      it 'returns instance of Thor' do
        expect(airplayer).to be_kind_of Thor
      end
    end

    describe '.devices' do
      before do
        Airplay.devices << double_device
      end

      it 'display devices' do
        devices = capture(:stdout) { airplayer.devices }
        expect(devices).to match double_device.name
      end
    end

    describe '.version' do
      it 'display version' do
        version = capture(:stdout) { airplayer.version }
        expect(version.chomp).to eq AirPlayer::VERSION
      end
    end
  end
end
