require "rails_helper"

RSpec.describe "Project Top Page", type: :system do

  let!(:user) { FactoryBot.create(:user_with_projects) }
  let!(:other_user) { FactoryBot.create(:user_with_projects) }

  describe "The layout of project top page(show page)" do
    before do
      visit login_path
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_button "Log in"
    end
    context "when user haven't joined in this project" do
      it "should return project index page" do
        project = other_user.projects.first
        visit project_path(project)

        expect(page).to have_text('All Projects')
      end
    end
    context "when user has already joined in this project" do
      it "should return project top page" do
        project = user.projects.first
        visit project_path(project)

        expect(page).to  have_text('Tasks')
        expect(page).to  have_text('Label')
        expect(page).to  have_text('People')
        expect(page).to  have_text('Graph')
      end
    end
  end
end