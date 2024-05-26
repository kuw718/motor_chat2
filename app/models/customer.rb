class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :post_images, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :liked_posts, through: :favorites, source: :post_image, dependent: :destroy
  has_many :followers, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followeds, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following_customers, through: :followers, source: :followed, dependent: :destroy
  has_many :follower_customers, through: :followeds, source: :follower, dependent: :destroy
  has_many :group_customers, dependent: :destroy
  has_many :groups, through: :group_customers, dependent: :destroy
  has_one_attached :profile_image

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/sample1.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

  def follow(customer_id)
    followers.create(followed_id: customer_id)
  end

  def unfollow(customer_id)
    followers.find_by(followed_id: customer_id).destroy
  end

  def following?(customer)
    following_customers.include?(customer)
  end
  
  def customername
    name
  end
end
