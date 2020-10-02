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
end
