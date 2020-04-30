require 'rails_helper'

RSpec.describe "Detail Task Page", type: :system do
  let(:member){ FactoryBot.create(:member_of_project_with_tasks) }
  let(:member_as_pic){ FactoryBot.create(:member_with_full_tasks) }

  describe "The layout of detail task page(show page)" do
    context "when user logged in as a member" do
      context "as not a person in charge of task" do
        before do
          log_in_as(member.user)
        end
        it "should return the page without edit and close" do
          project = member.project
          task = project.tasks.first

          visit project_path(project)
          click_link "show_#{task.id}"

          # expect(page).to have_text task.status
          expect(page).not_to have_link "edit_#{task.id}"
          expect(page).not_to have_link "close_#{task.id}"
          expect(page).to have_text task.name
          expect(page).to have_text task.deadline
          expect(page).to have_text task.content
          # expect(page).to have_text task.files
          task.tags.each do |tag|
            expect(page).to have_text tag.name
          end
          expect(page).to have_text priority_of(task.priority)
        end
      end
      context "as a person in charge of task" do
        before do
          log_in_as(member_as_pic.user)
        end
        it "should return the page with edit and close" do
          project = member_as_pic.project
          task = project.tasks.first

          visit project_path(project)
          click_link "show_#{task.id}"

          # expect(page).to have_text task.status
          expect(page).to have_link "edit_#{task.id}"
          expect(page).to have_link "close_#{task.id}"
          expect(page).to have_text task.name
          expect(page).to have_text pic_user(task).name
          expect(page).to have_text task.deadline
          expect(page).to have_text task.content
          # expect(page).to have_text task.files
          task.tags.each do |tag|
            expect(page).to have_text tag.name
          end
          expect(page).to have_text priority_of(task.priority)
        end
      end
    end
  end
end