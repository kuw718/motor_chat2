class GroupsController < ApplicationController
  before_action :set_group, only: [:edit, :update, :show, :destroy, :request_join, :approve_join, :reject_join]
  
  def index
    if params[:keyword].present?
      @group_lists = Group.where('name LIKE ?', "%#{params[:keyword]}%")
    else
      @group_lists = Group.all
    end

    if current_customer
      @group_joining = current_customer.groups
      @other_groups = @group_lists.where.not(id: @group_joining.pluck(:id))
    else
      @group_joining = []
      @other_groups = Group.all
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
    @posts = @group.posts.order(created_at: :desc)
  end

  def edit
  end

def show
  @group = Group.find(params[:id])
  @posts = @group.posts.order(created_at: :desc)
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

  def request_join
    if @group.join_requests.where(customer: current_customer).exists?
      redirect_to @group, notice: 'すでに参加申請を送っています。'
    else
      @group.join_requests.create(customer: current_customer)
      redirect_to @group, notice: '参加申請を送りました。'
    end
  end

  def approve_join
    join_request = @group.join_requests.find(params[:request_id])
    @group.customers << join_request.customer
    join_request.destroy
    redirect_to @group, notice: '参加申請を承認しました。'
  end

  def reject_join
    join_request = @group.join_requests.find(params[:request_id])
    join_request.destroy
    redirect_to @group, notice: '参加申請を拒否しました。'
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