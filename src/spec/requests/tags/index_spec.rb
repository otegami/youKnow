require 'rails_helper'

RSpec.describe "Tags", type: :request do
  let!(:member){ FactoryBot.create(:member) }
  let!(:the_other_project){ FactoryBot.create(:project) }
  describe "Get /projects/:project_id/tags" do
    context "when user didn't log in" do
      it "shouldn't show tag index page" do
        project = member.project
        get project_tags_path(project)
        expect(response).not_to have_http_status(:success)
      end
    end
    context "when user logged in" do
      before do
        log_in_as(member.user)
      end
      context "as not member of this project" do
        it "shouldn't show tag index page" do
          get project_tags_path(the_other_project)
          expect(response).not_to have_http_status(:success)
        end
      end
      context "as a member of this project" do
        it "shouldn show tag index page" do
          project = member.project
          get project_tags_path(project)
          expect(response).to have_http_status(:success)
        end
      end
    end
  end
end
