class Game < ActiveRecord::Base
  belongs_to :round
  has_many :players

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

  def get_2p_styling(player)
    #ONLY WORKS FOR TWO PLAYERS!
    p_1,p_2 = players
    position = (player == p_1) ? 'top' : 'bottom'
    win = player == winner(p_1,p_2) ? ' winner' : (tie? ? ' tie' : '')
    return position + win
  end

  def get_result(player)
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
