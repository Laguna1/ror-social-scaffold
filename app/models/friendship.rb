class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  def self.find_friendship(id1, id2)
    if Friendship.where(user_id: id1, friend_id: id2, confirmed: true).empty?
      Friendship.where(user_id: id2, friend_id: id1, confirmed: true)[0].id
    else
      Friendship.where(user_id: id1, friend_id: id2, confirmed: true)[0].id
    end
  end
end
