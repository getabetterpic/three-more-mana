require 'rails_helper'

RSpec.describe Deck, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:cards) }
  it { is_expected.to validate_presence_of(:user) }

  describe '#standard_legal?' do
    subject { FactoryBot.create(:deck) }

    describe 'when less than 60 cards' do
      let(:card) { FactoryBot.create(:mtg_card, :with_set, :standard, deck: subject) }

      it { is_expected.to_not be_standard_legal }
    end

    describe 'when more than 60 cards' do
      let(:cards) { FactoryBot.create_list(:mtg_card, 61, :with_set, :standard) }
      before(:each) do
        cards.each do |card|
          FactoryBot.create(:deck_card, card: card, deck: subject, mainboard: true)
        end
      end

      it { is_expected.to_not be_standard_legal }
    end

    describe 'when exactly 60 cards' do
      let(:cards) { FactoryBot.create_list(:mtg_card, 60, :with_set, :standard) }
      before(:each) do
        cards.each do |card|
          FactoryBot.create(:deck_card, card: card, deck: subject, mainboard: true)
        end
      end

      it { is_expected.to be_standard_legal }

      context 'but more than 15 sideboard cards' do
        let(:sideboard_cards) { FactoryBot.create_list(:mtg_card, 16, :with_set, :standard, name: Faker::Name.name) }
        before(:each) do
          sideboard_cards.each do |card|
            FactoryBot.create(:deck_card, card: card, deck: subject, mainboard: false)
          end
        end

        it { is_expected.to_not be_standard_legal }
      end

      context 'but any is not standard legal' do
        before(:each) do
          card = cards.last
          card.legalities['standard'] = 'not_legal'
          card.save!
        end

        it { is_expected.to_not be_standard_legal }
      end
    end
  end
end
