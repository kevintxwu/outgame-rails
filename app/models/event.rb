class Event < ActiveRecord::Base
  has_and_belongs_to_many :users

  def add_rounds(round)
    @round = round
  end
end
