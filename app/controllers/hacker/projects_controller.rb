class Hacker::ProjectsController < HackerController
  before_action :set_project, only:[:show, :edit, :update, :destroy]
	before_action :set_project_tags_to_gon, only:[:edit]
  before_action :set_available_tags_to_gon, only:[:edit]

  def index
  	@projects = Project.all
  	@new_project = Project.new
  end

  def show
    @project_posts = ProjectPost.where(project_id: @project.id).order(created_at: :desc)
    @auth_edit_user = false
    @project.users.each do |user|
      if user.id == current_user.id
        @auth_edit_user = true
        break
      end
    end
  end

  def create
  	@project = Project.new(project_params)
    @project.users << current_user #current_userを作成したprojectに紐付けした
  	@project.save
    Project.reindex # インデックスに追加
  	redirect_to edit_hacker_project_path(@project.id)
  end

  def edit
  end

  def update
    if @project.update(project_params)
      Project.reindex # インデックスに追加
      redirect_to hacker_project_path(params[:id])
    else
      render :edit
    end
  end

  def destroy
    @project.destroy
    redirect_to hacker_projects_path
  end

  # ユーザーのフォロワーの中から選択
  def show_users
    @followers = User.find(current_user.id).followers
    @project = Project.find(params[:id])
  end

  def add_project_user
    @project = Project.find(params[:id])
    @follower = User.find(params[:user_id])
    @project.users << @follower
    @project.save
  end

  def destroy_project_user
    @project = Project.find(params[:id])
    @follower = User.find(params[:user_id])
    @project.users.delete(@follower)
    @project.save
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
  	params.require(:project).permit(:title, :description, :image, :image_cache, :remove_image, :tag_list)
  end

  def set_project_tags_to_gon
    gon.project_tags = @project.tag_list
  end

  def set_available_tags_to_gon
    gon.available_tags = ActsAsTaggableOn::Tag.most_used(50).pluck(:name)
  end
end
