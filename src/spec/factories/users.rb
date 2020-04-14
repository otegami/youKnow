FactoryBot.define do
	factory :user do
		sequence(:name) { |n| "TEST_NAME#{n}" }
		sequence(:email) { |n| "TEST#{n}@example.com" }
		sequence(:password) { |n| "password#{n}" }
		sequence(:password_confirmation) { |n| "password#{n}" }
		activated { true }
		activated_at { Time.zone.now }

		factory :project_owner do
      after(:create) do |user, evaluator|
				create(:owner, user: user, project: create(:project))
      end
		end

		factory :project_member do
      after(:create) do |user, evaluator|
				create(:member, user: user, project: create(:project))
      end
		end
	end

	factory :user_without_projects, class: "User" do
		name { "user_without_projects" }
		email { "userwithoutrojects@gmail.com" }
		sequence(:password) { |n| "password#{n}" }
		sequence(:password_confirmation) { |n| "password#{n}" }
		activated { true }
		activated_at { Time.zone.now }
	end
	
	factory :invalidUser, class: "User" do
		name { " " }
		email { "user@invalid" }
		password { "foo" }
		password_confirmation { "bar" }
		activated { true }
		activated_at { Time.zone.now }
	end

	factory :deactivatedUser, class: "User" do
		name { "deactivatedUser" }
		email { "deactivated@gmail.com" }
		password { "deactivated" }
		password_confirmation { "deactivated" }
		activated { false }
	end

	factory :adminUser, class: "User" do
		name { "admin" }
		email { "admin@gmail.com" }
		password { "adminadmin" }
		password_confirmation { "adminadmin" }
		admin { true }
		activated { true }
		activated_at { Time.zone.now }
	end
end