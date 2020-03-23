FactoryBot.define do
  factory :project do
    name { "MyString" }
    description { "MyText" }
    status { true }
    association :owner, factory: :user
  end
end
