require 'rails_helper'

RSpec.describe "Tags", type: :request do
  describe "Post /projects/:project_id/tags" do
    let(:member){ FactoryBot.create(:member) }
    let(:the_other_member){ FactoryBot.create(:member) }
    let(:owner){ FactoryBot.create(:owner) }

    context "when user didn't log in" do
      it "should not add any tags" do
        project = owner.project
        expect{
          post project_tags_path(project), params: { 
            tag: {
              name: 'test tag',
            }
          }
        }.not_to change{ Tag.count }
      end
    end
    context "when user logged in" do
      context "as not a member of this project" do
        before do
          log_in_as(the_other_member.user)
        end
        it "should not add any tags" do
          project = owner.project
          expect{
            post project_tags_path(project), params: { 
              tag: {
                name: 'test tag',
              }
            }
          }.not_to change{ Tag.count }
        end
      end
      context "as a member of this project" do
        before do
          log_in_as(member.user)
        end
        it "should add a tag" do
          project = member.project
          expect{
            post project_tags_path(project), params: { 
              tag: {
                name: 'test tag',
              }
            }
          }.to change{ Tag.count }.by(1)
        end
      end
      context "as a owner of this project" do
        before do
          log_in_as(owner.user)
        end
        it "should add a tag" do
          project = owner.project
          expect{
            post project_tags_path(project), params: { 
              tag: {
                name: 'test tag',
              }
            }
          }.to change{ Tag.count }.by(1)
        end
      end
    end
  end
end