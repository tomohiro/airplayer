require 'spec_helper'

module AirPlayer
  describe App do
    context 'class type' do
      it 'Thor' do
        expect(subject).to be_kind_of Thor
      end
    end
  end
end
