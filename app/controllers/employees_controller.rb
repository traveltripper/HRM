class EmployeesController < ApplicationController
  before_action :authenticate_employee!
  layout 'dashboard'
  def index
  	@employee = current_employee
  end

  def show
  end

  def dashboard
  end

  def reports
  end
  
end
