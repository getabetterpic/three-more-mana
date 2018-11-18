FactoryBot.define do
  factory :user do
    email { "test@example.com" }
    name { "Seth" }
    password { "notasecurepassword" }
    password_confirmation { "notasecurepassword" }
    access_token { "1234" }
  end
end
