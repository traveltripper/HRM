class StaticController < ApplicationController
  before_action :authenticate_employee!
  layout 'dashboard'
  def home
  	p current_employee
  	@user = current_employee
  end  
end
