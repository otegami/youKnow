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
end
