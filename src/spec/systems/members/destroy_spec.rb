require 'rails_helper'

RSpec.describe "Removing Member to Project", type: :system do
  describe "The process of removing member from project" do
    let!(:owner){ FactoryBot.create(:owner_of_project) }
    let!(:member){ FactoryBot.create(:member_of_project) }

    context "when user logged in" do
      context "as a member of the project" do
      #   # User as a member log in 
      #   # Visit member index page
      #   # check the existence of remove button
      #   # * there is no remove buttons
        before do
          log_in_as(member.user)
        end
        it "shouldn't be executed by a member" do
          project = member.project
          visit project_members_path(project)

          expect(page).not_to have_link("remove_#{member.id}")
        end
      end
      context "as a owner of the project" do
        # User as a owner log in 
        # Visit member index page
        # check the existence of remove button
        # * there is no remove button about owner
        # click remove buttons about all members in your project
        # check whether member was deleted
        before do
          log_in_as(owner.user)
        end

        it "should be executed by owner" do
          project = owner.project
          members = project.members
          visit project_members_path(project)

          expect(page).not_to have_link("remove_#{owner.id}")
          members.each do |member|
            if member.owner
              expect(page).not_to have_link("remove_#{member.id}")
            else
              expect(page).to have_link("remove_#{member.id}")

              click_link("remove_#{member.id}")
              page.driver.browser.switch_to.alert.accept
              
              expect(page).not_to have_link("remove_#{member.id}")
            end
          end
        end
      end      
    end
  end
end