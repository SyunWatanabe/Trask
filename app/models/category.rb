class Category < ApplicationRecord
  validates :name, presence: true
  has_many :sub_categories, ->{ order(:id) }
end
