class RoundsController < ApplicationController

  def new
    @round = Round.new
  end

  def create
    @round = Round.new(round_params)
  end

  def update
    @round = Round.find params[:id]
    if @round.update_attributes round_params
      flash[:success] = 'Event successfully updated!'
      redirect_to @event
    else
      render 'show'
    end
  end

def round_params
  params.require(:round).permit(:id, games_attributes: [:id, :p1_win, :p2_win])
end

end
