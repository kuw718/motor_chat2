class PostsController < ApplicationController
  before_action :set_group, only: [:create]

  def create
    @post = @group.posts.build(post_params)
    @post.customer = current_customer
    if @post.save
      redirect_to group_path(@group), notice: '投稿しました。'
    else
      @posts = @group.posts.includes(:customer)
      render 'groups/show'
    end
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: 'グループが見つかりませんでした。'
  end

  def post_params
    params.require(:post).permit(:comment, :image)
  end
end

