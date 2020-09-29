class FriendshipsController < ApplicationController
  def create
    friendship = current_user.friendships.create(friend_id: params[:id])
    friendship.save
    redirect_to user_path(params[:id])
  end

  def update
    current_user.confirm_friend(User.find(params[:id]))
    redirect_to user_path(params[:id])
  end

  def destroy
    inverse_friend = User.find(params[:friend_id])
    friend_request = inverse_friend.friendships.find(params[:id])

    friendship = current_user.friendships.find_by_friend_id(inverse_friend.id)
    if friendship.nil?
      friend_request.destroy
      flash[:notice] = 'friend request removed.'
    else
      friendship.destroy
      friend_request.destroy
      flash[:notice] = 'riendship removed.'
    end
    redirect_to current_user
  end
end
