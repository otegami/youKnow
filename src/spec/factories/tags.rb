FactoryBot.define do
  factory :tag do
    sequence(:name) { |n| "TEST_NAME#{n}" }
    project
  end
end
