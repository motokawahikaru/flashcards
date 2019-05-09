class QuestionsList < ApplicationRecord
  belongs_to :question
  belongs_to :card
end
