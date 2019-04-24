class DecksController < ApplicationController
  before_action :require_user_logged_in
  before_action :set_deck, only: [:edit, :show, :update, :destroy]
  
  def index
    @decks = current_user.decks.order(id: :desc).page(params[:page])
  end
  
  def create
    @deck = current_user.decks.build(deck_params)
    if @deck.save
      flash[:success] = "デッキを作成しました"
      redirect_to decks_url
    else
      flash[:danger] = "デッキの作成に失敗しました"
      render "new"
    end
  end
  
  def new
    @deck = current_user.decks.build
  end
  
  def edit
  end
  
  def show
  end
  
  def update
    if @deck.update(deck_params)
      flash[:success] = "デッキを更新しました"
      redirect_to decks_url
    else
      flash[:danger] = "デッキの更新に失敗しました"
      render "edit"
    end
  end
  
  def destroy
    @deck.destroy
    flash[:success] = "デッキを削除しました"
    redirect_to decks_url
  end
  
  private
  
  def deck_params
    params.require(:deck).permit(:name)
  end
  
  def set_deck
    @deck = Deck.find(params[:id])
  end
end
