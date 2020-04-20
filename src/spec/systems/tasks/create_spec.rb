require 'rails_helper'

RSpec.describe "Create Tasks In The Project", type: :system do
  describe "The process of creating new tasks in project" do
    let(:member){ FactoryBot.create(:member) }

    context "when user logged in as project's member" do
      before do
        log_in_as(member.user)
      end
      it "should crate a task" do
        project = member.project
        visit project_path(project)
        click_link 'Add Task'

        fill_in "Name", with: ""
        fill_in "Deadline", with: ""
        fill_in "Content", with: ""
        select 'Medium', :from => 'Priority'
        
        click_button 'Create My Task'
        
        expect(page).to have_text 'The form contains 3 errors'
        expect(page).to have_text 'Name can\'t be blank'
        expect(page).to have_text 'Deadline can\'t be blank'
        expect(page).to have_text 'Content can\'t be blank'
      end

      it "should crate a task" do
        project = member.project
        visit project_path(project)
        click_link 'Add Task'

        fill_in "Name", with: "New task"
        fill_in "Deadline", with: "04-20-2020"
        fill_in "Content", with: "Detail about new task"
        select 'High', :from => 'Priority'
        
        click_button 'Create My Task'
        
        expect(page).to have_text "New task"
        expect(page).to have_text "2020-04-20"
      end
    end
  end
end