class Admin::GroupsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_group, only: [:show, :edit, :update, :destroy]


  def show
    @posts = @group.posts.includes(:customer)
  end
  
  def destroy
    @group.destroy
    redirect_to admin_path, notice: 'グループが削除されました。'
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end
end
