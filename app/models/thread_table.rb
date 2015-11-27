class ThreadTable < ActiveRecord::Base
	has_many :responses

	mount_uploader :image, ImageUploader # image uploader gem
end
