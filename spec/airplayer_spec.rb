require 'spec_helper'

describe AirPlayer do
  let(:app) { AirPlayer::App.new }

  context 'App' do
    it 'class type is Thor' do
      expect(app).to be_kind_of Thor
    end
  end

  context 'Logger' do
    it 'file path is /tmp/airplayer-access.log on Linux' do
      expect(AirPlayer::Logger.path).to eq '/tmp/airplayer-access.log'
    end
  end
end
