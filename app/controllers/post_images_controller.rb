class PostImagesController < ApplicationController

  def new
    @post_image = PostImage.new
  end
  
  def create
    @post_image = PostImage.new(post_image_params)
    @post_image.customer_id = current_customer.id
    @post_image.save
    redirect_to post_images_path
  end
  
  def index
    @post_images = PostImage.all
  end

  def show
    @post_image = PostImage.find(params[:id])
    @post_comment = PostComment.new
    @customer = @post_image.customer
  end
  
  def destroy
    post_image = PostImage.find(params[:id])
    post_image.destroy
    redirect_to '/post_images'
  end
  
  def set_featured
    $featured_images << params[:id].to_i unless $featured_images.include?(params[:id].to_i)
    redirect_to post_image_path(params[:id]), notice: '注目フラグが設定されました。'
  end

  def unset_featured
    $featured_images.delete(params[:id].to_i)
    redirect_to post_image_path(params[:id]), notice: '注目フラグが解除されました。'
  end


  private
  
  def post_image_params
    params.require(:post_image).permit(:title, :image, :caption)
  end

  def initialize_featured_images
    $featured_images ||= []
  end
end
