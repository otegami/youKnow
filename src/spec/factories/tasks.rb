FactoryBot.define do
  factory :task do
    sequence(:name) { |n| "TEST_NAME#{n}" }
    deadline { rand(10).minutes.ago }
    sequence(:content) { |n| "TEST_CONTENT#{n}" }
    project
  end
end
