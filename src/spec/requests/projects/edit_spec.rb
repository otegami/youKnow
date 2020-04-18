require 'rails_helper'

RSpec.describe "Projects", type: :request do
  let!(:user){ FactoryBot.create(:user) }
  let!(:other_user){ FactoryBot.create(:user) }
  let(:owner){ FactoryBot.create(:project_owner) }
  let!(:member){ FactoryBot.create(:project_member) }

  describe "GET /projects/params[:project_id]/edit" do
    context "when user didn't log in" do
      it "should't return http success" do
        project = owner.members.first.project
        get edit_project_path(project)
        expect(response).not_to have_http_status(:success)
      end
    end
    context "when user logged in" do
      context "as a project owner" do
        before do
          user = owner
          post login_path, params: { session: {email: user.email, password: user.password}}
        end
        it "should return http success" do
          project = owner.members.first.project
          get edit_project_path(project)
          expect(response).to have_http_status(:success)
        end
      end
      context "as a project member" do
        before do
          user = member
          post login_path, params: { session: {email: user.email, password: user.password}}
        end
        it "should return http success" do
          project = member.members.first.project
          get edit_project_path(project)
          expect(response).not_to have_http_status(:success)
        end
      end
    end
  end
end