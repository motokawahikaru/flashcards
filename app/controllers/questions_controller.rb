class QuestionsController < ApplicationController
  before_action :set_deck, only: [:show, :answer, :create]
  before_action :set_question, only: [:show, :answer]
  
  def create
    Question.where(user_id: current_user.id).destroy_all
    
    if Question.last != nil
      question_first_id = Question.last.id + 1
    end
    
    shuffled_cards = @deck.cards.pluck(:id).shuffle!
    cards = Card.where(id: shuffled_cards).order_as_specified(id: shuffled_cards)
    if cards == []
      redirect_back(fallback_location: root_path)
      flash[:danger] = "デッキにカードが登録されていません"
    else
      cards.each do |card|
        question = Question.new(card: card, user: current_user)
        question.save
      end
      redirect_to action: "show", id: question_first_id
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
    if @question.card.user != current_user
      redirect_to root_url
    end
  end
end
