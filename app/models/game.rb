class Game
  include ActiveModel::Model
  attr_accessor :player_1, :player_2, :winner, :has_tie, :p1_letter, :p2_letter

  def initialize(attributes = {})
    @winner = ''
    @has_tie = false
    @p1_letter = '?'
    @p2_letter = '?'
  end

  def result_classname(player)
  end

  def result_letter(player)
  end

  def is_winner(player)
    return player == winner && !@has_tie
  end


end
