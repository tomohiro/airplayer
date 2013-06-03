require 'spec_helper'

module AirPlayer
  describe Logger do
    subject { AirPlayer::Logger }

    context 'file path' do
      it '/tmp/airplayer-access.log on Linux' do
        if RbConfig::CONFIG['target_os'] =~ /linux|unix/
          expect(subject.path).to eq '/tmp/airplayer-access.log'
        end
      end
    end
  end
end
