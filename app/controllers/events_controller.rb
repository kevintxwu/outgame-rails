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

  def show_bracket
    @event = Event.find params[:id]
    @new_round = @event.rounds.last
    render 'show-bracket'
  end

  def new_round
    @event = Event.find params[:id]
    # last round can't be active!
    if @event.rounds.last == nil or !@event.rounds.last.active
      @event.generate_round
      @rounds = @event.rounds
      @event.save!
      @new_round = @event.rounds.last
    end
    render 'show-bracket'
    #redirect_to 'bracket_path'
  end

  def create_round
    @event = Event.find params [:id]
  end

  def edit
    @event = Event.find params[:id]
  end

  def new
    @event = Event.new
  end

  def update
    @event = Event.find params[:id]
    @event.calculate_scores
    if @event.update_attributes event_params
      flash[:success] = 'Event successfully updated!'
      redirect_to @event
    else
      render 'show'
    end
  end

  def update_bracket
    @event = Event.find params[:id]
    @event.calculate_scores
    if @event.update_attributes event_params
      flash[:success] = 'Event successfully updated!'
      render 'show-bracket'
      #redirect_to show_bracket
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
  params.require(:event).permit(:id, :name, :date, :bracket, :event_type, :description, rounds_attributes: [:id, :round_number, :active, :byes, games_attributes: [:id, :p1_win, :p2_win]])
end

end
