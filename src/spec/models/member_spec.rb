require 'rails_helper'

RSpec.describe Member, type: :model do
  let!(:member){ FactoryBot.create(:member) }
  let!(:owner){ FactoryBot.create(:owner) }

  describe "Validation" do
    it "should check the existence of member" do
      expect(member).to be_valid
    end
    it "should check user_id" do
      member.project_id = nil
      expect(member).to be_invalid
    end
    it "should check project_id" do
      member.user_id = nil
      expect(member).to be_invalid
    end
    # How to check this validation about boolean
    # it "should check owner" do
    #   member.owner = nil
    #   expect(member).to be_invalid
    # end
    context "about Owner" do
      it "should check the default value about owner is true" do
        expect(owner.owner).to be true
      end
    end
    context "about Member" do
      it "should check the default value about owner is false" do
        expect(member.owner).to be false
      end
    end
  end
end
