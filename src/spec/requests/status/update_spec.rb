require 'rails_helper'

RSpec.describe "Tags", type: :request do
  describe "POST /projects/:project_id/status" do
    let(:member){ FactoryBot.create(:member_of_project_with_tasks) }
    let(:pic_member){ FactoryBot.create(:member_with_full_tasks) }
    let(:the_other_member){ FactoryBot.create(:member_of_project_with_tasks) }

    context "whem user didn't log in" do
      it "shouldn't update task's status" do
        project = pic_member.project
        task = project.tasks.first
        expect do
          post project_status_index_path(project), params: {
            task: {
              status: 1,
              task_id: task.id
            }
          }
        end.not_to change{ task.reload.status }
      end
    end
    context "when user logged in" do
      context "as the other project's member" do
        before do
          log_in_as(the_other_member.user)
        end
        it "shouldn't update task's status" do
          project = pic_member.project
          task = project.tasks.first
          expect do
            post project_status_index_path(project), params: {
              task: {
                status: 1,
                task_id: task.id
              }
            }
          end.not_to change{ task.reload.status }
        end
      end
      context "as not pic user" do
        # How to test? I will think of it later
        it "shouldn't update task's status" do
        end
      end
      context "as a pic user" do
        before do
          log_in_as(pic_member.user)
        end
        it "shouldn't update task's status" do
          project = pic_member.project
          task = project.tasks.first

          expect do
            post project_status_index_path(project), params: {
              task: {
                status: 1,
                task_id: task.id
              }
            }
          end.to change{ task.reload.status }.by(1)
        end
      end
    end
  end
end