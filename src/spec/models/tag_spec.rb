require 'rails_helper'

RSpec.describe Tag, type: :model do
  let!(:tag){ FactoryBot.create(:tag) }
  let!(:project){ FactoryBot.create(:project) }

  describe "Validations" do
    it "should be valid" do
      expect(tag).to be_valid
    end

    describe "About name" do
      it "should approve length is under 20" do
        tag.name = "a" * 20
        expect(tag).to be_valid
      end
      it "should deny length is more than 20" do
        tag.name = "a" * 21
        expect(tag).to be_invalid
      end
      it "should deny name is nil" do
        tag.name = nil
        expect(tag).to be_invalid
      end
    end

    describe "Abour project_id" do
      it "should approve project_id exists" do
        tag.project_id = project.id
        expect(tag).to be_valid
      end
      it "should deny project_id is nil" do
        tag.project_id = nil
        expect(tag).to be_invalid
      end
    end
  end
end
