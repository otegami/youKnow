require 'rails_helper'

RSpec.describe "Members", type: :request do
  let(:project){ FactoryBot.create(:project_with_members) }

  # user is a member of project or not
  describe "Get /projects/:project_id/members" do
    before do
      user = project.owner
      post login_path, params: { session: {email: user.email, password: user.password}}
    end
    
    it "should show the index page about member" do
      get  project_members_path(project)
      expect(response).to have_http_status(:success)
    end
  end
end
