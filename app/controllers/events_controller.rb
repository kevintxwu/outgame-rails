class EventsController < ApplicationController
  helper_method :shorten_str, :num_players
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
    @new_round_disabled = num_players(@event) < 2
    render 'show-bracket'
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
    if @event.update_attributes event_params
      flash[:success] = 'Event successfully updated!'
      redirect_to @event
    else
      render 'show'
    end
  end

  def save_event
    @event = Event.find params[:id]
    if @event.update_attributes event_params
      @event.calculate_scores
      redirect_to :action => :show_bracket
    else
      render 'show' #for error checks
    end
  end

  def update_bracket
    @event = Event.find params[:id]
    # last round can't be active!
    if @event.rounds.last == nil or !@event.rounds.last.active
      @event.generate_round
      @rounds = @event.rounds
      @event.save!
      @new_round = @event.rounds.last
      render 'show-bracket'
    else
      if @event.update_attributes event_params
        flash[:success] = 'Event successfully updated!'
        @event.calculate_scores
        render 'show-bracket'
      else
        render 'show'
      end
    end
  end

  def destroy
    Event.find(params[:id]).destroy
    redirect_to events_path 
  end

  def undo_round
    @event = Event.find(params[:id])
    if !@event.rounds.empty?
      @event.rounds.last.destroy
      render 'show-bracket'
    end
  end
  
  def shorten_str(str,len)
    str.length > len ? str[0..len] + '...' : str[0..-1] 
  end

  def num_players(event)
    p = event.users.select { |u| u.type = 'Player' }
    return p.count
  end

private

def event_params
  params.require(:event).permit(:id, :name, :date, :bracket, :event_type, :description, rounds_attributes: [:id, :round_number, :active, :byes, games_attributes: [:id, :p1_win, :p2_win]])
end

end
