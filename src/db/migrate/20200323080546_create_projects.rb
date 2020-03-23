class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.boolean :status, default: true
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :projects, [:user_id, :created_at]
  end
end
