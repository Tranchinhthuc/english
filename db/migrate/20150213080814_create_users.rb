class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :address
      t.datetime :date_of_birth
      t.string :password_digest
      t.string :remember_digest
      t.boolean :admin
      t.boolean :activated
      t.datetime :activated_at
      t.string :reset_digest
      t.datetime :reset_sent_at

      t.timestamps null: false
    end
  end
end
