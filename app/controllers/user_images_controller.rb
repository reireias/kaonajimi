class UserImagesController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    if params[:type] == 'main'
      @user.main_image.attach(params[:images])
      @images = [@user.main_image]
    else
      @user.sub_images.attach(params[:images])
      @images = @user.sub_images
    end
    ret = @images.map { |image| { id: image.id, url: rails_blob_path(image, only_path: true) } }
    render :json => ret
  end

  def destroy
    current_user.sub_images.find(params[:id]).destroy!
  end
end
