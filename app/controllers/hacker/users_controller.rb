class Hacker::UsersController < HackerController

  def index
  end

  def show
  	@user = User.find(params[:id])
  	@projects = @user.like_projects
  end

  # フォローしているユーザーの一覧
  def following
  	@user = User.find(params[:id])
  	@users = @user.following
  end

  # フォロワー一覧（自分にフォローしてくれているユーザー）
  def followers
  	@user = User.find(params[:id])
  	@users = @user.followers
  end

end
