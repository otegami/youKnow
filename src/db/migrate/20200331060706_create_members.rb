class CreateMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :members do |t|
      t.integer :role
      t.references :user, foreign_key: true
      t.references :project, foreign_key: true

      t.timestamps
    end
    add_index :members, [:user_id, :project_id]
  end
end
