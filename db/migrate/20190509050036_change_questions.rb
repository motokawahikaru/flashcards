class ChangeQuestions < ActiveRecord::Migration[5.2]
  def change
    change_table :questions do |t|
      t.remove :card_id, :result
    end
  end
end
