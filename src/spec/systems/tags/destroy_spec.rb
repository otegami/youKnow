require "rails_helper"

RSpec.describe "Remove A Tag In The Project", type: :system do
  let(:owner){ FactoryBot.create(:owner_of_project_with_tags) }
  let(:member){ FactoryBot.create(:member_of_project_with_tags) }
  let(:the_other_user){ FactoryBot.create(:member) }

  describe "The process of removing tag in project" do
    context "when user logged in" do
      context "as not a member of this project" do
        before do
          log_in_as(the_other_user.user)
        end
        it "shouldn't remove any tags" do
          project = owner.project
          visit project_tags_path(project)

          expect(page).to have_text("All Projects")
        end
      end
      context "as a member of this project" do
        before do
          log_in_as(member.user)
        end
        it "shouldn't remove any tags" do
          project = member.project
          tag = project.tags.first 

          visit project_tags_path(project)

          expect(page).to have_text(tag.name)
          expect(page).not_to have_link("remove_#{tag.id}")
        end
      end
      context "as a owner of this project" do
        before do
          log_in_as(owner.user)
        end

        it "should remove a tag" do
          project = owner.project
          tag = project.tags.first

          visit project_tags_path(project)

          expect(page).to have_text(tag.name)
          click_link("remove_#{tag.id}")
          page.driver.browser.switch_to.alert.accept

          expect(page).not_to have_link("remove_#{tag.id}")
        end
      end
    end
  end
end