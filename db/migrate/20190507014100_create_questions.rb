class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.references :card, foreign_key: true
      t.boolean :result, default: false, null: true

      t.timestamps
    end
  end
end
