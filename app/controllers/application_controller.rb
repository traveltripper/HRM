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
    
    if params[:id] and params[:controller] =="events"
      @current_event = Event.friendly.find(params[:id])
    end
    role_ids = Role.where(name: ["HR", "Admin"] ).pluck :id
    if @current_event
      Event.joins(:employee).where(:employees =>{role_id: role_ids}).where(publish: true).where.not(id: @current_event.id).where('start >= ? or end_date >= ?', Date.today, Date.today).limit(2)
    else
      Event.joins(:employee).where(:employees =>{role_id: role_ids}).where(publish: true).where('start >= ? or end_date >= ?', Date.today, Date.today).limit(2)
    end
  end

  def upcoming_team_events
    if params[:id] and params[:controller] =="events"
    @current_event = Event.friendly.find(params[:id])
    end
    @department = current_employee.department
    @role = Role.where(:name => "Manager").first
    if Employee.count > 1
      @mng = Employee.where(:role_id =>@role.id , :department_id => @department.id).first
      if @mng
        if @current_event
        @mng.events.where(publish: true).where('start >= ? or end_date >= ?', Date.today, Date.today).where.not(id: @current_event.id).limit(2)

        else
        @mng.events.where(publish: true).where('start >= ? or end_date >= ?', Date.today, Date.today).limit(2)
        end
      end 
    end       
  end

  def cpp_designations_except_current    
    if params[:id] and params[:controller] =="cpp"
      @current_designation = Cpp.friendly.find(params[:id])      
      designations = Cpp.where.not(id: @current_designation.id)      
    end    
  end

  def cpp_designations        
      designations = Cpp.all   
  end

  def latest_announcements
    Announcement.active.limit(2)
  end

  def polling
    Pollquestion.where(status:true).first
  end

  def display_hr
    @names = []
    if Employee.count > 1
      role = Role.where(name: "HR").first
      emp = Employee.where(role_id: role.id)
      emp.each do |name|
        @names << name
      end
    end
    @names
  end
 
  rescue_from CanCan::AccessDenied do |exception|
  flash[:error] = "Access denied."
  redirect_to root_url
  end

  def pie_chart
    @pieSize = {
    :height => 500,
    :width => 500
  }

  @pieData = [
        {
          value: 300,
          color:"#F7464A",
          highlight: "#FF5A5E",
          label: "Red"
        },
        {
          value: 50,
          color: "#46BFBD",
          highlight: "#5AD3D1",
          label: "Green"
        },
        {
          value: 100,
          color: "#FDB45C",
          highlight: "#FFC870",
          label: "Yellow"
        },
        {
          value: 40,
          color: "#949FB1",
          highlight: "#A8B3C5",
          label: "Grey"
        },
        {
          value: 120,
          color: "#4D5360",
          highlight: "#616774",
          label: "Dark Grey"
        }

      ].to_json
  end


  helper_method :upcoming_company_events
  helper_method :upcoming_team_events
  helper_method :latest_announcements
  helper_method :display_hr
  helper_method :cpp_designations
  helper_method :cpp_designations_except_current
  helper_method :polling
  helper_method :pie_chart

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
