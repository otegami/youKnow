require "rails_helper"

RSpec.describe "Tasks", type: :request do
  describe "Post /projects/:project_id/tasks" do
    let(:the_other_member){ FactoryBot.create(:member) }
    let(:member){ FactoryBot.create(:member) }
    let(:owner){ FactoryBot.create(:owner) }
    context "when user didn't log in" do
      it "should return http success" do
        project = owner.project
        post project_tasks_path(project), params: {
          task: {
            name: 'task_name',
            deadline: '2019-04-20',
            content: 'What are you doing now?',
            priority: '0',
            project_id: owner.project.id,
            pic_attributes: [
              user_id: member.user.id
            ]
          }
        }
        expect(response).not_to have_http_status(:success)
      end
    end
    context "when user logged in" do
      context "as not a member of this project" do
        before do
          log_in_as(the_other_member.user)
        end
        it "shouldn't create any tasks" do
          project = owner.project
          expect do
            post project_tasks_path(project), params: {
              task: {
                name: 'task_name',
                deadline: '2019-04-20',
                content: 'What are you doing now?',
                priority: '0',
                project_id: owner.project.id,
                pic_attributes: [
                  user_id: member.user.id
                ]
              }
            }
          end.not_to change { Task.count }
        end
      end
      context "as a member of this project" do
        before do
          log_in_as(member.user)
        end
        it "should create a task" do
          project = member.project
          expect do
            post project_tasks_path(project), params: {
              task: {
                name: 'task_name',
                deadline: '2019-04-20',
                content: 'What are you doing now?',
                priority: '0',
                project_id: member.project.id,
                pic_attributes: {
                  user_id: member.user.id
                }
              }
            }
          end.to change { Task.count }.by(1)
        end
      end
      context "as a owner of this project" do
        before do
          log_in_as(owner.user)
        end
        it "should create a task" do
          skip
          project = owner.project
          expect do
            post project_tasks_path(project), params: {
              task: {
                name: 'task_name',
                deadline: '2019-04-20',
                content: 'What are you doing now?',
                priority: '0',
                project_id: owner.project.id,
                pic_attributes: [
                  user_id: member.user.id
                ]
              }
            }
          end.to change { Task.count }.by(1)
        end
      end
    end
  end
end