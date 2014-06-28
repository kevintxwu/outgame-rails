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

  def get_box_styling(player)
    position = (player == @player_1) ? 'top' : 'bottom'
    winner = (player == @winner) ? ' winner' : (tie? ? ' tie' : '')
    return position + winner 
  end

  def get_result(player)
    return @player == @winner ? 'W' :  
      (@player_2 == @winner ? 'L' : 'T')
  end

  def tie?
    return @winner == nil
  end

end
