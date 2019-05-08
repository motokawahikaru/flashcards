class Card < ApplicationRecord
  validates :question, presence: true, length: { maximum: 50 }
  validates :answer, presence: true, length: { maximum: 50 }
  
  
  belongs_to :user
  belongs_to :deck
end
