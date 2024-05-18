class GroupsController < ApplicationController
  before_action :set_group, only: [:edit, :update, :show, :destroy]

  def index
    @group_lists = Group.all
    if current_customer
      @group_joining = current_customer.groups
    else
      @group_joining = []
      @group_lists_none = "ログインしていません。"
    end
  end

  def new
    @group = Group.new
    @group.customers << current_customer
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to groups_url, notice: 'グループを作成しました。'
    else
      render :new
    end
  end

  def show
    @group = Group.find(params[:id])
    @posts = @group.posts.order(created_at: :desc) # 投稿を新しい順に取得する例
  end

  def edit
  end

  def update
    if @group.update(group_params)
      redirect_to groups_path, notice: 'グループを更新しました。'
    else
      render :edit
    end
  end

  def destroy
    if @group.destroy
      redirect_to groups_path, notice: 'グループを削除しました。'
    end
  end

  def create_post
    @group = Group.find(params[:id])
    @post = @group.posts.build(post_params)
    if @post.save
      redirect_to group_path(@group), notice: '投稿しました。'
    else
      flash[:alert] = '投稿に失敗しました。'
      render :show
    end
  end


  private

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name, customer_ids: [])
  end
  
def post_params
  params.permit(:comment)
end
end
