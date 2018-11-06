class UserController < ApplicationController
  before_action :authenticate_user, {only: [:edit, :update, :list]}
  before_action :forbid_login_user, {only: [:new, :create, :login_form, :login]}
  before_action :ensure_correct_user, {only: [:update, :edit]}

  def new
  end

  def create
    @user = User.new(user_id: params[:user_id], email: params[:email], password: params[:password])
    if @user.save
      flash[:notice] = "新規登録が完了しました"
      session[:id] = @user.id
      redirect_to "/"
    else
      render "user/new"
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.user_id = params[:user_id]
    @user.email = params[:email]
    @user.password = params[:password]

    if @user.save
      flash[:notice] = "編集が完了しました"
      redirect_to "/"
    else
      render "post/edit"
    end
  end
  

  def login_form
    @user = User.new
  end

  def login
    @user = User.find_by(user_id: params[:userid], password: params[:password])
    if @user
      session[:id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to "/"
    else
      @error_message = "メールアドレスまたはパスワードが間違っています"
      @email = params[:email]
      @password = params[:password]
      render "user/login_form"
    end
  end

  def logout
    session[:id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to "/user/login_form"
  end

  def list
    @users = User.all
  end
  
  def ensure_correct_user
    if @current_user.id != params[:id].to_i
      flash[:notice] = "権限がありません"
      redirect_to("/")
    end
  end

end
