require "rails_helper"

RSpec.describe "Tag edit Page In The Project", type: :system do
  let(:owner){ FactoryBot.create(:owner_of_project_with_tags) }
  let(:member){ FactoryBot.create(:member_of_project_with_tags) }
  let(:the_other_user){ FactoryBot.create(:member) }

  describe "The process of accessing tag edit page in project" do
    context "when user didn't logged in" do
      it "shouldn't show tag edit page" do
        project = owner.project
        visit project_tags_path(project)

        expect(page).to have_text("Log in")
        expect(page).to have_text("Sign up now !!")
      end
    end
    context "when user logged in" do
      context "as not a member of this project" do
        before do
          log_in_as(the_other_user.user)
        end
        it "shouldn't show tag edit page" do
          project = owner.project
          visit project_tags_path(project)

          expect(page).to have_text("All Projects")
        end
      end
      context "as a member of this project" do
        before do
          log_in_as(member.user)
        end
        it "should show tag edit page" do
          project = member.project
          tag = project.tags.first
          visit project_tags_path(project)

          expect(page).to have_text(tag.name)
          click_link("edit_#{tag.id}")

          expect(page).to have_text 'Edit Tag'
          expect(page).to have_field 'Name', with: tag.name
        end
      end
      context "as a owner of this project" do
        before do
          log_in_as(owner.user)
        end
        it "should show tag edit page" do
          project = owner.project
          tag = project.tags.first
          visit project_tags_path(project)

          expect(page).to have_text(tag.name)
          click_link("edit_#{tag.id}")

          expect(page).to have_text 'Edit Tag'
          expect(page).to have_field 'Name', with: tag.name
        end
      end
    end
  end
end