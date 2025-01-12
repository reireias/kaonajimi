class UserTagsController < ApplicationController
  def index
    @user_tags = UserTag.all
  end

  def show
    @user_tag = UserTag.includes(:user_taggings, :users).find(params[:id])
  end

  def edit
    @user_tag = UserTag.find(params[:id])
  end

  def create
    user_tag = UserTag.find_or_initialize_by(user_tag_params)
    tagging = UserTagging.find_or_initialize_by(user_tag: user_tag, user_id: params[:user_id])
    created = tagging.new_record?
    ActiveRecord::Base.transaction do
      user_tag.save! if user_tag.new_record?
      tagging.save! if tagging.new_record?
      UserTagHistory.create!(user_tag: user_tag, user_id: params[:user_id], status: :add) if created
    end
    render :json => { id: user_tag.id, tagging_id: tagging.id, created: created }
  end

  def update
    @user_tag = UserTag.find(params[:id])
    if @user_tag.update(user_tag_params)
      redirect_to @user_tag, notice: 'User tag was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @user_tag = UserTag.find(params[:id])
    @user_tag.destroy!
  end

  private

  def user_tag_params
    params.fetch(:user_tag, {}).permit(:title, :description)
  end
end
