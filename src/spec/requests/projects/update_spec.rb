require 'rails_helper'

RSpec.describe "Projects", type: :request do
  let!(:user){ FactoryBot.create(:user) }
  let!(:other_user){ FactoryBot.create(:user) }
  let(:owner){ FactoryBot.create(:project_owner) }
  let!(:member){ FactoryBot.create(:project_member) }

  describe "Patch /projects/params[:project_id]" do
    context "when user didn't log in" do
      it "shouldn't change project" do
        project = owner.projects.first
        changedName = 'Changed project name'
        changedDescription = 'Changed project description'
        expect {
          patch project_path(project), params: { project: { name: changedName, description: changedDescription } }
        }.not_to change{ project.reload.name }.from(project.name)
      end
    end
    context "when user logged in" do
      context "as a project owner" do
        before do
          user = owner
          post login_path, params: { session: {email: user.email, password: user.password}}
        end
        context "with invalid information about the project" do
          it "shouldn't update attributes about project" do
            project = owner.projects.first
            changedName = ' '
            changedDescription = ' '
            expect {
              patch project_path(project), params: { project: { name: changedName, description: changedDescription } }
            }.not_to change { project.reload.name }.from(project.name)
          end
        end
        context "with valid information about the project" do
          it "should update attributes about project" do
            project = owner.projects.first
            changedName = 'Changed project name'
            changedDescription = 'Changed project description'
            expect {
              patch project_path(project), params: { project: { name: changedName, description: changedDescription } }
            }.to change { project.reload.name }.from(project.name).to(changedName)
          end
        end
        context "as a project member" do
          before do
            user = member
            post login_path, params: { session: {email: user.email, password: user.password}}
          end
          it "should update attributes about project" do
            project = member.projects.first
            changedName = 'Changed project name'
            changedDescription = 'Changed project description'
            expect {
              patch project_path(project), params: { project: { name: changedName, description: changedDescription } }
            }.not_to change { project.reload.name }.from(project.name)
          end
        end
      end
    end
  end
end