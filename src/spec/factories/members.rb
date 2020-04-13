FactoryBot.define do  
  factory :member do
    role { 1 }
    owner { false }
    user
    project
  end

  factory :owner, class: "Member" do
    role { 1 }
    owner { true }
    user
    project
  end

  factory :test_member, class: "Member" do
    role { 1 }
    owner { false }
    user
    association :project, factory: :test_project
  end

  factory :test_owner, class: "Member" do
    role { 1 }
    owner { true }
    user
    association :project, factory: :test_project
  end

  factory :owner_of_project, class: "Member" do
    role { 1 }
    owner { true }
    user
    association :project, factory: :project_with_members
  end
end