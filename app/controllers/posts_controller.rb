class PostsController < ApplicationController
  before_action :find_post, :only => [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, :only => [:new, :create, :edit, :update, :destroy]
  before_action :own_post, :only => [:edit, :update, :destroy]

  def index
    @posts = Post.all.sorted.page params[:page]
  end

  def show
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Your Pic has been created!"
      redirect_to posts_path
    else
      flash.now[:alert] = "Your Pic couldnt be created! Please check the form"
      render 'new'
    end
  end

  def edit
  end

  def update
     if @post.update(post_params)
      flash[:notice] = "Your Pic was updated successfully!"
      redirect_to @post
    else
      flash.now[:alert] = "Your Pic couldnt be updated! Please check the form"
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    flash[:error] = "Your Pic was deleted successfully!"
    redirect_to posts_path
  end

  private

    def find_post
      @post = Post.find(params[:id])      
    end

    def post_params
      params.require(:post).permit(:image, :caption)
    end

    def own_post
      unless current_user == @post.user
        flash[:alert] = "That pic doesn't belong to you!"
        redirect_to root_path
      end
    end
end
