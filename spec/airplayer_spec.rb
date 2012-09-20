require 'spec_helper'

describe AirPlayer do
  let(:app) { AirPlayer::App.new }
  context 'App' do
    it 'class type is Thor' do
      expect(app).to be_kind_of Thor
    end
  end
end
