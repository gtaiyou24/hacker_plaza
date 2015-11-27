class ProjectPostComment < ActiveRecord::Base
	belongs_to :project_post
	belongs_to :user
end
