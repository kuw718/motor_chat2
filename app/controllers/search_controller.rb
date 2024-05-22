class SearchController < ApplicationController
  def index
    @category = params[:category]
    @query = params[:query]

    if @category == 'users'
      @results = Customer.where('name LIKE ?', "%#{@query}%").page(params[:page]).per(10)
    elsif @category == 'posts'
      @results = Post.where('content LIKE ?', "%#{@query}%").page(params[:page]).per(10)
    elsif @category == 'posts_images'
      @results = PostImage.where('caption LIKE ? OR title LIKE ?', "%#{@query}%", "%#{@query}%").page(params[:page]).per(10)
    else
      @results = []
    end
  end
end
