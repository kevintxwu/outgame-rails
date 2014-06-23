class Round
  include ActiveModel::Model
  attr_accessor :player_1, :player_2, :round_number, :games

  def initialize(attributes= {})
    @games = []
  end
end
