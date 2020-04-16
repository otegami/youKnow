require "rails_helper"

RSpec.describe "Delete a project", type: :system do
  let!(:owner){ FactoryBot.create(:project_owner) }
  let!(:member){ FactoryBot.create(:project_member) }

  describe "the process of creating a project" do
    context "with user not logging in" do
      it "should show login page" do
        visit new_project_path
        expect(page).to have_text("Log in")
        expect(page).to have_text("Email")
        expect(page).to have_text("Password")
      end
    end
    context "with user logging in" do
      context "as a project owner" do
        it "should show project index page" do
          visit login_path
          fill_in "Email", with: owner.email
          fill_in "Password", with: owner.password
          click_button "Log in"
  
          project = owner.projects.first
          click_link("close_#{project.id}")
          page.driver.browser.switch_to.alert.accept
  
          expect(page).not_to have_text(project.name)
          expect(page).not_to have_text(project.description)
        end
      end
      context "as a project member" do
        it "should show project's close link" do
          visit login_path
          fill_in "Email", with: member.email
          fill_in "Password", with: member.password
          click_button "Log in"
  
          project = member.projects.first
          expect(page).not_to have_selector "#close_#{project.id}"
        end
      end
    end 
  end
end