FactoryBot.define do
  factory :user do
    email { "example@example.com" }
    password { "abcdefgh" }
    password_confirmation { "abcdefgh" }
  end
end