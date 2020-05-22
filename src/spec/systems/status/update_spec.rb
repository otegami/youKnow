require 'rails_helper'

RSpec.describe "Update Task-Status", type: :system do
  describe "The process of updating task-status" do
    let(:member){ FactoryBot.create(:member_of_project_with_tasks) }
    let(:pic_member){ FactoryBot.create(:member_with_full_tasks) }

    context "when user logged in" do
      context "as not pic user" do
        before do
        end
        it "shouldn't show the status button" do
        end
      end
      context "as a pic user" do
        before do
          log_in_as(pic_member.user)
        end
        it "should see the status button" do
          project = pic_member.project
          task = project.tasks.first
          visit project_task_path(task)

          expect(page).to have_text "Start"
        end
        it "should update task's status" do
          project = pic_member.project
          task = project.tasks.first

          visit project_task_path(task)
          click_link "Start"
          expect(page).to have_text "Done"

          click_link "Done"
        end
      end
    end
  end
end