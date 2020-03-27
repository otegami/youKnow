require 'rails_helper'

RSpec.describe "Projects", type: :request do
  let!(:user){ FactoryBot.create(:user) }
  let!(:project){ FactoryBot.create(:project) }
  
  describe "Get /projects/new" do
    it "should return http success" do
      get new_project_path
      expect(response).to have_http_status(302)
    end
  end
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
  describe "Delete /projects/params[:id]" do
    context "when user didn't log in" do
      it "shouldn't delete a project" do
        expect{
          delete project_path(project)
        }.to change{ Project.count }.by(0)
      end
    end
    context "when user logged in" do
      it "should delete a project" do
        user = project.owner
        post login_path, params: { session: {email: user.email, password: user.password}}
        expect{
          delete project_path(project)
        }.to change{ project.reload.status }.from(true).to(false)
      end
    end
  end
end