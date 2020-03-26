require 'rails_helper'

RSpec.describe "Projects", type: :request do
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
    end
  end
  describe "Delete /projects/params[:id]" do
    context "when user didn't log in" do
      it "shouldn't delette a project" do
        expect{
          delete project_path(project)
        }.to change{ Project.count }.by(0)
      end
    end
    context "when user logged in" do
    end
  end
end