# frozen_string_literal: true

class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  counter_culture :question
  default_scope -> { order(created_at: :desc) }
  mount_uploader :repicture, RepictureUploader
  validates :user_id, presence: true
  validates :question_id, presence: true
  validates :reply, presence: true, length: { maximum: 500 }
  validate  :repicture_size
  has_many :likes, dependent: :destroy
  has_many :iine_users, through: :likes, source: :user
  has_many :comments, dependent: :destroy

  def iine(user)
    likes.create(user_id: user.id)
  end

  def uniine(user)
    likes.find_by(user_id: user.id).destroy
  end

  def iine?(user)
    iine_users.include?(user)
  end

  def self.sort_iine_ranks
    reorder('likes_count desc').order('created_at desc')
  end

  private

  def repicture_size
    if repicture.size > 5.megabytes
      errors.add(:repicture, 'should be less than 5MB')
    end
  end
end
