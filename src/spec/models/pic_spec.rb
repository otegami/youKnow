require 'rails_helper'

RSpec.describe Pic, type: :model do
  let(:pic){ FactoryBot.create(:pic) }
  
  describe "Validation" do
    it "should check the existence of pic" do
      expect(pic).to be_valid
    end
    it "should check user_id" do
      pic.task_id = nil
      expect(pic).to be_invalid
    end
    it "should check project_id" do
      pic.user_id = nil
      expect(pic).to be_invalid
    end
    it "should check owner" do
      pic.owner = nil
      expect(pic).to be_invalid
    end
  end
end
