require 'rails_helper'

require 'rails_helper'

RSpec.describe "Tasks", type: :request do
  describe "Patch /tasks/:id" do
    let(:member){ FactoryBot.create(:member_of_project_with_tasks) }
    let(:pic_member){ FactoryBot.create(:member_with_full_tasks) }
    let(:the_other_member){ FactoryBot.create(:member_of_project_with_tasks) }

    context "when user didn't log in" do
      it "should not edit any task" do
        project = pic_member.project
        other_member = project.members.second
        task = project.tasks.first

        expect do
          patch project_task_path(task), params: {
            task_form: {
              name: 'changed name',
              deadline: '2222-22-22',
              content: 'changted content',
              priority: '1',
              project_id: project.id,
              pic_attributes: {
                user_id: other_member.user.id
              }
            }
          }
        end.not_to change{ task.reload }.from(task)
      end
    end
    context "when user logged in" do
      context "as not a member of this project" do
        before do
          log_in_as(the_other_member.user)
        end
        it "should not edit any tasks" do
          project = pic_member.project
          other_member = project.members.second
          task = project.tasks.first
              
          expect do
            patch project_task_path(task), params: {
              task_form: {
                name: 'changed name',
                deadline: '2222-22-22',
                content: 'changted content',
                priority: '1',
                project_id: project.id,
                pic_attributes: {
                  user_id: other_member.user.id
                }
              }
            }
          end.not_to change{ task.reload }.from(task)
        end
      end
      context "as a member without pic's task" do
        before do
          log_in_as(member.user)
        end
        it "shouldn't edit a task" do
          project = member.project
          other_member = project.members.second
          task = project.tasks.first
              
          expect do
            patch project_task_path(task), params: {
              task_form: {
                name: 'changed name',
                deadline: '2222-22-22',
                content: 'changted content',
                priority: '1',
                project_id: project.id,
                pic_attributes: {
                  user_id: other_member.user.id
                }
              }
            }
          end.not_to change{ task.reload }.from(task)
        end
      end
      context "as a member with pic's task" do
        before do
          log_in_as(pic_member.user)
        end
        it "shouldn't edit a task without every attributes" do
          project = pic_member.project
          other_member = project.members.second
          task = project.tasks.first
              
          expect do
            patch project_task_path(task), params: {
              task_form: {
                name: '',
                deadline: '',
                content: '',
                priority: '',
                project_id: project.id,
                pic_attributes: {
                  user_id: ''
                }
              }
            }
          end.not_to change{ task.reload }.from(task)
        end
        it "should edit a task" do
          project = pic_member.project
          other_member = project.members.second
          task = project.tasks.first
              
          expect do
            patch project_task_path(task), params: {
              task_form: {
                name: 'changed name',
                deadline: '2222-22-22',
                content: 'changted content',
                priority: 2,
                project_id: project.id,
                pic_attributes: {
                  user_id: other_member.user.id
                }
              }
            }
          end.to change{ task.reload.name }.from(task.name).to('changed name').
              and change{ task.reload.deadline }.from(task.deadline).to('2222-22-22').
              and change{ task.reload.content }.from(task.content).to('changted content').
              and change{ task.reload.priority }.from(task.priority).to(2)
        end
      end
    end
  end
end