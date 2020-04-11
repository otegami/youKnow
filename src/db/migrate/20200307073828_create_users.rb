class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email, unique: true
      t.boolean :admin, default: false
      t.string :reset_digest
      t.string :activation_digest
      t.string :remember_digest
      t.string :password_digest
      t.boolean :activated, default: false
      t.datetime :reset_sent_at
      t.datetime :activated_at

      t.timestamps
    end
  end
end
