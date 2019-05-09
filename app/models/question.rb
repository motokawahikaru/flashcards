class Question < ApplicationRecord
  belongs_to :user
  has_many :questions_lists, dependent: :destroy
end
