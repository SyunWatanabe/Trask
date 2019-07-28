class Like < ApplicationRecord
  belongs_to :user
  belongs_to :answer
  counter_culture :answer
  validates :user_id, presence: true
  validates :answer_id, presence: true
end
