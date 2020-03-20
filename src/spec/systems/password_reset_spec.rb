require "rails_helper"

RSpec.describe "Password reset", type: :system do
  let!(:user){ FactoryBot.create(:user) }

  describe "Resetting user password" do
    context "with using invalid user email" do
      it "should return forgot password page" do
        visit new_password_reset_path

        fill_in "Email", with: ""
        click_button "Submit"
        
        expect(page).to have_text("Email address not found")
      end
    end
    context "with using valid user email" do
      before do
        visit new_password_reset_path
        fill_in "Email", with: user.email
        click_button "Submit"
      end  

      it "should return home page" do
        expect(page).to have_text("Email sent with password reset instructions")
      end

      # I don't know how I can get reset_token from user
      # it "should return password reset page" do
      #   visit edit_password_reset_path(.reset_token, email: user.email)

      #   expect(page).to have_text("Password")
      #   expect(page).to have_text("Password")

      #   fill_in "Password", with: "password"
      #   fill_in "Confirmation", with: "password"
      #   click_button "Submit"

      #   expect(page).to have_link 'Profile', href: user_path(user)
      # end  
    end
  end  
end  