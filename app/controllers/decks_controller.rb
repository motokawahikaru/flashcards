class DecksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_deck_user, only: [:edit, :show, :update, :destroy]
  
  def index
    user_counts(current_user)
    if logged_in?
      @decks = current_user.decks.order(id: :desc).page(params[:page])
    else
      redirect_to login_url
    end
  end
  
  def create
    @deck = current_user.decks.build(deck_params)
    if @deck.save
      flash[:success] = "デッキを作成しました"
      redirect_to decks_url
    else
      flash.now[:danger] = "デッキの作成に失敗しました"
      render 'new'
    end
  end
  
  def new
    @deck = current_user.decks.build
  end
  
  def edit
  end
  
  def show
    @cards = @deck.cards.order(id: :desc).page(params[:page])
    deck_counts(@deck)
  end
  
  def update
    if @deck.update(deck_params)
      flash[:success] = "デッキを更新しました"
      redirect_to decks_url
    else
      flash.now[:danger] = "デッキの更新に失敗しました"
      render "edit"
    end
  end
  
  def destroy
    @deck.destroy
    flash[:success] = "デッキを削除しました"
    redirect_to decks_url
  end
  
  def question
    @cards = @deck.cards.shuffle
  end
  
  private
  
  def deck_params
    params.require(:deck).permit(:name)
  end

  def correct_deck_user
    @deck = Deck.find(params[:id])
    if @deck.user != current_user
      redirect_to root_url
    end
  end

end
