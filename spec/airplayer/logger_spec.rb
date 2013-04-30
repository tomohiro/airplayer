require 'spec_helper'

module AirPlayer
  describe Logger do
    context 'file path' do
      it 'is /tmp/airplayer-access.log on Linux' do
        if RbConfig::CONFIG['target_os'] =~ /linux|unix/
          expect(subject.path).to eq '/tmp/airplayer-access.log'
        end
      end
    end
  end
end
