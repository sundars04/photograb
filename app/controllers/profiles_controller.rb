class ProfilesController < ApplicationController
  before_action :find_user
  before_action :authenticate_user!
  before_action :own_profile, only: [:edit, :update]

  def show    
    @posts = User.find_by(user_name: params[:user_name]).posts.sorted
  end

  def edit
  end

  def update
    if @user.update(profile_params)
      flash[:success] = "Your profile has been updated."
      redirect_to profile_path(@user.user_name)
    else
      @user.errors.full_messages
      flash[:error] = @user.errors.full_messages
      render 'edit'
    end
  end

  private

    def find_user
      @user = User.find_by(user_name: params[:user_name])      
    end

    def profile_params
      params.require(:user).permit(:avatar, :bio)
    end

    def own_profile
      @user = User.find_by(user_name: params[:user_name])
      unless current_user == @user
        flash[:alert] = "That profile doesn't belong to you!"
        redirect_to root_path
      end
    end
end
