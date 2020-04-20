require 'rails_helper'

RSpec.describe "Adding A Task to Project", type: :system do

  describe "The process of adding task to project" do
    let(:member){ FactoryBot.create(:member) }

    context "when user logged in as project's member" do
      before do
        log_in_as(member.user)
      end
      it "show new creating task page" do
        project = member.project
        visit project_path(project)
        click_link 'Add Task'

        expect(page).to have_text 'Create Task'
        expect(page).to have_text 'Name'
        expect(page).to have_text 'Deadline'
        expect(page).to have_text 'Pic'
        expect(page).to have_text 'Content'
        expect(page).to have_text 'File'
        expect(page).to have_text 'Tag'
        expect(page).to have_text 'Priority'
        expect(page).to have_button('Create My Task')
      end
    end
  end
end