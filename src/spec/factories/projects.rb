FactoryBot.define do
  factory :project do
    name { "MyString" }
    description { "MyText" }
    status { true }
    association :owner, factory: :user
  end

  factory :past10min, class: Project do
    
  end  
end
