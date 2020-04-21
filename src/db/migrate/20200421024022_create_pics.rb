class CreatePics < ActiveRecord::Migration[5.2]
  def change
    create_table :pics do |t|
      t.boolean :owner, default: false
      t.integer :user_id, foreign_key: true
      t.integer :task_id, foreign_key: true

      t.timestamps
    end
    add_index :pics, [:user_id, :task_id], unique: true
  end
end
