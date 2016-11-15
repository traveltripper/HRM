class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  protect_from_forgery with: :null_session
  helper :all
  require 'carrierwave'
  require 'carrierwave/orm/activerecord'
  
  
  def current_ability
    @current_ability ||= Ability.new(current_employee)
  end
  
  def upcoming_company_events   
    role_ids = Role.where(name: ["HR", "Admin"] ).pluck :id
    Event.joins(:employee).where(:employees =>{role_id: role_ids}).where(publish: true).where('start >= ? or end_date >= ?', Date.today, Date.today).last(1)
  end

  def upcoming_team_events
    @department = current_employee.department
    @role = Role.where(:name => "Manager").first
    @mng = Employee.where(:role_id =>@role.id , :department_id => @department.id).first
    if @mng
      @mng.events.where(publish: true).where('start >= ? or end_date >= ?', Date.today, Date.today).last(1)
    end        
  end
 
  rescue_from CanCan::AccessDenied do |exception|
  flash[:error] = "Access denied."
  redirect_to root_url
  end

  helper_method :upcoming_company_events
  helper_method :upcoming_team_events

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
