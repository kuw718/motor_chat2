class Post < ApplicationRecord
  has_one_attached :image
  
  belongs_to :customer
  belongs_to :group

  validates :customer_id, presence: true
  validates :comment, presence: true
end