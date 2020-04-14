require 'rails_helper'

RSpec.describe "Members", type: :request do
  let!(:owner){ FactoryBot.create(:project_owner) }
  let!(:member){ FactoryBot.create(:project_member) }
  let!(:the_other_user){ FactoryBot.create(:project_owner) }
  
  describe "Post /projects/:project_id/members" do
    context "when user didn't login" do
      context "as a owner of this project" do
        it "shouldn't return http success" do
          project = owner.projects.first
          post project_members_path(project), params: {
            member: {
              user_email: the_other_user.email
            }
          }
          expect(response).not_to have_http_status(:success)
        end
      end
    end
    context "when user logged in" do
      context "as not a member of this project" do
        before do
          log_in_as(the_other_user)
        end
        it "shouldn't return http success" do
          project = owner.projects.first
          post project_members_path(project), params: {
            member: {
              user_email: the_other_user.email
            }
          }
          expect(response).not_to have_http_status(:success)
        end
      end
      context "as a member of this project" do
        before do
          log_in_as(member)
        end
        it "shouldn't return http success" do
          project = member.projects.first
          post project_members_path(project), params: {
            member: {
              user_email: the_other_user.email
            }
          }
          expect(response).not_to have_http_status(:success)
        end
      end
      context "as a owner of this project" do
        before do
          log_in_as(owner)
        end
        it "should return http success" do
          project = owner.projects.first
          post project_members_path(project), params: {
            member: {
              user_email: the_other_user.email
            }
          }
          expect(response).to have_http_status(302)
        end
        it "should add new member to this project" do
          project = owner.projects.first
          expect do
            post project_members_path(project), params: {
              member: {
                user_email: the_other_user.email
              }
            }
          end.to change{ Member.count }.by(1)
        end
        it "should add the same user to this project" do
          project = owner.projects.first
          expect do
            post project_members_path(project), params: {
              member: {
                user_email: the_other_user.email
              }
            }
            post project_members_path(project), params: {
              member: {
                user_email: the_other_user.email
              }
            }
          end.to change { Member.count }.by(1)
        end
        it "should not add yourself to this project" do
          project = owner.projects.first
          expect do
            post project_members_path(project), params: {
              member: {
                user_email: owner.email
              }
            }
          end.not_to change { Member.count }
        end
      end
    end
  end
end