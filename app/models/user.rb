class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships
  has_many :friends, through: :friendships, dependent: :destroy
  has_many :friends_posts, through: :friends, source: :posts
  has_many :pending_friendships, -> { where confirmed: false }, class_name: 'Friendship', foreign_key: 'user_id'
  has_many :confirmed_friendships, -> { where confirmed: true }, class_name: 'Friendship'
  has_many :inverse_friendships, -> { where confirmed: false }, class_name: 'Friendship', foreign_key: 'friend_id'
  has_many :inverse_friends, through: :inverse_friendships, source: :user

  def friends
    invitation_i_sent = Friendship.where(user_id: id, confirmed: true).pluck(:friend_id)
    invitation_i_got = Friendship.where(friend_id: id, confirmed: true).pluck(:user_id)
    ids = invitation_i_sent + invitation_i_got
    User.where(id: ids)
  end

  def friend_with?(user)
    Friendship.confirmed_record?(id, user.id)
  end

  def send_invitation(user)
    friendships.create(friend_id: user.id)
  end

  def friends_and_own_posts
    Post.where(user: (friends + self))
    # This will produce SQL query with IN. Something like: select * from posts where user_id IN (1,45,874,43);
  end
end
