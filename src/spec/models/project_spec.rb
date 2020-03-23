require 'rails_helper'

RSpec.describe Project, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  let!(:project){ FactoryBot.create(:project) }
  describe "Validations" do
    it "should be valid" do
      expect(project).to be_valid
    end  

    it "should check about user id" do
      project.user_id = nil
      expect(project).to be_invalid
    end
    
    it "should check about name" do
      project.name = ""
      expect(project).to be_invalid
    end

    it "should check about description" do
      project.description = ""
      expect(project).to be_invalid
    end  
  end
end
