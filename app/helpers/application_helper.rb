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

  # def friend_request_helper
  #   if current_user.id == params[:id].to_i
  #     nil
  #   elsif current_user.friend?(User.find(params[:id]))
  #     'You are already friends'
  #   elsif current_user.pending_friends.include?(User.find(params[:id]))
  #     'Waiting for confirmation'
  #   elsif User.find(params[:id]).pending_friends.include?(current_user)
  #     link_to 'Accept friend', friend_path(params[:id]), method: :post
  #   else
  #     link_to 'Send friend request', create_friend_path(params[:id]), method: :post
  #   end
  # end
end
