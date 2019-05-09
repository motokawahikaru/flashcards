class QuestionsController < ApplicationController
  before_action :set_deck, only: [:create]
  before_action :set_question, only: [:show, :answer]
  before_action :correct_question_user, only: [:show, :answer]
  
  def create
    shuffled_cards = @deck.cards.pluck(:id).shuffle!
    cards = Card.where(id: shuffled_cards).order_as_specified(id: shuffled_cards)
    if cards == []
      redirect_back(fallback_location: root_path)
      flash[:danger] = "デッキにカードが登録されていません"
    else
      question = current_user.questions.build
      question.save
      i = 1
      cards.each do |card|
        @question_list = question.questions_lists.build(card: card, question_number: i)
        @question_list.save
        i += 1
      end
      
      redirect_to action: "show", question_id: question.id, id: 1
    end
  end

  def show
    if @question_list == nil
      redirect_to action: "destroy", id: params[:question_id]
    else
      @card = Card.find(@question_list[:card_id])
    end
  end
  
  def answer
    @card = Card.find(@question_list[:card_id])
  end

  def destroy
    Question.destroy(params[:id])
    flash[:success] = "出題が終了しました"
    redirect_to decks_url
  end
  
  private
  
  def set_deck
    @deck = Deck.find(params[:deck_id])
  end
  
  def set_question
    @question = Question.find(params[:question_id])
    question_counts(@question)
    @question_list = @question.questions_lists.find_by(question_number: params[:id])
    @q_num = @question_list.question_number
    if @question_list.question.user != current_user
      redirect_to root_url
    end
  end
end
