require 'base64'

class Post < ApplicationRecord
  has_one_attached :image

  after_commit :resize_image, if: -> { image.attached? }

  belongs_to :customer
  belongs_to :group

  validates :customer_id, presence: true
  validates :comment, presence: true
  before_save :replace_inappropriate_words

  # エンコードされた不適切な単語のハッシュ
  INAPPROPRIATE_WORDS = {
    Base64.encode64("自殺").strip => "****",
    Base64.encode64("死").strip => "**",
    Base64.encode64("殺す").strip => "***",
    Base64.encode64("殺せ").strip => "***",
    Base64.encode64("死ね").strip => "***",
    Base64.encode64("死んで").strip => "****",
    Base64.encode64("消えろ").strip => "***",

  }

  private

  def replace_inappropriate_words
    if comment.present?
      INAPPROPRIATE_WORDS.each do |encoded_word, replacement|
        decoded_word = Base64.decode64(encoded_word).force_encoding('UTF-8')
        comment.gsub!(decoded_word, replacement)
      end
    end
  end
  
  def resize_image
    image.variant(resize_to_limit: [800, 800]).processed
  end
end