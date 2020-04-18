class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :name
      t.datetime :deadline
      t.text :content
      t.integer :sort
      t.integer :project_id, foreign_key: true

      t.timestamps
    end
  end
end
