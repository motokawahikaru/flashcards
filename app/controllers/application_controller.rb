class ApplicationController < ActionController::Base
  include SessionsHelper
  
  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
  
  def user_counts(user)
    @count_decks = user.decks.count
    @count_all_cards = user.cards.count
  end
  
  def deck_counts(deck)
    @count_cards = deck.cards.count
  end
  
  def current_deck
    @deck = Deck.find(params[:deck_id])
  end
end
