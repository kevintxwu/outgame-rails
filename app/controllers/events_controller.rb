class EventsController < ApplicationController
  helper_method :shorten_str
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
  
  def shorten_str(str,len)
    str.length > len ? str[0..len] + '...' : str[0..-1] 
  end

private

def event_params
  params.require(:event).permit(:name, :date, :bracket, :event_type, :description)
end

end
