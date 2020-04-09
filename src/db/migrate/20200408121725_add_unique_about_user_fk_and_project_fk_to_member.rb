class AddUniqueAboutUserFkAndProjectFkToMember < ActiveRecord::Migration[5.2]
  def change
    add_index :members, [:project_id, :user_id], unique: true
  end
end
