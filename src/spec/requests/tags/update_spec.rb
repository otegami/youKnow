require 'rails_helper'

RSpec.describe "Tags", type: :request do
  describe "Patch /tags/:id" do
    let(:member){ FactoryBot.create(:member_of_project_with_tags) }
    let(:the_other_member){ FactoryBot.create(:member) }
    let(:owner){ FactoryBot.create(:owner_of_project_with_tags) } 

    context "when user didn't log in" do
      it "should not edit any tags" do
        project = owner.project
        tag = project.tags.first
        expect{
          patch project_tag_path(tag), params: { 
            tag: {
              name: 'test tag',
            }
          }
        }.not_to change{ tag.reload.name }.from(tag.name)
      end
    end
    context "when user logged in" do
      context "as not a member of this project" do
        before do
          log_in_as(the_other_member.user)
        end
        it "should not edit any tags" do
          project = owner.project
          tag = project.tags.first
          expect{
            patch project_tag_path(tag), params: { 
              tag: {
                name: 'test tag',
              }
            }
          }.not_to change{ tag.reload.name }.from(tag.name)
        end
      end
      context "as a member of this project" do
        before do
          log_in_as(member.user)
        end
        it "should edit a tag" do
          project = member.project
          tag = project.tags.first
          changed_name = 'test tag'
          expect{
            patch project_tag_path(tag), params: { 
              tag: {
                name: changed_name,
              }
            }
          }.to change{ tag.reload.name }.from(tag.name).to(changed_name)
        end
      end
      context "as a owner of this project" do
        before do
          log_in_as(owner.user)
        end
        it "shouldn't edit a tag without tag's name" do
          project = owner.project
          tag = project.tags.first
          expect{
            patch project_tag_path(tag), params: { 
              tag: {
                name: '',
              }
            }
          }.not_to change{ tag.reload.name }.from(tag.name)
        end
        it "should edit a tag" do
          project = owner.project
          tag = project.tags.first
          changed_name = 'test tag'
          expect{
            patch project_tag_path(tag), params: { 
              tag: {
                name: changed_name,
              }
            }
          }.to change{ tag.reload.name }.from(tag.name).to(changed_name)
        end
      end
    end
  end
end