class StaticPagesController < ApplicationController

  def home
  	p current_employee
  	@user = current_employee
  end
  
end
