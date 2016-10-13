class AlertsController < ApplicationController
	before_action :authenticate_employee!
	layout 'dashboard'
	add_breadcrumb "Home", :root_path

  def index
    unless ['HR', 'Manager'].include? current_employee.role.name
       redirect_to root_path
     end 
  	add_breadcrumb "Alerts"
  end

  def sendmail
  	
  	if params[:alert] == "particular"
  		@emails = params[:enter_emails].split(/\s*,\s*/)
  		@message = params[:message]
      @subject = params[:subject]
      AlertMailer.alert_to_particular_emails(@emails, @subject, @message).deliver_later
  	end
    
    if params[:alert] == "team"
      @message = params[:message]
      @subject = params[:subject]

      if current_employee.role.name == "Manager"
          @emails = current_employee.subordinates.pluck :email
      elsif current_employee.role.name == "HR"
          @emails = Employee.all.pluck :email
      end 
      AlertMailer.alert_to_particular_emails(@emails, @subject, @message).deliver_later     
    end


  	redirect_to alerts_path, :notice=> "Mail alerts are successfully sent"
  end
end
