class QuestionsController < ApplicationController
  before_action :set_deck, only: [:show, :answer, :create]
  before_action :set_question, only: [:show, :answer]
  
  def create
    cards = Card.where(id: @deck.cards.pluck(:id).shuffle!)
    if cards == []
      redirect_back(fallback_location: root_path)
      flash[:danger] = "デッキにカードが登録されていません"
    else
      cards.each do |card|
        question = Question.new(card: card)
        question.save
      end
      redirect_to action: "show", id: Question.first.id
    end
  end

  def show
    if @question == nil
      redirect_to action: "destroy"
    else
      @card = Card.find(@question[:card_id])
    end
  end
  
  def answer
    @card = Card.find(@question[:card_id])
  end

  def destroy
    Question.destroy_all
    flash[:success] = "出題が終了しました"
    redirect_to decks_url
  end
  
  private
  
  def set_deck
    @deck = Deck.find(params[:deck_id])
    deck_counts(@deck)
  end
  
  def set_question
    @question = Question.find(params[:id])
    @q_num = @question.id - Question.first.id + 1
  end
end