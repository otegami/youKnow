require 'rails_helper'

RSpec.describe "Projects", type: :request do
  let!(:user){ FactoryBot.create(:user) }
  let!(:other_user){ FactoryBot.create(:user) }
  let(:owner){ FactoryBot.create(:project_owner) }
  let!(:member){ FactoryBot.create(:project_member) }
  
  describe "Delete /projects/params[:id]" do
    context "when user didn't log in" do
      it "shouldn't delete a project" do
        project = owner.members.first.project
        expect{
          delete project_path(project)
        }.to change{ Project.count }.by(0)
      end
    end
    context "when user logged in" do
      context "as a project owner" do
        before do
          user = owner
          post login_path, params: { session: {email: user.email, password: user.password}}
        end
        it "should delete a project" do
          project = owner.members.first.project
          expect{
            delete project_path(project)
          }.to change{ project.reload.status }.from(true).to(false)
        end
      end
      context "as a project member" do
        before do
          user = member
          post login_path, params: { session: {email: user.email, password: user.password}}
        end
        it "shouldn't delete a project" do
          project = member.members.first.project
          expect{
            delete project_path(project)
          }.not_to change{ project.reload.status }.from(project.status)
        end
      end
    end
  end
end