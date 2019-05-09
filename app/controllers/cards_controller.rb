class CardsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_card_user, only: [:edit, :update, :destroy]
  
  def index
    @cards = current_user.cards.order(id: :desc).page(params[:page])
    user_counts(current_user)
  end
  
  def new
    @decks = current_user.decks
    if @decks == []
      flash[:danger] = "カードを追加するにはデッキを1つ以上追加してください"
      redirect_to root_url
    end
    @card = current_user.cards.build
  end
  
  def create
    @card = current_user.cards.build(card_params)
    if @card.save
      flash[:success] = "カードを追加しました"
      redirect_to new_card_url
    else
      flash[:danger] = "カードの追加に失敗しました"
      render "new"
    end
  end
  
  def edit
    @decks = current_user.decks
    correct_card_user(@card)
  end
  
  def update
    if @card.update(card_params)
      flash[:success] = "カードを更新しました"
      redirect_to cards_url
    else
      flash[:danger] = "カードの更新に失敗しました"
      render "edit"
    end
  end
  
  def destroy
    correct_card_user(@card)
    @card.destroy
    flash[:success] = "カードを削除しました"
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def card_params
    params.require(:card).permit(:question, :answer, :deck_id)
  end
end
