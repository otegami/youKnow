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

    factory :project_with_members do
      transient do
        members_count { 10 }
      end

      after(:create) do |project, evaluator|
        create_list(:member, evaluator.members_count, project: project)
      end
    end
    
    factory :project_with_tags do
      transient do
        tags_count { 10 }
      end

      after(:create) do |project, evaluator|
        create_list(:tag, evaluator.tags_count, project: project)
        create(:member, project: project)
      end
    end

    factory :project_with_tasks do
      transient do
        tasks_count { 10 }
      end

      after(:create) do |project, evaluator|
        create_list(:task, evaluator.tasks_count, project: project)
        create(:member, project: project)
      end
    end

    factory :project_with_full_tasks do
      transient do
        tasks_count { 3 }
      end

      after(:create) do |project, evaluator|
        create_list(:task_with_tags_and_taggings, evaluator.tasks_count, project: project)
        create(:member, project: project)
      end
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
