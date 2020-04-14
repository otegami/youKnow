require "rails_helper.rb"

RSpec.describe "Adding Member to Project", type: :system do
  describe "The process of adding member to project" do
    let!(:owner){ FactoryBot.create(:project_owner) }
    let!(:member){ FactoryBot.create(:project_member) }

    context "when user logged in" do
      context "as a owner" do
        before do
          log_in_as(owner)
        end
        it "should show the page of adding member to this project" do
          project = owner.projects.first
          visit project_members_path(project)
          click_link "Add Member"
          
          expect(page).to have_text('Add Member')
          expect(page).to have_text('User email')
          expect(page).to have_button('Add Member To Project')
        end
      end
    end
  end
end