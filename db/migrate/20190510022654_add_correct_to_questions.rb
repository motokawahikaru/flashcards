class AddCorrectToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :correct, :int, default: 0
  end
end
