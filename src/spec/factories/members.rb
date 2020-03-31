FactoryBot.define do
  factory :member do
    role { 1 }
    user
    project
  end
end
