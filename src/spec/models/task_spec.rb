require 'rails_helper'

RSpec.describe Task, type: :model do
  let!(:task){ FactoryBot.create(:task) }
  
  describe "Validation" do
    it "should check the existence of task" do
      expect(task).to be_valid
    end
    it "should check project_id" do
      task.project_id = nil
      expect(task).to be_invalid
    end
    context "About name" do
      it "should approve length is under 30" do
        task.name = "a" * 30
        expect(task).to be_valid
      end
      it "should deny length is more than 30" do
        task.name = "a" * 31
        expect(task).to be_invalid
      end
      it "should check name" do
        task.name = nil
        expect(task).to be_invalid
      end
    end
    it "should check deadline" do
      task.deadline = nil
      expect(task).to be_invalid
    end
    context "About content" do
      it "should approve length is under 500 " do
        task.content = "a" * 500
        expect(task).to be_valid
      end
      it "should deny length is more than 500" do
        task.content = "a" * 501
        expect(task).to be_invalid
      end
      it "should check content" do
        task.content = nil
        expect(task).to be_invalid
      end
    end
  end
end
