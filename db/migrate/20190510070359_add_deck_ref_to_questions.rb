class AddDeckRefToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_reference :questions, :deck, foreign_key: true
  end
end
