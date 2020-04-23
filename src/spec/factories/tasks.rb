FactoryBot.define do
  factory :task do
    sequence(:name) { |n| "TEST_NAME#{n}" }
    deadline { rand(10).minutes.ago }
    sequence(:content) { |n| "TEST_CONTENT#{n}" }
    priority { rand(0..2) }
    project

    factory :task_with_tags_and_taggings do
      transient do
        taggings_count { 2 }
      end

      after(:create) do |task, evaluator|
        create_list(:tagging, evaluator.taggings_count, task: task)
        create(:pic, task: task)
      end
    end
  end
end
