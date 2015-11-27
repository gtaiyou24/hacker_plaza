class Hacker::RelationshipsController < HackerController

	# フォローする
	def create
		@user = User.find(params[:followed_id])
		current_user.follow(@user)
		respond_to do |format|
			format.html { redirect_to hacker_user_path(@user.id) }
			format.js
		end	
	end

	#️ フォローをやめる
	def destroy
		@user = Relationship.find_by(followed_id: params[:id]).followed
		current_user.unfollow(@user)
		respond_to do |format|
			format.html { redirect_to hacker_user_path(@user.id) }
			format.js
		end
	end
end
