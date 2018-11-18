FactoryBot.define do
  factory :mtg_set do
    code { "grn" }
    name { "Guilds of Ravnica" }
    set_type { "expansion" }
    card_count { 273 }
    released_at { '2018-10-05' }

    trait :xln do
      code { 'xln' }
      name { 'Rivals of Ixalan' }
      released_at { '2017-09-29' }
    end
  end
end
