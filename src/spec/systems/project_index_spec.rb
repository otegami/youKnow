require "rails_helper"

RSpec.describe "Project Index Page", type: :system do
  # user who loggedn in  visit project index page
  # In project index page
  # user doesn't have any projects
  # you can see message about creating new project
  # you can see project create button
  # ==========
  # user who has at least one project
  # (have to check whether owner or member)
  # you can see project create button
  # you can see all of user project by 20 projects
  # you can see project name & description about each project
  # you can go to edit project page
  # you can close your project

  let!(:user_without_projects){ FactoryBot.create(:user) }
  let!(:owner){ FactoryBot.create(:project_owner) }
  let!(:member){ FactoryBot.create(:project_member) }

  describe "the layout in user project page" do
    context "without user logging in " do
      it "should return login page" do
        visit root_path
        expect(page).to have_text("Log in")
        expect(page).to have_text("Welcome to youKnow")
        expect(page).to have_text("Sign up now!")
      end
    end
    context "with user logging in and not having any projects " do
      it "should show project index page" do
        visit login_path
        fill_in "Email", with: user_without_projects.email
        fill_in "Password", with: user_without_projects.password
        click_button "Log in"
        visit root_path

        expect(page).to have_link('New Project')
        expect(page).to have_text('Please create new project or join in other projects!!')
      end
    end
    context "with user logging in and having projects " do
      context "as a project owner" do
        it "should show project index page" do
          visit login_path
          fill_in "Email", with: owner.email
          fill_in "Password", with: owner.password
          click_button "Log in"
          visit root_path
          
          expect(page).to have_link('New Project')
          owner.projects.where(status: true).page(1).each do |project|
            expect(page).to have_content(project.name)
            expect(page).to have_content(project.description)
            expect(page).to have_link("show_#{project.id}")
            expect(page).to have_link("edit_#{project.id}")
            expect(page).to have_link("close_#{project.id}")
          end
        end
      end
      context "as a member project" do
        it "should show project index page" do
          visit login_path
          fill_in "Email", with: member.email
          fill_in "Password", with: member.password
          click_button "Log in"
          visit root_path
          
          expect(page).to have_link('New Project')
          member.projects.where(status: true).page(1).each do |project|
            expect(page).to have_content(project.name)
            expect(page).to have_content(project.description)
            expect(page).to have_link("show_#{project.id}")
            expect(page).to have_link("edit_#{project.id}")
            expect(page).to have_link("close_#{project.id}")
          end
        end
      end
    end
  end
end
