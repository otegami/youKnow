require 'rails_helper'
RSpec.describe "Editting user", type: :system do

  let!(:user) { FactoryBot.create(:user) }
  let!(:the_other_user) { FactoryBot.create(:user) }

  describe "information by user who loged in " do
    before do
      visit login_path
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_button "Log in"
    end  

    context "with the invalid information" do
      it "should return errors about validationes" do
        visit edit_user_path(user)

        fill_in "Email", with: ""
        fill_in "Name", with: ""
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
        fill_in "Email", with: "emailIsChanged@gmail.com"
        fill_in "Password", with: ""
        fill_in "Confirmation", with: ""
        click_button "Save changes"

        expect(page).to have_text("user name is changed")
      end  
    end
  end

  describe "information by user who don't log in " do
    it "should return log in page" do
      visit edit_user_path(user)
      expect(page).to have_text("Please log in")
    end
  end

  describe "information by the other user" do
    before do
      visit login_path
      fill_in "Email", with: the_other_user.email
      fill_in "Password", with: the_other_user.password
      click_button "Log in"
    end 

    it "should return log in page" do
      skip
      visit edit_user_path(user)
      expect(page).to have_text("Welcome to youKnow")
    end
  end

  describe "infromation before logging in" do
    it "should return login page and then edit page" do
      visit edit_user_path(user)
      
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_button "Log in"
      expect(page).to have_text("Update your profile")
    end  
  end  
end  