require "rails_helper"

RSpec.describe "Tasks", type: :request do
  describe "Post /projects/:project_id/tasks" do
    let(:the_other_member){ FactoryBot.create(:member_of_project_with_tags) }
    let(:member){ FactoryBot.create(:member_of_project_with_tags) }
    let(:owner){ FactoryBot.create(:owner_of_project_with_tags) }
    context "when user didn't log in" do
      it "should return http success" do
        project = owner.project
        post project_tasks_path(project), params: {
          task_form: {
            name: 'task_name',
            deadline: '2019-04-20',
            content: 'What are you doing now?',
            priority: '0',
            project_id: owner.project.id,
            pic_attributes: {
              user_id: member.user.id
            }
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
          tags = project.tags.map { |tag| "#{tag.id}" }
          expect do
            post project_tasks_path(project), params: {
              task_form: {
                name: 'task_name',
                deadline: '2019-04-20',
                content: 'What are you doing now?',
                priority: '0',
                project_id: owner.project.id,
                pic_attributes: [
                  user_id: member.user.id
                ],
                taggings_attributes: {
                  tag_id: tags
                }
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
          tags = project.tags.map { |tag| "#{tag.id}" }
          expect do
            post project_tasks_path(project), params: {
              task_form: {
                name: 'task_name',
                deadline: '2019-04-20',
                content: 'What are you doing now?',
                priority: '0',
                project_id: member.project.id,
                pic_attributes: {
                  user_id: member.user.id
                },
                taggings_attributes: {
                  tag_id: tags
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
          project = owner.project
          tags = project.tags.map { |tag| "#{tag.id}" }
          expect do
            post project_tasks_path(project), params: {
              task_form: {
                name: 'task_name',
                deadline: '2019-04-20',
                content: 'What are you doing now?',
                priority: '0',
                project_id: owner.project.id,
                pic_attributes: {
                  user_id: member.user.id
                },
                taggings_attributes: {
                  tag_id: tags
                }
              }
            }
          end.to change { Task.count }.by(1)
        end
      end
    end
  end
end