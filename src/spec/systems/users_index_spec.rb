require "rails_helper"

RSpec.describe "Index of Users", type: :system do
  
  let!(:user) { FactoryBot.create(:user) }
  let!(:users) { FactoryBot.create_list(:user, 40) }

  describe "User accessing the index page of users" do
    context "without logging in" do
      it "should return login page" do
        visit users_path
        expect(page).to have_text("Log in")
      end  
    end

    context "with logging in" do

      before do
        visit login_path
        fill_in "Email", with: user.email
        fill_in "Password", with: user.password
        click_button "Log in"
      end  

      it "should return index pages" do
        visit users_path
        expect(page).to have_text("All users")
      end

      it "should return index pages with pagination" do
        visit users_path
        User.order(:name).page(1).each do |user|
          expect(page).to have_text(user.name)
        end
      end  
    end   
  end  
end  