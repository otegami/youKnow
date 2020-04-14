require "rails_helper"

RSpec.describe "Tag Index Page In The Project", type: :system do
  describe "The process of accessing member index page in project" do
    context "when user didn't logged in" do
      it "shouldn't show tag index page" do
      end
    end
    context "when user logged in" do
      context "as not a member of this project" do
        it "shouldn't show tag index page" do
        end
      end
      # Member doesn't have the right to edit or destroy tags
      context "as a member of this project" do
        it "should show tag index page" do
        end
      end
      # Member has the right to edit or destroy tags
      context "as a owner of this project" do
        it "should show tag index page" do
        end
      end
    end
  end
end