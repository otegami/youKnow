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
        task = project.tasks.first
        expect{
          patch project_task_path(project), params: {
            task_form: {
              name: 'task_name',
              deadline: '2019-04-20',
              content: 'What are you doing now?',
              priority: '0',
              project_id: pic_member.project.id,
              pic_attributes: {
                user_id: member.user.id
              }
            }
          }
        }.not_to change{ tag.reload.name }.from(tag.name)
      end
    end
    context "when user logged in" do
      context "as not a member of this project" do
        before do
          log_in_as(the_other_member.user)
        end
        it "should not edit any tasks" do
          project = owner.project
          tag = project.tags.first
          expect{
            patch project_tag_path(tag), params: { 
              tag: {
                name: 'test tag',
              }
            }
          }.not_to change{ tag.reload.name }.from(tag.name)
        end
      end
      context "as a member without pic's task" do
        before do
          log_in_as(member.user)
        end
        it "should edit a task" do
          project = member.project
          tag = project.tags.first
          changed_name = 'test tag'
          expect{
            patch project_tag_path(tag), params: { 
              tag: {
                name: changed_name,
              }
            }
          }.to change{ tag.reload.name }.from(tag.name).to(changed_name)
        end
      end
      context "as a member with pic's task" do
        before do
          log_in_as(owner.user)
        end
        it "shouldn't edit a task without every attributes" do
          project = owner.project
          tag = project.tags.first
          expect{
            patch project_tag_path(tag), params: { 
              tag: {
                name: '',
              }
            }
          }.not_to change{ tag.reload.name }.from(tag.name)
        end
        it "should edit a task" do
          project = owner.project
          tag = project.tags.first
          changed_name = 'test tag'
          expect{
            patch project_tag_path(tag), params: { 
              tag: {
                name: changed_name,
              }
            }
          }.to change{ tag.reload.name }.from(tag.name).to(changed_name)
        end
      end
    end
  end
end