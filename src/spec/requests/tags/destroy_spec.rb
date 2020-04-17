require 'rails_helper'

RSpec.describe "Tags", type: :request do
  describe "Delete /tags/:id" do
    let(:member){ FactoryBot.create(:member_of_project_with_tags) }
    let(:the_other_member){ FactoryBot.create(:member) }
    let(:owner){ FactoryBot.create(:owner_of_project_with_tags) }

    context "when user didn't in" do
      it "shouldn't delete any tags" do
        project = owner.project
        tag = project.tags.first

        delete project_tag_path(tag), params: {
          project_id: project.id
        }

        expect(response).not_to have_http_status(:success)
      end
    end
    context "when user logged in" do
      context "as not a member of this project" do
        before do
          log_in_as(the_other_member.user)
        end
        it "shouldn't delete any tags" do
          project = owner.project
          tag = project.tags.first

          expect do
            delete project_tag_path(tag), params: {
              project_id: project.id
            }
          end.not_to change{ Tag.count }
        end
      end
      context "as a member of this project" do
        before do
          log_in_as(member.user)
        end
        it "shouldn't delete any tags" do
          project = member.project
          tag = project.tags.first

          expect do
            delete project_tag_path(tag), params: {
              project_id: project.id
            }
          end.not_to change{ Tag.count }
        end
      end
      context "as a owner of this project" do
        before do
          log_in_as(owner.user)
        end
        it "should delete a tag" do
          project = owner.project
          tag = project.tags.first

          expect do
            delete project_tag_path(tag), params: {
              project_id: project.id
            }
          end.to change{ Tag.count }.by(-1)
        end
      end
    end
  end
end