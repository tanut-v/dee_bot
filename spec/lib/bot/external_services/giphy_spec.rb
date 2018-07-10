require 'rails_helper'

describe Bot::ExternalServices::Giphy do
  let(:giphy) do
    Bot::ExternalServices::Giphy.new('lorem')
  end

  describe '#search' do
    subject do
      VCR.use_cassette('giphy') do
        giphy.search
      end
    end

    it { is_expected.to include('mp4') }
    it { is_expected.to include('url') }
  end
end
