class QuestionsController < ApplicationController
  before_action :require_user_logged_in
  before_action :set_question, only: [:show, :answer, :correct_count]
  before_action :set_card, only: [:show, :answer]
  before_action :correct_question_user, only: [:show, :answer]
  
  def create
    @deck = Deck.find(params[:deck_id])
    shuffled_cards = @deck.cards.pluck(:id).shuffle!
    cards = Card.where(id: shuffled_cards).order_as_specified(id: shuffled_cards)
    if cards == []
      redirect_back(fallback_location: root_path)
      flash[:danger] = "デッキにカードが登録されていません"
    else
      question = current_user.questions.build(deck_id: @deck.id)
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
  end
  
  def answer
  end

  def destroy
    @question = Question.find(params[:id])
    question_counts(@question)
    correct_rate = (@question.correct.to_f/@count_questions * 100).floor
    Deck.find(@question.deck_id).update(current_correct_rate: correct_rate)
    
    @question.destroy
    flash[:success] = "出題が終了しました 正解率: #{correct_rate}%"
    redirect_to decks_url
  end
  
  def correct_count
    if params[:correct]
      @question.increment!(:correct)
    end
    
    next_id = params[:id].to_i + 1
    if @question.questions_lists.find_by(question_number: next_id) == nil
      redirect_to @question
    else
      redirect_to action: "show", id: next_id
    end
  end
  
  private

  def set_question
    @question = Question.find(params[:question_id])
    question_counts(@question)
  end  
  
  def set_card
    @question_list = @question.questions_lists.find_by(question_number: params[:id])
    @q_num = @question_list.question_number
    @card = Card.find(@question_list[:card_id])
  end
  
  def correct_question_user
    if @question_list.question.user != current_user
      redirect_to root_url
    end
  end
end