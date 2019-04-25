class ApplicationController < ActionController::Base
  include SessionsHelper
  
  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
  
  def counts(user)
    @count_decks = user.decks.count
    #@count_all_cards = current_user.deck.cards.count
  end
  
  #def counts(deck)
    #@count_cards = deck.cards.count
  #end
end
