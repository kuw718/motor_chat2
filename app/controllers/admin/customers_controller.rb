class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_customer, only: [:edit, :update, :destroy, :unsubscribe]

  def show
    # 表示用のアクション
  end

  def edit
    # 編集用のアクション
  end

  def update
    if @customer.update(customer_params)
      redirect_to admin_path, notice: "Customer was successfully updated." # /adminにリダイレクトする
    else
      render :edit
    end
  end

  def destroy
    set_customer
    if @customer
      @customer.destroy
      redirect_to admin_path, notice: "Customer was successfully destroyed."
    else
      redirect_to admin_path, alert: "Customer not found."
    end
  end

  def unsubscribe
    # 退会用のアクションを実装する
  end

  private

  def set_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(:name, :email) # 適切なパラメーターを許可する
  end
end
