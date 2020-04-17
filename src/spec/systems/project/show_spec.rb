require "rails_helper"

RSpec.describe "Project Top Page", type: :system do

  let!(:owner) { FactoryBot.create(:project_owner) }
  let!(:member) { FactoryBot.create(:project_member) }
  let!(:other_user) { FactoryBot.create(:project_owner) }

  describe "The layout of project top page(show page)" do
    context "when user haven't joined in this project" do
      before do
        visit login_path
        fill_in "Email", with: owner.email
        fill_in "Password", with: owner.password
        click_button "Log in"
      end
      it "should return project index page" do
        project = other_user.members.first.project
        visit project_path(project)

        expect(page).to have_text('All Projects')
      end
    end
    context "when user has already joined in this project" do
      context "as a project owner" do
        before do
          visit login_path
          fill_in "Email", with: owner.email
          fill_in "Password", with: owner.password
          click_button "Log in"
        end
        it "should return project top page" do
          project = owner.members.first.project
          visit project_path(project)
  
          expect(page).to  have_link 'Task'
          expect(page).to  have_link 'Tag', href: project_tags_path(project)
          expect(page).to  have_link 'Member', href: project_members_path(project)
          expect(page).to  have_link 'Graph'
        end
      end
      context "as a project member" do
        before do
          visit login_path
          fill_in "Email", with: member.email
          fill_in "Password", with: member.password
          click_button "Log in"
        end
        it "should return project top page" do
          project = member.members.first.project
          visit project_path(project)
  
          expect(page).to  have_link 'Task'
          expect(page).to  have_link 'Tag', href: project_tags_path(project)
          expect(page).to  have_link 'Member', href: project_members_path(project)
          expect(page).to  have_link 'Grap'
        end
      end 
    end
  end
end