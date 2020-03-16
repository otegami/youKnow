require "rails_helper"

RSpec.describe "Index of Users", type: :system do
  describe "User accessing an index page of users" do
    context "without logging in" do
      it "should return login page" do
        visit users_path
        expect(page).to have_text("Log in")
      end  
    end  
  end  
end  