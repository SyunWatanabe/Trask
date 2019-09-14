class SessionsController < ApplicationController
  skip_before_action :set_user_actions
  skip_before_action :validate_user, only: :destroy

  def new
  end

  def create
    user = User.find_by(email: session_params[:email].downcase)
    if user&.authenticate(session_params[:password])
      log_in user
      flash[:success] = "ログインしました！！"
      redirect_back_or user
    else
      flash.now[:danger] = '無効な メール / パスワード です'
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    flash[:success] = "ログアウトしました！"
    redirect_to root_url
  end

  private

    def session_params
      params.require(:session).permit(:email,:password)
    end
end
