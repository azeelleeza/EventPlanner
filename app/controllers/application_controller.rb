class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user

  include SessionsHelper

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end


  def authorize
    redirect_to '/login' unless current_user
  end

end
