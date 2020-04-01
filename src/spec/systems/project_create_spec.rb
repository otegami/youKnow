# require "rails_helper"

# RSpec.describe "Create a project", type: :system do
#   let(:user){ FactoryBot.create(:user) }

#   describe "the process of creating a project" do
#     context "with user not logging in" do
#       it "should show login page" do
#         visit new_project_path
#         expect(page).to have_text("Log in")
#         expect(page).to have_text("Email")
#         expect(page).to have_text("Password")
#       end
#     end
#     context "with user logging in" do
#       it "should show new page of a project" do
#         visit login_path
#         fill_in "Email", with: user.email
#         fill_in "Password", with: user.password
#         click_button "Log in"

#         visit new_project_path
#         fill_in "Name", with: "New project"
#         fill_in "Description", with: "Description about project"
#         click_button "Create My Project"

#         expect(page).to have_text("New project")
#         expect(page).to have_text("Description about project")
#       end
#     end 
#   end
# end