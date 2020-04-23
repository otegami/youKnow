require "rails_helper"

RSpec.describe "tasks' index page", type: :system do
  let(:owner){ FactoryBot.create(:owner) }
  let(:owner_with_tasks){ FactoryBot.create(:member_with_full_tasks) }
  PRIORITIES = ['Low', 'Medium', 'High']

  describe "the layout of tasks' index page" do
    context "when user doesn't have any tasks" do
      before do
        log_in_as(owner.user)
      end
      it "should show tasks' index page" do
        project = owner.project
        visit project_path(project)

        expect(page).to have_link 'Add Task'
        expect(page).to have_text "Let's create your first task"
      end
    end
    context "when user has at least one task" do
      before do
        log_in_as(owner_with_tasks.user)
      end
      it "should show tasks' index page" do
        project = owner_with_tasks.project
        tasks = project.tasks
        visit project_path(project)

        expect(page).to have_link 'Add Task'
        tasks.each do |task|
          tags = task.tags
          expect(page).to have_link task.name
          expect(page).to have_text task.deadline
          expect(page).to have_text PRIORITIES[task.priority]
          expect(page).to have_link "show_#{task.id}"
          expect(page).to have_link "remove_#{task.id}"
          tags.each do |tag|
            expect(page).to have_text tag.name
          end
        end
      end
    end
  end
end