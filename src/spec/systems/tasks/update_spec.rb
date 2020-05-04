require "rails_helper"

RSpec.describe "Edit Task In The Project", type: :system do
  let(:member_as_pic){ FactoryBot.create(:member_with_full_tasks) }

  describe "The process of editting task in project" do
    context "when user logged in as a person in charge of the task" do
      before do
        log_in_as(member_as_pic.user)
        @project = member_as_pic.project
        @task = @project.tasks.first
      end
      it "shouldn't edit a task with invalid attributes" do
        visit project_task_path(@task)
        click_link "edit_#{@task.id}"

        # expect(page).to have_text task.status
        # expect(page).to have_link "back_#{task.id}"
        # expect(page).to have_link "update_#{task.id}"
        fill_in 'Name', with: ""
        fill_in 'Deadline', with: ""
        # expect(page).to have_field 'Pic', with task.pic
        # expect(page).to have_select('task_form[pic_attributes][user_id]', selected: pic_user(task).name)
        fill_in 'Content', with: ""
        # expect(page).to have_field 'File', with task.
        # expect(page).to have_field 'Tag', with task.
        @project.tags.each do |tag|
          check tag.name
        end
        # expect(page).to have_select('Priority', selected: priority_of(task.priority))
        # expect(page).to have_text task.files
        click_button "Update My Task"

        expect(page).to have_text 'The form contains 3 errors'
        expect(page).to have_text 'Name can\'t be blank'
        expect(page).to have_text 'Deadline can\'t be blank'
        expect(page).to have_text 'Content can\'t be blank'
      end
      it "should edit a task with valid attributes" do
        visit project_task_path(@task)
        click_link "edit_#{@task.id}"

        fill_in 'Name', with: "ChangedName"
        fill_in 'Deadline', with: "10/10/2020"
        fill_in 'Content', with: "ChangedContent"
        @project.tags.each do |tag|
          check tag.name
        end
        click_button "Update My Task"

        expect(page).to have_text 'ChangedName'
        expect(page).to have_text '2020-10-10'
        expect(page).to have_text 'ChangedContent'
        @project.tags.each do |tag|
          expect(page).to have_text tag.name
        end
      end
    end
  end
end