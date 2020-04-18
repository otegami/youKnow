require 'rails_helper'

RSpec.describe "Projects", type: :request do
  let!(:user){ FactoryBot.create(:user) }
  let!(:other_user){ FactoryBot.create(:user) }
  let(:owner){ FactoryBot.create(:project_owner) }
  let!(:member){ FactoryBot.create(:project_member) }

  describe "Post /projects" do
    context "when user didn't log in" do
      it "shouldn't create new project" do
        expect{
          post projects_path, params: { project: FactoryBot.attributes_for(:project) }
        }.to change{ Project.count }.by(0)
      end
    end
    context "when user logged in" do
      it "with invalid info shouldn't create new project" do
        post login_path, params: { session: {email: user.email, password: user.password}}
        expect{
          post projects_path, params: { project: FactoryBot.attributes_for(:invalidProject) }
        }.to change{ Project.count }.by(0)
      end
      it "should create new project" do
        post login_path, params: { session: {email: user.email, password: user.password}}
        expect{
          post projects_path, params: { project: FactoryBot.attributes_for(:project) }
        }.to change{ Project.count }.by(1)
      end
    end
  end
end