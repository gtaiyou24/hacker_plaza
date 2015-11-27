class Users::RegistrationsController < Devise::RegistrationsController
before_filter :configure_sign_up_params, only: [:create]
before_filter :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    super
  end

  # GET /resource/edit
  def edit
    # super
    @user = User.find(current_user.id)
    render layout: 'hacker'
  end

  # PUT /resource
  def update
    @user = User.find(current_user.id)
    file = params[:user][:image]

    if !file.nil?
      file_name = file.original_filename
      File.open("public/user_images/#{file_name}", 'wb') {|f|f.write(file.read)}
      @user.image = file_name
    end

    if @user.update(user_params)
      redirect_to hacker_user_path(current_user.id)
    else
      render :edit
    end

    # super
    # redirect_to hacker_user_path(current_user.id)
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end
  private

  def user_params
    params.require(:user).permit(:name, :affiliation, :hobby, :image, :image_cache, :remove_image)
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.for(:sign_up) << :name
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.for(:account_update) << :name
    devise_parameter_sanitizer.for(:account_update) << :affiliation
    devise_parameter_sanitizer.for(:account_update) << :hobby
    devise_parameter_sanitizer.for(:account_update) << :image
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end