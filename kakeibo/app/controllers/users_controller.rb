class UsersController < ApplicationController
  before_action :login_seigen, only: %i[ logout ]
  before_action :already_login, only: %i[ new create login_form login ]
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(username: params[:username], email: params[:email], password: params[:password])
    if @user.save
      redirect_to '/', notice: 'ユーザー登録に成功しました'
    else
      render 'users/new'
    end
  end

  def login_form
  end

  def login
    @user = User.find_by(email: params[:email], password: params[:password])
    if @user then
      session[:user_id] = @user.id
      redirect_to("/", notice: 'ログインしました')
    else
      @error = "メールアドレスまたはパスワードが間違っています"
      @email = params[:email]
      @password = params[:password]
      render("users/login_form")
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to('/login', notice: 'ログアウトしました')
  end
end
