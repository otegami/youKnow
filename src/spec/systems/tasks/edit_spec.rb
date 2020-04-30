require 'rails_helper'

RSpec.describe "Editing A Task to Project", type: :system do
  describe "The process of editing task to project" do
    let(:member){ FactoryBot.create(:member_of_project_with_tasks) }
    let(:member_as_pic){ FactoryBot.create(:member_with_full_tasks) }

    context "when user logged in as a member" do
      context "as a person in charge of task" do
        before do
          log_in_as(member_as_pic.user)
        end
        it "should return the edit page" do
          project = member_as_pic.project
          task = project.tasks.first

          visit project_task_path(task)
          click_link "edit_#{task.id}"

          # expect(page).to have_text task.status
          #  expect(page).to have_link "back_#{task.id}"
          #  expect(page).to have_link "update_#{task.id}"
          expect(page).to have_field 'Name', with: task.name
          expect(page).to have_field 'Deadline', with: task.deadline.strftime("%Y-%m-%d")
          # expect(page).to have_field 'Pic', with task.pic
          # expect(page).to have_select('task_form[pic_attributes][user_id]', selected: pic_user(task).name)
          expect(page).to have_field 'Content', with: task.content
          # expect(page).to have_field 'File', with task.
          # expect(page).to have_field 'Tag', with task.
          expect(page).to have_select('Priority', selected: priority_of(task.priority))
          # expect(page).to have_text task.files
        end
      end
    end
  end
end