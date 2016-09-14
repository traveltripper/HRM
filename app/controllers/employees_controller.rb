class EmployeesController < ApplicationController
  before_action :authenticate_employee!, :only => [:index, :show, :dashboard, :reports, :profile]
  layout 'dashboard'
  add_breadcrumb "Home", :root_path
  def index
  	@employee = current_employee
    @employees = Employee.all
  end

  def show
    @employee = Employee.find_by_id(params[:id])
    render :template => 'employees/profile'
  end

  def dashboard
    add_breadcrumb "Dashboard", dashboard_path
  end

  def reports
    add_breadcrumb "Reports", reports_path
  end

  def profile
    @employee = current_employee
    add_breadcrumb "Profile", profile_path
  end

end