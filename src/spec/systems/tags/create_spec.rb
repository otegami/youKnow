require "rails_helper"

RSpec.describe "Create tags In The Project", type: :system do
  let(:owner){ FactoryBot.create(:owner_of_project_with_tags) }
  let(:member){ FactoryBot.create(:member_of_project_with_tags) }
  let(:the_other_user){ FactoryBot.create(:member) }

  describe "The process of creating new tags in project" do
    context "when user didn't logged in" do
      it "shouldn't create new tags" do
        project = owner.project
        visit new_project_tag_path(project)

        expect(page).to have_text("Log in")
        expect(page).to have_text("Sign up now !!")
      end
    end
    context "when user logged in" do
      context "as not a member of this project" do
        before do
          log_in_as(the_other_user.user)
        end
        it "shouldn't create new tags" do
          project = owner.project
          visit new_project_tag_path(project)

          expect(page).to have_text("All Projects")
        end
      end
      context "as a member of this project" do
        before do
          log_in_as(member.user)
        end
        it "should create new tags" do
          project = member.project
          tags = project.tags
          visit new_project_tag_path(project)

          fill_in "Name", with: 'Test tag Name'
          click_button "Add Tag"
          expect(page).to have_text 'Test tag Name'
        end
      end
      context "as a owner of this project" do
        before do
          log_in_as(owner.user)
        end
        it "should create new tags" do
          project = owner.project
          tags = project.tags
          visit new_project_tag_path(project)

          fill_in "Name", with: ''
          click_button "Add Tag"

          expect(page).to have_content 'Name can\'t be blank'

          fill_in "Name", with: 'Test tag Name'
          click_button "Add Tag"

          expect(page).to have_text 'Test tag Name'
        end
      end
    end
  end
end