# You will have to rethink of the layout in this page.

# require "rails_helper"

# RSpec.describe "User profile page", type: :system do
#   let!(:user){ FactoryBot.create(:user_with_projects) }

#   describe "The layout of user profile page" do
#     before do
#       visit login_path
#       fill_in "Email", with: user.email
#       fill_in "Password", with: user.password
#       click_button "Log in"
#       visit user_path(user)
#     end

#     it "should have all of users projects" do
#       expect(page).to have_text(user.name)
#       user.projects.page(1).each do |project|
#         expect(page).to have_text(project.name)
#       end
#     end
#   end
# end