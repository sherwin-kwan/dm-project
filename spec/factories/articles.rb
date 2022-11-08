FactoryBot.define do
  factory :article do
    title { "Default Title" }
    body { "Default Body" }
    author { FactoryBot.create(:person) }
  end
end
