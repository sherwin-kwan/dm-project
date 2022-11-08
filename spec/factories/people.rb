FactoryBot.define do
  factory :person do
    name { "Patrick Star" }
    given_name { "Patrick" }
    display_name { "Under_a_rock_420" }
    user { FactoryBot.create(:user, email: "#{rand}@example.com") }
    slogan { "Oh boy, 3am!" }
  end
end