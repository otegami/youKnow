class AddOwnerToProjects < ActiveRecord::Migration[5.2]
  def change
    add_column :members, :owner, :boolean, default: false
    change_column_default :members, :role, default: 1
  end
end
