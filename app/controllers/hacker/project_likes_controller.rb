class Hacker::ProjectLikesController < HackerController

	def like
		@project = Project.find(params[:project_id])
		project_like = current_user.project_likes.build(project_id: @project.id)
		project_like.save
	end

	def unlike
		@project = Project.find(params[:project_id])
		project_like = current_user.project_likes.find_by(project_id: @project.id)
		project_like.destroy
	end
end
