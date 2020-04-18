require 'rails_helper'

RSpec.describe "Projects", type: :request do
  let!(:user){ FactoryBot.create(:user) }
  let!(:other_user){ FactoryBot.create(:user) }
  let(:owner){ FactoryBot.create(:project_owner) }
  let!(:member){ FactoryBot.create(:project_member) }
  
  describe "Get /projects/new" do
    context "when user didn't log in" do
      it "should return http success" do
        get new_project_path
        expect(response).not_to have_http_status(:success)
      end
    end
    context "when user logged in" do
      it "should return http success" do
        post login_path, params: { session: {email: user.email, password: user.password}}
        get new_project_path
        expect(response).to have_http_status(:success)
      end
    end
  end
end