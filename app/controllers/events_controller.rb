class EventsController < ApplicationController
  before_action :authenticate_employee!
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  # layout 'dashboard'
  layout 'dashboard'
  # GET /events
  # GET /events.json
  def index
     @events = Event.where(start: params[:start]..params[:end])
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)
    @event.save
  end

  def update
    p "........."
    p "........."
    @event.update(event_params)
  end

  def destroy
    @event.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:title, :start, :end)
    end
end
