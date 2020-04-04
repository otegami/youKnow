require "rails_helper"

RSpec.describe "Edit a project", type: :system do
  let!(:owner){ FactoryBot.create(:project_owner) }
  let!(:member){ FactoryBot.create(:project_member) }

  describe "the process of editing a project" do
    context "without user logging in" do
      it "should show login page" do
        project = owner.projects.first
        visit edit_project_path(project)
        expect(page).to have_text("Log in")
        expect(page).to have_text("Email")
        expect(page).to have_text("Password")
      end
    end
    context "with user logging in" do
      context "as a project" do
        before do
          visit login_path
          fill_in "Email", with: owner.email
          fill_in "Password", with: owner.password
          click_button "Log in"
        end
        it "should show edit page of a project" do
          changedName = 'Changed project name'
          changedDescription = 'Changed project description'
          project = owner.projects.first
          visit edit_project_path(project)
          expect(page).to have_field 'Name', with: project.name
          expect(page).to have_field 'Description', with: project.description
  
          fill_in "Name", with: changedName
          fill_in "Description", with: changedDescription
          click_button 'Update'
  
          expect(page).to have_text(changedName)
          expect(page).to have_text(changedDescription)
        end
      end
      context "as a member" do
        before do
          visit login_path
          fill_in "Email", with: member.email
          fill_in "Password", with: member.password
          click_button "Log in"
        end
        it "should show project index page" do
          project = member.projects.first
          visit edit_project_path(project)
          expect(page).to have_link('New Project')
          member.projects.where(status: true).page(1).each do |project|
            expect(page).to have_content(project.name)
            expect(page).to have_content(project.description)
            expect(page).to have_link("show_#{project.id}")
          end
        end
      end
    end 
  end
end