class User < ActiveRecord::Base

  searchkick 

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_and_belongs_to_many :projects
  has_many :responses
  has_many :project_post_comments
  has_many :project_likes
  has_many :like_projects, through: :project_likes, source: :project #ユーザーが[いいね！]しているプロジェクトの取得
  has_many :user_posts, dependent: :destroy # ユーザーの投稿
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy # フォロー
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy # フォロワー
  has_many :following, through: :active_relationships, source: :followed # フォローしているユーザー
  has_many :followers, through: :passive_relationships, source: :follower # フォロワー

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, 
         :omniauthable, omniauth_providers: [:facebook]

  mount_uploader :image, ImageUploader # image uploader gem

  # ユーザーのフィードを返す
  def feed
    following_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id" # ユーザーがフォローしてりるuser_idを取得
    UserPost.where("user_id IN (#{following_ids}) OR user_id = :user_id", user_id: id).order(created_at: 'desc')
  end

  # ユーザーをフォローする
  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  # ユーザーをアンフォローする
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # 現在のユーザーがフォローしてたらtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end
         
  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first
    unless user
      user = User.create(
        uid: auth.uid,
        provider: auth.provider,
        name: auth.info.name,
        email: User.get_email(auth),
        password: Devise.friendly_token[4, 30])
    end
    user
  end

  private
    def self.get_email(auth)
      email = auth.info.email
      email = "#{auth.provider}-#{auth.uid}@example.com" if email.blank?
      email
    end

end