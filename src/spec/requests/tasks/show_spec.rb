require 'rails_helper'

RSpec.describe 'Tasks', type: :request do
  let(:member){ FactoryBot.create(:member_with_full_tasks) }
  let(:owner){ FactoryBot.create(:owner_with_full_tasks) }
  let(:the_other_member){ FactoryBot.create(:member_with_full_tasks) }

  describe "Get /tasks/:id" do
    context "when user didn't log in" do
      it "should not show detail page" do
        project = owner.project
        task = project.tasks.first

        get project_task_path(task)
        expect(response).not_to have_http_status(:success)
      end
    end
    context "when user logged in" do
      context "as not a member of this project" do
        before do
          log_in_as(the_other_member.user)
        end
        it "should not show detail page" do
          project = owner.project
          task = project.tasks.first

          get project_task_path(task)
          expect(response).not_to have_http_status(:success)
        end
      end
      context "as a member of this project" do
        before do
          log_in_as(member.user)
        end
        it "should show detail page" do
          project = member.project
          task = project.tasks.first

          get project_task_path(task)
          expect(response).to have_http_status(:success)
        end
      end
      context "as a owner of this project" do
        before do
          log_in_as(owner.user)
        end
        it "should show detail page" do
          project = owner.project
          task = project.tasks.first

          get project_task_path(task)
          expect(response).to have_http_status(:success)
        end
      end
    end
  end
end