class CreateTaggings < ActiveRecord::Migration[5.2]
  def change
    create_table :taggings do |t|
      t.integer :tag_id, foreign_key: true
      t.integer :task_id, foreign_key: true

      t.timestamps
    end
    add_index :taggings, [:tag_id, :task_id], unique: true
  end
end
