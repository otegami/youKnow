FactoryBot.define do
  factory :project do
    name { "MyString" }
    description { "MyText" }
    status { true }
    association :owner, factory: :user

    trait :before10mins do
      created_at { 10.minutes.ago }
    end

    trait :before3years do
      created_at { 3.years.ago }
    end

    trait :before2hours do
      created_at { 10.hours.ago }
    end

    trait :tomorrow do
      created_at { Time.current.tomorrow }
    end
  end

  # factory :orderProject, class: Project do
  #   sequence(:name) { |n| "TEST_NAME#{n}" }
	# 	sequence(:description) { |n| "TEST#{n} of description" }
  #   status { true }
  #   association :owner, factory: :user
  # end  
end
