class Game
  include ActiveModel::Model
  attr_accessor :player_1, :player_2, :result

  def initialize(attributes = {})
    @result = 'T' #represents a tie.
  end
end
