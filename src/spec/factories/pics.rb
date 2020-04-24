FactoryBot.define do
  factory :pic do
    owner { false }
    # I want to rethink of this point
    user { User.first }
    task
  end
end
