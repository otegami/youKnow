require "rails_helper"

RSpec.describe "Edit a project", type: :system do
  let!(:user){ FactoryBot.create(:user_with_projects) } 

  describe "the process of editing a project" do
    context "without user logging in" do
      it "should show login page" do
        project = user.projects.first
        visit edit_project_path(project)
        expect(page).to have_text("Log in")
        expect(page).to have_text("Email")
        expect(page).to have_text("Password")
      end
    end
    context "with user logging in" do
      before do
        visit login_path
        fill_in "Email", with: user.email
        fill_in "Password", with: user.password
        click_button "Log in"
      end
      it "should show edit page of a project" do
        changedName = 'Changed project name'
        changedDescription = 'Changed project description'
        project = user.projects.first
        visit edit_project_path(project)
        expect(page).not_to have_text(project.name)
        expect(page).not_to have_text(project.description)

        fill_in "Name", with: changedName
        fill_in "Description", with: changedDescription
        click_button 'Update'

        expect(page).to have_text(changedName)
        expect(page).to have_text(changedDescription)
      end
    end 
  end
end