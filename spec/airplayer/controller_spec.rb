require 'spec_helper'

module AirPlayer
  describe Controller do
    let (:controller) do
      AirPlayer::Controller
    end

    describe '.new' do
      context 'with args' do
        it 'returns instance of Controller' do
          expect(controller.new(device: 0)).to be_kind_of Controller
        end
      end

      context 'without args' do
        it 'returns instance of Controller' do
          expect(controller.new).to be_kind_of Controller
        end
      end
    end
  end
end
