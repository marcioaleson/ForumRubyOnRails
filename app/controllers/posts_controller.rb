class PostsController < ApplicationController
  before_action :authenticate_user!, :find_post, only: [:new, :show, :edit, :update, :destroy]
  def index
    @post = Post.all.order("created_at DESC")
  end

  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post  = current_user.post.build(post_params)

    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end

  def edit

  end

  def update
    if @post.update(post_params)
      redirect_to @post
    else
      redirect_to 'edit'
    end
  end

  def destroy
    if @post.destroy
      redirect_to root_path
    end
  end

  private
  def find_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
