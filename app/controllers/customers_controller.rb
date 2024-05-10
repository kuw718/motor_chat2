class CustomersController < ApplicationController
  def edit
    @customer = Customer.find(params[:id])
  end

  def show
    @customer = Customer.find(params[:id])
    @post_images = @customer.post_images
  end
  
  def update
    @customer = Customer.find(params[:id])
    @customer.update(customer_params)
    redirect_to customer_path(@customer.id)
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :profile_image)
  end
end
