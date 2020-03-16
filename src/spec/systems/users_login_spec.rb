require "rails_helper"

RSpec.describe "Log in", type: :system do
  describe "The process of loging in" do
    context "with using invalid information" do
      it "should show the errors" do
        visit login_path

        fill_in "Email", with: ""
        fill_in "Password", with: ""
        click_button "Log in"

        expect(page).to have_text("invalid email / password combination")

        visit root_path
        expect(page).not_to have_text("invalid email / password combination")
      end  
    end
    context "with using valid information" do
      let!(:user) { FactoryBot.create(:user) }
      
      it "should show user's profile page" do
        visit login_path

        fill_in "Email", with: user.email
        fill_in "Password", with: user.password
        click_button "Log in"

        expect(page).to have_link 'Log in', href: login_path, count: 0
        expect(page).to have_link 'Log out', href: logout_path
        expect(page).to have_link 'Profile', href: user_path(user)
        expect(page).to have_link 'Users', href: users_path

        click_link "Log out"

        expect(page).to have_link 'Log in', href: login_path
        expect(page).to have_link 'Log out', href: logout_path, count: 0
        expect(page).to have_link 'Profile', href: user_path(user), count: 0
        expect(page).not_to have_link 'Users', href: users_path
      end
    end  
  end  
end 