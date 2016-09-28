class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  protect_from_forgery with: :null_session

  def current_ability
    @current_ability ||= Ability.new(current_employee)
  end


  rescue_from CanCan::AccessDenied do |exception|
  flash[:error] = "Access denied."
  redirect_to root_url
  end

  protected
  def authenticate_employee!(options={})
    if employee_signed_in?
      super(options)
    else
      #redirect_to login_path, :notice => 'Please Login to continue'
      redirect_to login_path
    end
  end
end
