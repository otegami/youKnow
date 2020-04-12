require 'rails_helper'

RSpec.describe "Members", type: :request do
  let!(:owner){ FactoryBot.create(:project_owner) }
  let!(:member){ FactoryBot.create(:project_member) }
  let!(:the_other_user){ FactoryBot.create(:project_owner) }

  describe "Get /projects/:project_id/members" do
    context " when user didn't log in" do
      context "as a owner of this project" do
        it "shouldn't show member index page" do
          project = owner.projects.first
          get project_members_path(project)
          expect(response).not_to have_http_status(:success)
        end
      end
      context "as a owner of this project" do
        it "shouldn't show member index page" do
          project = member.projects.first
          get project_members_path(project)
          expect(response).not_to have_http_status(:success)
        end
      end
    end
    context "when user logged in " do
      context "as not member of this project" do
        before do
          post login_path, params: { session: {email: the_other_user.email, password: the_other_user.password}}
        end
        it "should show member index page" do
          project = owner.projects.first
          get project_members_path(project)
          expect(response).not_to have_http_status(:success)
        end
      end
      context "as a member of this project" do
        before do
          post login_path, params: { session: {email: member.email, password: member.password}}
        end
        it "should show member index page" do
          project = member.projects.first
          get project_members_path(project)
          expect(response).to have_http_status(:success)
        end
      end
      context "as a owner of this project" do
        before do
          post login_path, params: { session: {email: owner.email, password: owner.password}}
        end
        it "should show member index page" do
          project = owner.projects.first
          get project_members_path(project)
          expect(response).to have_http_status(:success)
        end
      end
    end
  end
  describe "Get /projects/:project_id/members/new" do
    context "when user didn't login" do
      context "as owner of this project" do
        it "shouldn't show the page adding member" do
          project = owner.projects.first
          get new_project_member_path(project)
          expect(response).not_to have_http_status(:success)
        end
      end
    end
    context "when user logged in" do
      context "as not member of this project" do
        before do
          log_in_as(the_other_user)
        end
        it "shouldn't show the page of adding member" do
          project = owner.projects.first
          get new_project_member_path(project)
          expect(response).not_to have_http_status(:success)
        end
      end
      context "as a owner of this project" do
        before do
          log_in_as(owner)
        end
        it "should show the page of adding member" do
          project = owner.projects.first
          get new_project_member_path(project)
          expect(response).to have_http_status(:success)
        end
      end
      context "as a member of this project" do
        before do
          log_in_as(member)
        end
        it "shouldn't show the page of adding member" do
          project = member.projects.first
          get new_project_member_path(project)
          expect(response).not_to have_http_status(:success)
        end
      end
    end
  end
end