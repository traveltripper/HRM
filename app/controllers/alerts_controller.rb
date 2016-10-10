class AlertsController < ApplicationController
	before_action :authenticate_employee!
	layout 'dashboard'
	add_breadcrumb "Home", :root_path
  def index
  	add_breadcrumb "Alerts"
  end

  def sendmail
  end
end
