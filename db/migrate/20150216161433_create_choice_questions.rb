class CreateChoiceQuestions < ActiveRecord::Migration
  def change
    create_table :choice_questions do |t|
      t.integer :number
      t.string :content
      t.integer :test_id

      t.timestamps null: false
    end
  end
end
