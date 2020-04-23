require 'rails_helper'

RSpec.describe 'Tasks', type: :request do
  describe 'Get /projects/:project_id/tasks/new' do
    let(:member){ FactoryBot.create(:member) }
    let(:owner){ FactoryBot.create(:owner) }
    let(:the_other_member){ FactoryBot.create(:member) }

    context "when user didn't log in" do
      it "shouldn't show new task's page" do
        project = owner.project
        get new_project_task_path(project)
        expect(response).not_to have_http_status(:success)
      end
    end
    context "when user logged in" do
      context "as not a member" do
        before do
          log_in_as(the_other_member.user)
        end
        it "shouldn't show new task's page" do
          project = owner.project
          get new_project_task_path(project)
          expect(response).not_to have_http_status(:success)
        end
      end
      context "as a member" do
        before do
          log_in_as(member.user)
        end
        it "should show new task's page" do
          project = member.project
          get new_project_task_path(project)
          expect(response).to have_http_status(:success)
        end
      end
      context "as a owner" do
        before do
          log_in_as(owner.user)
        end
        it "should show new task's page" do
          project = owner.project
          get new_project_task_path(project)
          expect(response).to have_http_status(:success)
        end
      end
    end
  end
end