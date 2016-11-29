class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_employee!
  load_and_authorize_resource  
  layout 'hrmdashboard'
  #layout "hrmdashboard", only: [:upcoming_company_events, :upcoming_team_events]

  add_breadcrumb "Home", :root_path
  # GET /events
  # GET /events.json
  def index
    @events = current_employee.events
    add_breadcrumb "Events", :events_path
  end

  # GET /events/1
  # GET /events/1.json
  def show
    render :layout => 'hrmdashboard'
    add_breadcrumb "Event"
  end

  # GET /events/new
  def new
    @employee = current_employee
    @event = @employee.events.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @employee = current_employee
    @event = @employee.events.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def company_events
    @announcements = Announcement.where(active: true).limit(4)  
    role_ids = Role.where(name: ["HR", "Admin"] ).pluck :id
    @company_events = Event.joins(:employee).where(:employees =>{role_id: role_ids}).where(publish: true).where('start >= ? or end_date >= ?', Date.today, Date.today)
    render :layout => 'hrmdashboard'
  end

  def team_events
    @announcements = Announcement.where(active: true).limit(4)  
    @department = current_employee.department
    @role = Role.where(:name => "Manager").first
    @mng = Employee.where(:role_id =>@role.id , :department_id => @department.id).first
    if @mng
      @team_events = @mng.events.where(publish: true).where('start >= ? or end_date >= ?', Date.today, Date.today)
    end 
    render :layout => 'hrmdashboard'    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:title, :start, :end_date, :reason, :picture, :publish)
    end
end
