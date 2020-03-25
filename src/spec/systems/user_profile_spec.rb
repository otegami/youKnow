require "rails_helper"

RSpec.describe "User profile page", type: :system do
  let!(:project){ FactoryBot.create(:project, 30) }

  describe "The layout of user profile page" do
    before do
      visit login_path
      fill_in "Email", with: project.owner.email
      fill_in "Password", with: project.owner.password
      click_button "Log in"
      visit user_path(project.owner)
    end

    it "should have all of users projects" do
      expect(page).to have_text(project.owner.name)
      expect(page).to have_text(project.owner.name)
    end
  end
end