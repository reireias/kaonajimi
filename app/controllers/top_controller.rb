class TopController < ApplicationController
  def index
    @recent_users = User.recent.with_attached_images.limit(6)
    @this_month_users = User.this_month.with_attached_images
    @tags_histories = UserTagHistory.add.includes(:user, :user_tag).recent.limit(10)
  end
end