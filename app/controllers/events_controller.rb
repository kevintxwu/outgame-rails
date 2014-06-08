class EventsController < ApplicationController
  def create
    @event = Event.new event_params
    if @event.save
      flash[:success] = 'Successfully created event!'
      redirect_to event_path @event
    else
      render 'new'
    end
  end

  def edit
  end

  def show
  end

  def new
    @event = Event.new
  end

  private

  def event_params
    params.require(:name).permit(:date, :type, :bracket, :description)
  end

end
