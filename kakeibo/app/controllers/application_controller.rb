class ApplicationController < ActionController::Base
  before_action :set_current_user

  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end

  def login_seigen
    unless @current_user
      redirect_to('/login', notice: 'ログインしてください')
    end
  end

  def already_login
    if @current_user
      redirect_to('/', notice: '既にログインしています')
    end
  end
end
