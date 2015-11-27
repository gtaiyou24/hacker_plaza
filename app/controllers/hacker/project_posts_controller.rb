class Hacker::ProjectPostsController < HackerController

	def new
		@project_post = ProjectPost.new
		@project = Project.find(params[:project_id])
	end

	def create
		@project_post = ProjectPost.new(project_post_params)
		@project = Project.find(params[:project_id])
		@project_post.project_id = @project.id
		if @project_post.save
			redirect_to hacker_project_path(@project.id)
		else
			render :new
		end
	end

	def comment_create
		@project_post_comment = ProjectPostComment.new(comment: params[:project_post_comment][:comment])
		@project_post_comment.user_id = current_user.id
		@project_post_comment.project_post_id = params[:id]
		@project_post_comment.save
		redirect_to hacker_project_path(params[:project_id])
	end

	private

	def project_post_params
		params.require(:project_post).permit(:title, :content)
	end
end
