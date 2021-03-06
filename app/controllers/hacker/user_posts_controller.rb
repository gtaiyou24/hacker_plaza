class Hacker::UserPostsController < HackerController

	def index
		@feed_items = current_user.feed
		@user = User.find(current_user.id)

		# 友達である可能性の高いユーザーを推薦
		@recommend_users = current_user.recommend_friend_users
	end

	def create
		@user_post = current_user.user_posts.build(user_post_params)
		@user_post.save
		redirect_to hacker_user_path(current_user.id)
	end

	def comment_create
		@user_post_comment = UserPostComment.new(comment: params[:user_post_comment][:comment])
		@user_post_comment.user_id = current_user.id
		@user_post_comment.user_post_id = params[:id]
		@user_post_comment.save
		redirect_to hacker_user_posts_path
	end

	private

	def user_post_params
		params.require(:user_post).permit(:content)
	end
end
