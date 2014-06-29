class EventsController < ApplicationController
  helper_method :shorten_str
  def index
    @events = Event.all
  end

  def create
    @event = Event.new event_params
    if @event.save
      flash[:success] = 'Successfully created event!'
      redirect_to events_path
    else
      render 'new'
    end
    
  end

  def show
    @event = Event.find params[:id]
  end

  def show_brackets
    @event = Event.find params[:id]
    @rounds = @event.rounds
  end

  def new_round
    @event = Event.find params[:id]
    @event.generate_round
    render 'show_brackets'
  end

  def edit
    @event = Event.find params[:id]
  end

  def new
    @event = Event.new
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
    Event.find(params[:id]).destroy
    redirect_to events_path 
  end
  
  def shorten_str(str,len)
    str.length > len ? str[0..len] + '...' : str[0..-1] 
  end

private

def event_params
  params.require(:event).permit(:name, :date, :bracket, :event_type, :description)
end

end
