class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def create
  end

  def show
    @event = Event.find params[:id]
  end
  
  def edit
    @event = Event.find params[:id]
  end

  def new
  end

  def update
    @event = Event.find params[:id]
    if @event.update_attributes event_params
      flash[:success] = 'Event successfully updated!'
      redirect_to @event
    else
      render 'show'
    end
  end

  def destroy
  end

private

def event_params
  params.require(:event).permit(:name, :date, :bracket, :event_type, :description)
end

end
