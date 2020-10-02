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

  def send_friendship(user)
    if  user_signed_in?  && !Friendship.reacted?(current_user.id, user.id) && current_user != user 
      link_to 'Send Friendship', friendships_create_path(ids: {id1: current_user.id, id2: user.id})
    end
  end

  def single_send_friendship
    if @user != current_user && !Friendship.reacted?(current_user.id, @user.id)
      link_to 'Send a Friend requst', friendships_create_path(ids: {id1: current_user.id, id2: @user.id})
    end
  end

  def unfriend(friend)
     if @user == current_user
      link_to 'Unfriend', friendships_destroy_path(friendship_id: Friendship.find_friendship(@user.id, friend.id))
    end
  end

  def friend_request(friendship)
    if @user == current_user
      ( link_to 'Accept | ', friendships_update_path(friendship_id: friendship.id) )  +
      ( link_to 'Reject', friendships_destroy_path(friendship_id: friendship.id))
    end
  end
end
