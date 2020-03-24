require 'rails_helper'

RSpec.describe Project, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  let!(:project){ FactoryBot.create(:project) }
  let!(:before10mins){ FactoryBot.create(:project, :before10mins) }
  let!(:before3years){ FactoryBot.create(:project, :before3years) }
  let!(:before2hours){ FactoryBot.create(:project, :before2hours) }
  

  describe "Validations" do
    it "should be valid" do
      expect(project).to be_valid
    end  

    it "should check about user id" do
      project.user_id = nil
      expect(project).to be_invalid
    end  

    describe "About name" do
      it "should check about name" do
        project.name = ""
        expect(project).to be_invalid
      end

      it "should check the length of name under 30" do
        project.name = "a" * 31
        expect(project).to be_invalid
      end
    end

    describe "About description" do
      it "should check about description" do
        project.description = ""
        expect(project).to be_invalid
      end

      it "should check the length of name under 150" do
        project.name = "a" * 151
        expect(project).to be_invalid
      end
    end  
  end

  describe "About order" do
    it "should be most recent first" do
      most_recent = FactoryBot.create(:project, :tomorrow)
      expect(most_recent).to eq(Project.first)
    end  
  end
end