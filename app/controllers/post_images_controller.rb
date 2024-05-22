class PostImagesController < ApplicationController
  before_action :authenticate_customer!, except: [:index]

  def edit
    @post_image = PostImage.find(params[:id])
  end

  def new
    @post_image = PostImage.new
  end
  
  def create
    @post_image = PostImage.new(post_image_params)
    @post_image.customer_id = current_customer.id
    if @post_image.save
      redirect_to post_images_path
    else
      render :new
    end
  end
  
  def index
    @post_images = PostImage.all
    @post_images = PostImage.includes(:customer, :post_comments).page(params[:page]).per(10)
  end

  def show
    @post_image = PostImage.find(params[:id])
    @post_comment = PostComment.new
    @customer = @post_image.customer
  end
  
  def destroy
    post_image = PostImage.find(params[:id])
    post_image.destroy
    redirect_to post_images_path
  end
  
  def set_featured
    initialize_featured_images
    $featured_images << params[:id].to_i unless $featured_images.include?(params[:id].to_i)
    redirect_to post_image_path(params[:id]), notice: '注目フラグが設定されました。'
  end

  def unset_featured
    initialize_featured_images
    $featured_images.delete(params[:id].to_i)
    redirect_to post_image_path(params[:id]), notice: '注目フラグが解除されました。'
  end

  def update
    @post_image = PostImage.find(params[:id])
    if @post_image.update(post_image_params)
      redirect_to @post_image, notice: 'Post image was successfully updated.'
    else
      render :edit
    end
  end

  private
  
  def post_image_params
    params.require(:post_image).permit(:title, :image, :caption)
  end

  def initialize_featured_images
    $featured_images ||= []
  end
end
