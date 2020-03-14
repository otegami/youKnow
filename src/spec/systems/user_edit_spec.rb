require 'rails_helper'
RSpec.describe "Editting user", type: :system do
  let!(:user) { FactoryBot.create(:user) }

  before do
    visit login_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"
  end  

  context "with the invalid information" do
    it "should return errors about validationes" do
      visit edit_user_path(user)

      fill_in "Name", with: ""
      fill_in "Email", with: ""
      fill_in "Password", with: ""
      fill_in "Confirmation", with: ""
      click_button "Save changes"

      expect(page).to have_text("The form contains 3 errors")
    end
  end
  context "with the valid information" do
    it "return the profile page" do
      visit edit_user_path(user)

      fill_in "Name", with: "user name is changed"
      fill_in "Email", with: "user email is changed"
      fill_in "Password", with: ""
      fill_in "Confirmation", with: ""
      click_button "Save changes"

      expect(page).to have_text("user name is changed")
    end  
  end
end  