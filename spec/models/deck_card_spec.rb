require 'rails_helper'

RSpec.describe DeckCard, type: :model do
  it { is_expected.to belong_to(:deck) }
  it { is_expected.to belong_to(:card) }
  it { is_expected.to validate_presence_of(:deck) }
  it { is_expected.to validate_presence_of(:card) }
  it { is_expected.to validate_presence_of(:card_count) }
  it { is_expected.to validate_numericality_of(:card_count).only_integer.is_greater_than_or_equal_to(1) }

  context "card uniqueness" do
    subject { FactoryBot.create(:deck_card, :with_persisted_card) }
    it { is_expected.to validate_uniqueness_of(:card_id).scoped_to(:deck_id, :mainboard) }
  end
end
