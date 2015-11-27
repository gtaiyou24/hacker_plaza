class ProjectPost < ActiveRecord::Base
	belongs_to :project
	has_many :project_post_comments
end
