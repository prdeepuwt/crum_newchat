class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include ApplicationHelper
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  private
  def user_not_authorized
    if user_signed_in?
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to(request.referrer || root_path)
    else
      session[:user_return_to] = request.path unless session[:user_return_to]
      flash[:alert] = "Please sign in to continue."
      redirect_to new_user_session_path
    end
  end
end
