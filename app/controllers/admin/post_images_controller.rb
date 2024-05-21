class Admin::PostImagesController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_post_image, only: [:show, :edit, :update, :destroy]

  def index
    @post_images = PostImage.all
  end

  def show
  end

  def edit
  end

  def update
    if @post_image.update(post_image_params)
      redirect_to admin_post_image_path(@post_image), notice: '投稿が更新されました。'
    else
      render :edit
    end
  end

  def destroy
    @post_image.destroy
    redirect_to admin_post_images_path, notice: '投稿が削除されました。'
  end

  private

  def set_post_image
    @post_image = PostImage.find(params[:id])
  end

  def post_image_params
    params.require(:post_image).permit(:title, :caption, :image)
  end
end
