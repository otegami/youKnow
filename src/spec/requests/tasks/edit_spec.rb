require 'rails_helper'

RSpec.describe 'Tasks', type: :request do
  describe 'Get /tasks/:id/edit' do
    let(:member){ FactoryBot.create(:member_of_project_with_tasks) }
    let(:pic_member){ FactoryBot.create(:member_with_full_tasks) }
    let(:the_other_member){ FactoryBot.create(:member_of_project_with_tasks) }

    context "when user didn't log in" do
      it "shouldn't show edit task's page" do
        project = pic_member.project
        task = project.tasks.first
        get edit_project_task_path(task)
        expect(response).not_to have_http_status(:success)
      end
    end
    context "when user logged in" do
      context "as not a member" do
        before do
          log_in_as(the_other_member.user)
        end
        it "shouldn't show edit task's page" do
          project = pic_member.project
          task = project.tasks.first
          get edit_project_task_path(task)
          expect(response).not_to have_http_status(:success)
        end
      end
      context "as a member without pic's task" do
        before do
          log_in_as(member.user)
        end
        it "shouldn't show edit task's page" do
          project = member.project
          task = project.tasks.first
          get edit_project_task_path(task)
          expect(response).not_to have_http_status(:success)
        end
      end
      context "as a member with pic's task" do
        before do
          log_in_as(pic_member.user)
        end
        it "should show edit task's page" do
          project = pic_member.project
          task = project.tasks.first
          get edit_project_task_path(task)
          expect(response).to have_http_status(:success)
        end
      end
    end
  end
end