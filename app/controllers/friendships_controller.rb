class FriendshipsController < ApplicationController
  def create
    id1 = params[:ids][:id1]
    id2 = params[:ids][:id2]
    @friendship = Friendship.new(user_id: id1, friend_id: id2)
    @friendship.save
    redirect_to users_path
  end

  def destroy
    friendship = Friendship.find(params[:friendship_id])
    friendship.destroy
    redirect_to user_path(current_user.id)
  end

  def update
    friendship = Friendship.find(params[:friendship_id])
    p current_user
    friendship.update(confirmed: true)
    redirect_to user_path(friendship.friend_id)
  end
  # def create
  #     friendship = current_user.friendships.create(friend_id: params[:id])
  #     friendship.save
  #     redirect_to user_path(params[:id])
  # end

  #   def update
  #     current_user.confirm_friend(User.find(params[:id]))
  #     redirect_to user_path(params[:id])
  #   end
end
