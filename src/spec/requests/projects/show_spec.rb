require 'rails_helper'

RSpec.describe "Projects", type: :request do
  let!(:user){ FactoryBot.create(:user) }
  let!(:other_user){ FactoryBot.create(:user) }
  let(:owner){ FactoryBot.create(:project_owner) }
  let!(:member){ FactoryBot.create(:project_member) }
  
  describe "Get /projects/params[:project_id]" do
    context "when user didn't log in" do
      it "shouldn't return project page" do
        project = owner.members.first.project
        get project_path(project)
        expect(response).not_to have_http_status(:success)
      end
    end
    context "when user logged in" do
      context "as a project owner" do
        it "shouldn return project page" do
          user = owner
          post login_path, params: { session: {email: user.email, password: user.password}}
          project = user.members.first.project
          get project_path(project)
          expect(response).to have_http_status(:success)
        end
      end
      context "as a project member" do
        it "shouldn return project page" do
          user = member
          post login_path, params: { session: {email: user.email, password: user.password}}
          project = user.members.first.project
          get project_path(project)
          expect(response).to have_http_status(:success)
        end
      end
    end
    context "when other user logged in" do
      it "should return project index page" do
        post login_path, params: { session: {email: other_user.email, password: other_user.password}}
        project = owner.members.first.project
        get project_path(project)
        expect(response).to have_http_status(302)
      end
    end
  end
end