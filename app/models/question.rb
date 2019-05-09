class Question < ApplicationRecord
  belongs_to :card
  belongs_to :user
end
