FactoryBot.define do
  factory :mtg_card do
    uuid { SecureRandom.uuid }
    name { Faker::Name.name }
    layout { 'normal' }
    set_code { 'xln' }
    rarity { 'uncommon' }
    type_line { 'Creature' }

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

    trait :not_standard do
      legalities { { 'standard' => 'not_legal' } }
    end
  end
end
