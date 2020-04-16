require "rails_helper"

RSpec.describe "Tag new Page In The Project", type: :system do
  let(:owner){ FactoryBot.create(:owner_of_project_with_tags) }
  let(:member){ FactoryBot.create(:member_of_project_with_tags) }
  let(:the_other_user){ FactoryBot.create(:member) }

  describe "The process of accessing tag new page in project" do
    context "when user didn't logged in" do
      it "shouldn't show tag new page" do
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
        it "shouldn't show tag new page" do
          project = owner.project
          visit new_project_tag_path(project)

          expect(page).to have_text("All Projects")
        end
      end
      context "as a member of this project" do
        before do
          log_in_as(member.user)
        end
        it "should show tag new page" do
          project = member.project
          visit new_project_tag_path(project)

          expect(page).to have_text 'Add Tag'
          expect(page).to have_text 'Name'
        end
      end
      context "as a owner of this project" do
        before do
          log_in_as(owner.user)
        end
        it "should show tag new page" do
          project = owner.project
          visit new_project_tag_path(project)

          expect(page).to have_text 'Add Tag'
          expect(page).to have_text 'Name'
        end
      end
    end
  end
end