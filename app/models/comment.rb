class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :answer
  validates :content, presence: true, length: { maximum: 40 }
end
