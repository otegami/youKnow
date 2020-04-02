class RemoveUserFkFromProjects < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :projects, :users
    remove_reference :projects, :user, index: true
  end
end
