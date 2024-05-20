class CustomersController < ApplicationController
  def edit
    @customer = Customer.find(params[:id])
  end

  def show
    @customer = Customer.find(params[:id])
    @post_images = @customer.post_images
    @following_customers = @customer.following_customers
    @follower_customers = @customer.follower_customers
  end
  
  def update
    @customer = Customer.find(params[:id])
    @customer.update(customer_params)
    redirect_to customer_path(@customer.id)
  end
  
  def follows
    customer = Customer.find(params[:id])
    @customers = customer.following_customers
  end

  def followers
    customer = Customer.find(params[:id])
    @customer = customer.follower_customers
  end

  def liked_posts
    @liked_posts = current_customer.liked_posts
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :profile_image)
  end
end
