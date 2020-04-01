# require 'rails_helper'

# RSpec.describe Member, type: :model do
#   let!(:project) { FactoryBot.create(:project_with_members) }

#   describe "Validation" do
#     it "should check the existence of member" do
#       member = project.members.first
#       expect(member).to be_valid
#     end
#     it "should check user_id" do
#       member = project.members.first
#       member.user_id = nil
#       expect(member).to be_invalid
#     end
#     it "should check project_id" do
#       member = project.members.first
#       member.project_id = nil
#       expect(member).to be_invalid
#     end
#   end
# end
