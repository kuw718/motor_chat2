class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_group
  before_action :set_post, only: [:destroy]

  def destroy
    @post.destroy
    redirect_to admin_group_path(@group), notice: '投稿を削除しました。'
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def set_post
    @post = @group.posts.find(params[:id])
  end
end
