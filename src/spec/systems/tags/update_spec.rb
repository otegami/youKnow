require "rails_helper"

RSpec.describe "Edit Tag In The Project", type: :system do
  let(:owner){ FactoryBot.create(:owner_of_project_with_tags) }
  let(:member){ FactoryBot.create(:member_of_project_with_tags) }
  let(:the_other_user){ FactoryBot.create(:member) }

  describe "The process of editting tag in project" do
    context "when user logged in" do
      context "as not a member of this project" do
        before do
          log_in_as(the_other_user.user)
        end
        it "shouldn't edit any tags" do
          project = owner.project
          visit project_tags_path(project)

          expect(page).to have_text("All Projects")
        end
      end
      context "as a member of this project" do
        before do
          log_in_as(member.user)
        end
        it "should edit tags" do
          project = member.project
          tag = project.tags.first 

          visit project_tags_path(project)

          expect(page).to have_text(tag.name)
          click_link("edit_#{tag.id}")

          fill_in 'Name', with: 'Changed Name'
          click_button 'Update'

          expect(page).to have_text('Changed Name')
        end
      end
      context "as a owner of this project" do
        before do
          log_in_as(owner.user)
        end

        it "shouldn't edit a tag" do
          project = owner.project
          tag = project.tags.first

          visit project_tags_path(project)

          expect(page).to have_text(tag.name)
          click_link("edit_#{tag.id}")

          fill_in 'Name', with: ''
          click_button 'Update'

          expect(page).to have_content 'Name can\'t be blank'
        end

        it "should edit tags" do
          project = owner.project
          tag = project.tags.first

          visit project_tags_path(project)

          expect(page).to have_text(tag.name)
          click_link("edit_#{tag.id}")

          fill_in 'Name', with: 'Changed Name'
          click_button 'Update'

          expect(page).to have_text('Changed Name')
        end
      end
    end
  end
end