require 'rails_helper'

RSpec.describe "Members", type: :request do
  let!(:project){ FactoryBot.create(:project_with_members) }
  let!(:user) { FactoryBot.create(:user) }
  
  # user is a member of project or not
  describe "Get /projects/:project_id/members" do
    context "when user is this project owner" do
      before do
        user = project.owner
        p user
        post login_path, params: { session: {email: user.email, password: user.password}}
        p user.email
        p user.password
      end
      
      it "should show the index page about member" do
        get project_members_path(project)
        expect(response).to have_http_status(:success)
      end
    end
    context "when user isn't a member of this project" do
      before do
        not_member = user
        post login_path, params: { session: {email: not_member.email, password: not_member.password}}
      end
      
      it "shouldn't show the index page about member" do
        get project_members_path(project)
        expect(response).not_to have_http_status(:success)
      end
    end
    context "when user is a member of this project" do
      before do
        member = project.members.first.user
        p member
        post login_path, params: { session: {email: member.email, password: member.password}}
        p member.email
        p member.password
      end

      it "should show the index page about member" do
        get project_members_path(project)
        expect(response).to have_http_status(:success)
      end
    end
  end
end