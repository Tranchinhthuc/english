class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :address
      t.datetime :date_of_birth
      t.datetime :date_of_join
      t.string :password_digest
      t.string :remember_digest
      t.boolean :is_supervisor
      t.boolean :activated
      t.string :activation_digest
      t.datetime :activated_at
      t.string :reset_digest
      t.datetime :reset_sent_at
      t.string :avatar

      t.timestamps null: false
    end
  end
end
