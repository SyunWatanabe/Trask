class PagesController < ApplicationController
  skip_before_action :set_user_actions
  skip_before_action :validate_user, only: :destroy

  def home
    render :layout => "home"
  end

  def about
  end

  def create
    user = User.find_by(email: session_params[:email].downcase)
    if user&.authenticate(session_params[:password])
      log_in user
      flash[:success] = "ログインしました！！"
      redirect_to user
    else
      flash.now[:danger] = '無効な メール / パスワード です'
      render 'sessions/new'
    end
  end

  private

    def session_params
      params.permit(:email,:password)
    end
end
