class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.boolean :status, default: true

      t.timestamps
    end
    add_index :projects, :created_at
  end
end
