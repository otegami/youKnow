require 'rails_helper'

RSpec.describe "Members", type: :request do
  let!(:the_other_user){ FactoryBot.create(:project_owner) }
  let!(:members){ FactoryBot.create_list(:test_member, 10) }
  let!(:owner){ FactoryBot.create(:test_owner) }

  describe "Delete /members/:id" do
    context "when user didn't log in" do
      context "as a owner" do
        it "should not delete a member from this project." do
          member = members.first
          project = member.project
          expect do
            delete project_member_path(member), params: {
              project_id: project.id
            }
          end.not_to change { Member.count }
        end
      end
    end
    context "when user logged in" do
      context "being not a member " do
        before do
          log_in_as(the_other_user)
        end
        it "should not delete a member from this project." do
          member = members.first
          project = member.project
          expect do
            delete project_member_path(member), params: {
              project_id: project.id
            }
          end.not_to change { Member.count }
        end
      end
      context "as a member" do
        before do
          member = members.first.user
          log_in_as(member)
        end
        it "should not delete a member from this project." do
          other_member = members.last
          project = other_member.project
          expect do
            delete project_member_path(other_member), params: {
              project_id: project.id
            }
          end.not_to change { Member.count }
        end
      end
      context "as a owner" do
        before do
          log_in_as(owner.user)
        end
        it "should return http success" do
          member = members.first
          project = owner.project
          delete project_member_path(member), params: {
            project_id: project.id
          }
          expect(response).to have_http_status(302)
        end
        it "should delete a member from this project." do
          member = members.first
          project = owner.project
          expect do
            delete project_member_path(member), params: {
              project_id: project.id
            }
          end.to change { Member.count }.by(-1)
        end
        it "shouldn't delete yourself from this project" do
          project = owner.project
          expect do
            delete project_member_path(owner), params: {
              project_id: project.id
            }
          end.not_to change { Member.count }
        end
      end
    end
  end
end