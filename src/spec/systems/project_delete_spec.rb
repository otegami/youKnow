# require "rails_helper"

# RSpec.describe "Delete a project", type: :system do
#   let!(:user){ FactoryBot.create(:user_with_projects) }

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

#         project = user.projects.first
#         click_link("close_#{project.id}")
#         page.driver.browser.switch_to.alert.accept

#         expect(page).not_to have_text(project.name)
#         expect(page).not_to have_text(project.description)
#       end
#     end 
#   end
# end