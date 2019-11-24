module UserSessionModule
  extend ActiveSupport::Concern

  included do
    helper_method :log_in,
                  :logged_in_user,
                  :current_user,
                  :current_user?,
                  :logged_in?,
                  :log_out,
                  :redirect_back_or,
                  :store_location
  end

  def log_in(user)
      session[:user_id] = user.id
    end

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = 'ログインしてください'
        redirect_to login_url
      end
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end

    def current_user?(user)
      user == current_user
    end

    def logged_in?
      !current_user.nil?
    end

    def log_out
      reset_session
    end

    def redirect_back_or(default)
      redirect_to(session[:forwarding_url] || default)
      session.delete(:forwarding_url)
    end

    def store_location
      session[:forwarding_url] = request.original_url if request.get?
    end
  
end
