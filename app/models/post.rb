class Post < ApplicationRecord
  belongs_to :user
  has_many_attached :images
  has_many :likes
  has_many :likers, through: :likes, source: :user

  validates :images, presence: true, blob: { content_type: :image }
end
