require 'rails_helper'

RSpec.describe "Tags", type: :request do
  describe "Get  /projects/:project_id/tags/new" do
    let(:member){ FactoryBot.create(:member) }
    let(:the_other_member){ FactoryBot.create(:member) }
    let(:owner){ FactoryBot.create(:owner) } 

    context "when user didn't login" do
      context "as owner of this project" do
        it "shouldn't show the page adding tag" do
          project = owner.project
          get new_project_tag_path(project)
          expect(response).not_to have_http_status(:success)
        end
      end
    end
    context "when user logged in" do
      context "as not member of this project" do
        before do
          log_in_as(the_other_member.user)
        end
        it "shouldn't show the page of adding tag" do
          project = owner.project
          get new_project_tag_path(project)
          expect(response).not_to have_http_status(:success)
        end
      end
      context "as a owner of this project" do
        before do
          log_in_as(owner.user)
        end
        it "should show the page of adding tag" do
          project = owner.project
          get new_project_tag_path(project)
          expect(response).to have_http_status(:success)
        end
      end
      context "as a member of this project" do
        before do
          log_in_as(member.user)
        end
        it "should show the page of adding tag" do
          project = member.project
          get new_project_tag_path(project)
          expect(response).to have_http_status(:success)
        end
      end
    end
  end
end