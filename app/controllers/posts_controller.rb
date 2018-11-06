class PostsController < ApplicationController

  before_action :authenticate_user, {only: [:list, :edit, :update, :destroy]}
  before_action :ensure_correct_user, {only: [:edit, :destory]}

  def index
    @posts = Post.all.order(updated_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(content: params[:content], user_id: @current_user.id)
    if @post.save
      flash[:notice] = "Tweetしました"
      redirect_to "/"
    else
      render "posts/index"
    end
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end
  
  def update
    @post = Post.find_by(id: params[:id])
    @post.content = params[:content]
    if @post.save
      flash[:notice] = "編集しました"
      redirect_to "/"
    end
  end
  
  def list
    @posts = Post.where(user_id: params[:id])
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    flash[:notice] = "Tweetを削除しました"
    redirect_to "/"
  end

  def ensure_correct_user
    @post = Post.find_by(id: params[:id])
    if @post.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to("/")
    end
  end
  
end
