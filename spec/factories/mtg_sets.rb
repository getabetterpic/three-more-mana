FactoryBot.define do
  factory :mtg_set do
    code { "grn" }
    name { "Guilds of Ravnica" }
    set_type { "expansion" }
    card_count { 273 }
    released_at { '2018-10-05' }
  end
end
