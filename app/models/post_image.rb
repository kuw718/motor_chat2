class PostImage < ApplicationRecord
  
  has_one_attached :image
  belongs_to :customer
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end
  
  def favorited_by?(customer)
    favorites.exists?(customer_id: customer.id)
  end
  
def resized_image
  return unless image.attached? # 画像がアタッチされているか確認
  image.variant(resize_to_limit: [800, 800]).processed if image.attached? # アタッチされている場合のみ処理を行う
end

end
