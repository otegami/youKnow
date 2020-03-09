FactoryBot.define do
	factory :user do
		sequence(:name) { |n| "TEST_NAME#{n}" }
		sequence(:email) { |n| "TEST#{n}@example.com" }
		sequence(:password) { |n| "password#{n}" }
		sequence(:password_confirmation) { |n| "password#{n}" }
	end
end