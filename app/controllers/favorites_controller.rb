class FavoritesController < ApplicationController
  
  def create
    post_image = PostImage.find(params[:post_image_id])
    @post_image = post_image # @post_imageを設定する
    favorite = current_customer.favorites.new(post_image_id: post_image.id)
    favorite.save
  end

  def destroy
    post_image = PostImage.find(params[:post_image_id])
    @post_image = post_image # @post_imageを設定する
    favorite = current_customer.favorites.find_by(post_image_id: post_image.id)
    favorite.destroy
  end
end

