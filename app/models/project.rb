class Project < ActiveRecord::Base

	searchkick 

	has_and_belongs_to_many :users
	acts_as_taggable
	has_many :project_posts
	has_many :project_likes, dependent: :destroy
	
	validates :title, presence: true

	mount_uploader :image, ImageUploader # image uploader gem
end
