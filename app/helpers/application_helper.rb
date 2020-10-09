# rubocop:disable Style/GuardClause
module ApplicationHelper
  def menu_link_to(link_text, link_path)
    class_name = current_page?(link_path) ? 'menu-item active' : 'menu-item'

    content_tag(:div, class: class_name) do
      link_to link_text, link_path
    end
  end

  def like_or_dislike_btn(post)
    like = Like.find_by(post: post, user: current_user)
    if like
      link_to('Dislike!', post_like_path(id: like.id, post_id: post.id), method: :delete)
    else
      link_to('Like!', post_likes_path(post_id: post.id), method: :post)
    end
  end

  def user_name
    return current_user.name unless current_user.nil?
  end

  def send_friend_requests
    if current_user != @user && !current_user.friend?(@user)
      link_to 'Send Invitation', user_friendships_path(@user), method: :post, class: 'btn btn-primary'
    end
  end

  def send_friend_request(user)
    if current_user != user && !current_user.friend?(user)
      link_to 'Send Invitation', user_friendships_path(user), method: :post, class: 'btn btn-primary'
    end
  end

  def unfriend(friend)
    if @user == current_user
      link_to 'Unfriend', friendships_destroy_path(friendship_id: Friendship.find_friendship(@user.id, friend.id))
    end
  end

  def accpect_decline_request(friend)
    link_to "Accept", user_friendship_path(@user, id: current_user.id), method: :put, class: "btn btn-success"
    link_to 'Decline', friendships_destroy_path(friendship_id: Friendship.find_friendship(@user.id, friend.id))
  end
end
# rubocop:enable Style/GuardClause
