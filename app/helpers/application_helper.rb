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

  def friend_request_helper
    if current_user.id == params[:id].to_i
      nil
    elsif current_user.friend?(User.find(params[:id]))
      'You guyz are friends already'
    elsif current_user.pending_friends.include?(User.find(params[:id]))
      'pls confirm your friend request'
    elsif User.find(params[:id]).pending_friends.include?(current_user)
      link_to 'Accept friend', friend_path(params[:id]), method: :post
      link_to 'Ignore', friendship_path(id: friendship_id, friend_id: user.id), method: :delete
    else
      link_to 'Send friend request', create_friend_path(params[:id]), method: :post
    end
  end
end
