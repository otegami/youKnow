require 'rails_helper'

RSpec.describe "Projects", type: :request do
  let!(:user){ FactoryBot.create(:user) }
  let!(:other_user){ FactoryBot.create(:user) }
  let(:owner){ FactoryBot.create(:owner) }
  let!(:member){ FactoryBot.create(:member) }
#   let!(:other_user){ FactoryBot.create(:owner) }
#   let!(:project){ FactoryBot.create(:project) }
  
  describe "Get /projects/params[:project_id]" do
    context "when user didn't log in" do
      it "shouldn't return project page" do
        project = owner.members.first.project
        get project_path(project)
        expect(response).not_to have_http_status(:success)
      end
    end
    context "when user logged in" do
      it "shouldn return project page" do
        user = owner
        post login_path, params: { session: {email: user.email, password: user.password}}
        project = user.members.first.project
        get project_path(project)
        expect(response).to have_http_status(:success)
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
  # Members cannot edit the project they have joined
  describe "GET /projects/params[:project_id]/edit" do
    context "when user didn't log in" do
      it "should't return http success" do
        project = owner.members.first.project
        get edit_project_path(project)
        expect(response).not_to have_http_status(:success)
      end
    end
    context "when user logged in" do
      before do
        user = owner
        post login_path, params: { session: {email: user.email, password: user.password}}
      end
      it "should't return http success" do
        project = project = owner.members.first.project
        get edit_project_path(project)
        expect(response).to have_http_status(:success)
      end
    end
  end
#   describe "Patch /projects/params[:project_id]" do
#     context "when user didn't log in" do
#       it "shouldn't change project" do
#         project = user.projects.first
#         changedName = 'Changed project name'
#         changedDescription = 'Changed project description'
#         expect {
#           patch project_path(project), params: { project: { name: changedName, description: changedDescription } }
#         }.not_to change{ project.reload.name }.from(project.name)
#       end
#     end
#     context "when user logged in" do
#       before do
#         post login_path, params: { session: {email: user.email, password: user.password}}
#       end
#       context "with invalid information about the project" do
#         it "shouldn't update attributes about project" do
#           project = user.projects.first
#           changedName = ' '
#           changedDescription = ' '
#           expect {
#             patch project_path(project), params: { project: { name: changedName, description: changedDescription } }
#           }.not_to change { project.reload.name }.from(project.name)
#         end
#       end
#       context "with valid information about the project" do
#         it "should update attributes about project" do
#           project = user.projects.first
#           changedName = 'Changed project name'
#           changedDescription = 'Changed project description'
#           expect {
#             patch project_path(project), params: { project: { name: changedName, description: changedDescription } }
#           }.to change { project.reload.name }.from(project.name).to(changedName)
#         end
#       end
#     end
#   end
#   describe "Delete /projects/params[:id]" do
#     context "when user didn't log in" do
#       it "shouldn't delete a project" do
#         expect{
#           delete project_path(project)
#         }.to change{ Project.count }.by(0)
#       end
#     end
#     context "when user logged in" do
#       it "should delete a project" do
#         user = project.owner
#         post login_path, params: { session: {email: user.email, password: user.password}}
#         expect{
#           delete project_path(project)
#         }.to change{ project.reload.status }.from(true).to(false)
#       end
#     end
#   end
#   describe "Get /projects/params[:id]/edit" do
#     context "when user didn't log in" do
#       it "shouldn't return http success" do
#         get edit_project_path(project)
#         expect(response).to have_http_status(302)
#       end
#     end
#     context "when user logged in" do
#     end
#   end
end