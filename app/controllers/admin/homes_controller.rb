class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
    @customers = Customer.all # すべてのユーザー情報を取得する
  end
  
  def about
  end
  
  # ユーザーの編集画面へのアクション
  def edit_user
    @customer = Customer.find(params[:id])
  end

  # ユーザーの更新アクション
  def update_user
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to admin_top_path, notice: 'ユーザー情報を更新しました'
    else
      render :edit_customer
    end
  end

  # ユーザーの削除アクション
  def destroy_customer
    @customer = Customer.find(params[:id])
    @customer.destroy
    redirect_to admin_top_path, notice: 'ユーザーを削除しました'
  end

  # ユーザーの退会アクション
  def unsubscribe_customer
    @customer= Customer.find(params[:id])
    @customer.destroy
    redirect_to root_path, notice: '退会しました'
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :email, :password, :password_confirmation)
  end
end
