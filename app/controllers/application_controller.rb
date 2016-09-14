class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected
  def authenticate_employee!
    if employee_signed_in?
      super
    else
      redirect_to login_path, :notice => 'Please Login to continue'
    end
  end
end
