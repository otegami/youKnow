require 'rails_helper'

RSpec.describe Tagging, type: :model do
  let(:tagging){ FactoryBot.create(:tagging) }
  
  describe "Validation" do
    it "should check the existence of tagging" do
      expect(tagging).to be_valid
    end
    it "should check user_id" do
      tagging.task_id = nil
      expect(tagging).to be_invalid
    end
    it "should check project_id" do
      tagging.tag_id = nil
      expect(tagging).to be_invalid
    end
  end
end
