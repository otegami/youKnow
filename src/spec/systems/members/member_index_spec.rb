require "rails_helper"

RSpec.describe "Member Index Page In Project", type: :system do
  describe "The process of accessing member index page in project" do
    let!(:owner){ FactoryBot.create(:project_owner) }
    let!(:member){ FactoryBot.create(:project_member) }
    let!(:the_other_user){ FactoryBot.create(:project_owner) }

    context "when user didn't log in" do
      context "as not member in this project" do
        it "should show login page" do
          project = the_other_user.projects.first
          visit project_members_path(project)

          expect(page).to have_text("Log in")
          expect(page).to have_text("Sign up now !!")
        end
      end
      context "as a owner in this project" do
        it "should show login page" do
          project = owner.projects.first
          visit project_members_path(project)

          expect(page).to have_text("Log in")
          expect(page).to have_text("Sign up now !!")
        end
      end
      context "as a member in this project" do
        it "should show login page" do
          project = member.projects.first
          visit project_members_path(project)

          expect(page).to have_text("Log in")
          expect(page).to have_text("Sign up now !!")
        end
      end
    end
    context "when user log in" do
      context "as not member in this project" do
        before do
          log_in_as(the_other_user)
        end
        it "should show project index page" do
          project = owner.projects.first
          visit project_members_path(project)

          expect(page).to have_text("All Projects")
        end
      end
      context "as a owner in this project" do
        before do
          log_in_as(owner)
        end
        it "should show member index page" do
          project = owner.projects.first
          visit project_members_path(project)

          expect(page).to have_link 'Add Member'
          expect(page).to have_link 'Remove selected members'
          project.members.each do |member|
            expect(page).to have_text("#{member.user.name}")
            if member.owner
              expect(page).not_to have_link("remove_#{member.id}")
            else
              expect(page).to have_link("remove_#{member.id}")
            end
          end
        end
      end
      context "as a member in this project" do
        before do
          log_in_as(member)
        end
        it "should show member index page" do
          project = member.projects.first
          visit project_members_path(project)

          expect(page).not_to have_link 'Add Member'
          expect(page).not_to have_link 'Remove selected members'
          project.members.each do |member|
            expect(page).to have_text("#{member.user.name}")
            expect(page).not_to have_link("remove_#{member.id}")
          end
        end
      end
    end
  end
end