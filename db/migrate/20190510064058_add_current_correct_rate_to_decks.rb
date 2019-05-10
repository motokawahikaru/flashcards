class AddCurrentCorrectRateToDecks < ActiveRecord::Migration[5.2]
  def change
    add_column :decks, :current_correct_rate, :int
  end
end
