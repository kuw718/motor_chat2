class CustomersController < ApplicationController
  def edit
    @customer = Customer.find(params[:id])
  end

  def show
    @customer = Customer.find(params[:id])
    #@post_images = @customer.post_images
    @following_customers = @customer.following_customers
    @follower_customers = @customer.follower_customers
    @post_images = @customer.post_images.page(params[:page]).per(10)
  end
  
  def update
    @customer = Customer.find(params[:id])
    @customer.update(customer_params)
    redirect_to customer_path(@customer.id)
  end
  
  def destroy
    @customer = Customer.find(params[:id])
    
    ActiveRecord::Base.transaction do
      # 関連レコードを手動で削除
      @customer.post_images.each do |post_image|
        post_image.image.purge if post_image.image.attached?
        post_image.destroy!
      end
      @customer.post_comments.destroy_all
      @customer.favorites.destroy_all
      @customer.followers.destroy_all
      @customer.followeds.destroy_all
      @customer.group_customers.destroy_all

      # 顧客に関連するActive Storageの添付ファイルも削除
      @customer.profile_image.purge if @customer.profile_image.attached?

      # 最後に顧客レコードを削除
      @customer.destroy!
    end

    redirect_to root_path, notice: "アカウントが削除されました。"
  rescue ActiveRecord::RecordNotDestroyed, ActiveRecord::InvalidForeignKey => e
    redirect_to root_path, alert: "アカウントの削除に失敗しました: #{e.message}"
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
