class Favorite < ApplicationRecord
  
  belongs_to :customer
  belongs_to :post_image
  
  validates :customer_id, uniqueness: {scope: :post_image_id}
  
end
