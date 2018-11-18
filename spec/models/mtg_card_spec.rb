require 'rails_helper'

RSpec.describe MtgCard, type: :model do
  subject { FactoryBot.build(:mtg_card) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:uuid) }
  it { is_expected.to validate_uniqueness_of(:uuid).case_insensitive }

  describe '.from_api' do
    let(:card_json) do
      {
        'id' => '2be32ffc-dc1d-4bb2-926f-51d110392b06',
        'name' => 'River Sneak',
        'set' => 'xln'
      }
    end

    before { FactoryBot.create(:mtg_set, :xln) }

    it 'creates a card from api JSON' do
      expect { MtgCard.from_api(card_json) }.to change { MtgCard.count }.by 1
    end
  end

  describe 'legality scopes' do
    let(:standard) { FactoryBot.create(:mtg_card, :with_set, :standard) }
    let(:modern) { FactoryBot.create(:mtg_card, :modern) }
    let(:legacy) { FactoryBot.create(:mtg_card, :legacy) }

    describe '.standard_legal scope' do
      before { standard; modern; }

      it 'only returns cards that are standard legal' do
        expect(MtgCard.standard_legal.count).to eq 1
      end
    end

    describe '.modern_legal scope' do
      before { standard; modern; }

      it 'only returns cards that are modern legal' do
        expect(MtgCard.modern_legal.count).to eq 1
      end
    end

    describe '.legacy_legal scope' do
      before { standard; legacy; }

      it 'only returns cards that are legacy legal' do
        expect(MtgCard.legacy_legal.count).to eq 1
      end
    end
  end
end
