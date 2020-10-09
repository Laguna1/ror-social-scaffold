class FriendshipsController < ApplicationController
  def create
    friendship = Friendship.new(user_id: current_user.id, friend_id: params[:user_id])

    if friendship.save
      flash[:notice] = "invitation was successfully"
      redirect_to users_path
    else
      flash[:error] = "invitation was unsuccessfully"
      redirect_to users_path
    end
  end

  def update
    current_user.confirm_friend(User.find(params[:id]))
    redirect_to user_path(params[:id])
  end

  def destroy
    friendship = Friendship.find(params[:friendship_id])
    friendship.destroy
    redirect_to user_path(current_user.id)
  end
end
