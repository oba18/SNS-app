class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow_user
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_user_id'
  has_many :followers, through: :reverse_of_relationships, source: :user
  

  # いいね機能のメソッド
  def already_liked?(post)
    self.likes.exists?(post_id: post)
  end

  # フォロー機能のメソッド
  def follow(other_user)
    unless self == other_user
      self.relationships.find_of_create_by(follow_user_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_of_create_by(follow_user_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end
end
