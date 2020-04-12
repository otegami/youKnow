FactoryBot.define do
  factory :project do
    sequence(:name) { |n| "PROJECT_NAME#{n}" }
    sequence(:description) { |n| "PROJECT_DESCRIPTION#{n}" }
    status { true }

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

  factory :invalidProject, class: "Project" do
    name { " " }
    description { " " }
    status { true }
  end

  factory :test_project, class: "Project" do
    name { "PROJECT_NAME" }
    description{ "PROJECT_DESCRIPTION" }
    status { true }
  end
end
