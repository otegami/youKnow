require "rails_helper"

RSpec.describe "Sign up", type: :system do
  describe "The process of signing up" do
    context "with using invalid infromation" do
      it "should show the errors" do
        visit signup_path

        fill_in "Name", with: ""
        fill_in "Email", with: ""
        fill_in "Password", with: ""
        fill_in "Confirmation", with: ""
        click_button "Create my account"
        
        expect(page).to have_text("The form contains 4 errors")
      end
    end

    context "with using valid infromation" do
      it "should show home page with valid message" do
        visit signup_path

        fill_in "Name", with: "Takuya"
        fill_in "Email", with: "test1026@gmail.com"
        fill_in "Password", with: "rails1026"
        fill_in "Confirmation", with: "rails1026"
        click_button "Create my account"
        
        expect(page).to have_text("Please check your email to activate your account")
      end
    end    
  end  
end 