class GamesController < ApplicationController

  def update
    @game = Game.find params[:id]
    if @game.update_attributes game_params
      flash[:success] = 'Event successfully updated!'
      redirect_to @event
    else
      render 'show'
    end
  end

def game_params
  params.require(:game).permit(:p1_win, :p2_win)
end

end
