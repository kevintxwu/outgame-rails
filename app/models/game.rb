class Game < ActiveRecord::Base
  belongs_to :round
  serialize :contestants, Array

  #p_1 (player_1) is top player, p_2 (player_2) is bottom
  #TODO: default player to winner if no other player given?

=begin
  def initialize(attributes = {})
    @winner = attributes[:winner] 
    @p_1 = attributes[:p_1]
    @p_2 = attributes[:p_2]
    #TODO: introduce this check!
    #assert ([@p_1, @p_2, nil].include? @winner)
    #  'winner must be a player in the match or nil'
  end
=end

  def get_2p_styling(pl)
    #ONLY WORKS FOR TWO PLAYERS!
    p_1,p_2 = contestants
    position = (pl == p_1) ? 'top' : 'bottom'
    win = pl == winner(p_1,p_2) ? ' winner' : (tie? ? ' tie' : '')
    return position + win
  end

  #FIX!
  def get_result(pl)
    return pp1_win? ? 'W' :  
      (@player_2 == @winner ? 'L' : 'T')
  end

  def tie?
    return (p1_win && p2_win) || (!p1_win && !p2_win)
  end

  def winner(p_1,p_2)
    return tie? ? nil : (p1_win? ? p_1 : p_2)
  end

end
