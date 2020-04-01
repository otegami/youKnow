User.create!(
  name:  "Example User",
  email: "example@railstutorial.org",
  password:              "foobarfoobar",
  password_confirmation: "foobarfoobar",
  admin: true,
  activated: true,
  activated_at: Time.zone.now
)

99.times do |n|
  name  = "example-#{n+1}"
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(
    name:  name,
    email: email,
    password:              password,
    password_confirmation: password,
    activated: true,
    activated_at: Time.zone.now
  )
end

# users = User.order(:created_at).take(6)
# 50.times do |n|
#   name = "example-#{n+1}"
#   description = "#{n+1}description test"
#   users.each do |user|
#     user.projects.create(
#       name: name,
#       description: description
#     )
#   end
# end