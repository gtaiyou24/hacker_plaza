class UserPost < ActiveRecord::Base
  belongs_to :user
  has_many :user_post_comments, dependent: :destroy
  validates :user_id, presence: true
  validates :content, presence: true
end
