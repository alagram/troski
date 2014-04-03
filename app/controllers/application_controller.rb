class ApplicationController < ActionController::Base
  before_filter :find_states

  protect_from_forgery with: :exception
  helper_method :require_signin!, :current_user

  private

  def require_signin!
    if current_user.nil?
      flash[:error] = "You need to sign in or sign up before continuing."
      redirect_to signin_path
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authorize_admin!
    require_signin!

    unless current_user.admin?
      flash[:alert] = "You must be an admin to do that."
      redirect_to root_path
    end
  end

  def find_states
    @states = State.all
  end

end
