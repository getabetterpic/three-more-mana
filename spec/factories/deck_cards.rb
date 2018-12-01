FactoryBot.define do
  factory :deck_card do
    deck
    card { build :mtg_card }

    trait :with_persisted_card do
      card { create(:mtg_card, :with_set) }
    end
  end
end
