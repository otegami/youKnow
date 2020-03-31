FactoryBot.define do
  factory :project do
    sequence(:name) { |n| "PROJECT_NAME#{n}" }
    sequence(:description) { |n| "PROJECT_DESCRIPTION#{n}" }
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

    factory :project_with_members do
			transient do
        members_count { 20 }
      end
      after(:create) do |project, evaluator|
        create_list(:member, evaluator.members_count, project: project)
      end
		end
  end

  factory :invalidProject, class: Project do
    name { " " }
    description { " " }
    status { true }
    association :owner, factory: :user
  end
end
