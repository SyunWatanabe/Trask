class Question < ApplicationRecord
  validates :title, presence: true, length: { maximum: 25 }
  validates :content, presence: true, length: { maximum: 500 }
  validates :user_id, presence: true
  validate  :picture_size
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  has_many :answers, dependent: :destroy
  acts_as_taggable

  private

    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end
