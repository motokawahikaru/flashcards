class CreateQuestionsLists < ActiveRecord::Migration[5.2]
  def change
    create_table :questions_lists do |t|
      t.references :question, foreign_key: true
      t.references :card, foreign_key: true
      t.integer :question_number

      t.timestamps
    end
  end
end
