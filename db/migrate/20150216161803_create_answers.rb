class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer :choice_question_id
      t.string :akey
      t.string :bkey
      t.string :ckey
      t.string :dkey
      t.integer :correctkey

      t.timestamps null: false
    end
  end
end
