class Admin::PostCommentsController < ApplicationController
  before_action :set_post_image
  before_action :set_post_comment, only: [:edit, :update, :destroy]

  def edit
  end

  def update
    if @post_comment.update(post_comment_params)
      redirect_to admin_post_image_path(@post_image), notice: 'コメントが更新されました'
    else
      render :edit
    end
  end

  def destroy
    @post_comment.destroy
    redirect_to admin_post_image_path(@post_image), notice: 'コメントが削除されました'
  end

  private

  def set_post_image
    @post_image = PostImage.find(params[:post_image_id])
  end

  def set_post_comment
    @post_comment = @post_image.post_comments.find(params[:id])
  end

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
