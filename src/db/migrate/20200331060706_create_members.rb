class CreateMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :members do |t|
      t.integer :role, default: 1
      t.boolean :owner, default: false
      t.integer :user_id, foreign_key: true
      t.integer :project_id, foreign_key: true

      t.timestamps
    end
    add_index :members, [:user_id, :project_id], unique: true
  end
end
