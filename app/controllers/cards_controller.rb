class CardsController < ApplicationController
  before_action :require_user_logged_in
  before_action :set_card, only: [:edit, :update, :destroy]
  
  def index
    @cards = current_user.deck.cards.order(id: :desc).page(params[:page])
  end
  
  def new
    @card = current_deck.cards.build
    @deck = current_deck
  end
  
  def create
    @card = current_deck.cards.build(card_params)
    if @card.save
      flash[:success] = "カードを追加しました"
      redirect_to new_deck_card_url
    else
      flash[:danger] = "カードの追加に失敗しました"
      redirect_back(fallback_location: root_path)
    end
  end
  
  def edit
    @deck = current_deck
  end
  
  def update
    if @card.update(card_params)
      flash[:success] = "カードを更新しました"
      redirect_to current_deck
    else
      flash[:danger] = "カードの更新に失敗しました"
      render "edit"
    end
  end
  
  def destroy
    @card.destroy
    flash[:success] = "カードを削除しました"
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def current_deck
    @deck = Deck.find(params[:deck_id])
  end
  
  def card_params
    params.require(:card).permit(:question, :answer)
  end
  
  def set_card
    @card = Card.find(params[:id])
  end
end
