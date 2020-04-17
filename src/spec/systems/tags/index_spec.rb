require "rails_helper"

RSpec.describe "Tag Index Page In The Project", type: :system do
  let(:owner){ FactoryBot.create(:owner_of_project_with_tags) }
  let(:member){ FactoryBot.create(:member_of_project_with_tags) }
  let(:the_other_user){ FactoryBot.create(:member) }

  describe "The process of accessing tag index page in project" do
    context "when user didn't logged in" do
      it "shouldn't show tag index page" do
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
        it "shouldn't show tag index page" do
          project = owner.project
          visit project_tags_path(project)

          expect(page).to have_text("All Projects")
        end
      end
      # Member doesn't have the right to edit or destroy tags
      context "as a member of this project" do
        before do
          log_in_as(member.user)
        end
        it "should show tag index page" do
          project = member.project
          tags = project.tags
          visit project_tags_path(project)

          expect(page).to have_link 'Add Tag', href: new_project_tag_path(project)
          tags.each do |tag|
            expect(page).to have_text(tag.name)
            expect(page).to have_link("edit_#{tag.id}")
            expect(page).not_to have_link("remove_#{tag.id}")
          end
        end
      end
      # Owner has the right to edit or destroy tags
      context "as a owner of this project" do
        before do
          log_in_as(owner.user)
        end
        it "should show tag index page" do
          project = owner.project
          tags = project.tags
          visit project_tags_path(project)

          expect(page).to have_link 'Add Tag', href: new_project_tag_path(project)
          tags.each do |tag|
            expect(page).to have_text(tag.name)
            expect(page).to have_link("edit_#{tag.id}")
            expect(page).to have_link("remove_#{tag.id}")
          end
        end
      end
    end
  end
end