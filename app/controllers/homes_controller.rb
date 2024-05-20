class HomesController < ApplicationController
  def top
    @post_images = PostImage.all.shuffle.take(4)
    @featured_post_images = PostImage.find($featured_images)

    @group_joining = current_customer.groups.order(created_at: :desc).limit(5)
    @other_groups = Group.where.not(id: @group_joining.pluck(:id)).order(created_at: :desc).limit(5)
  end

  def about
  end
end

