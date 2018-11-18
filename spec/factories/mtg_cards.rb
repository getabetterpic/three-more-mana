FactoryBot.define do
  factory :mtg_card do
    uuid { SecureRandom.uuid }
    name { 'River Sneak' }
    layout { 'normal' }
    set_code { 'xln' }
    rarity { 'uncommon' }

    trait :with_set do
      before(:create) do
        MtgSet.find_or_create_by(code: 'xln', name: 'Rivals of Ixalan')
      end
    end

    trait :standard do
      legalities { { 'standard' => 'legal' } }
    end

    trait :modern do
      legalities { { 'modern' => 'legal' } }
    end

    trait :legacy do
      legalities { { 'legacy' => 'legal' } }
    end
  end
end
